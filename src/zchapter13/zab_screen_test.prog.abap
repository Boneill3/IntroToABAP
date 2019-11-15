REPORT zab_screen_test.

DATA: ok_code TYPE syst_ucomm.
TABLES: scarr.
CALL SCREEN 100.

INCLUDE zab_screen_test_status_0100o01.

INCLUDE zab_screen_test_user_commani01.
