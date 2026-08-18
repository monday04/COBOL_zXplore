      *------------------------------------------------------------
      *  This COBOL program reads each record in ZOS.PUBLIC.HACKER.NEWS.
      *  It will select only the records that have mention of words
      *  COBOL or Mainframe in the Title column. Ranking score will be
      *  calculated based on the number of votes it received and the
      *  time it was posted.
      *  Record will be written to an output file along with the
      *  ranking score.
      *------------------------------------------------------------
       IDENTIFICATION DIVISION.
         PROGRAM-ID. CBL4000.
         AUTHOR. Zethlene de los Reyes.
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
         INPUT-OUTPUT SECTION.
         FILE-CONTROL.
             SELECT HACKER-FILE ASSIGN TO HACKER
                 ORGANIZATION IS SEQUENTIAL
                 FILE STATUS IS WS-HACKER-FS.
             SELECT REPORT-FILE ASSIGN TO HREPORT
                 ORGANIZATION IS SEQUENTIAL
                 FILE STATUS IS WS-MAINFRAME-FS.
      *----------------------------------------------------------------
       DATA DIVISION.
         FILE SECTION.
         FD  HACKER-FILE RECORDING MODE F.
         01  HACKER-RECORD.
             05  HACKER-FIELD          PIC X(143).
         FD  REPORT-FILE RECORDING MODE F.
         01  REPORT-RECORD.
             05  REPORT-FIELD          PIC X(149).
      *----------------------------------------------------------------
         WORKING-STORAGE SECTION.
         01  WS-EOF-FLAG                PIC X VALUE 'N'.
             88  FL-EOF                       VALUE 'Y'.
             88  FL-NOT-EOF                   VALUE 'N'.
         01  FL-GET-DATA                PIC X VALUE 'N'.
             88  FL-MAINFRAME                 VALUE 'Y'.
             88  FL-NOT-MAINFRAME             VALUE 'N'.

         01  WS-HACKER-FS               PIC XX.
         01  WS-MAINFRAME-FS            PIC XX.
         01  WS-COUNT                   PIC 9.
         01  WS-AGE                     PIC S9999V999999 COMP-3.

         01  HACK-IN-FIELDS.
             05 HACK-IN-ID               PIC X(8).
             05 HACK-IN-TITLE            PIC X(96).
             05 HACK-IN-POINTS           PIC 9(4).
             05 HACK-IN-COMMENTS         PIC 9(4).
             05 HACK-IN-AUTHOR           PIC X(15).
             05 HACK-IN-CREATE-DT        PIC X(16).

         01  WS-HACK-IN-TITLE            PIC X(96).
         01  WS-HACK-IN-POINTS           PIC 9(4).
         01  WS-HACK-IN-CREATE-DT.
             05 WS-DATE                  PIC X(9).
             05 WS-TIME                  PIC X(6).
         01  WS-TIME-CLEAN               PIC X(5) JUSTIFIED RIGHT.
         01 WS-HOUR                      PIC 9(2).
         01 WS-MINUTES                   PIC 9(2).
         01  WS-RANKING-SCORE            PIC S9999V999999 COMP-3.

         01  HACK-OUT-FIELDS.
             05 HACK-OUT-ID               PIC X(8).
             05 HACK-OUT-TITLE            PIC X(96).
             05 HACK-OUT-POINTS           PIC 9(4).
             05 HACK-OUT-COMMENTS         PIC 9(4).
             05 HACK-OUT-AUTHOR           PIC X(15).
             05 HACK-OUT-TIME             PIC X(16).
             05 HACK-OUT-RANKING-SCORE    PIC S9999V999999 COMP-3.
      *----------------------------------------------------------------
       PROCEDURE DIVISION.
      *----------------------------------------------------------------
       0000-OPEN-FILES.
           OPEN INPUT HACKER-FILE
             DISPLAY "filestatus of hacker open: " WS-HACKER-FS.
           OPEN OUTPUT REPORT-FILE
             DISPLAY "filestatus of report open:" WS-MAINFRAME-FS.

       1000-READ-CSV-FILE.
           PERFORM UNTIL FL-EOF
              READ HACKER-FILE INTO HACK-IN-FIELDS
                 AT END
                    SET FL-EOF TO TRUE
                 NOT AT END
                    PERFORM 1100-SELECT-MAINFRAME-COBOL
                    IF FL-MAINFRAME
                       PERFORM 1200-CALCULATE-RANKING-SCORE
                       PERFORM 1300-WRITE-TO-OUTPUT
                    END-IF
                    INITIALIZE HACK-IN-FIELDS HACK-OUT-FIELDS
                               WS-HACK-IN-CREATE-DT WS-RANKING-SCORE
                    SET FL-NOT-MAINFRAME TO TRUE
              END-READ
           END-PERFORM.

       9000-CLOSE-STOP.
           CLOSE HACKER-FILE.
           CLOSE REPORT-FILE.
           STOP RUN.

      *----------------------------------------------------------------
       1100-SELECT-MAINFRAME-COBOL.
             UNSTRING HACKER-FIELD DELIMITED BY ","
               INTO   HACK-IN-ID
                      HACK-IN-TITLE
                      HACK-IN-POINTS
                      HACK-IN-COMMENTS
                      HACK-IN-AUTHOR
                      HACK-IN-CREATE-DT.
             MOVE 0 TO WS-COUNT.
             MOVE HACK-IN-TITLE TO WS-HACK-IN-TITLE.
             INSPECT WS-HACK-IN-TITLE
                     CONVERTING 'abcdefghijklmnopqrstuvwxyz'
                             TO 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
             INSPECT WS-HACK-IN-TITLE TALLYING WS-COUNT FOR ALL 'COBOL'.
             INSPECT WS-HACK-IN-TITLE TALLYING WS-COUNT
                                                FOR ALL 'MAINFRAME'.
             IF WS-COUNT > 0
                SET FL-MAINFRAME TO TRUE
                MOVE HACK-IN-POINTS TO WS-HACK-IN-POINTS
                MOVE HACK-IN-CREATE-DT TO WS-HACK-IN-CREATE-DT
                MOVE HACK-IN-POINTS TO WS-HACK-IN-POINTS
             END-IF.


       1200-CALCULATE-RANKING-SCORE.
             MOVE FUNCTION TRIM(WS-TIME) TO WS-TIME-CLEAN
             UNSTRING WS-TIME-CLEAN DELIMITED BY ":"
                 INTO WS-HOUR
                      WS-MINUTES

             MOVE 0 TO WS-RANKING-SCORE
             MOVE 0 TO WS-AGE

             COMPUTE WS-AGE = WS-HOUR + (WS-MINUTES / 60)
             COMPUTE WS-RANKING-SCORE =
                     ((WS-HACK-IN-POINTS - 1) ** 0.8) /
                     ((WS-AGE + 2) ** 1.8)
             END-COMPUTE.


       1300-WRITE-TO-OUTPUT.
             MOVE HACK-IN-ID       TO HACK-OUT-ID
             MOVE HACK-IN-TITLE    TO HACK-OUT-TITLE
             MOVE HACK-IN-POINTS   TO HACK-OUT-POINTS
             MOVE HACK-IN-COMMENTS TO HACK-OUT-COMMENTS
             MOVE HACK-IN-AUTHOR   TO HACK-OUT-AUTHOR
             MOVE WS-TIME          TO HACK-OUT-TIME
             MOVE WS-RANKING-SCORE TO HACK-OUT-RANKING-SCORE
             WRITE REPORT-RECORD FROM HACK-OUT-FIELDS
              AFTER ADVANCING 1 LINE.
