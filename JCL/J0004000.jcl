//CBL4000J JOB 1,NOTIFY=&SYSUID
//***************************************************/
//COBRUN  EXEC IGYWCL
//COBOL.SYSIN  DD DSN=&SYSUID..CBL(CBL4000),DISP=SHR
//LKED.SYSLMOD DD DSN=&SYSUID..LOAD(CBL4000),DISP=SHR
//***************************************************/
// IF RC = 0 THEN
//***************************************************/
//STEP1   EXEC PGM=CBL4000
//STEPLIB   DD DISP=SHR,DSN=&SYSUID..LOAD
//HACKER    DD DISP=SHR,DSN=ZOS.PUBLIC.HACKER.NEWS
//HREPORT   DD DSN=&SYSUID..HACKER.REPORT,DISP=OLD
//*             DISP=(NEW,CATLG,DELETE),DCB=(RECFM=FB,LRECL=150),
//*             SPACE=(TRK,(5,1),RLSE)
//SYSOUT    DD SYSOUT=*
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//*------------------------------------------------*/
//STEP2   EXEC PGM=SORT
//SORTIN    DD DISP=SHR,DSN=*.STEP1.HREPORT
//SORTOUT   DD DSN=&SYSUID..HACKER.REPORT.SORTED,
//             DISP=(NEW,CATLG,DELETE),RECFM=FB,
//             SPACE=(TRK,(5,1),RLSE)
//SYSOUT    DD SYSOUT=*
//SYSIN     DD  *
 SORT FIELDS=(144,6,PD,D)
 OUTREC BUILD=(1,9,C'  ',10,96,C' ',106,4,C'   ',110,4,C'    ',
               114,15,C' ',129,16,C'  ',145,6,PD,EDIT=(IIII.TTTTTT))
 OUTFIL FNAMES=SORTOUT,
  HEADER1=(45:'Hacker News Front Page',
           75:DATE=(MDY/),' at ',TIME=(12.),
           /,
           45:'All Mainframe/COBOL Stories',
           /,
           1:168C'-',
           /,
           4:'ID',
           46:'Title',
           108:'Points',
           115:'Comments',
           125:'Author',
           141:'Time',
           161:'Score',
           /,
           1:168C'-'),
  REMOVECC
/*
//***************************************************/
// ENDIF
