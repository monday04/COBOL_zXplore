       IDENTIFICATION DIVISION.
      ******************************************************************
       PROGRAM-ID.  SR3000A.
       AUTHOR. Zethlene de los Reyes.
       ENVIRONMENT DIVISION.
         CONFIGURATION SECTION.
         INPUT-OUTPUT SECTION.
         FILE-CONTROL.
             SELECT CLAIMS-FILE ASSIGN TO CLAFILE
                 ORGANIZATION IS INDEXED
                 ACCESS MODE IS RANDOM
                 RECORD KEY IS CL-REC-KEY
                 FILE STATUS IS WS-CLA-FS.
       DATA DIVISION.
         FILE SECTION.
         FD  CLAIMS-FILE.
         01  CLAIMS-RECORD.
             COPY CLAIMS.

         WORKING-STORAGE SECTION.
         01 WS-CLA-FS                 PIC X(002).

         LINKAGE SECTION.
         01  LS-CLAIMS-KEY            PIC X(008).
         01  LS-CLAIMS-RECORD.
             COPY CLAIMS.

       PROCEDURE DIVISION USING LS-CLAIMS-KEY LS-CLAIMS-RECORD.
         0000-MAIN.
           OPEN INPUT CLAIMS-FILE.
             DISPLAY "claims file open: " WS-CLA-FS.
            
           PERFORM 1000-PROCESS-INPUT.
           
           CLOSE CLAIMS-FILE.

           MOVE ZERO TO RETURN-CODE.
           GOBACK.
      *----------------------------------------------------------------*         
      * subroutines
         1000-PROCESS-INPUT.
           IF LS-CLAIMS-KEY NOT = "ALL" THEN
              MOVE LS-CLAIMS-KEY TO CL-REC-KEY OF CLAIMS-RECORD 
              READ CLAIMS-FILE KEY IS CL-REC-KEY OF CLAIMS-RECORD 
              INVALID KEY
      *          record doesn't exist
                DISPLAY "invalid record key: " 
                  CL-REC-KEY OF CLAIMS-RECORD 

               NOT INVALID KEY
      *          record exist. send to calling program.
                 MOVE CLAIMS-RECORD TO LS-CLAIMS-RECORD
              END-READ
           ELSE
              DISPLAY "user wants all records in the file"
              DISPLAY "code coming in soon..."
           END-IF. 


