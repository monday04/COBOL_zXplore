//CBL2000J JOB 1,NOTIFY=&SYSUID
//***************************************************/
//COBRUN  EXEC IGYWCL
//COBOL.SYSIN  DD DSN=&SYSUID..CBL(CBL2000),DISP=SHR
//LKED.SYSLMOD DD DSN=&SYSUID..LOAD(CBL2000),DISP=SHR
//***************************************************/
// IF RC = 0 THEN
//***************************************************/
//STEP1   EXEC PGM=CBL2000
//STEPLIB   DD DISP=SHR,DSN=&SYSUID..LOAD
//AGEFILE   DD DISP=SHR,DSN=&SYSUID..INPUT.AGE
//ETHFILE   DD DISP=SHR,DSN=&SYSUID..INPUT.ETHNIC
//INDFILE   DD DISP=SHR,DSN=&SYSUID..INPUT.INDUS3
//RCEFILE   DD DISP=SHR,DSN=&SYSUID..INPUT.RACE
//SEXFILE   DD DISP=SHR,DSN=&SYSUID..INPUT.SEX
//* ------------ update KSDS file ------------------*/
//CLAFILE   DD DISP=SHR,DSN=&SYSUID..CLUSTER.CLAIMS
//SYSOUT    DD SYSOUT=*
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//***************************************************/
// ELSE
// ENDIF
