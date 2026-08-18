//CBL3000J JOB 1,NOTIFY=&SYSUID                                         JOB03685
//***************************************************/
//STEP1   EXEC PGM=CBL3000,PARM='01012012'
//STEPLIB   DD DSN=&SYSUID..LOAD,DISP=SHR
//* ---------------- INPUT  FILES ----------------- */
//CLAFILE DD DSN=Z31821.CLUSTER.CLAIMS,DISP=SHR
//SYSOUT    DD SYSOUT=*
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY