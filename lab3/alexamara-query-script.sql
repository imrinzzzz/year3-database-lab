-- 1) List the owner number, last name, and first name of every boat owner --
SELECT OwnerNum, LastName, FirstName FROM Owner

-- 2) List the complete Marina table (all rows and all columns) --
SELECT * FROM Marina

-- 3) List the last name and first name of every owner located in Bowton
SELECT LastName, FirstName FROM Owner WHERE City='Bowton'

-- 4) List the last name and first name of every owner not located in Bowton
SELECT LastName, FirstName FROM Owner WHERE NOT City='Bowton'
SELECT LastName, FirstName FROM Owner WHERE City!='Bowton'
SELECT LastName, FirstName FROM Owner WHERE City<>'Bowton'

-- 5) List marina number and (Boat) slip number for every slip whose length is equal to or less than 30 feet --
SELECT MarinaNum, SlipNum FROM MarinaSlip WHERE Length<=30

-- 6) List marina number and (Boat) slip number for every boat with the type Dolphin 28
SELECT MarinaNum, SlipNum FROM MarinaSlip WHERE BoatType='Dolphin 28'

-- 7) list the (Boat) slip number for every boat with the Boat type Dolphin 28 that is located in marina 1 --
SELECT SlipNum FROM MarinaSlip WHERE BoatType='Dolphin 28' AND MarinaNum=1

-- 8) List the boat number for each boat located in a (Boat) slip whose length is between 25 and 30 feet --
SELECT SlipNum FROM MarinaSlip WHERE Length>=25 AND Length<=30

--9 List the (Boat) slip number for every (Boat) slip in marina 1 whose annual rental fee is less than $3000 --
SELECT SlipNum FROM MarinaSlip WHERE MarinaNum = 1 AND RentalFee < 3000

-- 10) List the slip ID, category number, estimated hours, and estimated labor cost for every service request. --
SELECT SlipID, CategoryNum, EstHours, EstHours*60 AS EstimatedCost FROM ServiceRequest 

-- 11) List the marina number and (Boat) slip number for all slips containing a boat with the type Sprite 4000, Sprite 3000, or Ray 4025 --
SELECT MarinaNum, SlipNum FROM MarinaSlip WHERE BoatType = 'Sprite 4000' OR BoatType = 'Sprite 3000' OR BoatType = 'Ray 4025'

-- 12) List the marina number, (Boat) Slip number and boat name for all boats. Sort the results by boat name within marina number --
SELECT MarinaNum, SlipNum, BoatName FROM MarinaSlip ORDER BY MarinaNum, BoatName ASC

-- 13) how many Dolphin 25 boats are stored at both marinas --
SELECT COUNT(SlipID) AS Dolphin25Count FROM MarinaSlip WHERE BoatType='Dolphin 25' AND MarinaNum=1 AND MarinaNum=2

-- 14) Calculate the total rental fees Alexamara receives each year based on the length of the slip --
SELECT SUM(RentalFee) AS TotalRentalFees, Length FROM MarinaSlip GROUP BY Length

-- 15) For every boat, list the marina number, (Boat) slip number, boat name, owner number, owner's first name, and owner's last name --
SELECT M.MarinaNum, M.SlipNum, M.BoatName, O.OwnerNum, O.FirstName, O.LastName FROM MarinaSlip M JOIN Owner O ON M.OwnerNum = O.OwnerNum

-- 16) For every completed or open service request for routine engine maintenance, list the (Boat) slip ID, description, and status --
SELECT R.SlipID, R.Description, R.Status FROM ServiceRequest R JOIN ServiceCategory C ON R.CategoryNum = C.CategoryNum WHERE C.CategoryDescription = 'Routine engine maintenance'

-- 17) For every service request for routine engine maintenace, list the (Boat) slip ID, marina number, slip number, estimated hours, spent hours, owner number, and owner's last name --
SELECT R.SlipID, M.MarinaNum, M.SlipNum, R.EstHours, R.SpentHours, O.OwnerNum, O.LastName
FROM ServiceRequest R JOIN ServiceCategory C ON R.CategoryNum = C.CategoryNum JOIN MarinaSlip M ON R.SlipID = M.SlipID JOIN Owner O ON O.OwnerNum = M.OwnerNum
WHERE C.CategoryDescription = 'Routine engine maintenance'