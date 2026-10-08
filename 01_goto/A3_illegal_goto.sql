/*SET SERVEROUTPUT ON;

-- ==========================================
-- PART 1: The Illegal GOTO (Will output an Error)
-- ==========================================

DECLARE
    v_test NUMBER := 10;
BEGIN

    GOTO inner_block_label;

    BEGIN
        <<inner_block_label>>
        DBMS_OUTPUT.PUT_LINE('Inside inner block.');
    END;

END;
/
*/

-- ==========================================
-- PART 2: The Fixed Version (Valid Code)
-- ==========================================
DECLARE
    v_test NUMBER := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Start of main block.');
 GOTO outer_skip;
    DBMS_OUTPUT.PUT_LINE('This line will be skipped.');

    <<outer_skip>>
    DBMS_OUTPUT.PUT_LINE('Successfully jumped past the code safely!');

END;
/ 