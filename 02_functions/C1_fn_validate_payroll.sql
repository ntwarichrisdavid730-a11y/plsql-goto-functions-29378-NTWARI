CREATE OR REPLACE FUNCTION fn_validate_payroll (
    p_employee_id IN employees.employee_id%TYPE
) RETURN VARCHAR2 IS
    v_salary employees.salary%TYPE;
BEGIN
    
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE employee_id = p_employee_id;
    
    IF v_salary IS NULL THEN
        RETURN 'INVALID: Salary is missing';
    ELSIF v_salary <= 0 THEN
        RETURN 'INVALID: Salary must be greater than zero';
    ELSIF v_salary < 10000 THEN
        RETURN 'WARNING: Salary is below standard minimum threshold';
    ELSE
        RETURN 'VALID: Payroll amount is acceptable';
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'ERROR: Employee ID not found';
END fn_validate_payroll;
/

SET SERVEROUTPUT ON;

BEGIN
    -- This will test a normal valid employee (e.g., ID 100 or 101)
    DBMS_OUTPUT.PUT_LINE('Employee 101: ' || fn_validate_payroll(101));
    
    -- This will test an ID that doesn't exist to trigger the EXCEPTION
    DBMS_OUTPUT.PUT_LINE('Employee 999: ' || fn_validate_payroll(999));
END;
/