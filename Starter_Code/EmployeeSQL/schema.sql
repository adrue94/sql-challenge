-- Creating tables in order of dependencies
CREATE TABLE departments (
    dept_no VARCHAR(255) NOT NULL PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL
);
CREATE TABLE titles (
    title_id VARCHAR(255) NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(255) NOT NULL,
    birth_date VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex VARCHAR(255) NOT NULL,
    hire_date VARCHAR(255) NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

-- Creating a composite out of two FKs; then a composite for salaries
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE dept_manager (
	dept_no VARCHAR(255) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, salary)
); 

-- Import data into tables
------------ Data Analysis ------------
-- List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, last_name, first_name, sex, salary 
FROM employees AS e
INNER JOIN salaries on e.emp_no = salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date LIKE '1986%'
-- Add.: Can set "hire_date" as date datatype, querying "WHERE date_part('YEAR',hire_date) = '1986';"
-- Add.: Did not want to drop all tables

-- SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date LIKE '1986%'

-- List the manager of each department 
-- Along with their department number, department name, employee number, last name, and first name
SELECT DM.dept_no, dept_name, DM.emp_no, last_name, first_name
FROM dept_manager AS DM
INNER JOIN departments ON DM.dept_no = departments.dept_no
INNER JOIN employees ON DM.emp_no = employees.emp_no

-- List the department number for each employee 
-- Along with that employee’s employee number, last name, first name, and department name
SELECT DE.dept_no, DE.emp_no, last_name, first_name, dept_name
FROM dept_emp AS DE
INNER JOIN employees ON DE.emp_no = employees.emp_no
INNER JOIN departments ON DE.dept_no = departments.dept_no

-- List first name, last name, and sex of each employee 
-- Whose first name is Hercules and whose last name begins with the letter B (2 points)
SELECT first_name, last_name, sex 
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE'B%'

-- List each employee in the Sales department, 
-- Including their employee number, last name, and first name
SELECT DE.emp_no, last_name, first_name
FROM dept_emp AS DE
INNER JOIN employees ON DE.emp_no = employees.emp_no
INNER JOIN departments ON DE.dept_no = departments.dept_no
WHERE dept_name = 'Sales'

-- List each employee in the Sales and Development departments, 
-- Including their employee number, last name, first name, and department name
SELECT DE.emp_no, last_name, first_name, dept_name
FROM dept_emp AS DE
INNER JOIN employees ON DE.emp_no = employees.emp_no
INNER JOIN departments ON DE.dept_no = departments.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development'

-- List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name)
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT DESC