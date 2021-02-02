-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/u8FIsn
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- -     - one TO one
-- -<    - one TO many
-- >-    - many TO one
-- >-<   - many TO many
-- -0    - one TO zero or one
-- 0-    - zero or one TO one
-- 0-0   - zero or one TO zero or one
-- -0<   - one TO zero or many
-- >0-   - zero or many TO one
-- OrderLine as ol
-- ----
-- OrderLineID PK int
-- OrderID int FK >- Order.OrderID
-- ProductID int FK >- p.ProductID
-- Quantity int

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

-- import data value from csv file


ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


SELECT * FROM departments
SELECT * FROM dept_emp
SELECT * FROM dept_manager
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles



-- Data Analysis
-- -List the following details of each employee: employee number, last name, first name, sex, and salary.
-- 列出每個員工以下的資訊:employee number, last name, first name, sex, salary
SELECT e.emp_no, e.first_name, e.last_name, e.sex, s.salary FROM employees AS e LEFT JOIN salaries AS s ON e.emp_no = s.emp_no; 


-- -List first name, last name, and hire date for employees who were hired in 1986.
-- 列出在1986年被雇用的員工以下的資訊: first name, last name, and hire date
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date LIKE '%1986%';  --(LIKE '%1986%'這部分不確定)
--??

-- -List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
-- 列出每個department的manager以下的資料: department number, department name, the manager's employee number, last name, first name
SELECT departments.dept_no, departments.dept_name, employees.emp_no,employees.first_name, employees.last_name FROM departments
LEFT JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
LEFT JOIN employees ON employees.emp_no = dept_manager.emp_no;     --不確定應該用INNER JOIN還是LEFT JOIN/CODE本身也不確定@@


-- -List the department of each employee with the following information: employee number, last name, first name, and department name.
-- 列出dept_emp裡每個employee以下的資料: employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.first_name, employees.last_name, departments.dept_name FROM dept_emp
LEFT JOIN employees ON dept_emp.emp_no = employees.emp_no
LEFT JOIN departments ON departments.dept_no = dept_emp.dept_no;   --不確定應該用INNER JOIN還是LEFT JOIN/CODE本身也不確定@@


-- -List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
-- 列出first name是"Hercules", last name "B."開頭的員工以下的資料: first name, last name, and sex
SELECT first_name, last_name, sex FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- -List all employees in the Sales department, including their employee number, last name, first name, and department name.
-- 列出Sales department所有員工以下的資料: employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.first_name, employees.last_name, departments.dept_name FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no 
LEFT JOIN departments ON departments.dept_no = 'd007';     --不確定應該用INNER JOIN還是LEFT JOIN/CODE本身也不確定@@


-- -List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.first_name, employees.last_name, departments.dept_name FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no 
LEFT JOIN departments ON departments.dept_no = 'd007' OR departments.dept_no = 'd005';    --不確定應該用INNER JOIN還是LEFT JOIN/CODE本身也不確定@@


-- -In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
-- 由大到小排序,列出每個獨特的employee last names一共發生幾次 -- 多少人同last name
SELECT last_name, COUNT(last_name) AS "count#" FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;






