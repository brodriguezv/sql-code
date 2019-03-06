USE TestDB
GO

-- This query works, but we can save a lot of code using LEAD and LAG functions
SELECT 
	t.EmployeeName
,	t.ShiftName
,	t.ShiftDate
,	(
		SELECT TOP 1 
			ShiftDate 
		FROM EmployeeShift AS tlead
		WHERE 
			tlead.EmployeeName = t.EmployeeName
		AND t.ShiftName = tlead.ShiftName
		AND tlead.ShiftDate > t.ShiftDate
		ORDER BY 
			ShiftDate
	) AS NextShift
FROM
	EmployeeShift AS t
WHERE
	t.EmployeeName = 'Bob'
AND t.ShiftName = 'Night'
ORDER BY
	t.ShiftDate ASC



-- Example of how to use LEAD and LAG functions at the same time.
SELECT
	EmployeeName
,	ShiftName
,	ShiftDate
,	LEAD(ShiftDate,1) OVER(PARTITION BY EmployeeName ORDER BY ShiftDate ASC) NextShift
,	LAG(ShiftDate,1) OVER(PARTITION BY EmployeeName ORDER BY ShiftDate ASC) PreviousShift
FROM
	dbo.EmployeeShift
WHERE
	ShiftName = 'Night'
and	EmployeeName = 'Bob'



