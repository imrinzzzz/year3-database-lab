CREATE Database PremierProducts;
/*  DROP Database PremierProducts */

USE PremierProducts;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OrderLine' AND TABLE_SCHEMA = 'dbo')
    DROP TABLE dbo.OrderLine;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Part' AND TABLE_SCHEMA = 'dbo')
    DROP TABLE dbo.Part;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Orders' AND TABLE_SCHEMA = 'dbo')
    DROP TABLE dbo.Orders;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customer' AND TABLE_SCHEMA = 'dbo')
    DROP TABLE dbo.Customer;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Rep' AND TABLE_SCHEMA = 'dbo')
    DROP TABLE dbo.Rep;

CREATE TABLE Rep (
  RepNum	int			PRIMARY KEY
, LastName	nvarchar(100) 
, FirstName	nvarchar(50)
, Street	nvarchar(255)
, City		nvarchar(100)
, State		nvarchar(30)
, Zip		nvarchar(30)
, Commision money
, Rate		float
);

CREATE TABLE Customer (
	CustomerNum		int			PRIMARY KEY
,	CustomerName	nvarchar(255)
,	Street			nvarchar(255)
,	City			nvarchar(100)
,	State			nvarchar(30)
,	Zip				nvarchar(30)
,	Balance			money
,	CreditLine		money
,	RepNum			int
, FOREIGN KEY (RepNum)		REFERENCES Rep(RepNum)
);

CREATE TABLE Orders (
	OrderNum		int			PRIMARY KEY
,	OrderDate		Datetime2
,	CustomerNum		int
, FOREIGN KEY (CustomerNum)		REFERENCES Customer(CustomerNum)
);

CREATE TABLE Part (
	PartNum			nvarchar(10)			PRIMARY KEY
,	Description		nvarchar(255)
,	OnHand			int
,	Class			nvarchar(10)
,	Warehouse		smallint
,	Price			money
);

CREATE TABLE OrderLine (
	OrderNum		int
,	PartNum			nvarchar(10)	
,	NumOrdered		int
,	QuotedPrice		money
, FOREIGN KEY (OrderNum)		REFERENCES Orders(OrderNum)
, FOREIGN KEY (PartNum)			REFERENCES Part(PartNum)
);

CREATE TABLE CurrentOrders(
	CustomerName varchar(50),
	OrderNum int,
	PartNum nvarchar(10) ,
	Description nvarchar(255),
	NumOrdered int,
	QuotedPrice money,
	Wherehouse smallint,
	RepNum int, 
	FOREIGN KEY (RepNum)	REFERENCES Rep(RepNum),
	FOREIGN KEY (OrderNum)	REFERENCES Orders(OrderNum),
	FOREIGN KEY (PartNum)	REFERENCES Part(PartNum)
);

INSERT INTO Rep VALUES (20,'Kaiser','Valerie','624 Randall','Grove','FL' , 33321, 20542.50, 0.05);
INSERT INTO Rep VALUES (35,'Hull', 'Richard','532 Jackson','Sheldon','FL', 33553, 39216.00,	0.07);
INSERT INTO Rep VALUES (65,'Perez','Juan','1626 Taylor','Fillmore','FL'  , 33336, 23487.00,	0.05);

INSERT INTO Customer VALUES (148, 'Al''s Appliance and Sport', '2837 Greenway', 'Fillmore', 'FL', 33363, 6550.00, 7500.00, 20);
INSERT INTO Customer VALUES (282, 'Brookings Direct', '3827 Devon', 'Grove', 'FL', 33321, 431.50, 10000.00,	35);
INSERT INTO Customer VALUES (356, 'Ferguson''s',	'382 Wildwood',	'Northfield', 'FL',	33146,	5785.00,	7500.00,	65);
INSERT INTO Customer VALUES (408, 'The Everything Shop', '1828 Raven', 'Crystal', 'FL',	33503,	5285.25,	5000.00,	35);
INSERT INTO Customer VALUES (462, 'Bargains Galore', '3829 Central', 'Grove', 'FL',	33321,	3412.00,	10000.00,	65);
INSERT INTO Customer VALUES (524, 'Kline''s', '838 Ridgeland',	'Fillmore', 'FL',	33363,	12762.00,	15000.00,	20);
INSERT INTO Customer VALUES (608, 'Johnson''s Department Store', '372 Oxford', 'Sheldon', 'FL',	33553,	2106.00,	10000.00,	65);
INSERT INTO Customer VALUES (687, 'Lee''s Sport and Appliance', '282 Evergreen', 'Altonville', 'FL', 32543,	2851.00,	5000.00,	35);
INSERT INTO Customer VALUES (725, 'Deerfield''s Four Seasons', '282 Columbia','Sheldon','FL',	33553,	248.00,	7500.00,	35);
INSERT INTO Customer VALUES (842, 'All Season', '28 Lakeview', 'Grove', 'FL', 33321, 8221.00, 7500.00,	20);

INSERT INTO Orders VALUES (21608, '2010-10-20 00:00:00.000', 148);
INSERT INTO Orders VALUES (21610, '2010-10-20 00:00:00.000', 356);
INSERT INTO Orders VALUES (21613, '2010-10-21 00:00:00.000', 408);
INSERT INTO Orders VALUES (21614, '2010-10-21 00:00:00.000', 282);
INSERT INTO Orders VALUES (21617, '2010-10-23 00:00:00.000', 608);
INSERT INTO Orders VALUES (21619, '2010-10-23 00:00:00.000', 148);
INSERT INTO Orders VALUES (21623, '2010-10-23 00:00:00.000', 608);

INSERT INTO Part VALUES ('AT94',	'Iron',	50,	'HW',	3,	24.95);
INSERT INTO Part VALUES ('BV06','Home Gym',	45,	'SG',	2,	794.95);
INSERT INTO Part VALUES ('CD52','Microwave Oven', 32,'AP', 1, 165.00);
INSERT INTO Part VALUES ('DL71','Cordless Drill', 21,'HW', 3, 129.95);
INSERT INTO Part VALUES ('DR93','Gas Range',	8,	'AP', 2, 495.00);
INSERT INTO Part VALUES ('DW11','Washer',	12,	'AP',	3,	399.99);
INSERT INTO Part VALUES ('FD21','Stand Mixer',	22,	'HW', 3,	159.95);
INSERT INTO Part VALUES ('KL62','Dryer',	12,	'AP',	1,	349.95);
INSERT INTO Part VALUES ('KT03','Dishwasher',	8,	'AP',	3,	595.00);
INSERT INTO Part VALUES ('KV29','Treadmill',	9,	'SG',	2,	1390.00);

INSERT INTO OrderLine VALUES (21608,'AT94',	11,	21.95);
INSERT INTO OrderLine VALUES (21610,'DR93', 1, 495.00);
INSERT INTO OrderLine VALUES (21610,'DW11', 1, 399.99);
INSERT INTO OrderLine VALUES (21613,'KL62',	4, 329.95);
INSERT INTO OrderLine VALUES (21614,'KT03',	2, 595.00);
INSERT INTO OrderLine VALUES (21617,'BV06',	2, 794.95);
INSERT INTO OrderLine VALUES (21617,'CD52',	4, 150.00);
INSERT INTO OrderLine VALUES (21619,'DR93',	1, 495.00);
INSERT INTO OrderLine VALUES (21623,'KV29',	2, 1290.00);

INSERT INTO CurrentOrders VALUES ('Al''s Appliance and Sport',21608,'AT94','Iron',11,21.95,3,20);
INSERT INTO CurrentOrders VALUES ('Al''s Appliance and Sport',21619,'DR93','Gas Range',1,495.00,2,20);
INSERT INTO CurrentOrders VALUES ('Brookings Direct',21614,'KT03','Dishwasher',2,595.00,3,35);
INSERT INTO CurrentOrders VALUES ('Ferguson''s',21610,'DR93','Gas Range',1,495.00,2,65);
INSERT INTO CurrentOrders VALUES ('Ferguson''s',21610,'DW11','Washer',1,399.99,3,65);
INSERT INTO CurrentOrders VALUES ('Johnson''s Department Store',21617,'BV06','Home Gym',2,794.95,2,65);
INSERT INTO CurrentOrders VALUES ('Johnson''s Department Store',21617,'CD52','Microwave Oven',4,150.00,1,65);
INSERT INTO CurrentOrders VALUES ('Johnson''s Department Store',21623,'KV29','Treadmill',2,1290.00,2,65);
INSERT INTO CurrentOrders VALUES ('The Everything Shop',21613,'KL62','Dryer',4,329.95,1,35);
