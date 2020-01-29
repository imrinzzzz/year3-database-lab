# database lab part 2

---
title: Basic DB Using SQL Server (Part 2) - modify columns and learn some constraints
published: false
description: 
tags: 
---

Hello! This post will cover 3 things:
1) Modifying columns in existing table (like adding new columns)
2) Creating primary key and foreign key
3) Creating and deleting constraints

# 1) Modifying columns in existing table

### Showing details of columns

``` sql
EXEC SP_COLUMNS table_name
```

This simple line of code is a command to have the details of the columns from the specified table be shown. The details of the columns are called *metadata*. 

### Add a new column

``` sql
ALTER TABLE table_name
ADD column_name datatype;

-- for example --
ALTER TABLE Staff
ADD DateOfBirth VARCHAR(10);
```

This command lets you add another column into the existing table. You can specify the name and the data type of the new column.

### Add a multiple column

``` sql
ALTER TABLE table_name
ADD col_name1 datatype1, col_name2 datatype2, ...;
```

Of course, if you can add one more column, you can add A TON MORE columns.

### Alter an existing column

``` sql
ALTER TABLE table_name
ALTER COLUMN column_name datatype;

-- for example --
ALTER TABLE Staff
ALTER COLUMN DateOfBirth DATE;
```

Assume that originally `DateOfBirth` was of another data type, so we decided to change to `DATE` data type instead. 

However, it is important to note that if the existing table has data in it, those data or values **cannot** be converted to the new data type. Sometimes, this cause an error when we *alter* the column. 

### Drop an existing column

``` sql 
ALTER TABLE table_name
DROP COLUMN column_name;
```

The result of this code is as simple as the code itself. Basically, it drops a `column_name` column from the `table_name` table.

### Drop multiple columns

``` sql
ALTER TABLE table_name
DROP COLUMN col_name1, col_name2, ...;
```

If you can drop *one* column, you can drop a looooot of them.

# 2) Creating primary and foreign key
<a name='primary-foreign-key'></a>

Before we proceed to the code, let's look at what actually are primary keys and foreign keys.

> **Primary key** is a special relational database table column (or combination of columns) designated to uniquely identify all table records<sup>[1]</sup>.  
> 
> Primary key contains a unique value for each row of data and cannot be `NULL` value.

> **Foreign key** is a column or group of columns in a relational database table that provides a link between data in two tables.<sup>[2]</sup>.

### Create primary key (during table creation)

``` sql
CREATE TABLE table_name
(
  col_name datatype NOT NULL PRIMARY KEY,
  col_name datatype,
  col_name datatype
  ...
)

-- or --
CREATE TABLE table_name
(
  col_name datatype NOT NULL,
  col_name datatype,
  col_name datatype,
  -- if you add more columns inside the brackets, 
  -- that means a primary key is made up of more than 1 columns
  CONSTRAINT constraint_name PRIMARY KEY (col_name)
  ...
)
```

The idea is pretty simple. When you are in the process of creating a new table (links to part 1), you add `PRIMARY KEY` behind one of the columns that you want as a primary key.

However, you can also make a constraint and name it, then specify which column(s) you want as your primary key. You can add more than 1 columns. This means a primary key is made up of more than 1 columns.

Once you have set the primary key, the value of that column **cannot** be *duplicated* nor can it be left as *null*.

### Create primary key (with an existing table)

``` sql
ALTER TABLE table_name
ADD PRIMARY KEY (column_name)

-- or --
ALTER TABLE table_name
-- if you add more columns inside the brackets, 
-- that means a primary key is made up of more than 1 columns
ADD CONSTRAINT constraint_name PRIMARY KEY (col_name)
```

With this, we can specify which column we want to set as a primary key. However, that column must be declared **not NULL** values or else an error may occur. To fix the NULL issue, you can type the code below.

``` sql
ALTER TABLE table_name
ALTER COLUMN col_name datatype NOT NULL;
```

Just alter the (existing) column to be `NOT NULL`. And of course, there should be no duplicate value in the primary key column.

### Create foreign key (during table creation)

``` sql
CREATE TABLE table_name
(
  col_name datatype NOT NULL PRIMARY KEY,
  col_name datatype,
  col_name datatype FOREIGN KEY REFERENCES table2_name(table2_primary_key),
  ...
);

-- for example --
CREATE TABLE NewStaff
(
  StaffId int NOT NULL PRIMARY KEY,
  LastName varchar(50),
  FirstName varchar(50),
  StaffDeptId int FOREIGN KEY REFERNECES Department(DeptID)
);
```

We add a foreign key and specify which primary key will we be referencing on and from which table in the code above. 

``` sql
-- another method of creating a foreing key --
CREATE TABLE table_name
(
  col_name1 datatype NOT NULL,
  col_name2 datatype,
  PRIMARY KEY (col_name1),
  CONSTRAINT constraint_name FOREIGN KEY (col_name2)
  REFERENCES table2_name (table2_primary_key)
);
```

### Create foreign key (with an existing table)

``` sql
ALTER TABLE table_name
ADD FOREIGN KEY (col_name)
REFERENCES table_name_we_referenced_from(col_name_with_PK)

-- for example --
ALTER TABLE Staff
ADD FOREIGN KEY (StaffDeptID)
REFERENCES Department(DeptID)
```

In the above code, we add a foreign key to an existing column in the selected table, `table_name` or `Staff`. We referenced from `table_name_we_referenced_from` or `Department` table and `col_name_with_PK` or `DeptID` column. 

``` sql
-- another method of adding a foreing key --
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
FOREIGN KEY (col_name) REFERENCES table2_name (table2_primary_key);
```

### Updating values of foreign key

Note that we cannot change the value to some other values that were **not** in the referenced primary key column. For example, we have these 2 tables.

![clipboard.png](zqNYPACG-clipboard.png)

``` sql
-- we can do this --
UPDATE Staff
SET StaffDeptID = 1
WHERE StaffID = 126

-- but we cannot do this --
UPDATE Staff
SET StaffDeptID = 3
WHERE StaffID = 127
```

..simply because `StaffDeptID` is a foreign key referenced to `DeptID` from `Department` table and in `Department` table, there is a value of 1 but not 3. 

#### Additional Options for Foreign Key

When we update the value of a primary key, but we have a foreign key that referenced to the updated primary key. That foreign key might not get updated if we don't include the option(s) below.

``` sql
ON DELETE {NO ACTION | CASCADE | SET NULL | SET DEFAULT}
ON UPDATE {NO ACTION | CASCADE | SET NULL | SET DEFAULT}
```

Usually, if we don't specify what happens `ON DELETE` or `ON UPDATE`, the default value is `NO ACTION`. But we can specify which action should happen if there was an update to the referenced primary key. Here's what each action means. 

(We will call the data from the referenced primary key as  **parent data** and the data of the foreign key which references to the parent data as **child data**.)

* **NO ACTION** - basically means no action will be performed on the child data when parent data is updated or deleted.
* **CASCADE** - the child data is deleted when the parent data is deleted and the child data is updated when the parent data is updated.
* **SET NULL** - the child data is set to `NULL` when the parent data is updated or deleted. 
* **SET DEFAULT** - the child data is set to the default value (that we have to specify) when the parent data is updated or deleted. 

Let's take a look at some examples..
``` sql
-- ex1. CASCADE --
ALTER TABLE child_table
ADD CONSTRAINT constraint_name FOREIGN KEY (col_name)
REFERENCES parent_table (primary_key_col)
ON DELETE CASCADE
ON UPDATE CASCADE
```
<a name='default'></a>
``` sql
-- ex2. SET NULL / DEFAULT --
ALTER TABLE child_table 
ADD CONSTRAINT constraint_name FOREIGN KEY (col_name)
REFERENCES parent_table (primary_key_col)
ON UPDATE SET DEFAULT
ON DELETE SET NULL;

-- set default value
ALTER TABLE child_table
ADD CONSTRAINT constraint_name2 DEFAULT 0 FOR col_name;
```

# 3) Creating and Deleting constraints

Before we head over to the "creating and deleting constraints" part, we will first understand what constraints mean.

> Constraints are **rules** for the data in a table. If there is a violation of any constraints, the action is terminated. (e.g. Insert a null value into the table, but the constraint specifies 'no null value allowed'. The insert action will be terminated.)
> 
> Constraints can be specified when **creating a table** or **modifying a table**. 

The commonly used **constraints** are as follows:
* NOT NULL
* UNIQUE
* PRIMARY KEY
* FOREIGN KEY
* CHECK
* DEFAULT
* INDEX

<sub>For more information, [click here][3].</sub>

### NOT NULL

The `NOT NULL` constraint enforces a column to **NOT** accept NULL values. You cannot insert a new record or update a record without adding a value to the column.

``` sql
-- when creating table --
CREATE TABLE Table_name
(
  col_name datatype NOT NULL,
  col_name datatype NOT NULL,
  col_name datatype,
  ...
);
```
``` sql
-- using alter table --
ALTER TABLE table_name
ALTER COLUMN col_name datatype NOT NULL
```

### UNIQUE

The `UNIQUE` constraint ensures that the values in the unique column are different. A `PRIMARY KEY` constraint automatically has a `UNIQUE` constraint. The difference is that you can add only one `PRIMARY KEY` constraint while you can add as many `UNIQUE` constraints as you want. 

When adding a constraint, it is fine to not add the `constraint_name`, however, when dropping a constraint, a `constraint_name` is required.

``` sql
-- when creating table --
CREATE TABLE Table_name
(
  col_name datatype NOT NULL UNIQUE,
  col_name datatype UNIQUE,
  col_name datatype,
  ...
);

CREATE TABLE Table_name
(
  col_name datatype,
  col_name datatype,
  col_name datatype,
  -- can add more than 1 column inside the brackets)
  CONSTRAINT constraint_name UNIQUE (col_name)
);
```
``` sql
-- using alter table --
ALTER TABLE table_name
ADD UNIQUE(col_name)

ALTER TABLE table_name
 -- can add more than 1 column inside the brackets)
ADD CONSTRAINT constraint_name UNIQUE (col_name)
```

``` sql
-- drop a UNIQUE constraint --
ALTER TABLE table_name
DROP CONSTRAINT unique_constraint_name;
```

### PRIMARY KEY and FOREIGN KEY

You can check the [second topic](#primary-foreign-key) to find out more about what are `PRIMARY KEY` or `FOREIGN KEY` and how to create them.

``` sql
-- drop a PRIMARY KEY and FOREIGN KEY --
ALTER TABLE table_name
DROP CONSTRAINT primary_key_constraint_name;

ALTER TABLE table_name
DROP CONSTRAINT foreign_key_constraint_name;
```

### CHECK

The `CHECK` constraint is used to limit the value range in a column. For example, you only allow filling in an age that is greater than or equal to 18 (like the example below). If a value lower than 18 is filled in, the action will not get executed. 

``` sql
-- when creating table --
CREATE TABLE table_name
(
  col_name datatype,
  col_name datatype CHECK (condition)
);

-- or 
CREATE TABLE table_name
(
  col_name datatype,
  col_name datatype,
  -- defining CHECK constraint on multiple columns
  CONSTRAINT constraint_name CHECK (condition1 AND condition2)
);

-- example --
CREATE TABLE Persons
(
  ID int,
  Name varchar(255),
  Age int CHECK (Age >= 18)
);
```
``` sql
-- using alter table --
ALTER TABLE table_name
ADD CHECK (condition);

-- or
ALTER TABLE table_name
ADD CONSTRAINT constraint_name CHECK (condition1 AND condition2);
```

```sql
-- drop a CHECK constraint --
ALTER TABLE table_name
DROP CONSTRAINT check_constraint_name;
```

### DEFAULT

The `DEFAULT` constraint is used to provide a *default* value for a column if no value is specified; usually it is `NULL`. You can check out a way to create a `DEFAULT` constraint [here](#default). Another way is as follows.
``` sql
-- when creating table --
CREATE TABLE table_name
(
  col_name datatype,
  col_name datatype,
  col_name datatype DEFAULT value
);

-- example --
CREATE TABLE Persons
(
  ID int NOT NULL,
  Name varchar(255),
  City varchar(100) DEFAULT 'Bangkok'
);
```

``` sql
-- using alter table --
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
DEFAULT value FOR col_name;

-- example --
ALTER TABLE Persons
ADD CONSTRAINT df_city
DEFAULT 'Bangkok' FOR City
```

``` sql
-- drop a DEFAULT constraint --
ALTER TABLE table_name
ALTER COLUMN col_name DROP DEFAULT;
```

### INDEX

Indexes are used to retrieve data from the database more quickly. They are only used to speed up searches/queries and not seen by the users.

``` sql
-- when creating table --
CREATE INDEX index_name
ON table_name (column1, column2, ...);

-- or create a UNIQUE INDEX --
CREATE UNIQUE INDEX index_name
ON table_name (column1, column2, ...);
```
``` sql
-- drop INDEX --
DROP INDEX table_name.index_name;
```

And that's all for part 2! See you in the next part!

[1]: https://www.techopedia.com/definition/5547/primary-key
[2]: https://www.techopedia.com/definition/7272/foreign-key
[3]: https://www.w3schools.com/sql/sql_constraints.asp