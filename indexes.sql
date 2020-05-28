USE TestDB
GO

-- Orders table being queried on CustomerID
SELECT OrderID FROM Orders WHERE CustomerID = 'TOMSP'


-- Let's create an index on CustomerID
CREATE INDEX IX_Orders_CustomerID	-- Name of the index
ON dbo.Orders						-- Table where the index will be
(	
	CustomerID						-- Column to index
)
GO

-- Run again the same query against Orders table.
SELECT OrderID FROM dbo.Orders WHERE CustomerID = 'TOMSP'


-- Add Primary Key to an existing table.
ALTER TABLE dbo.Orders
ADD CONSTRAINT PK_Orders_OrderID PRIMARY KEY
(
	OrderID
)
GO


-- Run again the same query against Orders table.
SELECT OrderID FROM dbo.Orders WHERE CustomerID = 'TOMSP'
