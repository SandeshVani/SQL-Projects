-- B. BANK LOAN REPORT | OVERVIEW


-- Using the database bankloandb
USE bankloandb;


-- a. MONTH
-- Total applications, loan amount, and amount received grouped by month.
-- Including YEAR(issue_date) to prevent mixing data from different years.

SELECT  YEAR(issue_date) AS year, MONTH(issue_date) AS month,
		COUNT(*) AS total_applications,
		SUM(loan_amount) AS total_loan_amount,
		SUM(total_payment) AS total_payment_received
FROM loans
GROUP BY YEAR(issue_date), MONTH(issue_date);

-- b. STATE
-- Total number of applications, total loan amount and total amount received by State

SELECT  address_state AS state,
		COUNT(*) AS total_applications,
		SUM(loan_amount) AS total_loan_amount,
		SUM(total_payment) AS total_payment_received
FROM loans
GROUP BY address_state;

-- c. TERM
-- Total number of applications, total loan amount and total amount received by Term

SELECT  term,
		COUNT(*) AS total_applications,
		SUM(loan_amount) AS total_loan_amount,
		SUM(total_payment) AS total_payment_received
FROM loans
GROUP BY term;

-- d. EMPLOYEE LENGTH
-- Total applications, loan amount, and amount received grouped by employment length.
-- Handling potential NULL values using COALESCE().

SELECT  COALESCE(emp_length, 'Unknown') AS employee_length,
		COUNT(*) AS total_applications,
		SUM(loan_amount) AS total_loan_amount,
		SUM(total_payment) AS total_payment_received
FROM loans
GROUP BY COALESCE(emp_length, 'Unknown');

-- e. PURPOSE
-- Total number of applications, total loan amount and total amount received by Purpose

SELECT  purpose,
		COUNT(*) AS total_applications,
		SUM(loan_amount) AS total_loan_amount,
		SUM(total_payment) AS total_payment_received
FROM loans
GROUP BY purpose;

-- f. HOME OWNERSHIP
-- Total applications, loan amount, and amount received grouped by home ownership status.

SELECT  home_ownership,
		COUNT(*) AS total_applications,
		SUM(loan_amount) AS total_loan_amount,
		SUM(total_payment) AS total_payment_received
FROM loans
GROUP BY home_ownership;
