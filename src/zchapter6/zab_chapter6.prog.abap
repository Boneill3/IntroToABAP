REPORT zab_chapter6.

"Listing 6.1
DATA: plane_type  TYPE s_planetye, "Data Element
      plane_type2 TYPE sflight-planetype. "Table Field

"Listing 6.2
DATA:  flight TYPE sflight.

flight-carrid = 'AA'.
flight-connid = 17.
flight-fldate = 20190101.
MODIFY sflight FROM  flight.

"Listing 6.3
TYPES: t_airline TYPE s_carr_id,
       t_amount  TYPE p DECIMALS 2,
       t_cost    TYPE t_amount.

"Listing 6.4
TYPES: BEGIN OF t_my_structure,
         carrid TYPE sflight-carrid,
         connid TYPE sflight-connid,
       END OF t_my_structure.

"Listing 6.5
TYPES: t_my_table TYPE STANDARD TABLE OF t_my_structure.

"Listing 6.6
DATA: my_structure  TYPE t_my_structure,
      my_table      TYPE t_my_table,
      profit_margin TYPE t_amount.

"Listing 6.7
FIELD-SYMBOLS: <flight> TYPE sflight.

ASSIGN flight TO <flight>.
flight-carrid = 'AA'.
<flight>-carrid = ''.

"Listing 6.8
ASSIGN flight TO FIELD-SYMBOL(<flight2>).
flight-carrid = 'AA'.
<flight2>-carrid = ''.

"Listing 6.9
SELECT *
INTO TABLE @data(results)
FROM sflight.

"Listing 6.10
TYPES: BEGIN OF t_my_type,
         carrid TYPE sflight-carrid,
         connid TYPE sflight-connid,
       END OF  t_my_type.

DATA:  my_table2 TYPE STANDARD TABLE OF t_my_type.

SELECT carrid connid
INTO TABLE  my_table2
FROM sflight.

"Listing 6.11
TYPES: t_my_table_type TYPE STANDARD TABLE OF t_my_type.
DATA:  my_table3 TYPE t_my_table_type.

SELECT carrid connid
INTO TABLE my_table3
FROM sflight.

"Listing 6.12
DATA:  flights TYPE STANDARD TABLE OF sflight
  WITH KEY carrid connid fldate.

"Listing 6.13
TYPES: BEGIN OF my_type,
         id          TYPE c LENGTH 4,
         name        TYPE c LENGTH 35,
         some_number TYPE i,
       END OF my_type.

DATA: my_table4 TYPE STANDARD TABLE OF my_type.

"Listing 6.14
DATA flight_schedule TYPE STANDARD TABLE OF spfli
                      WITH NON-UNIQUE SORTED KEY destination
                           COMPONENTS airpto
                      WITH NON-UNIQUE SORTED KEY departure
                           COMPONENTS airpfrom.

"Listing 6.15
DATA: sorted_flights TYPE SORTED TABLE OF sflight
     WITH UNIQUE KEY carrid connid fldate.
SELECT * INTO TABLE sorted_flights
FROM sflight UP TO 50 ROWS.
cl_demo_output=>display( sorted_flights ).

"Listing 6.16
DATA: flights2 TYPE HASHED TABLE OF sflight
  WITH UNIQUE KEY carrid connid fldate.

"Listing 6.17
TYPES: BEGIN OF t_flights,
         carrid TYPE sflight-carrid,
         fldate TYPE sflight-fldate,
       END OF t_flights.
DATA: flights3 TYPE HASHED TABLE OF t_flights
        WITH UNIQUE KEY carrid.
SELECT carrid fldate
  FROM sflight
  INTO TABLE flights3.

"Listing 6.18
DATA: flights4 TYPE STANDARD TABLE OF sflight,
      flight2  TYPE sflight.
FIELD-SYMBOLS: <flight3> TYPE sflight.

SELECT *
FROM sflight
INTO TABLE  flights4.

READ TABLE  flights4 INTO flight2 INDEX 1.
READ TABLE  flights4 ASSIGNING <flight3> INDEX 1.

"Listing 6.19
SELECT *
FROM sflight
INTO TABLE @DATA(flights5).
READ TABLE  flights INTO DATA(flight3) INDEX 1.
READ TABLE  flights ASSIGNING FIELD-SYMBOL(<flight4>) INDEX 1.

"Listing 6.20
DATA: flights6 TYPE STANDARD TABLE OF sflight,
      flight4  TYPE REF TO sflight.
READ TABLE flights6 REFERENCE INTO flight4 INDEX 1.
"Using inline declarations
READ TABLE  flights6 REFERENCE INTO DATA(another_flight) INDEX 1.

"Listing 6.21
DATA: flight_schedule2 TYPE STANDARD TABLE OF spfli,
      schedule         TYPE spfli.

READ TABLE flight_schedule2 INTO schedule
    WITH KEY airpfrom = 'JFK' airpto = 'LHR'.

"Listing 6.22
DATA: flight_schedule3 TYPE STANDARD TABLE OF spfli
     WITH NON-UNIQUE SORTED KEY destination
          COMPONENTS airpto
     WITH NON-UNIQUE SORTED KEY departure
          COMPONENTS airpfrom.
DATA: schedule2 TYPE REF TO spfli.

READ TABLE flight_schedule REFERENCE INTO schedule2
    WITH KEY destination COMPONENTS airpto = 'LHR'.
READ TABLE flight_schedule REFERENCE INTO schedule2
    WITH KEY departure COMPONENTS airpfrom = 'JFK'.

"Listing 6.23
DATA: airlines TYPE HASHED TABLE OF scarr
        WITH UNIQUE KEY carrid.

SELECT carrid carrname
  FROM scarr
  INTO TABLE airlines.

*Using inline declarations
READ TABLE airlines REFERENCE INTO DATA(airline) WITH TABLE KEY carrid = 'AA'.

*Without inline declarationa
DATA: airline2  TYPE REF TO scarr.
READ TABLE airlines REFERENCE INTO airline2
WITH TABLE KEY carrid = 'AA'.

"Listing 6.24
READ TABLE airlines REFERENCE INTO airline
WITH TABLE KEY carrid = 'AA'.
IF sy-subrc = 0.
  DATA(airline_name) = airline->carrname.
ENDIF.

"Listing 6.25
READ TABLE airlines WITH TABLE KEY carrid = 'AA' TRANSPORTING NO FIELDS.
IF sy-subrc = 0.
  WRITE: / 'Record found!'.
ENDIF.

"Listing 6.26
DATA: flights7         TYPE STANDARD TABLE OF sflight,
      flight5          TYPE sflight,
      flight_reference TYPE REF TO sflight.
FIELD-SYMBOLS: <flight5> TYPE sflight.

SELECT *
FROM sflight
INTO TABLE flights7.

LOOP AT flights7 INTO flight5.
  flight5-carrid = 'AZ'.
ENDLOOP.
LOOP AT flights REFERENCE INTO flight_reference.
  flight_reference->carrid = 'AA'.
ENDLOOP.
LOOP AT flights ASSIGNING <flight>.
  <flight>-carrid = 'AZ'.
ENDLOOP.

"Listing 6.27
SELECT *
FROM sflight
INTO TABLE @DATA(flights8).
LOOP AT flights INTO DATA(flight6).
     flight6-carrid = 'AZ'.
ENDLOOP.
LOOP AT flights REFERENCE INTO DATA(flight_reference2).
     flight_reference2->carrid = 'AA'.
ENDLOOP.
LOOP AT flights ASSIGNING FIELD-SYMBOL(<flight6>).
     <flight6>-carrid = 'A'.
ENDLOOP.

"Listing 6.28
LOOP AT  flights ASSIGNING <flight>
WHERE fldate > '20190101'.
     <flight>-carrid = 'AZ'.
ENDLOOP.

"Listing 6.29
*LOOP AT flight_schedule ASSIGNING <schedule>
*    WHERE airpfrom = 'JFK'.
*    WRITE: / 'Flight', <schedule> 'leaves at', <schedule>
*ENDLOOP.
*IF sy-subrc <> 0.
*     WRITE: / 'No flights from JFK were found'.
*ENDIF.

"Listing 6.30
*LOOP AT flight_schedule ASSIGNING <schedule>
*    WITH KEY airpfrom = 'JFK'.
*    WRITE: / ‘Flight’, <schedule> ‘leaves at’, <schedule>
*ENDLOOP.
*IF sy-subrc <> 0.
*     WRITE: / ‘No flights from JFK were found’.
*ENDIF.

"Listing 6.31
DATA: flight7 TYPE sflight,
      flights9 TYPE STANDARD TABLE OF sflight.
flight7-carrid = 'AA'.
flight7-connid = '017'.
INSERT flight7 INTO TABLE flights9.

"Listing 6.32
flight7-carrid = 'AZ'.
INSERT flight7 INTO flights9 INDEX 1.

"listing 6.33
DATA: flights10 TYPE STANDARD TABLE OF sflight,
      flights11 TYPE STANDARD TABLE OF sflight,
      flight12   TYPE sflight.
flight-carrid = 'AA'.
flight-connid = '017'.
INSERT flight INTO TABLE flights10.
flight-carrid = 'AZ'.
INSERT flight INTO TABLE flights11.
INSERT LINES OF flights10 INTO TABLE flights11.

"Listing 6.34
DATA: flight13 TYPE sflight,
      flights14 TYPE STANDARD TABLE OF sflight.
flight-carrid = 'AA'.
flight-connid = '017'.
APPEND flight13 TO flights14.

"Listing 6.35
DATA:  flights15 TYPE SORTED TABLE OF sflight
     WITH NON-UNIQUE KEY carrid connid fldate,
     flight16 TYPE sflight.
SELECT *
FROM sflight
INTO TABLE flights.
flight16-carrid = 'AA'.
flight16-connid = 17.
flight16-fldate = '20190101'.
INSERT flight16 INTO TABLE flights15.
"Could cause sort order exception
INSERT flight16 INTO flights15 INDEX 2.

"Listing 6.36
DATA: flights17 TYPE HASHED TABLE OF sflight
  WITH UNIQUE KEY carrid connid fldate,
      flight17 TYPE sflight.
flight17-carrid = 'AA'.
flight17-connid = 17.
flight17-fldate = '20150101'.
INSERT flight17 INTO TABLE flights17.

"Listing 6.37
DATA: flights18 TYPE STANDARD TABLE OF sflight,
      flight18  TYPE sflight.
flight-carrid = 'AA'.
flight-connid = '017'.
flight-fldate = 20190101.
INSERT flight INTO TABLE flights.
flight-price = 500.
MODIFY TABLE flights FROM flight.

"Listing 6.38
DATA: flights19 TYPE STANDARD TABLE OF sflight,
      flight19  TYPE sflight.
SELECT *
INTO TABLE flights19
FROM sflight.
flight19-price = 500.
MODIFY flights19 FROM flight19
  TRANSPORTING price WHERE carrid = 'AA'.

"Listing 6.39
DATA: flights20 TYPE STANDARD TABLE OF sflight,
      flight20  TYPE sflight.
SELECT *
INTO TABLE flights20
FROM sflight.
flight20-price = 500.
MODIFY flights20 FROM flight20 INDEX 5 TRANSPORTING price.

"Listing 6.40
DATA: flights21 TYPE SORTED TABLE OF sflight
     WITH NON-UNIQUE KEY carrid connid fldate,
     flight21 TYPE sflight.
SELECT *
FROM sflight
INTO TABLE flights21.
flight21-carrid = 'AA'.
flight21-connid = 17.
flight21-fldate = '20190101'.
MODIFY TABLE flights21 FROM flight21.
*Could cause illegal sort order exception
MODIFY flights21 FROM flight21 INDEX 2.
flight21-price = 500.
MODIFY flights21 FROM flight21
  TRANSPORTING price WHERE carrid = 'AA'.

"Listing 6.41
DATA:  flights22 TYPE HASHED TABLE OF sflight
  WITH UNIQUE KEY carrid connid fldate,
      flight22 TYPE sflight.
"Key fields
flight22-carrid = 'AA'.
flight22-connid = 17.
flight22-fldate = '20190101'.
"Field to be updated
flight22-price = 200.
MODIFY TABLE flights22 FROM flight22.

"Listing 6.42
DATA: flights23 TYPE STANDARD TABLE OF sflight.
FIELD-SYMBOLS: <flight23> TYPE sflight.
SELECT *
INTO TABLE flights23
FROM sflight.
READ TABLE flights23 ASSIGNING <flight23> INDEX 2.
DELETE TABLE flights23 FROM <flight23>.

"Listing 6.43
DATA:  flights24 TYPE STANDARD TABLE OF sflight
  WITH KEY carrid connid fldate,
      flight24 TYPE sflight.
SELECT *
INTO TABLE flights24
FROM sflight.
flight24-carrid = 'AA'.
flight24-connid = 17.
flight24-fldate = '20190107'.
DELETE TABLE  flights24 FROM flight24.

"Listing 6.44
DATA: flights25 TYPE STANDARD TABLE OF sflight
  WITH KEY carrid connid fldate.
SELECT *
INTO TABLE flights25
FROM sflight.
DELETE TABLE flights25
WITH TABLE KEY carrid = 'AA' connid = 17
  fldate = '20190107'.

"Listing 6.45
DATA: flights26 TYPE STANDARD TABLE OF sflight
  WITH KEY carrid connid fldate.
SELECT *
INTO TABLE flights26
FROM sflight.
DELETE flights26 WHERE carrid = 'AA' AND connid = 17.

"Listing 6.46
DATA: table_source TYPE STANDARD TABLE OF sflight,
                        table_target TYPE STANDARD TABLE OF sflight.
                  SELECT *
                  INTO TABLE table_source
                  FROM sflight.
                  table_target  = table_source.

                  "Listing 6.47
                  TYPES: BEGIN OF t_flight_price,
                         carrid TYPE sflight-carrid,
                         connid TYPE sflight-connid,
                         price  TYPE sflight-price,
                       END OF t_flight_price.
                  DATA: flights27 TYPE STANDARD TABLE OF sflight,
                        flight_prices TYPE STANDARD TABLE OF t_flight_price.
                  SELECT *
                  INTO TABLE flights27
                  FROM SFLIGHT.
                  MOVE-CORRESPONDING flights27 TO flight_prices.

     "Listing 6.48
     DATA:  flights28 TYPE STANDARD TABLE OF sflight.
SELECT *
FROM sflight
INTO TABLE flights28.
SORT flights28 BY carrid connid ASCENDING fldate DESCENDING.

"Listing 6.49
DATA: flights29 TYPE HASHED TABLE OF sflight
  WITH UNIQUE KEY carrid connid fldate.
SELECT *
INTO TABLE flights29
FROM sflight.
SORT flights BY price.

"Listing 6.50
DATA:  flights30 TYPE SORTED TABLE OF sflight
  WITH UNIQUE KEY carrid connid fldate,
      flight30 TYPE sflight.
flight30-carrid = 'AA'.
flight30-connid = 17.
flight30-fldate = '20150101'.
INSERT flight30 INTO TABLE flights30.
INSERT flight30 INTO TABLE flights30.
DELETE ADJACENT DUPLICATES FROM flights30.

"Listing 6.51
DATA: flights31 TYPE SORTED TABLE OF sflight
  WITH UNIQUE KEY carrid connid fldate,
      flight31 TYPE sflight.
flight31-carrid = 'AA'.
flight31-connid = 17.
flight31-fldate = '20190101'.
INSERT flight31 INTO TABLE flights31.
INSERT flight31 INTO TABLE flights31.
DELETE ADJACENT DUPLICATES FROM flights31 COMPARING ALL FIELDS.
flight31-carrid = 'AZ'.
INSERT flight31 INTO TABLE flights31.
DELETE ADJACENT DUPLICATES FROM flights31
  COMPARING connid fldate.

"Listing 6.52
DATA: flights32 TYPE STANDARD TABLE OF sflight WITH HEADER LINE.
SELECT *
INTO TABLE flights32
FROM sflight.
READ TABLE flights32.
flights32-price = 100.
LOOP AT flights32.
flights32-price = 100.
ENDLOOP.
