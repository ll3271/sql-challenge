CREATE TABLE departments (
	dept_no VARCHAR(30) NOT NULL,
	dept_name VARCHAR(30) NOT NULL);
	
SELECT * FROM departments; 

CREATE TABLE dept_emp (
	emp_no VARCHAR(30) NOT NULL,
	dept_no VARCHAR(30) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL);

SELECT * FROM dept_emp; 

CREATE TABLE dept_manager (
	dept_no VARCHAR(30) NOT NULL,
	emp_no VARCHAR(30) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL);

SELECT * FROM dept_manager; 

CREATE TABLE employees (
	emp_no VARCHAR(30) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(30) NOT NULL,
	hire_date DATE NOT NULL);

SELECT * FROM employees; 

CREATE TABLE salaries (
	emp_no VARCHAR(30) NOT NULL,
	salary INT,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL);

SELECT * FROM salaries; 

CREATE TABLE titles (
	emp_no VARCHAR(30) NOT NULL,
	title VARCHAR(30) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL);

SELECT * FROM titles; 

--employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, employees.first_name, employees.last_name, employees.gender, salaries.salary
FROM salaries
INNER JOIN employees ON
employees.emp_no=salaries.emp_no;

--List employees who were hired in 1986.
SELECT * FROM employees
WHERE EXTRACT(year from hire_date) = 1986;

--List the manager of each department with the following information: department number
--department name, the manager's employee number, 
--last name, first name, and start and end employment dates
CREATE VIEW manager_info AS
	SELECT dept_manager.emp_no, dept_manager.dept_no, dept_manager.from_date, dept_manager.to_date, employees.first_name, employees.last_name 
	FROM employees
	INNER JOIN dept_manager ON
	dept_manager.emp_no=employees.emp_no;

SELECT * 
FROM manager_info 

SELECT manager_info.emp_no, manager_info.from_date, manager_info.to_date, manager_info.first_name, manager_info.last_name, departments.dept_no, departments.dept_name 
FROM departments
INNER JOIN manager_info ON
manager_info.dept_no = departments.dept_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

CREATE VIEW employee_info AS
	SELECT employees.emp_no, employees.first_name, employees.last_name, dept_emp.dept_no
	FROM dept_emp
	INNER JOIN employees ON
	dept_emp.emp_no=employees.emp_no;

CREATE VIEW emoloyee_info2 AS
	(SELECT employee_info.emp_no, employee_info.first_name, employee_info.last_name, departments.dept_name 
	FROM departments
	INNER JOIN employee_info ON
	employee_info.dept_no = departments.dept_no);

--List all employees whose first name is "Hercules" and last names begin with "B."

SELECT *
FROM employees
WHERE first_name = 'Hercules'
AND last_name Like 'B%'; 

--List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT * 
FROM emoloyee_info2
WHERE dept_name = 'Sales';

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT * 
FROM emoloyee_info2
WHERE dept_name IN ('Sales','Development')
;

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT emoloyee_info2.last_name, COUNT(emoloyee_info2.last_name) AS "name count" 
FROM emoloyee_info2
GROUP BY emoloyee_info2.last_name
ORDER BY "name count" DESC;


