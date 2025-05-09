# Importing the Netflix Database and using it
CREATE SCHEMA netflix;
USE netflix;

-- Analysis : 

-- 1.  top 3 most-watched movies based on viewing hours.

SELECT v.ContentID, c.TitleName, SUM(v.Runtime) AS Runtime
FROM viewinghistory v
JOIN content c on v.ContentID = c.ContentID
GROUP BY v.ContentID
ORDER BY Runtime DESC
LIMIT 3;

-- 2. Top genre in each category (ranked)

WITH TopGenres AS (
	SELECT  
		c.Category,
        c.Genre, 
        SUM(v.Runtime) AS Runtime, 
        RANK() OVER (PARTITION BY Category ORDER BY SUM(Runtime) DESC) AS rnk
	FROM viewinghistory v
	JOIN content c on v.ContentID = c.ContentID
	GROUP BY c.Category, c.Genre
	ORDER BY Runtime DESC
	LIMIT 3
)
SELECT Category, Genre, Runtime
FROM TopGenres
WHERE rnk = 1;

-- 3. Subscriptions for each plan

SELECT p.PlanID, p.PLanName,  COUNT(s.CustID) AS subscriberCount
FROM subscribes s
JOIN plans p ON s.PlanID = p.PlanID
-- WHERE s.Status = 'Active'
GROUP BY p.PlanID, p.PlanName
ORDER BY subscriberCount DESC;

-- 4. Most commonly used device type

SELECT DeviceType, count(*) AS AccessCount
FROM devices
GROUP BY DeviceType
ORDER BY AccessCount DESC;

-- 5. Average viewing time for movies vs TV shows

SELECT  c.Category, ROUND(AVG(v.Runtime), 2) AS AverageRuntime
FROM viewinghistory v
JOIN content c on v.ContentID = c.ContentID
GROUP BY c.Category
ORDER BY AverageRuntime DESC;

-- 6. Most preferred language by customers

SELECT Language, COUNT(DISTINCT CustID) AS CountOfUsers 
FROM customerslanguagepreferred
GROUP BY Language
ORDER BY CountOfUsers DESC
LIMIT 1;

-- 7. Customers with adult vs child accounts

SELECT 
	CASE 
		WHEN a.ProfileID IS NOT NULL THEN 'Adult'
        WHEN c.ProfileID IS NOT NULL THEN 'Child'
        ELSE 'UNKNOWN'
	END AS userType,
    COUNT(DISTINCT p.CustID) AS countOfCustomer
FROM profiles p
LEFT JOIN adultacc a ON p.ProfileID = a.ProfileID
LEFT JOIN childacc c ON p.ProfileID = c.ProfileID
GROUP BY userType;

-- 8. Average number of profiles per customer account

SELECT AVG(countOfProfile) AS averageProfileCount
FROM (
	SELECT COUNT(ProfileID) AS countOfProfile
	FROM profiles
	GROUP BY CustID
) AS profileCount;

-- 9. Content with lowest average viewing time per user

SELECT v.ContentID, c.TitleName, ROUND(AVG(v.Runtime), 2) AS averageRuntime 
FROM viewinghistory v
JOIN content c ON v.ContentID = c.ContentID
GROUP BY v.ContentID
ORDER BY averageRuntime ASC
LIMIT 1;

-- 10. Count for each content type

SELECT Category, COUNT(ContentID) AS contentType
FROM content
GROUP BY Category;

-- 11. Customers with unlimited vs limited access

SELECT ContentAccess, COUNT(DISTINCT CustID) AS countOfCustomers
FROM subscribes s 
JOIN plans p ON s.PlanID = p.PlanId
GROUP BY ContentAccess;

-- 12. Average monthly price for unlimited access plans

SELECT AVG(MonthlyPrice) AS averageMonthlyPrice 
FROM plans
WHERE ContentAccess = 'unlimited';

-- 13. Customers with plans expiring in 2028 or later

SELECT c.CustID, CONCAT(c.FNAME, " ", C.LNAME) AS CustName, p.ExpirationDate AS ExpiryDate
FROM paymentmethod p
JOIN customers c ON p.CustID = c.CustID
WHERE YEAR(p.ExpirationDate) >= '2028'
ORDER BY ExpiryDate DESC, CustName;

-- 14. Average revenue by city (ranked)

WITH CityRevenue AS (
	SELECT 
		pm.City, 
		ROUND(AVG(ph.PaymentAmount)) AS AverageRevenueGenerated
	FROM paymentmethod pm
	JOIN paymenthistory ph ON pm.CardId = ph.CardID
	GROUP BY pm.City
)
SELECT 
	city, 
	AverageRevenueGenerated, 
	RANK() OVER (ORDER BY AverageRevenueGenerated DESC) AS CityRank
FROM CityRevenue
ORDER BY CityRank;

-- 15. Most frequently viewed genre among adults for each category

WITH AdultViewing AS (
	SELECT 
		c.Category, 
        c.Genre, 
        SUM(v.Runtime) AS Runtime,
		RANK() OVER (PARTITION BY c.Category ORDER BY SUM(v.Runtime) DESC) AS rnk
	FROM viewinghistory v
	JOIN content c ON v.ContentID = c.ContentID
	JOIN profiles p ON v.ProfileID = p.ProfileID
	JOIN adultacc a ON p.ProfileId = a.ProfileId
	GROUP BY c.Category, c.Genre
)
SELECT Category, Genre, Runtime
FROM AdultViewing
WHERE rnk = 1;



















