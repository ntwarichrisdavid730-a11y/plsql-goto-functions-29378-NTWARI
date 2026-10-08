CREATE OR REPLACE FUNCTION fn_dept_name (
    p_employee_id IN employees.employee_id%TYPE
) RETURN VARCHAR2 IS
    v_dept_id   employees.department_id%TYPE;
    v_dept_name VARCHAR2(50);
BEGIN
    
    SELECT department_id
    INTO v_dept_id
    FROM employees
    WHERE employee_id = p_employee_id;
    
    v_dept_name := CASE v_dept_id
        WHEN 10 THEN 'IT'
        WHEN 20 THEN 'HR'
        WHEN 30 THEN 'Finance'
        ELSE 'General'
    END;
    
    RETURN v_dept_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Unknown';
END fn_dept_name;
/