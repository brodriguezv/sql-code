USE TestDB
GO

-- The query somebody asked me for help
SELECT 'class_requests', COUNT(*) FROM dbo.ClassRequests WHERE requested_by_user_id = 1
UNION
SELECT 'class_requests (approved)', COUNT(*) FROM dbo.ClassRequests WHERE requested_by_user_id = 1 AND STATUS = 'APPROVED'
UNION
SELECT 'class_requests (not approved)', COUNT(*) FROM dbo.ClassRequests WHERE requested_by_user_id = 1 AND STATUS = 'NOT_APPROVED';



-- Using CROSS APPLY with a table constructor
SELECT
	A.Status, SUM(A.Value)
FROM
	dbo.ClassRequests AS R
	CROSS APPLY(VALUES	('class_requests', 1),
						('class_requests (approved)', CASE WHEN R.Status = 'APPROVED' THEN 1 ELSE 0 END),
						('class_requests (not approved)', CASE WHEN R.Status = 'NOT_APPROVED' THEN 1 ELSE 0 END)) A(Status, Value)
WHERE
	R.Requested_By_User_Id = 1
GROUP BY
	A.Status;



-- OUTER APPLY
SELECT
	e.EmployeeID
,	a.OrderID
,	a.OrderDate
FROM
	dbo.Employees AS e
	OUTER APPLY
	(
		SELECT TOP (3) o.OrderID, o.EmployeeID, o.OrderDate
		FROM dbo.Orders AS o
		WHERE o.EmployeeID = e.EmployeeID
		ORDER BY o.OrderDate DESC, OrderID DESC 
	)AS a;

GO


/*
	Create a function with the inner query of the OUTER APPLY
*/
CREATE OR ALTER FUNCTION dbo.ufn_TopOrdersSoldByEmployee
(
	@EmployeeID	AS INT
)RETURNS TABLE
AS
RETURN
(
	SELECT TOP (3) o.OrderID, o.EmployeeID, o.OrderDate
	FROM dbo.Orders AS o
	WHERE o.EmployeeID = @EmployeeID
	ORDER BY o.OrderDate DESC, OrderID DESC
);


-- OUTER APPLY using TVF
SELECT
	e.EmployeeID
,	a.OrderID
,	a.OrderDate
FROM
	dbo.Employees AS e
	OUTER APPLY dbo.ufn_TopOrdersSoldByEmployee(e.EmployeeID) AS a;
