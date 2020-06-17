USE TestDB
GO

-- Let's create a test table
CREATE TABLE dbo.ItemsFirstValue
(
	ID		INT IDENTITY(1,1) PRIMARY KEY
,	ItemID	VARCHAR(40)
,	Value1	INT NULL
,	Value2	INT NULL
)

-- And insert some data
INSERT INTO dbo.ItemsFirstValue
SELECT	'Item1',	12,	78		UNION ALL
SELECT	'Item1',	12,	NULL	UNION ALL
SELECT	'Item1',	12,	NULL	UNION ALL
SELECT	'Item2',	44,	46		UNION ALL
SELECT	'Item2',	44,	NULL	UNION ALL
SELECT	'Item2',	44,	NULL	UNION ALL
SELECT	'Item2',	44,	NULL	UNION ALL
SELECT	'Item2',	44,	NULL	UNION ALL
SELECT	'Item3',	53,	90		UNION ALL
SELECT	'Item3',	53,	NULL	UNION ALL
SELECT	'Item4',	75,	36		UNION ALL
SELECT	'Item4',	75,	NULL	UNION ALL
SELECT	'Item4',	75,	NULL	


-- Getting the first value of the partition
SELECT
	ID, ItemID, Value1, value2
,	FIRST_VALUE(Value2) OVER(PARTITION BY ItemID ORDER BY ID ASC) AS FirstVal
FROM
	dbo.ItemsFirstValue;



USE  AdventureWorks
GO

-- Wrong Last Value
SELECT 
	CustomerID
,	SalesOrderID
,	TotalDue
,	LAST_VALUE(TotalDue) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID) AS AmountLastValue
FROM
	Sales.SalesOrderHeader
ORDER BY
	CustomerID, SalesOrderID;


-- Correct Last Value
SELECT 
	CustomerID
,	SalesOrderID
,	TotalDue
,	LAST_VALUE(TotalDue) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID
									ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS AmountLastValue
FROM
	Sales.SalesOrderHeader
ORDER BY
	CustomerID, SalesOrderID;