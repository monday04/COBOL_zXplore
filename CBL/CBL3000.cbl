      * This program is the main COBOL program that call the subroutine
      * SR3000A to create a report based on the input parameters given.
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
         PROGRAM-ID. CBL3000.
         AUTHOR. Zethlene de los Reyes.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         FILE SECTION.
         WORKING-STORAGE SECTION.
         COPY CLAIMS.
         01 WS-CLAIMS-RECORD        PIC X(142).
         01 WS-RETURN-CODE          PIC X(002).

         LINKAGE SECTION.
         01 P-BLOCK.
            05 P-LENGTH               PIC S9(4) COMP.
            05 P-RECORD-ID            PIC X(008).


      *-----------------------------------------------------------------
       PROCEDURE DIVISION USING P-BLOCK.
      *  make sure all inputs other than the record-id are covered.
           IF P-RECORD-ID = LOW-VALUES 
           OR P-RECORD-ID = SPACES 
           OR P-RECORD-ID = '*'
              MOVE "ALL" TO P-RECORD-ID
           END-IF.
           CALL 'SR2000A' USING P-RECORD-ID WS-CLAIMS-RECORD
                                WS-RETURN-CODE .

           IF WS-RETURN-CODE NOT = "00"
              DISPLAY "no record found for " P-RECORD-ID
           ELSE
              MOVE WS-CLAIMS-RECORD TO CLAIMS-RECORD 
              DISPLAY "Record ID   :" CL-REC-KEY
              DISPLAY "Record Date :" CL-REC-DATE
              DISPLAY "Age Information --------------------------------"
              DISPLAY "INA         :" CL-AGE-INA
              DISPLAY "Under 22    :" CL-AGE-U22
              DISPLAY "23-24       :" CL-AGE-2324
              DISPLAY "25-34       :" CL-AGE-2534
              DISPLAY "35-44       :" CL-AGE-3544
              DISPLAY "45-54       :" CL-AGE-4554
              DISPLAY "55-59       :" CL-AGE-5559
              DISPLAY "60-64       :" CL-AGE-6064
              DISPLAY "Greater 64  :" CL-AGE-GE65
              DISPLAY "Ethnicity Information --------------------------"
              DISPLAY "INA         :" CL-ETH-INA
              DISPLAY "Hispanic Lat:" CL-ETH-HIS-LAT
              DISPLAY "Not Hisp/Lat:" CL-ETH-N-HIS-LAT
              DISPLAY "Race Information -------------------------------"
              DISPLAY "INA         :" CL-RCE-INA
              DISPLAY "White       :" CL-RCE-WHITE
              DISPLAY "Asian       :" CL-RCE-ASIAN
              DISPLAY "Black       :" CL-RCE-BLACK
              DISPLAY "American Ind:" CL-RCE-AMEIND
              DISPLAY "Nat.Hawai PI:" CL-RCE-NHOPI
              DISPLAY "Sex Information --------------------------------"
              DISPLAY "INA         :" CL-SEX-INA
              DISPLAY "Male        :" CL-SEX-MALE
              DISPLAY "Female      :" CL-SEX-FEMALE
              DISPLAY "Industry Information ---------------------------"
              DISPLAY "INA            :" CL-IND-INA
              DISPLAY "Wholesale Trade:" CL-IND-WHNR
              DISPLAY "Retail Trade   :" CL-IND-RT
              DISPLAY "Construction   :" CL-IND-CONST
              DISPLAY "Manufacturing  :" CL-IND-MANU
              DISPLAY "Utilities      :" CL-IND-UTI
              DISPLAY "Information    :" CL-IND-INFOR
              DISPLAY "Other Services :" CL-IND-OS
              DISPLAY "Mining         :" CL-IND-MINE
              DISPLAY "Educational Services:" CL-IND-ES
              DISPLAY "Public Administration:" CL-IND-PUAD
              DISPLAY "Finance and Insurance:" CL-IND-FIIN
              DISPLAY "Transportation and Warehouse:" CL-IND-TRWA
              DISPLAY "Accomodation and Food Services:" CL-IND-ACFS
              DISPLAY "Health Care & Social Assistance:" CL-IND-HCSA
              DISPLAY "Arts, Entertainment & Recreation:" CL-IND-AER
              DISPLAY "Admin.& Support/Waste Management:" CL-IND-ASWMRS
              DISPLAY "Agriculture/Forestry/Fishing/Hunting:"
                       CL-IND-AFFH
              DISPLAY "Professional/Scientific/Tech.Services:" 
                       CL-IND-PSTS
              DISPLAY "Management of Companies and Enterprises:"
                       CL-IND-MCE
           END-IF.

           STOP RUN.
