CREATE OR REPLACE FUNCTION fn_calculate_tax (
    p_employee_id IN employees.employee_id%TYPE
) RETURN NUMBER IS
    v_salary     employees.salary%TYPE;
    v_annual_sal NUMBER(10,2);
    v_tax        NUMBER(10,2);
BEGIN
    
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE employee_id = p_employee_id;

    v_annual_sal := v_salary * 12;
    
    IF v_annual_sal <= 60000 THEN
        v_tax := v_annual_sal * 0.10; 
    ELSIF v_annual_sal <= 100000 THEN
        v_tax := v_annual_sal * 0.15; 
    ELSE
        v_tax := v_annual_sal * 0.20; 
    END IF;
    
    RETURN v_tax;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_calculate_tax;
/