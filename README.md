# PL/SQL GOTO Statements and Functions: Individual Assignment III

**Course:** Database Development with PL/SQL (INSY 8311)
**Instructor:** Eric Maniraguha
**Student:** `NTWARI CHRIS DAVID` | **Student ID:** `29378`
**Group:** ` I `
**Deadline:** Thursday, 8 October 2026, 11:59 PM

---

## 1. Overview

This repository contains my solutions to Individual Assignment III. It covers:

- PL/SQL `GOTO` statements (valid use, illegal use, and rewriting without `GOTO`)
- Stored functions with exception handling
- Calling functions from SQL `SELECT` statements
- A combined payroll validation task
- GitHub organisation and documentation

All work uses a single `employees` table with five sample rows.

---

## 2. Repository Structure

```
plsql-goto-functions-<studentID>-<firstname>/
├── README.md
├── .gitignore
├── 00_setup/
│   └── create_tables.sql
├── 01_goto/
│   ├── A1_number_classifier.sql
│   ├── A2_salary_review.sql
│   ├── A3_illegal_goto.sql
│   └── A4_rewrite_no_goto.sql
├── 02_functions/
│   ├── B1_fn_annual_salary.sql
│   ├── B2_fn_years_of_service.sql
│   ├── B3_fn_calculate_tax.sql
│   ├── B4_fn_dept_name.sql
│   └── C1_fn_validate_payroll.sql
├── 03_tests/
│   ├── B5_functions_in_select.sql
│   ├── test_functions.sql
│   └── test_validate_payroll.sql
├── screenshots/
│   ├── A1_output.png
│   ├── A2_output.png
│   ├── A3_error_and_fix.png
│   ├── A4_output.png
│   ├── B5_select_output.png
│   └── C1_output.png
└── docs/
    └── REFLECTION.md
```

---

## 3. Database Setup

`00_setup/create_tables.sql` creates the `employees` table and inserts the sample data.

| Column          | Type          | Notes       |
|-----------------|---------------|-------------|
| `employee_id`   | NUMBER        | Primary key |
| `first_name`    | VARCHAR2(50)  |             |
| `last_name`     | VARCHAR2(50)  |             |
| `department_id` | NUMBER        |             |
| `salary`        | NUMBER(10,2)  | Monthly salary |
| `hire_date`     | DATE          |             |

**Sample data**

| ID  | Name          | Dept | Salary | Hire Date  |
|-----|---------------|------|--------|------------|
| 101 | John Doe      | 10   | 50000  | 2020-01-15 |
| 102 | Jane Smith    | 20   | 65000  | 2018-06-10 |
| 103 | Peter Brown   | 10   | 40000  | 2023-03-20 |
| 104 | Mary Jones    | 30   | 80000  | 2015-09-01 |
| 105 | David Wilson  | 20   | 55000  | 2021-11-05 |

---

## 4. Part A: GOTO Statements

| Task | File | Description |
|------|------|-------------|
| **A1** | `A1_number_classifier.sql` | Classifies a number as positive, negative or zero using `GOTO` labels (`positive`, `negative`, `zero`, `finish`). |
| **A2** | `A2_salary_review.sql` | Reads an employee's salary and uses `GOTO` to print high (≥ 70,000), average (≥ 50,000) or low salary messages. |
| **A3** | `A3_illegal_goto.sql` | Shows an **illegal** `GOTO` that jumps *into* an inner block (commented out because it fails to compile), followed by a **fixed** valid version. |
| **A4** | `A4_rewrite_no_goto.sql` | Rewrites A2 using a structured `IF / ELSIF / ELSE`, with identical output and no `GOTO`. |

**Key rules about GOTO in PL/SQL**

- A `GOTO` can jump to a label in the same block or an enclosing block.
- A `GOTO` **cannot** jump into an inner block, into an `IF` branch, or into a loop. This is the error demonstrated in A3.
- A label must be followed by an executable statement.
- A `GOTO` cannot jump out of a subprogram, so execution cannot leave a function or procedure this way.

---

## 5. Part B: Functions

All functions take an `employee_id` and handle `NO_DATA_FOUND`.

| Task | Function | Returns | Logic | If employee not found |
|------|----------|---------|-------|-----------------------|
| **B1** | `fn_annual_salary` | NUMBER | `salary * 12` | `NULL` |
| **B2** | `fn_years_of_service` | NUMBER | `FLOOR(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)` | `NULL` |
| **B3** | `fn_calculate_tax` | NUMBER | Annual salary × rate: ≤ 60,000 → 10%; ≤ 100,000 → 15%; above → 20% | `NULL` |
| **B4** | `fn_dept_name` | VARCHAR2 | 10 → IT, 20 → HR, 30 → Finance, otherwise General | `'Unknown'` |
| **B5** | *(SQL usage)* | n/a | Calls B1 to B4 inside one `SELECT` over the whole `employees` table | n/a |

---

## 6. Part C: Combined Task

### C1: Payroll Validator (`fn_validate_payroll`)

| Condition | Result |
|-----------|--------|
| Salary is `NULL` | `INVALID: Salary is missing` |
| Salary ≤ 0 | `INVALID: Salary must be greater than zero` |
| Salary < 10,000 | `WARNING: Salary is below standard minimum threshold` |
| Otherwise | `VALID: Payroll amount is acceptable` |
| Employee does not exist | `ERROR: Employee ID not found` |

### C2: Reflection

See [`docs/REFLECTION.md`](docs/REFLECTION.md).

---

## 7. How to Run

Run the scripts in this order (SQL*Plus, SQL Developer or SQLcl):

1. `00_setup/create_tables.sql`: creates the table and sample data.
2. All files in `02_functions/`: compiles the functions (B1 to B4, C1).
3. All files in `01_goto/`: runs the GOTO programs.
4. All files in `03_tests/`: runs the test scripts.
5. Verify the output against the screenshots in `screenshots/`.

> Run `SET SERVEROUTPUT ON;` first, otherwise `DBMS_OUTPUT` messages will not display.
> The files in `02_functions/` must be run **before** the tests, because the tests call those functions.

---

## 8. Expected Output

**A1** (`v_number := 25`)
```
The number 25 is positive.
Number classification completed.
```

**A2 / A4** (employee 101, salary 50,000)
```
Employee 101 has an average salary of 50000
Salary review completed.
```

**A3, fixed version**
```
Start of main block.
Successfully jumped past the code safely!
```

**C1 tests**
```
Employee 101: VALID: Payroll amount is acceptable
Employee 999: ERROR: Employee ID not found
```

**B5**: one row per employee showing monthly salary, annual salary, years of service, tax and department name. `years_of_service` depends on `SYSDATE`, so it changes over time.

---

## 9. Testing Summary

| Test file | What it checks |
|-----------|----------------|
| `B5_functions_in_select.sql` | All four functions used together in a `SELECT` |
| `test_functions.sql` | Runs B1 to B4 and C1 for employee 101 with formatted output |
| `test_validate_payroll.sql` | Valid employee (101) and non-existent employee (999) |

---

## 10. Notes

- **AI usage:** I used an AI assistant (Claude) to help draft this README and the structure of the reflection document. The SQL code i udes gemini ai to debug some of my codes the ones i had few difficulties to run, and I can explain every script, including the GOTO rules and how each function handles exceptions.
- The salary column is treated as a **monthly** salary, so the annual figure is `salary * 12`.
- Tax is calculated on the **annual** salary.
- A3 contains the illegal `GOTO` inside a comment block so the file can still run. Remove the comment markers `/* ... */` to reproduce the compilation error shown in `screenshots/A3_error_and_fix.png`.


