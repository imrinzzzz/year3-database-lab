-- 1) How many parts are there? --
SELECT COUNT(PartNum) AS [Number of part]
FROM Part

-- 2) How many parts are in item class HW? --
SELECT COUNT(PartNum) AS [Number of part]
FROM Part
GROUP BY Class
HAVING Class='HW'

-- 3) How many lines are there in each order? --
SELECT OrderNum, COUNT(OrderNum) AS [Number of Lines]
FROM OrderLine
GROUP BY OrderNum

-- 4) How many number of customers and the total of their balances? --
SELECT COUNT(CustomerNum) AS [number of customers], SUM(CAST(Balance as float)) AS [Balance Total]
FROM Customer

-- 5) What is the average balance of customer? --
SELECT AVG(CAST(Balance as float)) AS [Average Balance]
FROM Customer

-- 6) For each sales rep with fewer than four customers, find his/her total balance and the number of customers assigned to the rep --
SELECT RepNum, COUNT(CustomerNum) AS [Amount of Customers], SUM(CAST(Balance as float)) AS [Total Balance]
FROM Customer
GROUP BY RepNum
HAVING COUNT(CustomerNum) < 4
 

SELECT * FROM 
(
	SELECT RepNum, COUNT(CustomerNum) AS [Amount of Customers], SUM(CAST(Balance as float)) AS [Total Balance]
	FROM Customer
	GROUP BY RepNum
) AS Alias
	WHERE [Amount of Customers] < 4

-- 7) For the customers whose balance is larger than 5000, list the customer numbers, their names and the number of orders issued by them --
SELECT C.CustomerNum, C.CustomerName, COUNT(O.OrderNum) AS [number of orders], C.Balance
FROM Customer C LEFT JOIN Orders O ON C.CustomerNum = O.CustomerNum
WHERE Balance>5000
GROUP BY C.CustomerNum, C.CustomerName, C.Balance

-- 8) How many parts are in item class HW and price below 100? --
SELECT COUNT(PartNum) AS [Number of Parts]
FROM Part
WHERE Price < 100
GROUP BY Class
HAVING Class='HW'

-- 9) How much the total balance of customer and how many customers assigned to each sale representative? --
SELECT RepNum, COUNT(CustomerNum) AS [Amount of Customers], SUM(CAST(Balance as float)) AS [Total Balance]
FROM Customer
GROUP BY RepNum

-- 10) How many customers who has the lowest credit limit? --
SELECT COUNT(CustomerNum) AS [Amount of Customers]
FROM Customer
WHERE CreditLine = (SELECT MIN(CreditLine) FROM Customer)

-- 11) How mnay customer have balance higher than the average balance? --
SELECT COUNT(*) NumberOfCustomer
FROM Customer
WHERE Balance > (SELECT AVG(Balance) as avgr FROM Customer)

-- 12) For the customers who issue more than one order and whose balance is larger than 5000, list the customer numbers, their names and the number of orders --
SELECT C.CustomerNum, C.CustomerName, COUNT(O.OrderNum) AS [Number of Orders]
FROM Customer C JOIN Orders O ON C.CustomerNum = O.CustomerNum
WHERE Balance > 5000
GROUP BY C.CustomerNum, C.CustomerName
HAVING COUNT(O.OrderNum) > 1
