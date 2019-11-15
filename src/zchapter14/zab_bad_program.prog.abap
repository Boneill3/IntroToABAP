REPORT zab_bad_program.

DATA: variable_not_needed.
PARAMETERS: p_carrid TYPE sflight-carrid.

START-OF-SELECTION.
  DATA: another_variable TYPE sflight-connid.
  PERFORM do_stuff USING another_variable.
FORM do_stuff USING i_variable.
  CASE i_variable.
    WHEN '123'.
      MESSAGE e000(38) WITH 'Variable is 123'.
    WHEN OTHERS.
* Do nothing
  ENDCASE.
ENDFORM.
