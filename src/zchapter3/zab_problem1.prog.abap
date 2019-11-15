"Listing 3.50
REPORT zab_problem1.

SELECTION-SCREEN BEGIN OF BLOCK selection
  WITH FRAME TITLE TEXT-001.
PARAMETERS: p_item TYPE string,
            p_cost TYPE p DECIMALS 2,
            p_quan TYPE i.
SELECTION-SCREEN END OF BLOCK selection.

AT SELECTION-SCREEN.
  IF p_quan > 999.
    MESSAGE 'Please enter quantity less than 999' TYPE 'E'.
  ENDIF.

START-OF-SELECTION.
  DATA: total_cost TYPE p DECIMALS 2.
  total_cost = p_cost * p_quan.

  WRITE: 'The cost of ', p_quan, ' ', p_item, '(s) is ',
    total_cost.
