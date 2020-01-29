-- Q1 Drop Database testDB --
DROP DATABASE testDB
-- Q2 Recreate Database testDB --
CREATE DATABASE testDB COLLATE THAI_CI_AS
-- Q3 Create ‘Students’ table with the following attributes StudentID (int), FirstName, LastName, NickName, Email, PhoneNumber, Sex, BirthDate (date) --
CREATE TABLE testDB.dbo.Students
(
	StudentID int,
	FirstName varchar(255),
	LastName varchar(255),
	Nickname varchar(255),
	Email varchar(255),
	PhoneNumber varchar(15), 
	Sex int,
	BirthDate date
);
-- Q4 Insert your information into ‘Students’ table --
INSERT INTO Students
VALUES (6088044,'Vipawan','Jarukitpipat','Ampere','vipawan.amp@gmail.com','0933061011',1,'1999-01-11')
-- Q5 Gather your friends information --
INSERT INTO Students (StudentID,FirstName,LastName,Nickname)
VALUES
(6088105,'Dujnapa','Tanundet','Fha'),
(6088111,'Klinton','Chunn','Klinton'),
(6088122,'Tanirin','Trironnarith','Rin')

INSERT INTO Students (StudentID,FirstName,LastName,Nickname)
VALUES (6088122,'Tanirin','Trironnarith','Rin')

-- Q6 Update your friends information to add their phone numbers --
UPDATE Students
SET PhoneNumber = '0912345678' WHERE StudentID = 6088105
UPDATE Students
SET PhoneNumber = '0963061011' WHERE StudentID = 6088122
UPDATE Students
SET PhoneNumber = '0945678945' WHERE StudentID = 6088111
-- Q7 Delete the last student in your Students table --
DELETE FROM Students
WHERE StudentID = 6088111

DELETE FROM Students
WHERE StudentID = (
SELECT TOP 1 StudentID
FROM Students
ORDER BY StudentID DESC)

