-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
	 first_name VARCHAR NOT NULL,
	 last_name VARCHAR NOT NULL,
	 gender VARCHAR(1) NOT NULL,
	 hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no),
     UNIQUE (emp_no)
);
--DROP TABLE dept_manager
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
--DROP TABLE titles
CREATE TABLE IF NOT EXISTS public.titles
(
    emp_no integer NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (emp_no, from_date, to_date),
    CONSTRAINT fk_titles_emp_no FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
--SELECT * FROM titles
--DROP TABLE dept_emp
CREATE TABLE IF NOT EXISTS public.dept_emp
(
    emp_no integer NOT NULL,
    dept_no character varying COLLATE pg_catalog."default" NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (emp_no, dept_no, from_date, to_date),
    CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY (dept_no)
        REFERENCES public.departments (dept_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

--SELECT * FROM dept_manager
--1952 birth year
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
--1953 birth year
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

--1954 birth year
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

--1955 birth year
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

--Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring into a table retirement_info
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT * FROM retirement_info

--DROP TABLE retirement_info