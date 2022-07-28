--SELECT * FROM employees
--DROP TABLE retirement_titles
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		tit.title,
		tit.from_date,
		tit.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS tit
ON e.emp_no = tit.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')		
ORDER BY e.emp_no ASC;

--SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date BETWEEN '9999-01-01' AND '9999-01-01') 
ORDER BY rt.emp_no, rt.to_date DESC;

--Count of Retiring Employees by Title
SELECT COUNT(ut.title),
			ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count DESC;

--Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no)
		e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		tit.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN titles as tit
ON e.emp_no = tit.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date BETWEEN '9999-01-01' AND '9999-01-01')
ORDER BY e.emp_no ASC, tit.from_date DESC;