USE Northwind
GO

-- Count all rows, and ignore nulls
SELECT
	COUNT(*) AS CountAllRows
,	COUNT(ShipRegion) AS CountWithoutNulls
FROM
	Orders;



-- Using SUM
SELECT
	SUM(UnitPrice) AS SumTotalUnitPrice
FROM
	Products;



-- Using AVG
SELECT
	AVG(UnitPrice) AS AverageUnitPrice
FROM
	Products;


--Using MIN and MAX
SELECT
	MIN(UnitPrice)	AS	CheapestProduct
,	MAX(UnitPrice)	AS	MostExpensiveProduct
FROM
	Products;



--Using GROUP BY clause
SELECT
	CategoryID
,	COUNT(*) AS CountOfProducts
FROM
	Products
GROUP BY
	CategoryID;

-- More group by examples.
SELECT
	ShipCountry
,	ShipCity
,	COUNT(*) AS CountOfShipments
FROM
	Orders
GROUP BY
	ShipCountry, ShipCity
ORDER BY
	COUNT(*) DESC;



SELECT
	ShipCountry
,	ShipCity
,	COUNT(*) AS CountOfShipments
FROM
	Orders
GROUP BY
	ShipCountry, ShipCity
ORDER BY
	ShipCountry, COUNT(*) DESC;


-- Filtering groups - error message
SELECT
	ShipCountry
,	ShipCity
,	COUNT(*) AS CountOfShipments
FROM
	Orders
WHERE
	COUNT(*) >= 20
GROUP BY
	ShipCountry, ShipCity;


-- Filtering groups with HAVING
SELECT
	ShipCountry
,	ShipCity
,	COUNT(*) AS CountOfShipments
FROM
	Orders
GROUP BY
	ShipCountry, ShipCity
HAVING
	COUNT(*) >= 20;