USE WideWorldImporters
GO

-- Let's create an empty copy of the OrderLines table
SELECT * INTO dbo.OrderLinesCopy FROM Sales.OrderLines WHERE 1 = 2;

-- Table is empty
SELECT * FROM dbo.OrderLinesCopy


-- A simple example of how to use the MERGE statement
MERGE INTO dbo.OrderLinesCopy AS tgt
USING Sales.OrderLines AS src
ON src.OrderLineID = tgt.OrderLineID
WHEN MATCHED  AND (src.Quantity < 20) THEN	-- We want to see only those who have less than 20 items
UPDATE
	SET tgt.TaxRate					= (src.TaxRate * 1.1) -- We're increasing the tax by 10 percent
	,	tgt.PickingCompletedWhen	= GETDATE()
	,	tgt.LastEditedBy			= 11
	,	tgt.LastEditedWhen			= GETDATE()
WHEN NOT MATCHED THEN
INSERT 
	VALUES
	(
	src.OrderLineID
,	src.OrderID
,	src.StockItemID
,	src.Description
,	src.PackageTypeID
,	src.Quantity
,	src.UnitPrice
,	src.TaxRate
,	src.PickedQuantity
,	src.PickingCompletedWhen
,	src.LastEditedBy
,	src.LastEditedWhen
	);

-- Compare OrderLine vs OrdeLinesCopy table
SELECT COUNT(*) AS TotalOrderLines FROM dbo.OrderLinesCopy;
SELECT COUNT(*) AS TotalOrderLines FROM Sales.OrderLines;

-- Execute again to only update those order that have less than 20 items
MERGE INTO dbo.OrderLinesCopy AS tgt
USING Sales.OrderLines AS src
ON src.OrderLineID = tgt.OrderLineID
WHEN MATCHED  AND (src.Quantity < 20) THEN
UPDATE
	SET tgt.TaxRate					= (src.TaxRate * 1.1) -- We're increasing the tax by 10 percent
	,	tgt.PickingCompletedWhen	= GETDATE()
	,	tgt.LastEditedBy			= 11
	,	tgt.LastEditedWhen			= GETDATE()
WHEN NOT MATCHED THEN
INSERT 
	VALUES
	(
	src.OrderLineID
,	src.OrderID
,	src.StockItemID
,	src.Description
,	src.PackageTypeID
,	src.Quantity
,	src.UnitPrice
,	src.TaxRate
,	src.PickedQuantity
,	src.PickingCompletedWhen
,	src.LastEditedBy
,	src.LastEditedWhen
	);

-- Check if was updated only the orders we wanted
SELECT 
	* 
FROM 
	dbo.OrderLinesCopy
WHERE 
	Quantity < 20;

-- Use the EXISTS predicate + EXCEPT operator
MERGE INTO dbo.OrderLinesCopy AS tgt
USING Sales.OrderLines AS src
ON src.OrderLineID = tgt.OrderLineID
WHEN MATCHED AND EXISTS
	(
		SELECT src.StockItemID, src.Description, src.Quantity, src.UnitPrice, src.TaxRate  
		EXCEPT
		SELECT tgt.StockItemID, tgt.Description, tgt.Quantity, tgt.UnitPrice, tgt.TaxRate
	) THEN
UPDATE
	SET tgt.TaxRate					= (src.TaxRate * 1.1)
	,	tgt.PickingCompletedWhen	= GETDATE()
	,	tgt.LastEditedBy			= 11
	,	tgt.LastEditedWhen			= GETDATE()
WHEN NOT MATCHED THEN
INSERT 
	VALUES
	(
	src.OrderLineID
,	src.OrderID
,	src.StockItemID
,	src.Description
,	src.PackageTypeID
,	src.Quantity
,	src.UnitPrice
,	src.TaxRate
,	src.PickedQuantity
,	src.PickingCompletedWhen
,	src.LastEditedBy
,	src.LastEditedWhen
	)
OUTPUT
	$action AS the_action,
	inserted.TaxRate, deleted.TaxRate AS old_TaxRate
,	inserted.PickingCompletedWhen, deleted.PickingCompletedWhen AS old_PickingCompletedWhen
,	inserted.LastEditedBy, deleted.LastEditedBy AS old_LastEditedBy
,	inserted.LastEditedWhen, deleted.LastEditedWhen AS old_LastEditedWhen;


-- Use the EXISTS predicate + EXCEPT operator, for all columns
MERGE INTO dbo.OrderLinesCopy AS tgt
USING Sales.OrderLines AS src
ON src.OrderLineID = tgt.OrderLineID
WHEN MATCHED AND EXISTS (SELECT src.* EXCEPT SELECT tgt.*) THEN
UPDATE
	SET tgt.TaxRate					= (src.TaxRate * 1.1)
	,	tgt.PickingCompletedWhen	= GETDATE()
	,	tgt.LastEditedBy			= 11
	,	tgt.LastEditedWhen			= GETDATE()
WHEN NOT MATCHED THEN
INSERT 
	VALUES
	(
	src.OrderLineID
,	src.OrderID
,	src.StockItemID
,	src.Description
,	src.PackageTypeID
,	src.Quantity
,	src.UnitPrice
,	src.TaxRate
,	src.PickedQuantity
,	src.PickingCompletedWhen
,	src.LastEditedBy
,	src.LastEditedWhen
	)
OUTPUT
	$action AS the_action,
	inserted.TaxRate, deleted.TaxRate AS old_TaxRate
,	inserted.PickingCompletedWhen, deleted.PickingCompletedWhen AS old_PickingCompletedWhen
,	inserted.LastEditedBy, deleted.LastEditedBy AS old_LastEditedBy
,	inserted.LastEditedWhen, deleted.LastEditedWhen AS old_LastEditedWhen;