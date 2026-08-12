      *------------------------------------------------------------
      *  This COBOL program reads 5 CSV files, extract information and
      *  load data into KSDS database. 5 CSV data are separated into
      *  categories and each category is loaded into the same KSDS
      *  database.
      *------------------------------------------------------------
       IDENTIFICATION DIVISION.
         PROGRAM-ID. CBL2000.
         AUTHOR. Zethlene de los Reyes.
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
         INPUT-OUTPUT SECTION.
         FILE-CONTROL.
             SELECT AGE-FILE ASSIGN TO AGEFILE
                 ORGANIZATION IS SEQUENTIAL
                 FILE STATUS IS WS-AGE-FS.
             SELECT ETHNICITY-FILE ASSIGN TO ETHFILE
                 ORGANIZATION IS SEQUENTIAL
                 FILE STATUS IS WS-ETH-FS.
             SELECT INDUSTRY-FILE ASSIGN TO INDFILE
                 ORGANIZATION IS SEQUENTIAL
                 FILE STATUS IS WS-IND-FS.
             SELECT RACE-FILE ASSIGN TO RCEFILE
                 ORGANIZATION IS SEQUENTIAL
                 FILE STATUS IS WS-RCE-FS.
             SELECT SEX-FILE ASSIGN TO SEXFILE
                 ORGANIZATION IS SEQUENTIAL
                 FILE STATUS IS WS-SEX-FS.
             SELECT CLAIMS-FILE ASSIGN TO CLAFILE
                 ORGANIZATION IS INDEXED
                 ACCESS MODE IS RANDOM
                 RECORD KEY IS CL-REC-KEY
                 FILE STATUS IS WS-CLA-FS.
      *----------------------------------------------------------------
       DATA DIVISION.
         FILE SECTION.
         FD  AGE-FILE RECORDING MODE F.
         01  AGE-RECORD.
             05  AGE-FIELD                PIC X(100).
         FD  ETHNICITY-FILE RECORDING MODE F.
         01  ETHNICITY-RECORD.
             05  ETHNICITY-FIELD          PIC X(55).
         FD  INDUSTRY-FILE RECORDING MODE F.
         01  INDUSTRY-RECORD.
             05  INDUSTRY-FIELD           PIC X(195).
         FD  RACE-FILE RECORDING MODE F.
         01  RACE-RECORD.
             05  RACE-FIELD               PIC X(80).
         FD  SEX-FILE RECORDING MODE F.
         01  SEX-RECORD.
             05  SEX-FIELD                PIC X(50).
         FD  CLAIMS-FILE.
         01  CLAIMS-RECORD.
             05  CL-REC-KEY            PIC X(8).
             05  CL-REC-DATE           PIC X(10).
             05  CL-REC-AGE.
                 07  CL-AGE-INA        PIC 99    COMP-3.
                 07  CL-AGE-U22        PIC 99999 COMP-3.
                 07  CL-AGE-2324       PIC 99999 COMP-3.
                 07  CL-AGE-2534       PIC 99999 COMP-3.
                 07  CL-AGE-3544       PIC 99999 COMP-3.
                 07  CL-AGE-4554       PIC 99999 COMP-3.
                 07  CL-AGE-5559       PIC 99999 COMP-3.
                 07  CL-AGE-6064       PIC 99999 COMP-3.
                 07  CL-AGE-GE65       PIC 99999 COMP-3.
             05  CL-REC-ETHNICITY.
                 07  CL-ETH-INA        PIC 99999 COMP-3.
                 07  CL-ETH-HIS-LAT    PIC 99999 COMP-3.
                 07  CL-ETH-N-HIS-LAT  PIC 99999 COMP-3.
             05  CL-REC-INDUSTRY.
                 07  CL-IND-INA        PIC 99999 COMP-3.
                 07  CL-IND-WHNR       PIC 99999 COMP-3.
                 07  CL-IND-TRWA       PIC 99999 COMP-3.
                 07  CL-IND-CONST      PIC 99999 COMP-3.
                 07  CL-IND-FIIN       PIC 99999 COMP-3.
                 07  CL-IND-MANU       PIC 99999 COMP-3.
                 07  CL-IND-AFFH       PIC 99999 COMP-3.
                 07  CL-IND-PUAD       PIC 99999 COMP-3.
                 07  CL-IND-UTI        PIC 99999 COMP-3.
                 07  CL-IND-ACFS       PIC 99999 COMP-3.
                 07  CL-IND-INFOR      PIC 99999 COMP-3.
                 07  CL-IND-PSTS       PIC 99999 COMP-3.
                 07  CL-IND-OS         PIC 99999 COMP-3.
                 07  CL-IND-MCE        PIC 99999 COMP-3.
                 07  CL-IND-ES         PIC 99999 COMP-3.
                 07  CL-IND-MINE       PIC 99999 COMP-3.
                 07  CL-IND-HCSA       PIC 99999 COMP-3.
                 07  CL-IND-AER        PIC 99999 COMP-3.
                 07  CL-IND-ASWMRS     PIC 99999 COMP-3.
                 07  CL-IND-RT         PIC 99999 COMP-3.
             05  CL-REC-RACE.
                 07  CL-RCE-INA        PIC 99999 COMP-3.
                 07  CL-RCE-WHITE      PIC 999999 COMP-3.
                 07  CL-RCE-ASIAN      PIC 99999 COMP-3.
                 07  CL-RCE-BLACK      PIC 99999 COMP-3.
                 07  CL-RCE-AMEIND     PIC 99999 COMP-3.
                 07  CL-RCE-NHOPI      PIC 99999 COMP-3.
             05  CL-REC-SEX.
                 07  CL-SEX-INA        PIC 99     COMP-3.
                 07  CL-SEX-MALE       PIC 999999 COMP-3.
                 07  CL-SEX-FEMALE     PIC 999999 COMP-3.
      *----------------------------------------------------------------
         WORKING-STORAGE SECTION.
      *----------------------------------------------------------------
         01  WS-FILE-STATUS.
             05  WS-AGE-FS             PIC XX.
             05  WS-ETH-FS             PIC XX.
             05  WS-IND-FS             PIC XX.
             05  WS-RCE-FS             PIC XX.
             05  WS-SEX-FS             PIC XX.
             05  WS-CLA-FS             PIC XX.

         01 WS-AGE-RECORD              PIC X(100).
         01 WS-ETHNICITY-RECORD        PIC X(55).
         01 WS-INDUSTRY-RECORD         PIC X(195).
         01 WS-RACE-RECORD             PIC X(80).
         01 WS-SEX-RECORD              PIC X(50).

         01 WS-REC-KEY                 PIC X(8).
         01 WS-REC-DATE                PIC X(10).

         01  WS-REC-AGE.
           05  WS-AGE-INA        PIC 99.
           05  WS-AGE-U22        PIC 99999.
           05  WS-AGE-2324       PIC 99999.
           05  WS-AGE-2534       PIC 99999.
           05  WS-AGE-3544       PIC 99999.
           05  WS-AGE-4554       PIC 99999.
           05  WS-AGE-5559       PIC 99999.
           05  WS-AGE-6064       PIC 99999.
           05  WS-AGE-GE65       PIC X(5).
         01  WS-REC-ETHNICITY.
           07  WS-ETH-INA        PIC 99999.
           07  WS-ETH-HIS-LAT    PIC 99999.
           07  WS-ETH-N-HIS-LAT  PIC X(5).
         01  WS-REC-INDUSTRY.
           07  WS-IND-INA        PIC 99999.
           07  WS-IND-WHNR       PIC 99999.
           07  WS-IND-TRWA       PIC 99999.
           07  WS-IND-CONST      PIC 99999.
           07  WS-IND-FIIN       PIC 99999.
           07  WS-IND-MANU       PIC 99999.
           07  WS-IND-AFFH       PIC 99999.
           07  WS-IND-PUAD       PIC 99999.
           07  WS-IND-UTI        PIC 99999.
           07  WS-IND-ACFS       PIC 99999.
           07  WS-IND-INFOR      PIC 99999.
           07  WS-IND-PSTS       PIC 99999.
           07  WS-IND-OS         PIC 99999.
           07  WS-IND-MCE        PIC 99999.
           07  WS-IND-ES         PIC 99999.
           07  WS-IND-MINE       PIC 99999.
           07  WS-IND-HCSA       PIC 99999.
           07  WS-IND-AER        PIC 99999.
           07  WS-IND-ASWMRS     PIC 99999.
           07  WS-IND-RT         PIC X(5).
         01  WS-REC-RACE.
           07  WS-RCE-INA        PIC 99999.
           07  WS-RCE-WHITE      PIC 999999.
           07  WS-RCE-ASIAN      PIC 99999.
           07  WS-RCE-BLACK      PIC 99999.
           07  WS-RCE-AMEIND     PIC 99999.
           07  WS-RCE-NHOPI      PIC X(5).
         01  WS-REC-SEX.
           07  WS-SEX-INA        PIC 99.
           07  WS-SEX-MALE       PIC 999999.
           07  WS-SEX-FEMALE     PIC X(6).

         01  F-MOVE-DATA         PIC X.
           88  F-MOVE-AGE        VALUE "1".
           88  F-MOVE-ETH        VALUE "2".
           88  F-MOVE-IND        VALUE "3".
           88  F-MOVE-RCE        VALUE "4".
           88  F-MOVE-SEX        VALUE "5".

      *----------------------------------------------------------------
         PROCEDURE DIVISION.
      *----------------------------------------------------------------
         0000-MAIN-PROCEDURE.
             PERFORM 1000-OPEN-FILES
             PERFORM 2000-READ-AGE-FILE
             PERFORM 3000-READ-ETHNICITY-FILE
             PERFORM 4000-READ-INDUSTRY-FILE
             PERFORM 5000-READ-RACE-FILE
             PERFORM 6000-READ-SEX-FILE
             PERFORM 8000-CLOSE-FILES.
         0000-EXIT.
             STOP RUN.
      *----------------------------------------------------------------
         1000-OPEN-FILES.
             OPEN INPUT AGE-FILE
               DISPLAY "age file open: " WS-AGE-FS
             OPEN INPUT ETHNICITY-FILE
               DISPLAY "ethnicity file open:" WS-ETH-FS
             OPEN INPUT INDUSTRY-FILE
               DISPLAY "industry file open: " WS-IND-FS
             OPEN INPUT RACE-FILE
               DISPLAY "race file open: " WS-RCE-FS
             OPEN INPUT SEX-FILE
               DISPLAY "sex file open: " WS-SEX-FS
             OPEN I-O CLAIMS-FILE
               DISPLAY "claims file open: " WS-CLA-FS.
         1000-EXIT.
             EXIT.

         2000-READ-AGE-FILE.
             PERFORM UNTIL WS-AGE-FS NOT = "00"
               READ AGE-FILE INTO WS-AGE-RECORD
                 AT END
                    MOVE "99" TO WS-AGE-FS
                 NOT AT END
                    PERFORM 2100-PROCESS-AGE-RECORD
                    PERFORM 7000-WRITE-CLAIMS-RECORD
               END-READ
             END-PERFORM.
         2000-EXIT.
             EXIT.

         2100-PROCESS-AGE-RECORD.
             UNSTRING WS-AGE-RECORD DELIMITED BY ","
               INTO   WS-REC-KEY
                      WS-REC-DATE
                      WS-AGE-INA
                      WS-AGE-U22
                      WS-AGE-2324
                      WS-AGE-2534
                      WS-AGE-3544
                      WS-AGE-4554
                      WS-AGE-5559
                      WS-AGE-6064
                      WS-AGE-GE65
             END-UNSTRING.
             MOVE "1" TO F-MOVE-DATA.
         2100-EXIT.
             EXIT.

         3000-READ-ETHNICITY-FILE.
             PERFORM UNTIL WS-ETH-FS NOT = "00"
               READ ETHNICITY-FILE INTO WS-ETHNICITY-RECORD
                 AT END
                    MOVE "99" TO WS-ETH-FS
                 NOT AT END
                    PERFORM 3100-PROCESS-ETHNICITY-RECORD
                    PERFORM 7000-WRITE-CLAIMS-RECORD
               END-READ
             END-PERFORM.
         3000-EXIT.
             EXIT.

         3100-PROCESS-ETHNICITY-RECORD.
             UNSTRING WS-ETHNICITY-RECORD DELIMITED BY ","
               INTO   WS-REC-KEY
                      WS-REC-DATE
                      WS-ETH-INA
                      WS-ETH-HIS-LAT
                      WS-ETH-N-HIS-LAT
             END-UNSTRING.
             MOVE "2" TO F-MOVE-DATA.
         3100-EXIT.
             EXIT.

         4000-READ-INDUSTRY-FILE.
             PERFORM UNTIL WS-IND-FS NOT = "00"
               READ INDUSTRY-FILE INTO WS-INDUSTRY-RECORD
                 AT END
                    MOVE "99" TO WS-IND-FS
                 NOT AT END
                    PERFORM 4100-PROCESS-INDUSTRY-RECORD
                    PERFORM 7000-WRITE-CLAIMS-RECORD
               END-READ
             END-PERFORM.
         4000-EXIT.
             EXIT.

         4100-PROCESS-INDUSTRY-RECORD.
             UNSTRING WS-INDUSTRY-RECORD DELIMITED BY ","
               INTO   WS-REC-KEY
                      WS-REC-DATE
                      WS-IND-INA
                      WS-IND-WHNR
                      WS-IND-TRWA
                      WS-IND-CONST
                      WS-IND-FIIN
                      WS-IND-MANU
                      WS-IND-AFFH
                      WS-IND-PUAD
                      WS-IND-UTI
                      WS-IND-ACFS
                      WS-IND-INFOR
                      WS-IND-PSTS
                      WS-IND-OS
                      WS-IND-MCE
                      WS-IND-ES
                      WS-IND-MINE
                      WS-IND-HCSA
                      WS-IND-AER
                      WS-IND-ASWMRS
                      WS-IND-RT
             END-UNSTRING.
             MOVE "3" TO F-MOVE-DATA.
         4100-EXIT.
             EXIT.

         5000-READ-RACE-FILE.
             PERFORM UNTIL WS-RCE-FS NOT = "00"
               READ RACE-FILE INTO WS-RACE-RECORD
                 AT END
                    MOVE "99" TO WS-RCE-FS
                 NOT AT END
                    PERFORM 5100-PROCESS-RACE-RECORD
                    PERFORM 7000-WRITE-CLAIMS-RECORD
               END-READ
             END-PERFORM.
         5000-EXIT.
             EXIT.

         5100-PROCESS-RACE-RECORD.
             UNSTRING WS-RACE-RECORD DELIMITED BY ","
               INTO   WS-REC-KEY
                      WS-REC-DATE
                      WS-RCE-INA
                      WS-RCE-WHITE
                      WS-RCE-ASIAN
                      WS-RCE-BLACK
                      WS-RCE-AMEIND
                      WS-RCE-NHOPI
             END-UNSTRING.
             MOVE "4" TO F-MOVE-DATA.
         5100-EXIT.
             EXIT.

         6000-READ-SEX-FILE.
               PERFORM UNTIL WS-SEX-FS NOT = "00"
                 READ SEX-FILE INTO WS-SEX-RECORD
                   AT END
                      MOVE "99" TO WS-SEX-FS
                   NOT AT END
                      PERFORM 6100-PROCESS-SEX-RECORD
                      PERFORM 7000-WRITE-CLAIMS-RECORD
                 END-READ
               END-PERFORM.
         6000-EXIT.
             EXIT.

         6100-PROCESS-SEX-RECORD.
             UNSTRING WS-SEX-RECORD DELIMITED BY ","
               INTO   WS-REC-KEY
                      WS-REC-DATE
                      WS-SEX-INA
                      WS-SEX-MALE
                      WS-SEX-FEMALE
             END-UNSTRING.
             MOVE "5" TO F-MOVE-DATA.
         6100-EXIT.
             EXIT.

         7000-WRITE-CLAIMS-RECORD.
             INITIALIZE CLAIMS-RECORD
             MOVE WS-REC-KEY TO CL-REC-KEY
             READ CLAIMS-FILE KEY IS CL-REC-KEY
               INVALID KEY
      *          record doesn't exist
                 PERFORM 7500-MOVE-RECORDS
                 WRITE CLAIMS-RECORD
                   INVALID KEY DISPLAY "write error: " WS-CLA-FS
                 END-WRITE

               NOT INVALID KEY
      *          record exist. update
                 PERFORM 7500-MOVE-RECORDS
                 REWRITE CLAIMS-RECORD
                   INVALID KEY DISPLAY "rewrite error: " WS-CLA-FS
                 END-REWRITE
             END-READ.
             DISPLAY "after read: " WS-CLA-FS
             MOVE SPACE TO F-MOVE-DATA.

         7000-EXIT.
             EXIT.

         7500-MOVE-RECORDS.
             IF F-MOVE-AGE
                MOVE WS-REC-DATE TO CL-REC-DATE
                MOVE WS-AGE-INA  TO CL-AGE-INA
                MOVE WS-AGE-U22  TO CL-AGE-U22
                MOVE WS-AGE-2324 TO CL-AGE-2324
                MOVE WS-AGE-2534 TO CL-AGE-2534
                MOVE WS-AGE-3544 TO CL-AGE-3544
                MOVE WS-AGE-4554 TO CL-AGE-4554
                MOVE WS-AGE-5559 TO CL-AGE-5559
                MOVE WS-AGE-6064 TO CL-AGE-6064
                MOVE FUNCTION TRIM(WS-AGE-GE65 TRAILING) TO CL-AGE-GE65
             END-IF.
             IF F-MOVE-ETH
                MOVE WS-REC-DATE      TO CL-REC-DATE
                MOVE WS-ETH-INA       TO CL-ETH-INA
                MOVE WS-ETH-HIS-LAT   TO CL-ETH-HIS-LAT
                MOVE FUNCTION TRIM(WS-ETH-N-HIS-LAT TRAILING)
                  TO CL-ETH-N-HIS-LAT
             END-IF.
             IF F-MOVE-IND
                MOVE WS-REC-DATE   TO CL-REC-DATE
                MOVE WS-IND-INA    TO CL-IND-INA
                MOVE WS-IND-WHNR   TO CL-IND-WHNR
                MOVE WS-IND-TRWA   TO CL-IND-TRWA
                MOVE WS-IND-CONST  TO CL-IND-CONST
                MOVE WS-IND-FIIN   TO CL-IND-FIIN
                MOVE WS-IND-MANU   TO CL-IND-MANU
                MOVE WS-IND-AFFH   TO CL-IND-AFFH
                MOVE WS-IND-PUAD   TO CL-IND-PUAD
                MOVE WS-IND-UTI    TO CL-IND-UTI
                MOVE WS-IND-ACFS   TO CL-IND-ACFS
                MOVE WS-IND-INFOR  TO CL-IND-INFOR
                MOVE WS-IND-PSTS   TO CL-IND-PSTS
                MOVE WS-IND-OS     TO CL-IND-OS
                MOVE WS-IND-MCE    TO CL-IND-MCE
                MOVE WS-IND-ES     TO CL-IND-ES
                MOVE WS-IND-MINE   TO CL-IND-MINE
                MOVE WS-IND-HCSA   TO CL-IND-HCSA
                MOVE WS-IND-AER    TO CL-IND-AER
                MOVE WS-IND-ASWMRS TO CL-IND-ASWMRS
                MOVE FUNCTION TRIM(WS-IND-RT TRAILING) TO CL-IND-RT
             END-IF.
             IF F-MOVE-RCE
                MOVE WS-REC-DATE   TO CL-REC-DATE
                MOVE WS-RCE-INA    TO CL-RCE-INA
                MOVE WS-RCE-WHITE  TO CL-RCE-WHITE
                MOVE WS-RCE-ASIAN  TO CL-RCE-ASIAN
                MOVE WS-RCE-BLACK  TO CL-RCE-BLACK
                MOVE WS-RCE-AMEIND TO CL-RCE-AMEIND
                MOVE FUNCTION TRIM(WS-RCE-NHOPI TRAILING)
                  TO CL-RCE-NHOPI
             END-IF.
             IF F-MOVE-SEX
                MOVE WS-REC-DATE   TO CL-REC-DATE
                MOVE WS-SEX-INA    TO CL-SEX-INA
                MOVE WS-SEX-MALE   TO CL-SEX-MALE
                MOVE FUNCTION TRIM(WS-SEX-FEMALE TRAILING)
                  TO CL-SEX-FEMALE
             END-IF.
         7500-EXIT.
             EXIT.

        8000-CLOSE-FILES.
             CLOSE AGE-FILE
             CLOSE ETHNICITY-FILE
             CLOSE INDUSTRY-FILE
             CLOSE RACE-FILE
             CLOSE SEX-FILE
             CLOSE CLAIMS-FILE.
               DISPLAY "CLOSE FILES SUCCESSFUL".
        8000-EXIT.
             EXIT.

