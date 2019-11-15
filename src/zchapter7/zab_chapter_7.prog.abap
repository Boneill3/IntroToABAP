REPORT zab_chapter_7.

"The following examples use the same subroutine.
"Un-comment the one you want to test and comment the rest

"Listing 7.1
PERFORM my_subroutine.

FORM my_subroutine.
  WRITE: 'Hello World'.
ENDFORM.

"Listing 7.2
*DATA: global_num TYPE I VALUE 1.
*PERFORM my_subroutine.
*
*FORM my_subroutine.
*    DATA: local_num TYPE i VALUE 2.
*    WRITE: 'local_num', local_num, 'global_num', global_num.
*ENDFORM.

"Listing 7.3
*DATA: global_num TYPE i VALUE 1.
*PERFORM my_subroutine USING global_num.
*
*FORM my_subroutine USING use_num TYPE i.
*  DATA: local_num TYPE i VALUE 2.
*  WRITE: 'local_num', local_num, 'global_num', global_num,
*         'use_num', use_num.
*ENDFORM.

"Listing 7.4
*DATA: global_num  TYPE i VALUE 1,
*      another_num TYPE i VALUE 1.
*
*PERFORM my_subroutine USING global_num CHANGING another_num.
*FORM my_subroutine USING use_num TYPE i CHANGING change_num TYPE i.
*  DATA: local_num TYPE i VALUE 2.
*  change_num = 3.
*  WRITE: 'local_num', local_num, 'global_num', global_num, 'use_ num', use_num, 'change_num', change_num.
*ENDFORM.

"The following examples use the same class name.
"Un-comment the one you want to test and comment the rest

"Listing 7.6
*CLASS  car DEFINITION.
*ENDCLASS.
*CLASS  car IMPLEMENTATION.
*ENDCLASS.

"Listing 7.7
*CLASS car DEFINITION.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car TYPE REF TO car.
*  CREATE OBJECT my_car.
*
*CLASS car IMPLEMENTATION.
*ENDCLASS.

"Listing 7.8
*CLASS car DEFINITION.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car TYPE REF TO car.
*
*  my_car = NEW car( ).
*
*CLASS car IMPLEMENTATION.
*ENDCLASS.

"Listing 7.9
*CLASS car DEFINITION.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car TYPE REF TO car.
*
*  my_car = NEW #( ).
*
*CLASS car IMPLEMENTATION.
*ENDCLASS.

"Listing 7.10
*CLASS car DEFINITION.
*ENDCLASS.
*
*START-OF-SELECTION.
*DATA(car) = NEW car( ).
*
*CLASS car IMPLEMENTATION.
*ENDCLASS.

"Listing 7.11
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*  PRIVATE SECTION.
*ENDCLASS.
*CLASS car IMPLEMENTATION.
*ENDCLASS.

"Listing 7.12
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string READ-ONLY.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*CLASS car IMPLEMENTATION.
*ENDCLASS.

"Listing 7.13
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate,
*             decelerate,
*             refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*  ENDMETHOD.
*  METHOD decelerate.
*  ENDMETHOD.
*  METHOD refuel.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.14
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate,
*             decelerate,
*             refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    speed = speed + 5.
*    fuel = fuel - 5.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.15
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate,
*      decelerate,
*      refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*DATA: my_car TYPE REF TO car.
*CREATE OBJECT my_car.
*my_car->accelerate( ).
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    speed = speed + 5.
*    fuel = fuel - 5.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = 100.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.16
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate IMPORTING accel_rate TYPE i,
*      decelerate,
*      refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car TYPE REF TO car.
*  CREATE OBJECT my_car.
*  my_car->accelerate( 5 ).
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    speed = speed + accel_rate. fuel = fuel - 5.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.17
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool,
*      decelerate,
*      refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car.
*  is_success = my_car->accelerate( 5 ).
*  IF is_success = abap_true.
*    WRITE: 'it worked!'.
*  ENDIF.
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.18
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                                  other_param       TYPE i
*                        RETURNING VALUE(is_success) TYPE abap_bool,
*      decelerate,
*      refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO  car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car.
*  is_success = my_car->accelerate( accel_rate = 5 other_param = 1 ).
*  IF is_success = abap_true.
*    WRITE: 'it worked!'.
*  ENDIF.
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.19
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate IMPORTING accel_rate TYPE i
*             other_param TYPE i OPTIONAL RETURNING VALUE(is_success) TYPE abap_bool,
*             decelerate,
*             refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car.
*  is_success = my_car->accelerate( 5 ).
*  IF is_success = abap_true.
*    WRITE: 'It worked!'.
*  ENDIF.
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.20
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate IMPORTING accel_rate TYPE i
*                        EXPORTING is_success TYPE abap_bool,
*             decelerate,
*             refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car.
*  my_car->accelerate( EXPORTING accel_rate = 5
*                      IMPORTING is_success = is_success ).
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.21
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate IMPORTING accel_rate TYPE i
*                        CHANGING  is_success TYPE abap_bool,
*            decelerate,
*            refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car.
*  my_car->accelerate( EXPORTING accel_rate = 5
*                      CHANGING is_success = is_success ).
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.22
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          brand        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool,
*      decelerate,
*      refuel.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car.
*  CREATE OBJECT my_car.
*  IF my_car->accelerate( 5 ) = abap_true.
*    WRITE: 'it worked!'.
*  ENDIF.
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.23
*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          model        TYPE string,
*          manufacturer TYPE string.
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool,
*      decelerate,
*      refuel,
*      constructor
*        IMPORTING ip_manufacturer TYPE string
*                  ip_model        TYPE string.
*  PRIVATE SECTION.
*    DATA: gear TYPE i.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car
*    EXPORTING
*      ip_manufacturer = 'Toyota'
*      ip_model        = 'Tundra'.
*  is_success = my_car->accelerate( 5 ).
*  IF is_success = abap_true.
*    WRITE: 'It worked!'.
*  ENDIF.
*
*CLASS car IMPLEMENTATION.
*  METHOD constructor.
*    manufacturer = ip_manufacturer.
*    model        = ip_model.
*  ENDMETHOD.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

"Listing 7.24
CLASS fibonacci DEFINITION.
  PUBLIC SECTION.
    METHODS: calculate IMPORTING place         TYPE i
                       RETURNING VALUE(result) TYPE i.
ENDCLASS.

START-OF-SELECTION.
  DATA: fib    TYPE REF TO fibonacci,
        result TYPE i.
  CREATE OBJECT fib.
  result = fib->calculate( 4 ).

  WRITE: result.
CLASS fibonacci IMPLEMENTATION.
  METHOD calculate.
    DATA: one TYPE i,
          two TYPE i.
    IF place <= 1.
      result = place.
    ELSE.
      one = place - 1.
      two = place - 2.
      result = calculate( one ) + calculate( two ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

"Listing 7.25

START-OF-SELECTION.
  DATA: previous_previous TYPE i,
        previous          TYPE i VALUE 0,
        current           TYPE i VALUE 1.
  DO 3 TIMES.
    previous_previous = previous.
    previous = current.
    current = previous_previous + current.
  ENDDO.
  WRITE: current.

  "Listing 7.26
*CLASS vehicle DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          model        TYPE string,
*          manufacturer TYPE string.
*ENDCLASS.
*CLASS car DEFINITION INHERITING FROM vehicle.
*  PUBLIC SECTION.
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool,
*      decelerate,
*      refuel,
*      constructor IMPORTING ip_manufacturer TYPE string
*                            ip_model        TYPE string.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car  EXPORTING ip_manufacturer = 'Toyota'
*                                  ip_model        = 'Tundra'.
*  is_success = my_car->accelerate( 5 ).
*  IF is_success = abap_true.
*    WRITE: 'It worked!'.
*  ENDIF.
*
*CLASS car IMPLEMENTATION.
*  METHOD constructor.
*  super->constructor( ).
*    manufacturer = ip_manufacturer.
*    model        = ip_model.
*  ENDMETHOD.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

  "Listing 7.27
*CLASS vehicle DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          model        TYPE string,
*          manufacturer TYPE string.
*
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool.
*ENDCLASS.
*
*CLASS vehicle IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS car DEFINITION INHERITING FROM vehicle.
*  PUBLIC SECTION.
*    METHODS:
*      decelerate,
*      refuel,
*      constructor IMPORTING ip_manufacturer TYPE string
*                            ip_model        TYPE string.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car
*    EXPORTING
*      ip_manufacturer = 'Toyota'
*      ip_model        = 'Tundra'.
*  is_success = my_car->accelerate( 5 ).
*  IF is_success = abap_true.
*    WRITE: 'It worked!'.
*  ENDIF.
*
*CLASS car IMPLEMENTATION.
*  METHOD constructor.
*    super->constructor( ).
*    manufacturer = ip_manufacturer.
*    model        = ip_model.
*  ENDMETHOD.
*
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

*  "Listing 7.28
*CLASS vehicle DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          model        TYPE string,
*          manufacturer TYPE string.
*
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool.
*ENDCLASS.
*
*CLASS vehicle IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS car DEFINITION INHERITING FROM vehicle.
*  PUBLIC SECTION.
*    METHODS:
*      accelerate REDEFINITION,
*      decelerate,
*      refuel,
*      constructor IMPORTING ip_manufacturer TYPE string
*                            ip_model        TYPE string.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_car     TYPE REF TO car,
*        is_success TYPE abap_bool.
*  CREATE OBJECT my_car
*    EXPORTING
*      ip_manufacturer = 'Toyota'
*      ip_model        = 'Tundra'.
*  is_success = my_car->accelerate( 5 ).
*  IF is_success = abap_true.
*    WRITE: 'It worked!'.
*  ENDIF.
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    speed = 1.
*    is_success = abap_true.
*  ENDMETHOD.
*
*  METHOD constructor.
*    super->constructor( ).
*    manufacturer = ip_manufacturer.
*    model        = ip_model.
*  ENDMETHOD.
*
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

  "Listing 7.29
*CLASS vehicle DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          model        TYPE string,
*          manufacturer TYPE string.
*
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool.
*ENDCLASS.
*
*CLASS vehicle IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS car DEFINITION INHERITING FROM vehicle.
*  PUBLIC SECTION.
*    METHODS:
*      accelerate REDEFINITION,
*      decelerate,
*      refuel,
*      constructor IMPORTING ip_manufacturer TYPE string
*                            ip_model        TYPE string.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_vehicle TYPE REF TO vehicle.
*  CREATE OBJECT my_vehicle TYPE car
*    EXPORTING
*      ip_manufacturer = 'Toyota'
*      ip_model        = 'Tundra'.
*  my_vehicle->accelerate( 5 ).
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    speed = 1.
*    is_success = abap_true.
*  ENDMETHOD.
*
*  METHOD constructor.
*    super->constructor( ).
*    manufacturer = ip_manufacturer.
*    model        = ip_model.
*  ENDMETHOD.
*
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

  "Listing 7.30
*CLASS engine DEFINITION.
*  PUBLIC SECTION.
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success) TYPE abap_bool.
*ENDCLASS.
*CLASS engine IMPLEMENTATION.
*  METHOD accelerate.
*    IF accel_rate < 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.

  "Listing 7.31
*CLASS engine DEFINITION.
*  PUBLIC SECTION.
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success) TYPE abap_bool.
*ENDCLASS.
*CLASS engine IMPLEMENTATION.
*  METHOD accelerate.
*    IF accel_rate < 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
* ENDCLASS.
*
*CLASS vehicle DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          model        TYPE string,
*          manufacturer TYPE string.
*
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool.
*ENDCLASS.
*
*CLASS vehicle IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS car DEFINITION INHERITING FROM vehicle.
*  PUBLIC SECTION.
*    METHODS:
*      accelerate REDEFINITION,
*      decelerate,
*      refuel,
*      constructor.
*
*  PRIVATE SECTION.
*  DATA: my_engine TYPE REF TO engine.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_vehicle TYPE REF TO vehicle.
*  CREATE OBJECT my_vehicle TYPE car.
*  my_vehicle->accelerate( 5 ).
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    my_engine->accelerate( accel_rate ).
*  ENDMETHOD.
*
*  METHOD constructor.
*    super->constructor( ).
*    CREATE OBJECT my_engine.
*  ENDMETHOD.
*
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

  "Listing 7.32
*CLASS engine DEFINITION.
*  PUBLIC SECTION.
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success) TYPE abap_bool.
*ENDCLASS.
*CLASS engine IMPLEMENTATION.
*  METHOD accelerate.
*    IF accel_rate < 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS vehicle DEFINITION.
*  PUBLIC SECTION.
*    DATA: fuel         TYPE i,
*          speed        TYPE i,
*          model        TYPE string,
*          manufacturer TYPE string.
*
*    METHODS: accelerate IMPORTING accel_rate        TYPE i
*                        RETURNING VALUE(is_success)
*                                    TYPE abap_bool.
*ENDCLASS.
*
*CLASS vehicle IMPLEMENTATION.
*  METHOD accelerate.
*    IF fuel >= 5.
*      speed = speed + accel_rate.
*      fuel = fuel - 5.
*      is_success = abap_true.
*    ELSE.
*      is_success = abap_false.
*    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS car DEFINITION INHERITING FROM vehicle.
*  PUBLIC SECTION.
*    METHODS:
*      accelerate REDEFINITION,
*      decelerate,
*      refuel,
*      constructor IMPORTING engine TYPE REF TO engine.
*
*  PRIVATE SECTION.
*    DATA: my_engine TYPE REF TO engine.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA: my_vehicle TYPE REF TO vehicle,
*        my_engine  TYPE REF TO engine.
*
*  CREATE OBJECT my_engine.
*  CREATE OBJECT my_vehicle TYPE car
*    EXPORTING
*      engine = my_engine.
*  my_vehicle->accelerate( 5 ).
*
*CLASS car IMPLEMENTATION.
*  METHOD accelerate.
*    my_engine->accelerate( accel_rate ).
*  ENDMETHOD.
*
*  METHOD constructor.
*    super->constructor( ).
*    my_engine = engine.
*  ENDMETHOD.
*
*  METHOD decelerate.
*    speed = speed - 5.
*  ENDMETHOD.
*  METHOD refuel.
*    CONSTANTS: c_full_tank TYPE i VALUE 100.
*    fuel = c_full_tank.
*  ENDMETHOD.
*ENDCLASS.

  "Listing 7.33
INTERFACE engine_interface.
  METHODS: accelerate IMPORTING accel_rate        TYPE i
                      RETURNING VALUE(is_success) TYPE abap_bool.
ENDINTERFACE.

"Listing 7.34
CLASS engine DEFINITION.
  PUBLIC SECTION.
    INTERFACES: engine_interface.
ENDCLASS.
CLASS engine IMPLEMENTATION.
  METHOD engine_interface~accelerate.
    IF accel_rate < 5.
      is_success = abap_true.
    ELSE.
      is_success = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

"Listing 7.35
CLASS fast_engine DEFINITION.
  PUBLIC SECTION.
    INTERFACES: engine_interface.
ENDCLASS.
CLASS fast_engine IMPLEMENTATION.
  METHOD engine_interface~accelerate.
    IF accel_rate < 10.
      is_success = abap_true.
    ELSE.
      is_success = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

"Listing 7.36
CLASS vehicle DEFINITION.
  PUBLIC SECTION.
    DATA: fuel         TYPE i,
          speed        TYPE i,
          model        TYPE string,
          manufacturer TYPE string.

    METHODS: accelerate IMPORTING accel_rate        TYPE i
                        RETURNING VALUE(is_success)
                                    TYPE abap_bool.
ENDCLASS.

CLASS vehicle IMPLEMENTATION.
  METHOD accelerate.
    IF fuel >= 5.
      speed = speed + accel_rate.
      fuel = fuel - 5.
      is_success = abap_true.
    ELSE.
      is_success = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS car DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    METHODS: accelerate REDEFINITION,
      decelerate,
      refuel,
      constructor IMPORTING engine TYPE REF TO engine_interface.
  PRIVATE SECTION.
    DATA: my_engine TYPE REF TO engine_interface.
ENDCLASS.

START-OF-SELECTION.
  DATA: racer1      TYPE REF TO car,
        racer2      TYPE REF TO car,
        engine      TYPE REF TO engine,
        fast_engine TYPE REF TO fast_engine,
        result2     TYPE abap_bool.
  CREATE OBJECT engine.
  CREATE OBJECT fast_engine.
  CREATE OBJECT racer1
    EXPORTING
      engine = engine.
  CREATE OBJECT racer2
    EXPORTING
      engine = fast_engine.
  result2 = racer1->accelerate( 8 ).
  WRITE: 'RACER1: ',result.
  result2 = racer2->accelerate( 8 ).
  WRITE: 'Racer2: ',result.



CLASS car IMPLEMENTATION.
  METHOD constructor.
    super->constructor(  ).
    my_engine = engine.
  ENDMETHOD.

  METHOD accelerate.
    my_engine->accelerate( accel_rate ).
  ENDMETHOD.

  METHOD decelerate.
    speed = speed - 5.
  ENDMETHOD.
  METHOD refuel.
    CONSTANTS: c_full_tank TYPE i VALUE 100.
    fuel = c_full_tank.
  ENDMETHOD.
ENDCLASS.

"Listing 7.39
DATA: my_int TYPE i.
START-OF-SELECTION.
CALL FUNCTION 'Z_NEW_FUNCTION_MODULE'
  EXPORTING
    import = 1
  IMPORTING
    export = my_int
  CHANGING
    change = my_int.
