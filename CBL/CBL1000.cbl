      *------------------------------------------------------------
      *  This COBOL program reads the uploaded CSV file and
      *  reformats it to display contents easier to read for the user.
      *------------------------------------------------------------
       IDENTIFICATION DIVISION.
         PROGRAM-ID. CBL1000.
         AUTHOR. Zethlene de los Reyes.
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
         INPUT-OUTPUT SECTION.
         FILE-CONTROL.
             SELECT CSV-FILE ASSIGN TO CSVFILE
                 ORGANIZATION IS SEQUENTIAL
                 FILE STATUS IS WS-INPUT-FILE-STATUS.
      *----------------------------------------------------------------
       DATA DIVISION.
         FILE SECTION.
         FD  CSV-FILE.
         01  CSV-RECORD.
             05  CSV-FIELD          PIC X(150).
      *----------------------------------------------------------------
         WORKING-STORAGE SECTION.
         01  WS-EOF-FLAG                PIC X VALUE 'N'.
             88  EOF-FLAG                     VALUE 'Y'.
             88  NOT-EOF-FLAG                 VALUE 'N'.
         01 WS-INPUT-FILE-STATUS        PIC XX.
         01  WS-REC-COUNT               PIC 9(5) VALUE 0.

         01  WS-CSV-RECORD.
           05  WS-CSV-ID                PIC X(37).
           05  WS-CSV-DATA              PIC X(113).

         01  WS-REC-PREMIUM             PIC X(8).

         01  WS-OUT-LINE               PIC X(40) VALUE ALL "=".
         01  WS-REC-DATE-TIME.
           05  WS-OUT-DATE              PIC X(10).
           05  WS-OUT-TIME              PIC X(14).
         01  WS-OUT-COUNTRY             PIC X(30).
         01  WS-OUT-CCODE               PIC XX.
         01  WS-OUT-SLUG                PIC X(30).
         01  WS-OUT-NCC                 PIC 99999.
         01  WS-OUT-TCC                 PIC 99999.
         01  WS-OUT-NEW-DEATHS          PIC 99999.
         01  WS-OUT-TOTAL-DEATHS        PIC 99999.
         01  WS-OUT-NEW-RECOV           PIC 99999.
         01  WS-OUT-TOTAL-RECOV         PIC 99999.
      *----------------------------------------------------------------
       PROCEDURE DIVISION.
      *----------------------------------------------------------------
       0000-OPEN-FILES.
           OPEN INPUT CSV-FILE
           DISPLAY "file status after open: " WS-INPUT-FILE-STATUS.

       1000-READ-CSV-FILE.
           PERFORM UNTIL EOF-FLAG
              READ CSV-FILE INTO WS-CSV-RECORD
                 AT END
                    SET EOF-FLAG TO TRUE
                 NOT AT END
                    COMPUTE WS-REC-COUNT = WS-REC-COUNT + 1
                    IF WS-REC-COUNT = 1
                       CONTINUE
                    ELSE
                       PERFORM 1100-PROCESS-CSV-RECORD
                       PERFORM 1200-DISPLAY-CSV-RECORD
                    END-IF
              END-READ
           END-PERFORM.

       9000-CLOSE-STOP.
           CLOSE CSV-FILE.
           STOP RUN.

      *----------------------------------------------------------------
       1100-PROCESS-CSV-RECORD.
             UNSTRING WS-CSV-DATA DELIMITED BY ","
               INTO   WS-OUT-COUNTRY
                      WS-OUT-CCODE
                      WS-OUT-SLUG
                      WS-OUT-NCC
                      WS-OUT-TCC
                      WS-OUT-NEW-DEATHS
                      WS-OUT-TOTAL-DEATHS
                      WS-OUT-NEW-RECOV
                      WS-OUT-TOTAL-RECOV
                      WS-REC-DATE-TIME.

       1200-DISPLAY-CSV-RECORD.
             DISPLAY WS-OUT-LINE
             DISPLAY "DATE: " WS-OUT-DATE
             DISPLAY "TIME: " WS-OUT-TIME
             DISPLAY "COUNTRY: " WS-OUT-COUNTRY
             DISPLAY "COUNTRY CODE: " WS-OUT-CCODE
             DISPLAY "SLUG: " WS-OUT-SLUG
             DISPLAY "NEW CONFIRMED CASES: " WS-OUT-NCC
             DISPLAY "TOTAL CONFIRMED CASES: " WS-OUT-TCC
             DISPLAY "NEW DEATHS: " WS-OUT-NEW-DEATHS
             DISPLAY "TOTAL DEATHS: " WS-OUT-TOTAL-DEATHS
             DISPLAY "NEW RECOVERIES: " WS-OUT-NEW-RECOV
             DISPLAY "TOTAL RECOVERIES: " WS-OUT-TOTAL-RECOV.
