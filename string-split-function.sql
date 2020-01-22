USE TestDB
GO

-- Basic usage of STRING_SPLIT()
DECLARE @OrderNumbers VARCHAR(40) = '1278, 1894, 2328, 2235, 5639, 8905'

SELECT * FROM STRING_SPLIT(@OrderNumbers, ',')


USE WideWorldImporters
GO

CREATE PROCEDURE dbo.uspGetOrderDetail
(
	@OrderID	VARCHAR(500)
)
AS
	SELECT 
		O.OrderID
	,	O.CustomerID
	,	OL.Description
	,	OL.Quantity
	FROM Sales.Orders AS O
	INNER JOIN Sales.OrderLines AS OL
	ON O.OrderID = OL.OrderID
	INNER JOIN STRING_SPLIT(@OrderID, ',') AS V
	ON O.OrderID = CAST(V.value AS INT)
	ORDER BY
		O.OrderID



EXECUTE uspGetOrderDetail @OrderID = '71685, 4570, 55501, 22339'