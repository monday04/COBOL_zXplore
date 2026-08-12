      * this is a copy book for the ksds file 'claims'                  00010000
      *   01  CLAIMS-RECORD.                                            00020000
             05  CL-REC-KEY            PIC X(8).                        00030000
             05  CL-REC-DATE           PIC X(10).                       00040000
             05  CL-REC-AGE.                                            00050000
                 07  CL-AGE-INA        PIC 99    COMP-3.                00060000
                 07  CL-AGE-U22        PIC 99999 COMP-3.                00070000
                 07  CL-AGE-2324       PIC 99999 COMP-3.                00080000
                 07  CL-AGE-2534       PIC 99999 COMP-3.                00090000
                 07  CL-AGE-3544       PIC 99999 COMP-3.                00100000
                 07  CL-AGE-4554       PIC 99999 COMP-3.                00110000
                 07  CL-AGE-5559       PIC 99999 COMP-3.                00120000
                 07  CL-AGE-6064       PIC 99999 COMP-3.                00130000
                 07  CL-AGE-GE65       PIC 99999 COMP-3.                00140000
             05  CL-REC-ETHNICITY.                                      00150000
                 07  CL-ETH-INA        PIC 99999 COMP-3.                00160000
                 07  CL-ETH-HIS-LAT    PIC 99999 COMP-3.                00170000
                 07  CL-ETH-N-HIS-LAT  PIC 99999 COMP-3.                00180000
             05  CL-REC-INDUSTRY.                                       00190000
                 07  CL-IND-INA        PIC 99999 COMP-3.                00200000
                 07  CL-IND-WHNR       PIC 99999 COMP-3.                00210000
                 07  CL-IND-TRWA       PIC 99999 COMP-3.                00220000
                 07  CL-IND-CONST      PIC 99999 COMP-3.                00230000
                 07  CL-IND-FIIN       PIC 99999 COMP-3.                00240000
                 07  CL-IND-MANU       PIC 99999 COMP-3.                00250000
                 07  CL-IND-AFFH       PIC 99999 COMP-3.                00260000
                 07  CL-IND-PUAD       PIC 99999 COMP-3.                00270000
                 07  CL-IND-UTI        PIC 99999 COMP-3.                00280000
                 07  CL-IND-ACFS       PIC 99999 COMP-3.                00290000
                 07  CL-IND-INFOR      PIC 99999 COMP-3.                00300000
                 07  CL-IND-PSTS       PIC 99999 COMP-3.                00310000
                 07  CL-IND-OS         PIC 99999 COMP-3.                00320000
                 07  CL-IND-MCE        PIC 99999 COMP-3.                00330000
                 07  CL-IND-ES         PIC 99999 COMP-3.                00340000
                 07  CL-IND-MINE       PIC 99999 COMP-3.                00350000
                 07  CL-IND-HCSA       PIC 99999 COMP-3.                00360000
                 07  CL-IND-AER        PIC 99999 COMP-3.                00370000
                 07  CL-IND-ASWMRS     PIC 99999 COMP-3.                00380000
                 07  CL-IND-RT         PIC 99999 COMP-3.                00390000
             05  CL-REC-RACE.                                           00400000
                 07  CL-RCE-INA        PIC 99999 COMP-3.                00410000
                 07  CL-RCE-WHITE      PIC 999999 COMP-3.               00420000
                 07  CL-RCE-ASIAN      PIC 99999 COMP-3.                00430000
                 07  CL-RCE-BLACK      PIC 99999 COMP-3.                00440000
                 07  CL-RCE-AMEIND     PIC 99999 COMP-3.                00450000
                 07  CL-RCE-NHOPI      PIC 99999 COMP-3.                00460000
             05  CL-REC-SEX.                                            00470000
                 07  CL-SEX-INA        PIC 99     COMP-3.               00480000
                 07  CL-SEX-MALE       PIC 999999 COMP-3.               00490000
                 07  CL-SEX-FEMALE     PIC 999999 COMP-3.               00500000
