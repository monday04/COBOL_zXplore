//CBL1000J JOB ,'&SYSUID.-KSDS',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID
//*
//********************************************************************
//*   JOB  SUBMITTED FROM &SYSUID..MVS.JCL(J0001000)                 ***
//*   DOC: CREATE A KSDS FILE                                      ***
//********************************************************************
//STEP00  EXEC PGM=IDCAMS
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
    DELETE &SYSUID..CLUSTER.CLAIMS CLUSTER PURGE ERASE
/*
// IF RC=0 THEN
//STEP01  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//AMSDUMP  DD SYSOUT=*
//SYSIN    DD *
  DEFINE CLUSTER(NAME(&SYSUID..CLUSTER.CLAIMS) -
    RECORDSIZE(142 142)                      -
    TRACKS(2 1)                              -
    FREESPACE(0 0)                           -
    KEYS(8 0)                                -
    CISZ(4096)                               -
    INDEXED                                  -
    REUSE)                                   -
  INDEX(NAME(&SYSUID..CLUSTER.CLAIMS.INDEX))   -
  DATA(NAME(&SYSUID..CLUSTER.CLAIMS.DATA))
/*
// ENDIF
