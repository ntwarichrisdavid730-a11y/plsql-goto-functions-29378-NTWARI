SET SERVEROUTPUT ON;

DECLARE
    v_employee_id employees.employee_id%TYPE := 101;
    v_salary      employees.salary%TYPE;
BEGIN
    
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE employee_id = v_employee_id;
    
    IF v_salary >= 70000 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_employee_id || ' has a high salary of ' || v_salary);
        
    ELSIF v_salary >= 50000 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_employee_id || ' has an average salary of ' || v_salary);
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_employee_id || ' has a low salary of ' || v_salary);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Salary review completed.');
END;
/