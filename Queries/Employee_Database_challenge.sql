
--create a Retirement Titles table for employees who are born between January 1, 1952 and December 31, 1955. 
SELECT e.emp_no, e.first_name, e.last_name,
tl.title, tl.from_date, tl.to_date
INTO retirement_titles
FROM employees as e 
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;
--create a Unique Titles table that contains the employee number, first and last name, and most recent title.
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

--create a Retiring Titles table that contains the number of titles filled by employees who are retiring
SELECT COUNT(ut.title),
ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY count DESC;

--create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
de.from_date, de.to_date, tl.title
--INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de 
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no ASC;