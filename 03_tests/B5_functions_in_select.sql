SET SERVEROUTPUT ON;

SELECT 
    employee_id,
    first_name,
    last_name,
    salary AS monthly_salary,
    fn_annual_salary(employee_id) AS annual_salary,
    fn_years_of_service(employee_id) AS years_of_service,
    fn_calculate_tax(employee_id) AS calculated_tax,
    fn_dept_name(employee_id) AS department_name
FROM 
    employees;