-- C. Miscellaneous | OVERVIEW

-- Using the database bankloandb
USE bankloandb;


-- 1. MoM Loan Application growth rate
-- This calculates the percentage change in loan applications from the previous month.
-- Handling NULL values to avoid division errors.

WITH loan_counts AS(
	SELECT
		YEAR(issue_date) AS year,
        	MONTH(issue_date) AS month,
        	COUNT(*) AS total_loans
	FROM loans
    	GROUP BY YEAR(issue_date), MONTH(issue_date)
)
SELECT	  
	year, 
	month,
	COAlESCE((total_loans - LAG(total_loans) OVER (ORDER BY year, month)) * 100 /
	NULLIF(LAG(total_loans) OVER (ORDER BY year, month), 0), 
        0
	) AS mom_loan_application_growth_rate
FROM loan_counts;

-- 2. MoM Loan Amount Disbursed Growth Rate
-- This calculates the percentage change in total loan disbursed compared to the previous month.
-- Handling NULL values to avoid division errors.

WITH loan_disbursed AS (
    SELECT 
        YEAR(issue_date) AS year, 
        MONTH(issue_date) AS month, 
        SUM(loan_amount) AS total_loan_disbursed
    FROM loans
    GROUP BY YEAR(issue_date), MONTH(issue_date)
)
SELECT 
    year, 
    month, 
    total_loan_disbursed, 
    COALESCE((total_loan_disbursed - LAG(total_loan_disbursed) OVER (ORDER BY year, month)) * 100 / 
    NULLIF(LAG(total_loan_disbursed) OVER (ORDER BY year, month), 0),
    0
    ) AS mom_loan_disbursed_growth_rate
FROM loan_disbursed;


-- 3. Interest Rate for Various Subgrade and Grade Loan Types
-- This calculates the average interest rate for each loan grade and subgrade.

SELECT 
	grade, 
    	sub_grade, 
    	int_rate,
    	AVG(int_rate) OVER (PARTITION BY grade) AS avg_interest_rate_per_grade, 
    	AVG(int_rate) OVER (PARTITION BY grade, sub_grade) AS avg_interest_rate_per_subgrade
FROM loans ;

