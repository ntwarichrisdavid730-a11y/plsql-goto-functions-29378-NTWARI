SET SERVEROUTPUT ON;

DECLARE
    
    v_test_emp_valid   employees.employee_id%TYPE := 101; 
    v_test_emp_invalid employees.employee_id%TYPE := 999; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('      PAYROLL VALIDATION TEST SUITE     ');
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    DBMS_OUTPUT.PUT_LINE('Testing Employee ID ' || v_test_emp_valid || ':');
    DBMS_OUTPUT.PUT_LINE('Result -> ' || fn_validate_payroll(v_test_emp_valid));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE('Testing Employee ID ' || v_test_emp_invalid || ' (Non-existent):');
    DBMS_OUTPUT.PUT_LINE('Result -> ' || fn_validate_payroll(v_test_emp_invalid));
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/