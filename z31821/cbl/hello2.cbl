       IDENTIFICATION DIVISION.                                         00010000
       PROGRAM-ID. HELLO2.                                              00020000
       ENVIRONMENT DIVISION.                                            00030000
       INPUT-OUTPUT SECTION.                                            00031000
       FILE-CONTROL.                                                    00032000
           SELECT OUTPUT-FILE ASSIGN TO "OUTPUT"                        00033000
               ORGANIZATION IS SEQUENTIAL                               00034001
               ACCESS MODE IS SEQUENTIAL                                00034101
               FILE STATUS IS WS-FILE-STATUS.                           00034201
                                                                        00034300
       DATA DIVISION.                                                   00034400
                                                                        00034500
       FILE SECTION.                                                    00036000
       FD OUTPUT-FILE.                                                  00037000
       01 OUTPUT-LINE PIC X(80).                                        00038000
                                                                        00038100
       WORKING-STORAGE SECTION.                                         00039000
       01 WS-OUTPUT-LINE PIC X(80).                                     00039100
       01 WS-FILE-STATUS PIC XX.                                        00039201
                                                                        00039300
       PROCEDURE DIVISION.                                              00050000
         MAIN-PARA.                                                     00060000
           OPEN OUTPUT OUTPUT-FILE.                                     00070000
           DISPLAY "File Status: " WS-FILE-STATUS.                      00071001
                                                                        00072001
           MOVE "Hello World!" TO WS-OUTPUT-LINE.                       00080000
           WRITE OUTPUT-LINE FROM WS-OUTPUT-LINE.                       00090000
                                                                        00091001
           CLOSE OUTPUT-FILE.                                           00100000
           DISPLAY "File Status: " WS-FILE-STATUS.                      00101001
                                                                        00102001
           STOP RUN.                                                    00110000
