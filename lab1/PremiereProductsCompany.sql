-- Create Database Premiere Products Company
CREATE DATABASE PremiereProductsCompany COLLATE THAI_CI_AS
-- Create Rep Table --
CREATE TABLE PremiereProductsCompany.dbo.Rep
(
	RepNum int NOT NULL PRIMARY KEY,
	LastName varchar(255),
	FirstName varchar(255),
	Street varchar(255),
	City varchar(255),
	State varchar(255),
	Zip int,
	Commission float,
	Rate float,
);
-- Create Customer Table --
CREATE TABLE PremiereProductsCompany.dbo.Customer
(
	CustomerNum int NOT NULL PRIMARY KEY,
	CustomerName varchar(255),
	Street varchar(255),
	City varchar(255),
	State varchar(255),
	Zip int,
	Balance float,
	CreditLimit float,
	RepNum int FOREIGN KEY REFERENCES Rep(RepNum)
);

-- Create Orders Table --
CREATE TABLE PremiereProductsCompany.dbo.Orders
(
	OrderNum CHAR(5) PRIMARY KEY,
	OrderDate DATE,
	CustomerNum int FOREIGN KEY REFERENCES Customer(CustomerNum)

);
-- Create Part Table --
CREATE TABLE PremiereProductsCompany.dbo.Part
(
	PartNum CHAR(4) PRIMARY KEY,
	Description CHAR(15),
	OnHand DECIMAL(4,0),
	Class CHAR(2),
	Warehouse CHAR(1),
	Price DECIMAL(6,2)
);
-- Create OrderLine Table --
CREATE TABLE PremiereProductsCompany.dbo.OrderLine
(
	OrderNum CHAR(5),
	PartNum CHAR(4) FOREIGN KEY REFERENCES Part(PartNum),
	NumOrdered DECIMAL(3,0),
	QuotedPrice DECIMAL(6,2),
	--PRIMARY KEY (OrderNum, PartNum)--
);

ALTER TABLE OrderLine
ADD FOREIGN KEY (OrderNum)
REFERENCES Orders(OrderNum)

EXEC sp_columns OrderLine

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'OrderLine';

CREATE TABLE PremiereProductsCompany.dbo.CurrentOrders
(
	CustomerName CHAR(255),
	OrderNum CHAR(5) FOREIGN KEY REFERENCES Orders(OrderNum),
	PartNum CHAR(4) FOREIGN KEY REFERENCES Part(PartNum),
	Description CHAR(255),
	NumOrdered CHAR(5),
	QuotedPrice float,
	Warehouse CHAR(255),
	RepNum int FOREIGN KEY REFERENCES Rep(RepNum)
);
-- Add data to rep --
INSERT INTO Rep
VALUES
('20','Kaiser','Valerie','624 Randall','Grove','FL','33321',20542.50,0.05),
('35','Hull','Richard','532 Jackson','Sheldon','FL','33553',39216.00,0.07),
('65','Perez','Juan','1626 Taylor','Fillmore','FL','33336',23487.00,0.05);

-- Add data to customer --
INSERT INTO Customer
VALUES
('148','Al''s Appliance and Sport','2837 Greenway','Fillmore','FL','33336',6550.00,7500.00,'20'),
('282','Brookings Direct','3827 Devon','Grove','FL','33321',431.50,10000.00,'35'),
('356','Ferguson''s','382 Wildwood','Northfield','FL','33146',5785.00,7500.00,'65'),
('408','The Everything Shop','1828 Raven','Crystal','FL','33503',5285.25,5000.00,'35'),
('462','Bargains Galore','3829 Central','Grove','FL','33321',3412.00,10000.00,'65'),
('524','Kline''s','838 Ridgeland','Fillmore','FL','33336',12762.00,15000.00,'20'),
('608','Johnson''s Department Store','372 Oxford','Sheldon','FL','33553',2106.00,10000.00,'65'),
('687','Lee''s Sport and Appliance','282 Evergreen','Altonville','FL','32543',2851.00,5000.00,'35'),
('725','Deerfield''s Four Seasons','282 Columbia','Sheldon','FL','33553',248.00,7500.00,'35'),
('842','All Season','28 Lakeview','Grove','FL','33321',8221.00,7500.00,'20');
-- Add data to  

SELECT * from Rep
SELECT * from Customer

INSERT INTO Orders
VALUES
('21608','20-OCT-2013','148');
INSERT INTO Orders
VALUES
('21610','20-OCT-2013','356');
INSERT INTO Orders
VALUES
('21613','21-OCT-2013','408');
INSERT INTO Orders
VALUES
('21614','21-OCT-2013','282');
INSERT INTO Orders
VALUES
('21617','23-OCT-2013','608');
INSERT INTO Orders
VALUES
('21619','23-OCT-2013','148');
INSERT INTO Orders
VALUES
('21623','23-OCT-2013','608');
INSERT INTO Part
VALUES
('AT94','Iron',50,'HW','3',24.95);
INSERT INTO Part
VALUES
('BV06','Home Gym',45,'SG','2',794.95);
INSERT INTO Part
VALUES
('CD52','Microwave Oven',32,'AP','1',165.00);
INSERT INTO Part
VALUES
('DL71','Cordless Drill',21,'HW','3',129.95);
INSERT INTO Part
VALUES
('DR93','Gas Range',8,'AP','2',495.00);
INSERT INTO Part
VALUES
('DW11','Washer',12,'AP','3',399.99);
INSERT INTO Part
VALUES
('FD21','Stand Mixer',22,'HW','3',159.95);
INSERT INTO Part
VALUES
('KL62','Dryer',12,'AP','1',349.95);
INSERT INTO Part
VALUES
('KT03','Dishwasher',8,'AP','3',595.00);
INSERT INTO Part
VALUES
('KV29','Treadmill',9,'SG','2',1390.00);
INSERT INTO OrderLine
VALUES
('21608','AT94',11,21.95);
INSERT INTO OrderLine
VALUES
('21610','DR93',1,495.00);
INSERT INTO OrderLine
VALUES
('21610','DW11',1,399.99);
INSERT INTO OrderLine
VALUES
('21613','KL62',4,329.95);
INSERT INTO OrderLine
VALUES
('21614','KT03',2,595.00);
INSERT INTO OrderLine
VALUES
('21617','BV06',2,794.95);
INSERT INTO OrderLine
VALUES
('21617','CD52',4,150.00);
INSERT INTO OrderLine
VALUES
('21619','DR93',1,495.00);
INSERT INTO OrderLine
VALUES
('21623','KV29',2,1290.00);

SELECT * from Part

SELECT * from OrderLine