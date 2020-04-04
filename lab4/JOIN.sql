-- 1) Write a query that returns BusinessEntityID, LastName, NationalIDNumber, and JobTitle of ALL Person --
SELECT p.BusinessEntityID, p.LastName, e.NationalIDNumber, e.JobTitle
FROM Person.Person p LEFT JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID

-- 2) Write a query that returns FirstName, LastName and CreditCardID of Person who have credit cards --
SELECT p.FirstName, p.LastName, c.CreditCardID
FROM Person.Person p JOIN
Sales.PersonCreditCard c
ON p.BusinessEntityID = c.BusinessEntityID

-- 3) Write a query that returns ProductName, ProductCategory, ProductSubCategory and Product Model of all unique products --
SELECT DISTINCT p.Name AS [Product Name], c.Name AS [Catrgory], s.Name AS [Sub-catergory], m.Name AS [Model Name]
FROM Production.ProductModel m JOIN
Production.Product p ON m.ProductModelID = p.ProductModelID
JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID = p.ProductSubcategoryID
JOIN Production.ProductCategory c ON c.ProductCategoryID = s.ProductCategoryID

-- 4) Write a query that returns Name, LoginID and DepartmentName of Employee who were assigned the department and loginID --
SELECT p.LastName, e.LoginID, d.Name AS [Department Name]
FROM HumanResources.Department d
LEFT JOIN HumanResources.EmployeeDepartmentHistory h ON h.DepartmentID = d.DepartmentID
LEFT JOIN HumanResources.Employee e ON e.BusinessEntityID = h.BusinessEntityID
LEFT JOIN Person.Person p ON p.BusinessEntityID = h.BusinessEntityID

-- 5) Write a query that returns ONE COLUMN called Name and contains the last name of the employee with NationalIDNumber 112457891 --
SELECT CONCAT(p.LastName,' ' , e.NationalIDNumber) AS Name
FROM Person.Person p
JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.NationalIDNumber = 112457891

-------------------------------------------------- HOMEWORK --------------------------------------------------

-- Write a query that returns ProductID, Name and SpecialOfferID of 
-- (1) all products and that have NO special offers, and
-- (2) all products that have NO discount offer
SELECT p.ProductID, p.Name, o.SpecialOfferID
FROM Production.Product p 
LEFT JOIN Sales.SpecialOfferProduct o ON o.ProductID = p.ProductID
WHERE o.SpecialOfferID IS NULL