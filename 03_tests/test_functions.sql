SET SERVEROUTPUT ON;

DECLARE
    v_emp_id     employees.employee_id%TYPE := 101; 
    v_fname      employees.first_name%TYPE;
    v_lname      employees.last_name%TYPE;
BEGIN
    -- Fetch employee details for reporting
    SELECT first_name, last_name 
    INTO v_fname, v_lname 
    FROM employees 
    WHERE employee_id = v_emp_id;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('TEST RESULTS FOR: ' || v_fname || ' ' || v_lname || ' (ID: ' || v_emp_id || ')');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    
    -- Test B1: Annual Salary Function
    DBMS_OUTPUT.PUT_LINE('Annual Salary    : ' || TO_CHAR(fn_annual_salary(v_emp_id), 'FM$999,999.00'));
    
    -- Test B2: Years of Service Function
    DBMS_OUTPUT.PUT_LINE('Years of Service : ' || fn_years_of_service(v_emp_id) || ' years');
    
    -- Test B3: Tax Calculation Function
    DBMS_OUTPUT.PUT_LINE('Calculated Tax   : ' || TO_CHAR(fn_calculate_tax(v_emp_id), 'FM$999,999.00'));
    
    -- Test B4: Department Name Function
    DBMS_OUTPUT.PUT_LINE('Department Name  : ' || fn_dept_name(v_emp_id));
    
    -- Test C1: Payroll Validation Function
    DBMS_OUTPUT.PUT_LINE('Payroll Status   : ' || fn_validate_payroll(v_emp_id));
    
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || v_emp_id || ' does not exist in the database.');
END;
/