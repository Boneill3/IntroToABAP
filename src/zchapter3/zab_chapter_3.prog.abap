REPORT zab_chapter_3.

"Listing 3.1
DATA: my_variable       TYPE i,
      my_other_variable TYPE string VALUE 'Hello World'.

"Listing 3.2
DATA: multiple_characters TYPE c LENGTH 5 VALUE 'fiver',
      single_character    TYPE c VALUE 'A'.

"Listing 3.3
DATA: character_variable TYPE c LENGTH 2 VALUE 'My variable'.
WRITE: character_variable.

"Listing 3.4
DATA: my_boolean TYPE abap_bool.
my_boolean = abap_true.

"Listing 3.5
DATA: BEGIN OF customer,
        customer_id   TYPE i,
        customer_name TYPE string,
      END OF customer.

"Listing 3.6
customer-customer_id = 1.
customer-customer_name = 'My First Customer'.

"Listing 3.7
"Code from listing 3.5 commented out
DATA: "BEGIN OF customer,
*        customer_id   TYPE i,
*        customer_name TYPE string,
*      END OF customer,
      customers LIKE STANDARD TABLE OF customer.

customer-customer_id = 1.
customer-customer_name = 'My First Customer'.
INSERT customer INTO TABLE customers.
customer-customer_id = 2.
customer-customer_name = 'My Second Customer'.
INSERT customer INTO TABLE customers.

"Listing 3.8
DATA: traditional_integer TYPE integer.
traditional_integer = 10.

"Listing 3.9
CONSTANTS: c_thing_one TYPE string VALUE 'Thing One',
           c_thing_two TYPE string VALUE 'Thing Two'.

"Listing 3.10
"Intentional Compiler Error Commented Out
CONSTANTS: c_my_constant TYPE string VALUE 'Something'.
*c_my_constant = 'Something else'.

"Listing 3.11
DATA: current_date TYPE d.
current_date = sy-datum.

"Listing 3.12
DATA: my_integer TYPE i.
my_integer = 3.

"Listing 3.13
DATA: my_result TYPE decfloat16.
my_result = ( 3 + 3 ) * ( 10 * 10 ).
WRITE my_result.
my_result = 3 + 3 * 10 * 10.
WRITE / my_result.

"Listing 3.14
"Code from listing 3.13 commented out
CONSTANTS c_case_size TYPE i VALUE 12.
*DATA my_result TYPE decfloat16.
my_result = 24 / c_case_size.

"Listing 3.15
DATA: full_cases     TYPE i,
      single_bottles TYPE i.
full_cases = 28 DIV c_case_size.
single_bottles  = 28 MOD c_case_size.

"Listing 3.16
"Code from listing 3.13 commented out
*DATA: my_result TYPE decfloat16.
my_result = 10 ** 3.

"Listing 3.17
DATA: this_is_ten   TYPE decfloat16 VALUE 10,
      this_is_three TYPE i VALUE 3.
my_result = this_is_ten ** this_is_three.

"Listing 3.18
"Code from listing 3.13 commented out
*DATA: my_result type i.
my_result = abs( -10 ).

"Listing 3.19
DATA: my_value     TYPE decfloat16 VALUE '1.16',
      result_floor TYPE i,
      result_ceil  TYPE i.
result_floor = floor( my_value ).
result_ceil = ceil( my_value ).

"Listing 3.20
DATA my_number TYPE i.
my_number = 3 * 2.
WRITE: 'My number is' , my_number.
CLEAR my_number.
WRITE: / 'And now my number is' , my_number.

"Listing 3.21
"Commented out to avoid conflict with listing 3.3
*DATA my_result TYPE string VALUE 'My value'.
*my_result = 'Different value'.
*CLEAR my_result.
*WRITE 'Result is', my_result.

"Listing 3.22
DATA: variable_one      TYPE i,
      variable_two      TYPE i,
      my_structure      TYPE sflight,
      my_internal_table TYPE STANDARD TABLE OF sflight.
CLEAR: variable_one, variable_two, my_structure,
my_internal_table.

"Listing 3.23
DATA: my_test TYPE i.
my_test = 1.
IF my_test = 1.
  WRITE: 'True'.
ENDIF.

"Listing 3.24
"Code from listing 3.23 commented out
*DATA: my_test TYPE i.
my_test = 2.
IF my_test = 1.
  WRITE: 'True'.
ELSE.
  WRITE: 'False'.
ENDIF.

"Listing 3.25
DATA: test_a TYPE abap_bool,
      test_b TYPE abap_bool.
test_a = abap_true.
test_b = abap_false.
IF test_a = abap_true AND test_b = abap_true.
  WRITE: 'True'.
ELSE.
  WRITE: 'False'.
ENDIF.

"Listing 3.26
IF test_a = abap_true OR test_b = abap_true.
  WRITE: 'True'.
ELSE.
  WRITE: 'False'.
ENDIF.

"Listing 3.27
DATA: test_true  TYPE c LENGTH 1,
      test_false TYPE c LENGTH 1.
*[...some code...]
IF  ( test_true = abap_true OR test_true = 'Y' ) AND
( test_false = abap_false OR test_false = 'N' ).
  WRITE: 'This works'.
ENDIF.

"Listing 3.28
DATA: my_age TYPE i.
my_age = 2.
IF my_age = 0.
  WRITE: 'I am a newborn!'.
ELSEIF my_age < 1.
  WRITE: 'I am a baby!'.
ELSEIF my_age < 5.
  WRITE: 'I am a toddler!'.
ELSEIF my_age < 11.
  WRITE: 'I am a big kid!'.
ELSEIF my_age BETWEEN 11 AND 19.
  WRITE: 'I am a teenager!'.
ELSE.
  WRITE: 'I am not a kid anymore :('.
ENDIF.

"Listing 3.29
DATA: my_string TYPE string VALUE 'ACDE'.
IF my_string CA 'AB'.
  WRITE: 'This string contains letters A or B'.
ENDIF.

"Listing 3.30
"Code from listing 3.13 commented out
*DATA: my_test TYPE i.
my_test = 1.
CASE my_test.
  WHEN 0.
    WRITE: '0'.
  WHEN 1.
    WRITE: '1'.
  WHEN 2.
    WRITE: '2'.
  WHEN OTHERS.
    WRITE: 'Others'.
ENDCASE.

"Listing 3.31
DATA: my_string_test TYPE string.
my_string_test = 'APPLE'.
CASE my_string_test.
  WHEN 'APPLE' OR 'ORANGE'.
    WRITE: 'This is a fruit'.
  WHEN 'CARROT' OR 'PEAS' OR 'CAULIFLOWER'.
    WRITE: 'This is a vegetable'.
  WHEN OTHERS.
    WRITE: 'Others'.
ENDCASE.

"Listing 3.32
"Code from listing 3.31 commented out
"DATA: my_string_test TYPE string.
my_string_test = 'apple'.
CONSTANTS: c_fruit_1     TYPE string VALUE 'apple',
           c_fruit_2     TYPE string VALUE 'orange',
           c_vegetable_1 TYPE string VALUE 'carrot',
           c_vegetable_2 TYPE string VALUE 'peas',
           c_vegetable_3 TYPE string VALUE 'cauliflower'.
CASE my_string_test.
  WHEN c_fruit_1 OR c_fruit_2.
    WRITE: 'This is a fruit'.
  WHEN c_vegetable_1 OR c_vegetable_2 OR c_vegetable_3.
    WRITE: 'This is a vegetable'.
  WHEN OTHERS.
    WRITE: 'Others'.
ENDCASE.

"Listing 3.33
DATA: variable_1 TYPE abap_bool VALUE abap_true,
      variable_2 TYPE abap_bool VALUE abap_false,
      variable_3 TYPE abap_bool VALUE abap_false.

CASE abap_true.
  WHEN variable_1 OR variable_2 OR variable_3.
    WRITE: 'This variable has value abap_true'.
ENDCASE.

"Listing 3.34
"Code from listing 3.13 commented out
*DATA: my_test TYPE i VALUE 0.
DO 5 TIMES.
  my_test = my_test + 1.
ENDDO.
WRITE: my_test.

"Listing 3.35
"Code from listing 3.13 commented out
*DATA: my_test TYPE i VALUE 0.
WHILE my_test < 5.
  WRITE: my_test.
  my_test = my_test + 1.
ENDWHILE.

"Listing 3.36
PARAMETERS: p_listbx TYPE boolean AS LISTBOX VISIBLE LENGTH 10,
            p_chkbox TYPE boolean AS CHECKBOX,
            p_radio1 TYPE boolean RADIOBUTTON GROUP grp DEFAULT 'X',
            p_radio2 TYPE boolean RADIOBUTTON GROUP grp,
            p_input  TYPE string OBLIGATORY.

"Listing 3.37
"Code from listing 3.36 commented out
PARAMETERS: "p_radio1 TYPE boolean RADIOBUTTON GROUP grp,
  "p_radio2 TYPE boolean RADIOBUTTON GROUP grp,
  p_radio3 TYPE boolean RADIOBUTTON GROUP grp2,
  p_radio4 TYPE boolean RADIOBUTTON GROUP grp2.

"Listing 3.38
PARAMETERS: p_lcase  TYPE string LOWER CASE,
            p_nocase TYPE string.
WRITE: 'This is p_lcase:', p_lcase.
WRITE: / 'This is p_nocase:', p_nocase.

"Listing 3.39
DATA: airportid TYPE sairport-id.
SELECT-OPTIONS: so_air FOR airportid.

"Listing 3.40
"Code from listing 3.36 commented out
SELECTION-SCREEN BEGIN OF SCREEN 2000.
*    PARAMETER p_input TYPE string.
SELECTION-SCREEN END OF SCREEN 2000.

"Listing 3.41
"code from listing 3.36 commented out
SELECTION-SCREEN BEGIN OF BLOCK selection WITH FRAME TITLE TEXT-001.
*PARAMETERS:
*  p_listbx TYPE boolean AS LISTBOX VISIBLE LENGTH 10,
*  p_chkbox TYPE boolean AS CHECKBOX,
*  p_radio1 TYPE boolean RADIOBUTTON GROUP grp,
*  p_radio2 TYPE boolean RADIOBUTTON GROUP grp,
*  p_input  TYPE string.
SELECTION-SCREEN END OF BLOCK selection.
CALL SELECTION-SCREEN 2000.

"Listing 3.42
PARAMETERS: p_date TYPE d.

INITIALIZATION.
  p_date = sy-datum - 7.

  "Listing 3.43
  "code from listing 3.36, 3.41 changed
  SELECTION-SCREEN BEGIN OF BLOCK selection2
    WITH FRAME TITLE TEXT-001.
  PARAMETER p_input2 TYPE string.
  SELECTION-SCREEN END OF BLOCK selection2.

AT SELECTION-SCREEN.
  IF p_input <> 'HELLO WORLD'.
    MESSAGE e000(38) WITH 'Invalid Entry'.
  ENDIF.

START-OF-SELECTION.
  WRITE: p_input.

  "Listing 3.44
  "code from listing 3.36 commented out
*  PARAMETERS p_input TYPE string.

AT SELECTION-SCREEN ON p_input.
  IF p_input CS 'A'.
    MESSAGE e000(38) WITH 'This input contains letter A'.
  ENDIF.

  "Listing 3.45
  DATA: my_var       TYPE i,
        my_variable  TYPE i,
        my_other_var TYPE i.

  "Listing 3.46
  "Declare Data
  DATA: my_title TYPE string. "title

  "Listing 3.47
  DATA: total TYPE i VALUE 5.
  "All totals must be multiplied by 5 due to local regulations
  total = total * 5.
  WRITE: total.

  "Listing 3.48
  "total = total + 5.
total = total + 6.

"Listing 3.49 can be found in program ZAB_SAMPLE1

"Listing 3.50 can be found in program ZAB_PROBLEM1
