-- Step 1: Create Database
CREATE DATABASE BankLoanDB;
USE BankLoanDB;

-- Step 2: Create Table for Financial Loan Data
CREATE TABLE loans (
    id INT PRIMARY KEY,
    address_state VARCHAR(10),
    application_type VARCHAR(50),
    emp_length VARCHAR(20),
    emp_title VARCHAR(255),
    grade CHAR(1),
    home_ownership VARCHAR(50),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(50),
    next_payment_date DATE,
	member_id INT,
    purpose VARCHAR(255),
    sub_grade VARCHAR(5),
    term VARCHAR(20),
    verification_status VARCHAR(50),
    annual_income DECIMAL(12,2),
    dti DECIMAL(5,2),
    installment DECIMAL(10,2),
    int_rate DECIMAL(5,4),
    loan_amount INT,
    total_acc INT,
    total_payment DECIMAL(12,2)
);

-- Step 3: Load Data from CSV file 
-- Correcting the Data Type of all Date columns

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\financial_loan.csv"
INTO TABLE loans
FIELDS TERMINATED BY ',' 
ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@id, @address_state, @application_type, @emp_length, @emp_title, @grade, @home_ownership, 
@issue_date, @last_credit_pull_date, @last_payment_date, @loan_status, @next_payment_date, 
@member_id, @purpose, @sub_grade, @term, @verification_status, @annual_income, @dti, @installment, 
@int_rate, @loan_amount, @total_acc, @total_payment)
SET 
    id = @id,
    address_state = @address_state,
    application_type = @application_type,
    emp_length = @emp_length,
    emp_title = @emp_title,
    grade = @grade,
    home_ownership = @home_ownership,
    issue_date = STR_TO_DATE(@issue_date, '%d-%m-%Y'),
    last_credit_pull_date = STR_TO_DATE(@last_credit_pull_date, '%d-%m-%Y'),
    last_payment_date = STR_TO_DATE(@last_payment_date, '%d-%m-%Y'),
    loan_status = @loan_status,
    next_payment_date = STR_TO_DATE(@next_payment_date, '%d-%m-%Y'),
    member_id = @member_id,
    purpose = @purpose,
    sub_grade = @sub_grade,
    term = @term,
    verification_status = @verification_status,
    annual_income = @annual_income,
    dti = @dti,
    installment = @installment,
    int_rate = @int_rate,
    loan_amount = @loan_amount,
    total_acc = @total_acc,
    total_payment = @total_payment;


select * 
from loans;

