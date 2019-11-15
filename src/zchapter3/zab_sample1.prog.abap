"Listing 3.49
REPORT zab_sample1.

DATA: result TYPE decfloat16.
SELECTION-SCREEN BEGIN OF BLOCK selection WITH FRAME.
PARAMETERS:
  p_val1   TYPE decfloat34,
  p_add    TYPE abap_bool RADIOBUTTON GROUP grp DEFAULT 'X',
  p_subt   TYPE abap_bool RADIOBUTTON GROUP grp,
  p_multi  TYPE abap_bool RADIOBUTTON GROUP grp,
  p_divide TYPE abap_bool RADIOBUTTON GROUP grp,
  p_power  TYPE abap_bool RADIOBUTTON GROUP grp,
  p_val2   TYPE decfloat34.
SELECTION-SCREEN END OF BLOCK selection.

AT SELECTION-SCREEN.
  IF p_divide = abap_true AND p_val2 = 0.
    MESSAGE  'Cannot divide by zero' TYPE 'E'.
  ENDIF.

START-OF-SELECTION.
  IF p_add = abap_true.
    result = p_val1 + p_val2.
  ELSEIF p_subt = abap_true.
    result = p_val1 - p_val2.
  ELSEIF p_multi = abap_true.
    result = p_val1 * p_val2.
  ELSEIF p_divide = abap_true.
    result = p_val1 / p_val2.
  ELSEIF p_power = abap_true.
    result = ipow( base = p_val1 exp = p_val2 ).
  ENDIF.
  WRITE: result.
