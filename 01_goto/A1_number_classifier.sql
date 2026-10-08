SET SERVEROUTPUT ON;

DECLARE
    v_number NUMBER := 25;
BEGIN

    IF v_number > 0 THEN
        GOTO positive;

    ELSIF v_number < 0 THEN
        GOTO negative;

    ELSE
        GOTO zero;

    END IF;


    <<positive>>
    DBMS_OUTPUT.PUT_LINE('The number ' || v_number || ' is positive.');
    GOTO finish;


    <<negative>>
    DBMS_OUTPUT.PUT_LINE('The number ' || v_number || ' is negative.');
    GOTO finish;


    <<zero>>
    DBMS_OUTPUT.PUT_LINE('The number is zero.');


    <<finish>>
    DBMS_OUTPUT.PUT_LINE('Number classification completed.');

END;
/