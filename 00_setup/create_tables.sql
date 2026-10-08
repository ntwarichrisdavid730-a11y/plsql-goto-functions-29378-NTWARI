CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department_id NUMBER,
    salary NUMBER(10,2),
    hire_date DATE
);

INSERT INTO employees
(employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
(101, 'John', 'Doe', 10, 50000, DATE '2020-01-15');

INSERT INTO employees
(employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
(102, 'Jane', 'Smith', 20, 65000, DATE '2018-06-10');

INSERT INTO employees
(employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
(103, 'Peter', 'Brown', 10, 40000, DATE '2023-03-20');

INSERT INTO employees
(employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
(104, 'Mary', 'Jones', 30, 80000, DATE '2015-09-01');

INSERT INTO employees
(employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
(105, 'David', 'Wilson', 20, 55000, DATE '2021-11-05');

COMMIT;



