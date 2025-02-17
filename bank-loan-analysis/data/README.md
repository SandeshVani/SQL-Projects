# README - Bank Loan Data Analysis

## Overview
This repository contains two key documents related to bank loan data analysis:
1. **Domain Knowledge & Data Dictionary - Bank Loan**
2. **Data Analysis Project 2 - Problem Statement**

These files provide insights into bank loan processes, key terminologies, and a structured problem statement for performing data analysis using MySQL.

---

## 1. Domain Knowledge & Data Dictionary - Bank Loan
### **Description**
This document provides an overview of the bank loan process, including how banks collect and manage loan data. It defines important terms and fields used in loan-related data.

### **Key Topics Covered**
- **Bank Loan Process**: Steps involved in granting a loan, from application to repayment.
- **Loan Data Collection**: Sources of data such as applications, credit reports, internal records, and third-party data.
- **Loan Data Analysis**: Reasons for analyzing bank loan data, including risk assessment, fraud detection, regulatory compliance, and profitability analysis.
- **Terminologies & Data Fields**:
  - Loan ID, Address State, Employee Length, Employee Title
  - Grade, Sub Grade, Home Ownership, Issue Date
  - Last Credit Pull Date, Last Payment Date, Loan Status
  - Next Payment Date, Purpose, Term, Verification Status
  - Annual Income, Debt-to-Income Ratio (DTI), Installment, Interest Rate, Loan Amount

---

## 2. Bank Loan Data Analysis Project  - Problem Statement
### **Description**
This document outlines a bank loan data analysis project, including key performance indicators (KPIs) and reporting requirements.

### **Key Topics Covered**
- **Project Objective**: Create a MySQL database for bank loan data and analyze key parameters.
- **Key Performance Indicators (KPIs)**:
  - Total Loan Applications (MTD, PMTD)
  - Funded Amount (Total, MTD, PMTD)
  - Amount Received (Total, MTD, PMTD)
  - Interest Rate Analysis (Average, MTD, PMTD)
  - Debt-to-Income Ratio (DTI) Analysis
- **Good Loan vs. Bad Loan Analysis**:
  - Classification of loans based on repayment status (Fully Paid, Current, Charged Off)
  - Percentage of Good vs. Bad Loans
  - Funded Amount and Amount Received for each category
- **Loan Status Overview**:
  - Monthly trends of loan applications, funded amounts, and payments received
  - Regional analysis by state
  - Loan term, employee length, loan purpose, and home ownership breakdowns
- **Miscellaneous Analysis**:
  - Month-over-Month (MoM) growth in loan applications and funded amounts
  - Interest rate trends across different subgrades and grades

---

## Usage
1. **Understanding Loan Data**: The "Domain Knowledge & Data Dictionary" document serves as a reference for key loan-related terminologies and data attributes.
2. **Data Analysis & Reporting**: The "Data Analysis Project 2 - Problem Statement" document provides a structured approach to analyzing bank loan data using MySQL.
3. **Database Implementation**: Users are expected to create a MySQL database using financial_loan.csv and generate SQL reports based on the specified KPIs.

---

## License
All rights reserved by **TECHIOTA LLP**.


