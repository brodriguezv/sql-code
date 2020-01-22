USE TestDB
GO
-- Window aggregates 2005 version
-- No PARTITION BY, ORDER BY
SELECT
	CustomerID
,	OrderID
,	MIN(OrderDate) OVER() FirstOrder
,	MAX(OrderDate) OVER() LastOrder
,	COUNT(*) OVER() OrderCount
,	SUM(Freight) OVER() TotalFreightAmount
FROM
	Orders
ORDER BY 
	CustomerID, OrderID

-- With PARTITION BY clause
SELECT
	CustomerID
,	OrderID
,	MIN(OrderDate) OVER(PARTITION BY CustomerID) FirstOrder
,	MAX(OrderDate) OVER(PARTITION BY CustomerID) LastOrder
,	COUNT(*) OVER(PARTITION BY CustomerID) OrderCount
,	SUM(Freight) OVER(PARTITION BY CustomerID) TotalFreightAmount
FROM
	Orders
ORDER BY 
	CustomerID, OrderID


-- Accumulating aggregates. From SQL Server 2012 onwards
SELECT
	CustomerID
,	OrderID
,	OrderDate
,	Freight
,	SUM(Freight) OVER(PARTITION BY CustomerID ORDER BY OrderID) RunningTotal
FROM
	dbo.Orders

-- Adding a frame to the window.
SELECT
	YEAR(OrderDate) AS OrderYear
,	MONTH(OrderDate) AS OrderMonth
,	COUNT(*) AS OrderCount
,	AVG(COUNT(*)) OVER(ORDER BY YEAR(OrderDate), MONTH(OrderDate)
						ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) ThreeMonthAverage
FROM
	dbo.Orders
GROUP BY
	YEAR(OrderDate) 
,	MONTH(OrderDate)









