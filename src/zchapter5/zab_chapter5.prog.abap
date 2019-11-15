REPORT zab_chapter5.
"Some examples use new Open SQL. You will need to comment those lines out on older ABAP versions
"ZAB_FLIGHT is used instead of ZFLIGHT to avoid conflicts with the reader's work

"Listing 5.1
DATA: results TYPE STANDARD TABLE OF sflight.
SELECT *
INTO TABLE results
FROM sflight.

"Listing 5.2
"Code commented out to avoid conflict with previous listing
*DATA: results TYPE zab_flights.
*SELECT fldate carrid connid
*INTO TABLE results
*FROM sflight.

"Listing 5.3
"Code commented out to avoid conflict with previous listing
*SELECT fldate, price
*INTO TABLE @DATA(results)
*FROM sflight.

"Listing 5.4
DATA: date TYPE s_date.

"old Open SQL
SELECT SINGLE fldate
INTO date
FROM sflight.
"new Open SQL
SELECT SINGLE fldate
INTO @DATA(inline_date)
FROM sflight.

"Listing 5.5
"Code commented out to avoid conflict with previous listing
DATA: "date   TYPE d,
  carrid TYPE s_carr_id,
  connid TYPE s_conn_id.
"old Open SQL
SELECT SINGLE fldate carrid connid
INTO (date, carrid, connid)
FROM sflight.
"new Open SQL
SELECT SINGLE fldate, carrid, connid
FROM sflight
INTO (@DATA(in_date), @DATA(in_carrid), @DATA(in_connid)).

"Listing 5.6
DATA:flight TYPE zab_flight.
"old Open SQL
SELECT SINGLE fldate carrid connid
INTO flight
FROM sflight.
"new Open SQL
SELECT SINGLE fldate, carrid, connid
INTO @DATA(in_flight)
FROM sflight.

"Listing 5.7
"Code commented out to avoid conflict with previous listing
*DATA: results TYPE STANDARD TABLE OF SFLIGHT.
"old Open SQL
SELECT *
INTO TABLE results
FROM sflight
UP TO 5 ROWS.
"new Open SQL
SELECT *
INTO TABLE @DATA(in_results)
FROM sflight
UP TO 5 ROWS.

"Listing 5.8
DATA: flights TYPE zab_flights.
"old Open SQL
SELECT fldate carrid connid
INTO TABLE flights
FROM sflight
WHERE carrid = 'AA'
AND planetype = '747-400'.
"new Open SQL
SELECT fldate, carrid, connid
INTO TABLE @DATA(in_flights)
FROM sflight
WHERE carrid = 'AA'
AND planetype = '747-400'.

"Listing 5.9
"Code commented out to avoid conflict with previous listing
DATA: "date TYPE s_date,
      time TYPE s_dep_time.
"old Open SQL
SELECT SINGLE fldate deptime
INTO (date, time)
FROM sflight
INNER JOIN spfli
ON sflight~carrid = spfli~carrid
AND sflight~connid = spfli~connid.
"new Open SQL
SELECT SINGLE fldate, deptime
INTO (@date, @time)
FROM sflight
INNER JOIN spfli
ON sflight~carrid = spfli~carrid
AND sflight~connid = spfli~connid.

"Listing 5.10
"Code commented out to avoid conflict with previous listing
*DATA: carrid TYPE s_carr_id,
*      date   TYPE s_date,
*      time   TYPE s_dep_time.

"old Open SQL
SELECT SINGLE sflight~carrid fldate deptime
INTO ( carrid, date, time )
FROM sflight
INNER JOIN spfli
ON sflight~carrid = spfli~carrid
AND sflight~connid = spfli~connid.
"new Open SQL
SELECT SINGLE sflight~carrid, fldate, deptime
INTO ( @carrid, @date, @time )
FROM sflight
INNER JOIN spfli
ON sflight~carrid = spfli~carrid
AND sflight~connid = spfli~connid.

"Listing 5.11
"Code commented out to avoid conflict with previous listing
*DATA: carrid TYPE s_carr_id,
*      date   TYPE s_date,
*      time   TYPE s_dep_time.
"old Open SQL
SELECT SINGLE f~carrid fldate deptime
INTO ( carrid, date, time )
FROM sflight AS f
INNER JOIN spfli AS s
ON f~carrid = s~carrid AND f~connid = s~connid.
"new Open SQL
SELECT SINGLE f~carrid, fldate, deptime
INTO ( @carrid, @date, @time )
FROM sflight AS f
INNER JOIN spfli AS s
ON f~carrid = s~carrid AND f~connid = s~connid.

"Listing 5.12
"Code commented out to avoid conflict with previous listing
*DATA: carrid TYPE s_carr_id,
*      date   TYPE s_date,
*      time   TYPE s_dep_time.
"old Open SQL
SELECT SINGLE f~carrid fldate deptime
INTO ( carrid, date, time )
FROM sflight AS f
INNER JOIN spfli AS s
ON f~carrid = s~carrid
AND f~connid = s~connid
WHERE airpfrom = 'JFK'
AND planetype = '747-400'.
"new Open SQL
SELECT SINGLE f~carrid, fldate, deptime
INTO ( @carrid, @date, @time )
FROM sflight AS f
INNER JOIN spfli AS s
ON f~carrid = s~carrid
AND f~connid = s~connid
WHERE airpfrom = 'JFK'
AND planetype = '747-400'.

"Listing 5.13
"Code commented out to avoid conflict with previous listing
*SELECT bookid, carrname, b~connid, b~fldate, deptime
*INTO TABLE @data(results)
*FROM SBOOK AS b
*INNER JOIN SFLIGHT AS f
*ON b~carrid = f~carrid
*AND b~connid = f~connid
*AND b~fldate = f~fldate
*INNER JOIN spfli AS s
*ON b~carrid = s~carrid
*AND b~connid = s~connid
*INNER JOIN scarr as c
*ON b~carrid = c~carrid
*WHERE customid = 3264.

"Listing 5.14
SELECT SINGLE sflight~carrid, fldate, deptime
INTO ( @carrid, @date, @time )
FROM sflight
JOIN spfli
ON sflight~carrid = spfli~carrid
AND sflight~connid = spfli~connid.

"Listing 5.15
"Code commented out to avoid conflict with previous listing
*DATA: date   TYPE s_date,
*      time   TYPE s_dep_time.
"old Open SQL
SELECT SINGLE fldate deptime
INTO ( date, time )
FROM sflight
LEFT OUTER JOIN spfli
ON sflight~carrid = spfli~carrid
AND sflight~connid = spfli~connid.
"new Open SQL
SELECT SINGLE fldate, deptime
INTO ( @date, @time )
FROM sflight
LEFT OUTER JOIN spfli
ON sflight~carrid = spfli~carrid
AND sflight~connid = spfli~connid.

"Listing 5.16
SELECT fldate, deptime
INTO TABLE @DATA(t_flights)
FROM sflight
LEFT OUTER JOIN spfli
ON sflight~carrid = spfli~carrid
AND sflight~connid = spfli~connid
WHERE spfli~deptime IS NULL.

"Listing 5.17
DATA: book   TYPE STANDARD TABLE OF sbook,
      custom TYPE STANDARD TABLE OF scustom.
"old Open SQL
SELECT *
INTO TABLE book
FROM sbook
UP TO 5 ROWS.

SELECT *
INTO TABLE custom
FROM scustom
FOR ALL ENTRIES IN book
WHERE scustom~id = book-customid.

"new Open SQL
SELECT *
INTO TABLE @book
FROM sbook
UP TO 5 ROWS.

SELECT *
INTO TABLE @custom
FROM scustom
FOR ALL ENTRIES IN @book
WHERE scustom~id = @book-customid.

"Listing 5.18
"Code commented out to avoid conflict with previous listing
*DATA: carrid  TYPE s_carr_id,
*      flights TYPE STANDARD TABLE OF sflight.
*
*SELECTION-SCREEN BEGIN OF BLOCK selection.
*SELECT-OPTIONS: so_carr FOR carrid.
*SELECTION-SCREEN END OF BLOCK selection.
*"old open sql
*SELECT *
*INTO TABLE flights
*FROM sflight
*WHERE carrid IN so_carr.
*"new open sql
*SELECT *
*INTO TABLE @flights
*FROM sflight
*WHERE carrid IN @so_carr.

"Listing 5.19
PARAMETERS: p_date TYPE dats.

DATA: record_count TYPE i.
"old Open SQL

SELECT COUNT( * )
       INTO record_count
       FROM sflight
       WHERE fldate > p_date.
WRITE: / record_count, 'records found'.

"New Open SQL
SELECT COUNT( * )
       FROM sflight
       WHERE fldate > @p_date
       INTO @record_count.

"Listing 5.20
DATA: total_price TYPE p DECIMALS 2.

SELECT SINGLE SUM( price )
INTO total_price
FROM sflight
WHERE carrid = 'AA'.

"Listing 5.21
"Code commented out to avoid conflict with previous listing
"DATA: flights TYPE zab_flights.
"Old SQL
SELECT MAX( fldate ) carrid connid
INTO TABLE flights
FROM sflight
WHERE planetype = '747-400'
GROUP BY carrid connid.
"New SQL
SELECT MAX( fldate ), carrid, connid
FROM sflight
WHERE planetype = '747-400'
GROUP BY carrid, connid
INTO TABLE @flights.

"Listing 5.22
"Code commented out to avoid conflict with previous listing
*SELECT sflight~*, spfli~deptime
*FROM sflight
*INNER JOIN spfli
*ON sflight~carrid = spfli~carrid
*AND sflight~connid = spfli~connid
*INTO TABLE @DATA(flights).

"Listing 5.23
"Code commented out to avoid conflict with previous listing
*SELECT SINGLE fldate AS flight_date, carrid
*FROM sflight
*INTO @DATA(flight).
*
*DATA(date) = flight-flight_date.

"Listing 5.24
"Code commented out to avoid conflict with previous listing
*SELECT *
*FROM sflight
*WHERE carrid = 'AA'
*INTO TABLE @DATA(flights).

"Listing 5.25
"Code commented out to avoid conflict with previous listing
*SELECT carrid, connid
*FROM sflight
*WHERE carrid = 'AA'
*UNION
*SELECT carrid, connid
*FROM sflight
*WHERE carrid = 'DL'
*INTO TABLE @DATA(flights).

"Listing 5.26 can be found in zab_cds_view

"Listing 5.27
"Code commented out to avoid conflict with previous listing
*SELECT *
*FROM zab_cds_view
*INTO TABLE @DATA(results).

"Listing 5.28
DATA: booking TYPE sbook.
booking-carrid = 'aa'.
booking-connid = 0017.
booking-fldate = 20181220.
booking-bookid = 00999999.
"old open sql
INSERT sbook FROM booking.
"new open sql
booking-bookid = 00999998.
INSERT sbook FROM @booking.

"Listing 5.29
"Code commented out to avoid conflict with previous listing
DATA: "booking TYPE sbook,
      bookings TYPE STANDARD TABLE OF sbook.
booking-carrid = 'AA'.
booking-connid = 0017.
booking-fldate = 20181220.
booking-bookid = 00999997.
APPEND booking TO bookings.
booking-bookid = 00999996.
APPEND booking TO bookings.

"old Open SQL
INSERT sbook FROM TABLE bookings.
"new Open SQL
CLEAR bookings.
booking-bookid = 00999995.
APPEND booking TO bookings.

INSERT sbook FROM TABLE @bookings.

"Listing 5.30
"Code commented out to avoid conflict with previous listing
*DATA:  booking TYPE sbook.
booking-carrid = 'AA'.
booking-connid = 0017.
booking-fldate = 20181220.
booking-bookid = 00999999.
booking-customid = 3.
"old Open SQL
MODIFY sbook FROM booking.
"new Open SQL
MODIFY sbook FROM @booking.

"Listing 5.31
"Code commented out to avoid conflict with previous listing
*DATA: booking TYPE sbook,
*      bookings TYPE STANDARD TABLE OF sbook.
"using a structure
booking-carrid = 'AA'.
booking-connid = 0017.
booking-fldate = 20181220.
booking-bookid = 00999999.
"old Open SQL
UPDATE sbook FROM booking.
"new Open SQL
UPDATE sbook FROM @booking.
"using a table
APPEND booking TO bookings.
"old Open SQL
UPDATE sbook FROM TABLE bookings.
"new Open SQL
UPDATE sbook FROM TABLE @bookings.

"Listing 5.32
"old Open SQL
UPDATE sflight
SET seatsmax = 400 planetype = '747'
WHERE planetype = '747-400'.
"new Open SQL
UPDATE sflight
SET seatsmax = 400, planetype = '747'
WHERE planetype = '747-400'.

"Listing 5.33
"Code commented out to avoid conflict with previous listing
*DATA: booking TYPE sbook.
booking-carrid = 'AA'.
booking-connid = 0017.
booking-fldate = 20181220.
booking-bookid = 00999999.
"old Open SQL
DELETE sbook FROM booking.
"new Open SQL
DELETE sbook FROM @booking.

"Listing 5.34
"old/new Open SQL
DELETE FROM sflight
WHERE planetype = '747'.

"Listing 5.35
CALL FUNCTION 'ENQUEUE_EZAB_SFLIGHT'
  EXPORTING
    mode_sflight   = 'E'
    mode_sbook     = 'E'
    mandt          = sy-mandt
    carrid         = 'AA'
    connid         = '0017'
    fldate         = '20181220'
    x_carrid       = ' '
    x_connid       = ' '
    x_fldate       = ' '
    _scope         = '1'
    _wait          = ' '
    _collect       = ' '
  EXCEPTIONS
    foreign_lock   = 1
    system_failure = 2
    OTHERS         = 3.
IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.

"Listing 5.36
CALL FUNCTION 'ENQUEUE_EZAB_SFLIGHT'
  EXPORTING
    mode_sflight   = 'E'
    mode_sbook     = 'E'
    mandt          = sy-mandt
    carrid         = 'AA'
    connid         = '0017'
    fldate         = '20181220'
    x_carrid       = ' '
    x_connid       = ' '
    x_fldate       = ' '
    _scope         = '1'
    _wait          = ' '
    _collect       = ' '
  EXCEPTIONS
    foreign_lock   = 1
    system_failure = 2
    OTHERS         = 3.
IF sy-subrc = 0.
  "Update database here
  CALL FUNCTION 'DEQUEUE_EZAB_SFLIGHT'
    EXPORTING
      mode_sflight = 'E'
      mode_sbook   = 'E'
      mandt        = sy-mandt
      carrid       = 'AA'
      connid       = '0017'
      fldate       = '20181220'
      x_carrid     = ' '
      x_connid     = ' '
      x_fldate     = ' '
      _scope       = '1'
      _synchron    = ' '
      _collect     = ' '.
ENDIF.

"Listing 5.37
SELECT * FROM SBOOK
INTO @DATA(result).
    "Do something
ENDSELECT.

"Listing 5.38
SELECT fldate INTO @DATA(flight_date) UP TO 1 ROWS
  FROM sflight
  WHERE carrid = 'AA'
  ORDER BY connid, fldate.
ENDSELECT.

"Listing 5.39
TABLES: sbook.
SELECT * FROM sbook.
   WRITE: sbook-bookid.
ENDSELECT.
