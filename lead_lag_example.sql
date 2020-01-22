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
	t.ShiftName = 'Night'
AND	t.ShiftDate = '2015-03-01'
ORDER BY
	t.EmployeeName ASC;





-- Example of how to use LEAD and LAG functions at the same time.
WITH Shifts
AS
(
	SELECT
		EmployeeName
	,	ShiftName
	,	ShiftDate
	,	LEAD(ShiftDate,1)	OVER(PARTITION BY EmployeeName, ShiftName ORDER BY ShiftDate asc) NextNightShift
	,	ROW_NUMBER()		OVER(PARTITION BY EmployeeName, ShiftName ORDER BY ShiftDate asc) RowNum
	FROM
		dbo.EmployeeShift
)
SELECT 
	EmployeeName
,	ShiftName
,	ShiftDate
,	NextNightShift
FROM 
	Shifts 
WHERE 
	RowNum = 1
AND	ShiftName = 'Night'
AND ShiftDate = '2015-03-01'
ORDER BY
	EmployeeName ASC

-- Using LAG
WITH Shifts
AS
(
	SELECT
		EmployeeName
	,	ShiftName
	,	ShiftDate
	,	LAG(ShiftName,1)	OVER(PARTITION BY employeename ORDER BY ShiftDate desc) PreviousShift
	FROM
		dbo.EmployeeShift
)
SELECT 
	EmployeeName
,	ShiftName
,	ShiftDate
,	PreviousShift
FROM 
	Shifts 
WHERE 
	ShiftDate = '2015-03-24'
ORDER BY
	EmployeeName ASC