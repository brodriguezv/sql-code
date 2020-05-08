USE TestDB
GO

-- Base query, the number of students enrolled in a courses by department.
SELECT
	c.Title AS CourseTitle
,	d.Name AS DepartmentName
,	COUNT(*) AS NumberOfStudents
FROM
	StudentGrade AS sg
	INNER JOIN Course AS c
		ON sg.CourseID = c.CourseID
	INNER JOIN Department AS d
		ON d.DepartmentID = c.DepartmentID
GROUP BY 
	c.Title, d.Name;


--Pivot Basic Syntax
/*
WITH PivotData
AS
(
	SELECT
		<what you want to see as rows>,
		<what you want to see in columns>,
		<the value you want to aggregate>
	FROM
	 <source table>
)
SELECT <list of columns>
FROM
	PivotData
	PIVOT( <the aggregate function you want to use (SUM,MAX, AVG...etc)>(<the aggregate column>)
		FOR <what you want in columns> IN (<the different values of what you want in columns>) AS P;
*/


-- Changing rows into colums with PIVOT
WITH PivotData
AS
(
	SELECT
		c.Title AS CourseTitle		--This is what you want in rows
	,	d.Name AS DepartmentName	--This is what you want in columns
	,	sg.StudentID				--This is the aggregate value
	FROM
		StudentGrade AS sg
		INNER JOIN Course AS c
			ON sg.CourseID = c.CourseID
		INNER JOIN Department AS d
			ON d.DepartmentID = c.DepartmentID
)
SELECT
	CourseTitle
,	[Economics],[Engineering],[English],[Mathematics]
FROM
	PivotData
	PIVOT
	(
		-- Here's where we use the aggregate, in our case COUNT().
		COUNT(StudentID)
		-- FOR DepartmentName is the value you want in columns.
		-- You need to hard code the distinct values you want show as the column names.
		FOR DepartmentName IN ([Economics],[Engineering],[English],[Mathematics])
	) AS P;













