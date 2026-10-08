# Reflection: PL/SQL GOTO Statements and Functions

**Student:** `NTWARI CHRIS DAVID` | **ID:** `29378`
**Course:** Database Development with PL/SQL (INSY 8311)

---

## 1. What I Did

In this assignment I wrote PL/SQL programs that use `GOTO` to control the flow of execution (a number classifier and a salary review). I also deliberately wrote an illegal `GOTO` to see the compiler error, then rewrote the salary review without `GOTO`. In the second part I built five stored functions (`fn_annual_salary`, `fn_years_of_service`, `fn_calculate_tax`, `fn_dept_name` and `fn_validate_payroll`) and called them from a single `SELECT` statement and from test blocks.

---

## 2. What I Learned About GOTO

- `GOTO` jumps unconditionally to a label written as `<<label_name>>`, and the label must be followed by an executable statement.
- It can jump forward or backward within the same block, or out to an enclosing block.
- It **cannot jump into** an inner block, an `IF` branch or a loop. In A3, my first version tried to jump into a nested `BEGIN ... END` block and failed to compile because the label was not in scope. The fix was to put the label in the same block as the `GOTO`.
- In A1 and A2 I needed extra `GOTO finish` statements after each branch, otherwise execution would fall through into the next label and print the wrong messages. This showed me how easily `GOTO` code can go wrong.

---

## 3. GOTO vs Structured Code

When I rewrote A2 as A4 using `IF / ELSIF / ELSE`, the program became shorter and easier to read. There were no labels to follow, no risk of falling through to the wrong section, and the logic reads from top to bottom. Both versions produce the same output.

**My conclusion:** structured control statements (`IF`, `CASE`, loops) should be the default choice. `GOTO` is rarely needed, and it can make a program hard to read, debug and maintain. Still, it was useful to learn how it works and what its scope restrictions are, since I may meet it in older code.

---

## 4. What I Learned About Functions

- A function **must return a value** and is declared with `RETURN <datatype>`. Unlike a procedure, it can be called inside a SQL statement.
- Using `%TYPE` (for example `employees.salary%TYPE`) keeps variables consistent with the table columns, so my code keeps working if a column's definition changes.
- Every function that uses `SELECT ... INTO` raises `NO_DATA_FOUND` when no row matches. I handled this in each function:
  - Numeric functions return `NULL`.
  - `fn_dept_name` returns `'Unknown'`.
  - `fn_validate_payroll` returns `'ERROR: Employee ID not found'`.
- Handling the exception inside the function means a bad employee ID does not crash the whole query or program.
- Using functions in SQL (B5) was powerful. One `SELECT` produced annual salary, years of service, tax and department name for every employee. However, each function runs a separate query per row, so on a very large table this could be slow.

---

## 5. Challenges and How I Solved Them

| Challenge | How I solved it |
|-----------|-----------------|
| Wrong messages printing because execution fell through into the next label | Added `GOTO finish` after each branch |
| Understanding why the illegal GOTO fails | Read the compiler error and moved the label into the correct scope |
| Making functions safe for missing employees | Added a `NO_DATA_FOUND` exception handler to each function |
| Testing both valid and invalid cases | Wrote tests for employee 101 (exists) and 999 (does not exist) |

---

## 6. Limitations and Possible Improvements

- Every employee in the sample data has an annual salary above 100,000, so the 10% and 15% tax brackets in `fn_calculate_tax` are never tested by the current data. Adding employees with lower salaries would test those branches.
- `fn_dept_name` uses hard-coded department numbers. A separate `departments` table with a join would be more flexible and easier to maintain.
- `fn_years_of_service` depends on `SYSDATE`, so its results change over time.
- `fn_validate_payroll` could also check other fields, such as a missing hire date.

---

## 7. Final Thoughts

This assignment helped me understand control flow in PL/SQL and how to write reusable, safe functions. I now understand why `GOTO` has scope restrictions, why structured code is preferred, and how stored functions can be combined with SQL queries. I also practised organising a project in GitHub with clear folders, tests, screenshots and documentation.

---

