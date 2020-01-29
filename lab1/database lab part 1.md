# database lab part 1

---
title: Basic DB Using SQL Server (Part 1) - Basic commands!
published: false
description: 
tags: 
---

Hello! This post will be about "Basic commands" just like what the topic said. We will cover 2 types of SQL commands; DDL commands and DML commands. Let's see what these 2 mean first...

> **DDL**, or Data Definition Language, is used to create and/or modify the structure of a database and database objects<sup>[1][1]</sup>. DDL commands include *CREATE*, *ALTER*, *RENAME*, *DROP*, and *TRUNCATE*.

> **DML**, or Data Manipulation Language, is used to manipulate data in the server <sup>[2][1]</sup>. DML commands include *INSERT*, *DELETE*, *UPDATE*, *LOCK*, and *MERGE*.

<sub>For more information, [click here][2].</sub>


# 1) DDL Commands

Now let's look at some DDL commands that we commonly use.

``` sql
-- Create a database user account --
CREATE LOGIN login_name
WITH PASSWORD = 'type_password_here';
GO  -- this is optional. If the above command doesn't work, the program won't stop and keep GOing --

-- Create user and add server role --
CREATE USER user_name FOR LOGIN login_name
GO
EXEC sp_addsrvrolemember 'login_name', 'role'
GO
```

When we successfully enter into the server, we don't want to use **sa**, or system administrator, user account. Thus, we will create a new account into the server using the above commands. The role can be `sysadmin`. 


### Create a new database
```sql
CREATE DATABASE database_name COLLATE THAI_CI_AS
GO
```
According to [this site][3], **collation** is a set of rules that tell database engine how to compare and sort the character data in SQL Server.

What we did above is creating a database and naming it whatever you put in the `database_name` part while also specifying some set of rules; in this case, THAI_CI_AS. 

### Delete an existing database
``` sql
DROP DATABASE database_name
GO

-- optional step --
-- checking to see if database_name exists --
IF EXISTS(SELECT * FROM sys.databases WHERE name='database_name')
DROP DATABASE database_name -- if it exists, drop it --
```

Sometimes, there's an error saying `cannot drop database "database_name" because it is currently in use.`. In order to solve this, we will switch to another database using the following command.
``` sql
USE master  -- every SQL server will have one --
```

# 2) DML Commands

After creating a database (or two), we can now create tables inside!

### Create a new table
``` sql
CREATE TABLE database_name.schema_name.table_name  -- usually we use dbo schema --
(
      column_name1 data_type(size),
      column_name2 data_type(size),
      ...
);

-- AN EXAMPLE --
CREATE TABLE test_db.dbo.Staff
(
      StaffId int,
      LastName varchar(255),
      FirstName varchar(255)
);
```
### Delete an existing table

``` sql
DROP TABLE database_name.schema_name.table_name 
-- or --
DROP TABLE table_name
```

### Insert a new record into a table

``` sql
INSERT INTO table_name
VALUES (value1, value2, value3);

--enter multiple records --
INSERT INTO table_name
VALUES (value1, value2, value3),
       (value1, value2, value3),
       (value1, value2, value3),
       ...
       (value1, value2, value3);
```

However, if your table has 4 values to insert, but you would like to insert only 3 values, there are 2 approaches to not cause an error. 

``` sql
-- 1) use null --
INSERT INTO table_name
VALUES(value1, value2, value3, null);

-- 2) specify which column you want to insert into --
INSERT INTO table_name(column1, column2, column3)
VALUES (value1, value2, value3);
```

### Update an existing record

``` sql
UPDATE table_name
SET column1=value1, column2=value2,...
WHERE condition;

-- for example --
-- updating all records in Staff --
UPDATE Staff
SET Address = 'Bangkok'
-- updating only StaffId = 124 --
UPDATE Staff
SET Address = 'Chiang Mai'
WHERE StaffId = 124;
```

### Delete an existing record

``` sql
DELETE FROM table_name
WHERE condition;    -- this is optional --
```


And that's all for this part, see you in the next part!

[1]: https://www.tutorialgateway.org/sql-dml-ddl-dcl-and-tcl-commands/
[2]: https://www.minigranth.com/sql-tutorial/types-of-sql-commands/
[3]: https://www.sqlshack.com/the-collate-sql-command-overview/