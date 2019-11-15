REPORT zab_chapter12.

"Listing 12.1
DATA: my_date TYPE d VALUE '20190102',
      year    TYPE i,
      month   TYPE i,
      day     TYPE i.

year = substring( val = my_date off = 0 len = 4 ).
month = substring( val = my_date off = 4 len = 2 ).
day = substring( val = my_date off = 6 len = 2 ).

"Listing 12.2
my_date = my_date + 35.

"Listing 12.3
my_date = my_date + 35.

"Listing 12.4
DATA: start_date TYPE d.

start_date = '20190101'.
my_date = start_date + 70.
WRITE: 'Date in a regular year:', 25 my_date.
start_date = '20200101'.
my_date = start_date + 70.
WRITE: / 'Date in a leap year:', 25 my_date.

"Listing 12.5
CALL FUNCTION 'RP_CALC_DATE_IN_INTERNAL'
  EXPORTING
    date      = my_date
    days      = 0
    months    = 1
    years     = 0
  IMPORTING
    calc_date = my_date.

"Listing 12.6
DATA: one_date     TYPE d VALUE '20190801',
      another_date TYPE d.
another_date = one_date + 1.
IF another_date > one_date.
  WRITE: 'True'.
ELSE.
  WRITE: 'False'.
ENDIF.

"Listing 12.7
DATA: my_integer TYPE i.
my_date = '20190230'.
my_integer = my_date.
IF my_integer = 0.
  WRITE: / 'Date is invalid'.
ENDIF.

"Listing 12.8
PARAMETERS: p_date TYPE d OBLIGATORY.
DATA: simple_date  TYPE d,
      factory_date TYPE scal-facdate.
simple_date = p_date.
WRITE: / 'Date entered:', p_date.
CALL FUNCTION 'DATE_CONVERT_TO_FACTORYDATE'
  EXPORTING
    date                         = simple_date
    factory_calendar_id          = 'US'
  IMPORTING
    factorydate                  = factory_date
  EXCEPTIONS
    calendar_buffer_not_loadable = 1
    correct_option_invalid       = 2
    date_after_range             = 3
    date_before_range            = 4
    date_invalid                 = 5
    factory_calendar_not_found   = 6
    OTHERS                       = 7.
IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.
ADD 10 TO factory_date.
CALL FUNCTION 'FACTORYDATE_CONVERT_TO_DATE'
  EXPORTING
    factorydate                  = factory_date
    factory_calendar_id          = 'US'
  IMPORTING
    date                         = simple_date
  EXCEPTIONS
    calendar_buffer_not_loadable = 1
    factorydate_after_range      = 2
    factorydate_before_range     = 3
    factorydate_invalid          = 4
    factory_calendar_id_missing  = 5
    factory_calendar_not_found   = 6
    OTHERS                       = 7.
IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.
WRITE: / 'Result:', simple_date.

"Listing 12.9
DATA: my_datum TYPE datum VALUE '20190801'.
WRITE: 'Type DATUM:', my_datum.
"DATA: my_date TYPE d VALUE '20190801'.
WRITE: /'Type D:', my_date.

"Listing 12.10
DATA: today       TYPE sy-datum,
      today_local TYPE sy-datlo,
      factory_day TYPE sy-fdayw.
today = sy-datum.
today_local = sy-datlo.
factory_day = sy-fdayw.

"Listing 12.11
"New Open SQL
SELECT *
FROM usr02
INTO TABLE @data(results)
WHERE gltgv <= @sy-datum
AND gltgb >= @sy-datum.
"old Open SQL
*DATA: results TYPE STANDARD TABLE OF USR02.
*SELECT *
*FROM UR02
*INTO TABLE results
*WHERE GLTGV <= sy-datum
*AND GLTGB >= sy-datum.

"Listing 12.12
DATA: one_time     TYPE t,
      another_time TYPE t.
one_time = sy-uzeit.
WRITE: / 'Current time:', one_time.
another_time = one_time + 5.
WRITE: / 'Current time + 5:', another_time.
IF one_time = another_time.
  WRITE: / 'Time is the same'.
ELSE.
  WRITE: / 'Time is different'.
ENDIF.

"Listing 12.13
DATA: my_timestamp  TYPE timestamp,
      my_timestampl TYPE timestampl.
GET TIME STAMP FIELD my_timestamp.
GET TIME STAMP FIELD my_timestampl.
GET TIME STAMP FIELD DATA(my_inline_timestamp).

"Listing 12.14
my_timestamp = '20190101000000'.
my_timestampl = '20190101000000.0000001'.
IF my_timestampl > my_timestamp.
  WRITE: 'True'.
ENDIF.

"Listing 12.15
GET TIME STAMP FIELD DATA(my_utc).
CONVERT TIME STAMP my_utc TIME ZONE 'PST'
INTO DATE DATA(my_pst_date)
TIME DATA(my_pst_time)
DAYLIGHT SAVING TIME DATA(my_dst).

"Listing 12.16
*DATA: my_utc type timestamp,
*my_pst_date type d,
*my_pst_time type t,
*my_dst type abap_bool.
GET TIME STAMP FIELD my_utc.
CONVERT TIME STAMP my_utc TIME ZONE 'PST'
INTO DATE my_pst_date
TIME my_pst_time
DAYLIGHT SAVING TIME my_dst.

"Listing 12.17
CONVERT DATE my_pst_date
TIME my_pst_time
DAYLIGHT SAVING TIME my_dst
INTO TIME STAMP my_utc TIME ZONE 'PST'.

"Listing 12.18
DATA: unformatted TYPE timestampl
VALUE '20190101120000.0000000'.
DATA(my_string) = |{ unformatted TIMESTAMP = ISO }|.

"Listing 12.19
my_string = |{ unformatted TIMESTAMP = ISO
TIMEZONE = 'PST' }|.

"Listing 12.20
DATA: sys_time     TYPE sy-uzeit,
      sys_timezone TYPE sy-tzone,
      loc_time     TYPE sy-timlo,
      loc_timezone TYPE sy-zonlo.
sys_time = sy-uzeit.
sys_timezone = sy-tzone.
loc_time = sy-timlo.
loc_timezone = sy-zonlo.

"Listing 12.21
DATA: my_quantity TYPE i VALUE 5.
CALL FUNCTION 'UNIT_CONVERSION_SIMPLE'
  EXPORTING
    input                = my_quantity
    unit_in              = 'M'
    unit_out             = 'CM'
  IMPORTING
    output               = my_quantity
  EXCEPTIONS
    conversion_not_found = 1
    division_by_zero     = 2
    input_invalid        = 3
    output_invalid       = 4
    overflow             = 5
    type_invalid         = 6
    units_missing        = 7
    unit_in_not_found    = 8
    unit_out_not_found   = 9
    OTHERS               = 10.
IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.
WRITE: my_quantity.

"Listing 12.22
DATA: local_amount TYPE p DECIMALS 2.

CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
  EXPORTING
    date             = sy-datlo
    foreign_amount   = 100
    foreign_currency = 'EUR'
    local_currency   = 'USD'
  IMPORTING
    local_amount     = local_amount
  EXCEPTIONS
    no_rate_found    = 1
    overflow         = 2
    no_factors_found = 3
    no_spread_found  = 4
    derived_2_times  = 5
    OTHERS           = 6.
IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.

"Listing 12.23 - 12.26
"See code example in class ZCL_AB_SHOPPING_CART_12

"Listing 12.27 - 12.39
"See code example in program ZAB_PRODUCT_MAINT_12

"Listing 12.31
"See code example in program ZAB_CART_MAINT_12
