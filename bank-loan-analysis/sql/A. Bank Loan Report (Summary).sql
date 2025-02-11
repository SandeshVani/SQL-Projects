-- A. BANK LOAN REPORT | SUMMARY

-- Using the database bankloandb
USE bankloandb;

-- 1. KPI’s:

-- 1) Number of Applications

-- a) Total Loan Applications

SELECT COUNT(*) AS total_loan_applications
FROM loans;

-- b) MTD Loan Applications(Month-To-Date i.e. Current Month)

SELECT COUNT(*) AS month_to_date_applications
FROM loans
WHERE MONTH(issue_date) = MONTH(CURDATE()) 
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);

-- c) PMTD Loan Applications(Previous Month)

SELECT COUNT(*) AS previous_month_to_date
FROM loans
WHERE MONTH(issue_date) = MONTH(CURDATE() - INTERVAL 1 MONTH)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);

-- 2) Funded Amount (Total Loan Amount approved)

-- a) Total Funded Amount

SELECT SUM(loan_amount) AS total_funded_amount 
FROM loans;

-- b) MTD Total Funded Amount

SELECT SUM(loan_amount) AS mtd_funded_amount 
FROM loans
WHERE MONTH(issue_date) = MONTH(CURDATE())
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);

-- c) PMTD Total Funded Amount

SELECT SUM(loan_amount) AS pmtd_funded_amount FROM loans 
WHERE MONTH(issue_date) = MONTH(CURDATE() - INTERVAL 1 MONTH)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);

-- 3) Amount Received(Loan Amount paid)

-- a) Total Amount Received

SELECT SUM(total_payment) AS total_amount_received FROM LOANS;

-- b) MTD Total Amount Received

SELECT SUM(total_payment) AS mtd_total_amount_received FROM loans 
WHERE MONTH(issue_date) = MONTH(CURDATE())
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);

-- c) PMTD Total Amount Received

SELECT SUM(total_payment) AS mtd_total_amount_received FROM loans 
WHERE MONTH(issue_date) = MONTH(CURDATE() - INTERVAL 1 MONTH)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);

-- 4) Interest Rate

-- a) Average Interest Rate

SELECT AVG(int_rate) AS average_interest_rate
FROM loans;

-- b) MTD Average Interest
SELECT AVG(int_rate) AS average_interest_rate
FROM loans
WHERE MONTH(issue_date) = MONTH(CURDATE())
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);

-- c) PMTD Average Interest

SELECT AVG(int_rate) AS average_interest_rate
FROM loans
WHERE MONTH(issue_date) = MONTH(CURDATE() - INTERVAL 1 MONTH)
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);

-- 5. 5) DTI (Debt to Income ratio)

-- a) Avg DTI

SELECT AVG(dti) AS avg_dti FROM loans;

-- b) MTD Avg DTI

SELECT AVG(dti) AS avg_dti 
FROM loans
WHERE MONTH(issue_date) = MONTH(CURDATE()) 
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);


-- c) PMTD Avg DTI
SELECT AVG(dti) AS avg_dti 
FROM loans
WHERE MONTH(issue_date) = MONTH(CURDATE() - INTERVAL 1 MONTH) 
AND YEAR(issue_date) = (SELECT MAX(YEAR(issue_date)) FROM loans);



-- 2. GOOD LOAN ISSUED

-- a). Good Loan Percentage

-- Calculating percentage based on only good loan applications

SELECT (COUNT(*) * 100)/(SELECT COUNT(*) FROM loans WHERE loan_status IN ('Fully paid', 'Current')) AS good_loan_percentage
FROM loans;

-- b). Good Loan Applications

SELECT COUNT(*) as total_good_loan_applications
FROM loans
WHERE loan_status IN ('Fully paid', 'Current');

-- c). Good Loan Funded Amount

SELECT SUM(CASE 
				WHEN loan_status IN  ('Fully paid', 'Current') THEN loan_amount 
			END) AS good_loan_funded_amount
FROM loans;
            
            
-- d). Good Loan Amount Received

SELECT SUM(CASE 
				WHEN loan_status IN  ('Fully paid', 'Current') THEN total_payment 
			END) AS good_loan_received_amount
FROM loans;

-- 3. BAD LOAN ISSUED

-- a). Bad Loan Percentage

-- Ensuring calculation is based only on bad loan applications

SELECT (COUNT(*) * 100)/(SELECT COUNT(*) FROM loans) as bad_loan_percentage
FROM loans
WHERE loan_status IN ('Charged Off');

-- b) Bad Loan Applications

SELECT COUNT(*) as total_bad_loan_applications
FROM loans
WHERE loan_status IN ('Charged Off');

-- c) Bad Loan Funded Amount

SELECT SUM(CASE 
				WHEN loan_status IN  ('Charged Off') THEN loan_amount 
			END) AS bad_loan_funded_amount
FROM loans;

-- d) Bad Loan Amount Received

SELECT SUM(CASE 
				WHEN loan_status IN  ('Charged Off') THEN total_payment 
			END) AS bad_loan_received_amount
FROM loans;


            











