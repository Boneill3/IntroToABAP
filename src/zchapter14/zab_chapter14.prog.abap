REPORT zab_chapter14.

"Listing 14.1
"Un-executable template code

"Listing 14.2
PARAMETERS: r_change RADIOBUTTON GROUP r1,
            r_disp   RADIOBUTTON GROUP r1.

IF r_change = abap_true.
  AUTHORITY-CHECK OBJECT 'Z_ENTRT'
  ID 'ACTVT' FIELD '02'.
ELSE.
  AUTHORITY-CHECK OBJECT 'Z_ENTRT'
  ID 'ACTVT' FIELD '03'.
ENDIF.
IF sy-subrc = 0.
  WRITE: 'Authorization check successful'.
ELSE.
  WRITE: 'No authorization'.
ENDIF.

"Listing 14.3
PARAMETERS p_carrid TYPE scarr-carrid.

AT SELECTION-SCREEN.
  AUTHORITY-CHECK OBJECT 'S_CARRID'
  ID 'CARRID' FIELD p_carrid
  ID 'ACTVT' FIELD '03'.
  IF sy-subrc <> 0.
    MESSAGE e000(38) WITH 'No authorization to display airline' p_carrid.
  ENDIF.

  "Listing 14.4
  "See program ZAB_FILE_PRES_SERVER

  "Listing 14.5
  "See program ZAB_FILE_PRES_SERVER_READ

  "Listing 14.6
  "See program ZAB_FILE_COPY

  "Listing 14.7
  "See program ZAB_FILE_WRITE

  "Listing 14.8
  "See program ZAB_FILE_READ

  "Listing 14.9
  "un-executable code for demonstration only

  "Listing 14.10 - 14.11
  "See program zab_unit_test

  "Listing 14.12
  WRITE: 'This is WRITE command'.
  MESSAGE i000(38) WITH 'This is just a message'.

  "Listing 14.13
  "See program zab_bad_program
