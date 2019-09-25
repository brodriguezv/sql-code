USE TestDB
GO

-- First, let's create an empty table with the structure we want.
CREATE TABLE #OrdersCustomerID
(
	OrderID			INT
,	CustomerID		NCHAR(10)
,	OrderDate		DATETIME
,	ShipName		NVARCHAR(80)
,	ShipAddress		NVARCHAR(120)
,	ShipCity		NVARCHAR(30)
,	ShipCountry		NVARCHAR(30)
,	ShipPostalCode	NVARCHAR(20)
)

-- Create a table for storing our inserted records.
CREATE TABLE TableForAuditingPurposes
(
	OrderID			INT
,	CustomerID		NCHAR(10)
,	OrderDate		DATETIME
,	ShipName		NVARCHAR(80)
,	ShipAddress		NVARCHAR(120)
,	ShipCity		NVARCHAR(30)
,	ShipCountry		NVARCHAR(30)
,	ShipPostalCode	NVARCHAR(20)
)



-- Using the OUTPUT clause to return information to the user.
INSERT INTO #OrdersCustomerID(OrderID, CustomerID, OrderDate, ShipName, ShipAddress, ShipCity, ShipCountry, ShipPostalCode)
OUTPUT
	INSERTED.OrderID, INSERTED.OrderDate, INSERTED.ShipName, INSERTED.ShipAddress, INSERTED.ShipCity, INSERTED.ShipCountry, INSERTED.ShipPostalCode
SELECT 
	OrderID
,	CustomerID
,	OrderDate
,	ShipName
,	ShipAddress
,	ShipCity
,	ShipCountry
,	ShipPostalCode	
FROM 
	dbo.Orders
WHERE
	CustomerID = 'GROSR'


-- Using the OUTPUT clause and insert into a table.
INSERT INTO #OrdersCustomerID(OrderID, CustomerID, OrderDate, ShipName, ShipAddress, ShipCity, ShipCountry, ShipPostalCode)
OUTPUT
	INSERTED.OrderID, INSERTED.CustomerID, INSERTED.OrderDate, INSERTED.ShipName, INSERTED.ShipAddress, INSERTED.ShipCity, INSERTED.ShipCountry, INSERTED.ShipPostalCode
INTO
	TableForAuditingPurposes(OrderID, CustomerID, OrderDate, ShipName, ShipAddress, ShipCity, ShipCountry, ShipPostalCode)
SELECT 
	OrderID
,	CustomerID
,	OrderDate
,	ShipName
,	ShipAddress
,	ShipCity
,	ShipCountry
,	ShipPostalCode	
FROM 
	dbo.Orders
WHERE
	CustomerID = 'GROSR'



-- OUTPUT with DELETE statement, and inserting into a table
DELETE dbo.Orders
OUTPUT
	DELETED.OrderID, DELETED.CustomerID, DELETED.OrderDate, DELETED.ShipName, DELETED.ShipAddress, DELETED.ShipCity, DELETED.ShipCountry, DELETED.ShipPostalCode
INTO
	TableForAuditingPurposes(OrderID, CustomerID, OrderDate, ShipName, ShipAddress, ShipCity, ShipCountry, ShipPostalCode)
WHERE
	CustomerID = 'SAVEA'


-- Rows for CustomerID: SAVEA were inserted into the auditing table
SELECT 
	OrderID, CustomerID, OrderDate, ShipName, ShipAddress, ShipCity, ShipCountry, ShipPostalCode
FROM 
	TableForAuditingPurposes 
WHERE 
	CustomerID = 'SAVEA'

-- And removed from the Orders table
SELECT 
	OrderID, CustomerID, OrderDate, ShipName, ShipAddress, ShipCity, ShipCountry, ShipPostalCode 
FROM 
	dbo.Orders
WHERE 
	CustomerID = 'SAVEA'


-- Using OUTPUT clause with UPDATE statement
UPDATE dbo.Orders
SET
	ShippedDate = GETDATE()
OUTPUT
	INSERTED.OrderID
,	DELETED.ShippedDate AS Old_ShippedDate
,	INSERTED.ShippedDate AS New_ShippedDate
WHERE
	CustomerID = 'HUNGC'


-- Create a table for storing our updated records.
-- Let's say that we only are going to change the ShipDate of the Order we are going to audit.
CREATE TABLE AuditTableForUpdates
(
	OrderID			INT
,	CustomerID		NCHAR(10)
,	OrderDate		DATETIME
,	ShippedDate_Old	DATETIME
,	ShippedDate_New DATETIME
,	BatchDate		DATETIME
)


--DECLARE @batch_date DATETIME = GETDATE()

UPDATE dbo.Orders
SET
	ShippedDate = GETDATE()
OUTPUT
	inserted.OrderID
,	inserted.CustomerID
,	inserted.OrderDate
,	deleted.ShippedDate as ShippedDate_Old
,	inserted.ShippedDate as ShippedDate_New
,	@batch_date
INTO
	AuditTableForUpdates(OrderID, CustomerID, OrderDate, ShippedDate_Old, ShippedDate_New, BatchDate)
WHERE
	CustomerID = 'SIMOB'


-- Verify that we inserted the records we just updated.
SELECT 
	OrderID, CustomerID, OrderDate, ShippedDate_Old, ShippedDate_New, BatchDate
FROM
	AuditTableForUpdates
WHERE
	CustomerID = 'SIMOB'


-- Verify the records were updated in the original table.
SELECT 
	OrderID, CustomerID, ShippedDate
FROM
	dbo.Orders
WHERE
	CustomerID = 'SIMOB'


-- Returning the values of the OrderIDs for this Customer to their original values.
DECLARE @batch_date DATETIME = '2019-09-24 22:59:08.280'

UPDATE O
SET
	O.ShippedDate = A.ShippedDate_Old
OUTPUT
	inserted.OrderID
,	deleted.ShippedDate AS ShippedDate_Old
,	inserted.ShippedDate AS ShippedDate_New
FROM 
	dbo.Orders AS O
	INNER JOIN dbo.AuditTableForUpdates as A
		ON A.OrderID = O.OrderID
WHERE
	A.BatchDate = @batch_date
AND A.CustomerID = 'SIMOB'
