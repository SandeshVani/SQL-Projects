-- C. Miscellaneous | OVERVIEW

-- Using the database bankloandb
USE bankloandb;


-- 1. MoM Loan Application growth rate
-- This calculates the percentage change in loan applications from the previous month.
-- Handling NULL values to avoid division errors.

SELECT (COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date))) * 100 /
		NULLIF(LAG(COUNT(*)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date))) AS mom_loan_application_growth_rate
FROM loans
GROUP BY YEAR(issue_date), MONTH(issue_date);

-- 2. MoM Loan Amount Disbursed Growth Rate
-- This calculates the percentage change in total loan disbursed compared to the previous month.
-- Handling NULL values to avoid division errors.

SELECT (SUM(loan_amount) - LAG(SUM(loan_amount)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date))) * 100 /
		NULLIF(LAG(SUM(loan_amount)) OVER (ORDER BY YEAR(issue_date), MONTH(issue_date))) AS mom_loan_disbursed_growth_rate
FROM loans
GROUP BY YEAR(issue_date), MONTH(issue_date);

-- 3. Interest Rate for Various Subgrade and Grade Loan Types
-- This calculates the average interest rate for each loan grade and subgrade.

SELECT grade, sub_grade, AVG(int_rate) AS avg_interest_rate 
FROM loans 
GROUP BY grade, sub_grade;

