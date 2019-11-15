*----------------------------------------------------------------------*
***INCLUDE ZAB_SCREEN_TEST_USER_COMMANI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE PROGRAM.
    WHEN 'SEND'.
      SELECT SINGLE carrname
      FROM scarr
      WHERE carrid = @scarr-carrid
      INTO @DATA(airline_name).
      IF sy-subrc = 0.
        MESSAGE i001(38) WITH airline_name 'thanks you for the feedback!'.
      ELSE.
        MESSAGE i001(38) WITH 'Thanks for your feedback!'.
      ENDIF.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
