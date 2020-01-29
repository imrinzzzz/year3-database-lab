# database lab part 3

---
title: Basic DB Using SQL Server (Part 3) - retrieve data using SQL  
published: false
description: 
tags: 
---

In this post, we are going to learn how to **retrieve data** in a relational database by using *Structured Query Language* (SQL). 

Topics that we are going to cover:
1. SELECT statement
2. Search condition (WHERE)
3. Computed fields
4. Intro to Aggregation functions
5. Sorting function
6. Intro to Joining

<sub>In the queries below, we are going to use tables from PremierProduct database. The SQL script to create PremiereProduct database, create tables and relations, and add records to the tables can be found [here][premier-db].</sub>

# 1) SELECT statement

The `SELECT` statement is used to select data from a database. The data returned is displayed as a table<sup>[1]</sup>.

``` sql
SELECT select_list [INTO new_table]
FROM table_source [WHERE search_condition]
[GROUP BY group_by_expression]
[HAVING search_condition]
[ORDER BY order_expression [ASC | DESC]]
```
<sub>note: the query expressions inside the [ ] are optional. We are going to go over these expressions later.</sub>

The table that we are going to use is called `Customer` and it looks like this...

![clipboard.png](_-tJqCbE-clipboard.png)

``` sql
-- List all information from the table Customer --
SELECT * FROM Customer

-- List the number, name, balance, and credit limit from the table Customer --
SELECT CustomerNum, CustomerName, Balance, CreditLine FROM Customer
```

### Distinct

Sometimes, we just want to list distinct values from a column because a column can have a lot of duplicate values, for example, the `City` column contains duplicate city names. 

``` sql 
-- list distinct city from the table Customer --
SELECT DISTINCT City FROM Customer
```

# 2) Search condition

We are going to use `WHERE` clause to filter records and get only the ones that fulfill our condition(s).

``` sql 
-- find the Name of Customer number 148 --
SELECT CustomerName FROM Customer 
WHERE CustomerNum=148
```

Another table that we are going to use is called `Part` and it looks like this.

![clipboard.png](v3JMETGO-clipboard.png)

### AND / OR conditions
``` sql 
-- List the description, on-hand value, and warehouse number for parts 
-- that have more than 10 units on-hand AND are located in warehouse 3. --
SELECT Description, OnHand, Warehouse FROM Part
WHERE OnHand>10 AND Warehouse=3
```
``` sql
-- List the description, on-hand value, and warehouse number for parts 
-- that have more than 10 units on-hand OR are located in warehouse 3. --
SELECT Description, OnHand, Warehouse FROM Part
WHERE OnHand>10 OR Warehouse=3
```
```sql
-- List the Part number, Description, and Price where the price is between $100 and $400. --
SELECT PartNum, Description, Price FROM Part
WHERE Price>100 AND Price<400
```

### NOT

To select records that do *NOT* have a certain property can be written in 3 ways.

``` sql
-- list all information of all the customers who are not from the city Grove --
SELECT * FROM Customer
WHERE City!='Grove'

SELECT * FROM Customer
WHERE City<>'Grove'

SELECT * FROM Customer
WHERE NOT City='Grove'
```

# 3) Computing fields

A **Computed field** is a field that is the result of a calculating using one or more existing fields. 

Arithmetic operators (e.g. +, -, \*, /) and parentheses can be used. 

``` sql
-- list the number, name, and available credit for all customers --
SELECT CustomerNum, CustomerName, (CreditLine - Balance) AS Available_Credit FROM Customer
```

As you can see, we don't have `Available_credit` column, so we have to make one. The available credit is the subtraction of `CreditLine` and `Balance`. 

  We rename the newly made column using `AS` command and the column is called `Available_credit`. This is called **Alias**.

# 4) Intro to Aggregation Functions

Aggregation Functions are functions where the values of multiple rows are grouped together as input on certain criteria to form a single value of more significant meaning<sup>[2]</sup>.

The commonly used SQL aggregate functions are `AVG`, `COUNT`, `MIN`, `MAX`, and `SUM`.

### COUNT

`Count` is a function that returns the number of rows that matches a specified criteria<sup>[3]</sup>.

``` sql
-- how many customers does sales rep 35 represent? --
SELECT COUNT(CustomerNum) AS Total_customers FROM Customer
WHERE RepNum=35
```

The `AS` command is optional. We use `COUNT` on one of the column (in the example, we use `CustomerNum` column) to count how many rows fit the condition.

### AVERAGE

`AVG` function returns the average value of a *numeric* column<sup>[3]</sup>.

``` sql
-- what is the average balance of all customers of sales rep 35? --
SELECT AVG(Balance) AS Average_balance FROM Customer
WHERE RepNum=35
```

### SUM

``` sql
-- find the total balance of all the customers living in Grove --
SELECT SUM(Balance) AS total_balance FROM Customer
WHERE City='Grove'
```

### Grouping

Grouping means creating groups of records that share some common characteristics. We can use Aggregation functions together with grouping. The calculations will affect groups of records. 

``` sql
-- what is the average balance for all customers of each sales rep? --
SELECT RepNum, AVG(Balance) AS Average_balance FROM Customer
GROUP BY RepNum
```

# 5) Sorting function

`ORDER` function helps us list the records in query results in a particular way. Sorting records can be performed on more than one field.

``` sql
-- list all customers and sort the output alphabetically by customer name --
SELECT * FROM Customer
ORDER BY CustomerName ASC
```

You can add `ASC` or `DESC` to specify whether you want to sort in ascending order (`ASC`) or descending order (`DESC`). If nothing is specified, the default is `ASC`.

``` sql
-- list all customers and sort the output by sales rep num
-- within the sales rep num, sort the output by customer name --
SELECT * FROM Customer
ORDER BY RepNum, CustomerName
```
# 6) Intro to Joining

Sometimes, it is necessary to join the tables based on matching fields to query data from different tables. 

Another table that will be used is called `Rep` and it looks like this.

![clipboard.png](udqD9Fa0-clipboard.png)

``` sql
-- list customer's number and name, along with the number, last and first name of each customer's sale rep --
SELECT Customer.CustomerNum, Customer.CustomerName, Rep.RepNum, Rep.LastName, Rep.FirstName
FROM Rep JOIN Customer ON Rep.RepNum = Customer.RepNum
```

We join `Rep` table with `Customer` table on the common column they both have; `RepNum`. However, when we `SELECT` the columns, we have to specify which table that column is from; e.g. `Customer.CustomerNum`.

However, specifying which table it is using the table name can be too long. We can shorten it by making a nickname for the table(s).

``` sql
SELECT C.CustomerNum, C.CustomerName, R.RepNum, R.LastName, R.FirstName
-- we are making a nickname here --
-- Table Rep is called R and table Customer is called C --
FROM Rep R JOIN Customer C ON R.RepNum = C.RepNum
```

More examples on `JOIN` (with `WHERE`)

``` sql
-- list the customer's number and name, along with the number, last and first name of the sales rep
-- for customer where credit limit is $10,000 --
SELECT C.CustomerNum, C.CustomerName, R.RepNum, R.LastName, R.FirstName
FROM Rep R JOIN Customer C ON R.RepNum = C.RepNum
WHERE C.CreditLine = 10000
```

Let's join more than 2 tables! The additional tables that we are going to use are `Orders` and `OrderLine`. 

This is `Order`.

![clipboard.png](jxGhL1XP-clipboard.png)

And this is `OrderLine`

![clipboard.png](w7rq5IG1-clipboard.png)

``` sql
-- For each order, list order number, order date, customer number and name
-- in addition, list the part number, description, number of units and quoted price --
SELECT O.OrderNum, O.OrderDate, C.CustomerNum, C.CustomerName, P.PartNum,
P.Description, P.OnHand AS [Number of Units], OL.QuotedPrice
FROM Customer C JOIN Orders O ON C.CustomerNum=O.CustomerNum
JOIN OrderLine OL ON OL.OrderNum=O.OrderNum
JOIN Part P ON P.PartNum=OL.PartNum
```

We can also use another table to come up with another query command. The table is called `CurrentOrders` which look like this.

![clipboard.png](QkzrncdR-clipboard.png)

``` sql
-- another query command that produces the same result --
SELECT CO.OrderNum, O.OrderDate, C.CustomerNum, CO.CustomerName, P.PartNum,
CO.Description, P.OnHand AS [Number of Units], CO.QuotedPrice
FROM CurrentOrders CO JOIN Customer C ON CO.CustomerName=C.CustomerName
JOIN Orders O ON O.OrderNum=CO.OrderNum
JOIN Part P ON P.PartNum=CO.PartNum
```

## EOF!

And so, we have come to the end of *part 3*! If anyone wishes to try out SQL command, there's another SQL script that will produce another database, tables, and values. The database is called `ALEXAMARA` and can be accessed [here][alexamara].

Some query problems to exercise with can be found [here][exercise]. There are also [queries][query] to those problems in case you want to check if the result is correct.

[premier-db]: https://github.com/imrinzzzz/year3-database-lab/blob/master/lab3/PremierProducts.sql
[1]: https://www.w3schools.com/sql/sql_select.asp
[2]: https://www.geeksforgeeks.org/aggregate-functions-in-sql/
[3]: https://www.w3schools.com/sql/sql_count_avg_sum.asp
[alexamara]: https://github.com/imrinzzzz/year3-database-lab/blob/master/lab3/Alexamara.sql
[exercise]: https://github.com/imrinzzzz/year3-database-lab/blob/master/lab3/alexamara-exercise.md
[query]: https://github.com/imrinzzzz/year3-database-lab/blob/master/lab3/alexamara-query-script.sql