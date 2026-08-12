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
         COPY CLAIMS.

         WORKING-STORAGE SECTION.
         01 WS-CLA-FS                 PIC X(002).

         LINKAGE SECTION.
         01  LS-CLAIMS-KEY            PIC X(008).
         01  LS-CLAIMS-DATA           PIC X(142).

       PROCEDURE DIVISION USING LS-CLAIMS-KEY LS-CLAIMS-DATA.
           OPEN INPUT CLAIMS-FILE.
             DISPLAY "claims file open: " WS-CLA-FS.

           MOVE LS-CLAIMS-KEY TO CL-REC-KEY
           READ CLAIMS-FILE KEY IS CL-REC-KEY
             INVALID KEY
      *          record doesn't exist
               DISPLAY "invalid record key: " CL-REC-KEY

              NOT INVALID KEY
      *          record exist. send to calling program.
                MOVE CLAIMS-RECORD TO LS-CLAIMS-DATA
           END-READ.

           CLOSE CLAIMS-FILE.

           MOVE ZERO TO RETURN-CODE.
           GOBACK.

