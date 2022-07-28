# Pewlett-Hackard-Analysis
## Overview
  This project was brought on by Pewlett Hackard. The company foresaw a massive outflux of workers from the Baby Boomer generation in the coming years. They had data on .csv files with all of the relevant information, but the information was not tied together and was difficult to work with.
  
### Purpose
  The purpose of this project was to take these different data sources and tie them together in one database, then to join and sort tables within this database so that Pewlett Hackard could have an exact understanding of the loss of manpower they would be experiencing in the coming years.
  
###Results
  This analysis relied on SQL and the use of SQL allowed us to find the extent of as well as start planning for the outflow of manpower from the Pewlett Hackard Enterprise. Some of the findings are below.

  Being elligible for retirement was determined as employees born between 1952 and 1955 for this analysis.

*retirement_titles.csv
  *This file shows us the names, emploee numbers, titles, and hire dates of the people identified as being soon to retire.
  *This file DID NOT exclude those employees who have already left the company.
  *This file SHOULD NOT be used to asses the impact of the upcoming mass retirement.
  
*unique_titles.csv
  *This file DID exclude those workers who have already left the company.
  *These employees are identified as having "to_date"s, for their employment, of 9999-01-01.
    *This is the exclusionary date meant to identify a non-real/non-existant date.
  *This file contains relevant information pertaining to those employees deemed elligible for retirement.
  
*retiring_titles.csv
  *This file contains the number of employees, who are still employed, and are eligible for retirement by their job title.
  *Senior positions, i.e. Senior Engineers and Senior Staff have the highest numbers of retirement eligible employees.
    *25,916 and 24,926 respectively.
  *This data wil help recruiter start preparing for the positions that will need to be filled after the mass exodus of the retiring employees.
  *The full list can be seen below.
  
  #### Retiring Titles Results
  ![retiring_titles.csv](https://github.com/Beardlow/Pewlett-Hackard-Analysis/blob/main/retiring_titles.png)
  
*mentorship_eligibility.csv
  *This file shows relevant data for employees who were deemed eligible for the mentorship program.
  *Eligibility was deemed as those employees born during the year 1965.
  *This table/.csv lists the name, birthday, hire date, and title of those employees deemed eligible.
  
###Summary
  This analysis found that 72,458 employees are eligible for retirement, and 1,549 employees are eligible for the mentorship program. The following two queries were used to create the retiring_titles table and the Mentorship eligibilty tables, respectively. The mentorship eligibility table was also sorted so that the employees current title was shown instead of a random title that they could have had previously within the company.
  
#### Retirement by Title Query
```
--Count of Retiring Employees by Title
SELECT COUNT(ut.title),
			ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count DESC;
```

#### Mentorship Eligibility Query
```
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
```
