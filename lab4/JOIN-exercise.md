1. Write a query that returns BusinessEntityID, LastName, NationalIDNumber, and JobTitle of all Person. 
[Table: Person, Employee]

2. Write a query that returns FirstName, LastName, and CreditCardID of Person who have credit cards. 
[Table: Person, PersonCreditCard]

3. Write a query that returns ProductName, Product Category, Product SubCategory and Product Model of all unique Products.
[Table: ProductModel, Product, ProductSubcategory, ProductCategory]

4. Write a query that returns Name, LoginIn and Department Name of Employee who were assigned the department and LoginID.
[Table: Person, Employee, Department, EmployeeDepartmentHistory]

5. Write a query that returns 1 column called Name and contains the last name of the employee with NatinoalIDNumber 112457891.
[Table: Person, Employee]
HINT: CONCAT(column1, column2) is used for combining column results. 

------------------------------------ EXTRA ------------------------------------

Write a query against the **AdventureWorks** database that returns ProductID, Name, and SpecialOfferID of
1. all products and that have <u>No special offers</u>, and
2. all prodcut that have <u>No discount offer</u>.

HINT: {1) Production.Product and Sales.SpecialOfferProduct
