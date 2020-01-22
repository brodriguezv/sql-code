--Let's create a test database
CREATE DATABASE TestDB
GO

USE TestDB
GO

-- Create a table to hold Students
CREATE TABLE dbo.Students
(
	StudentName	VARCHAR(50)
,	Grade		INT			-- We don't care about decimals
)
GO

-- Some variables to handle our business ;)
DECLARE @student		VARCHAR(50) = ''
,		@counter		INT			= 1
,		@max_students	INT			= 25	-- Just 25 students for our example
,		@max_grade		INT			= 100	-- No one can get a grade greater than 100, except for Chuck Norris
,		@min_grade		INT			= 44	-- Let's suppose nobody got less than 45

WHILE @counter <= @max_students
BEGIN
	
	INSERT INTO dbo.Students(StudentName, Grade)
	SELECT 
		'Student' + CAST(@counter AS VARCHAR) StudentName
	,	FLOOR(RAND()*(@max_grade-@min_grade+1))+@min_grade AS Grade 
	-- This formula helps you create random numbers within a range, in this case between 45 and 100 

	SET @counter += 1
END


-- This query gives us the result we want
SELECT TOP (1) 
	StudentName
,	Grade 
FROM
(	
	SELECT TOP (2)
		StudentName
	,	Grade 
	FROM 
		Students
	ORDER BY
		Grade DESC
) A
ORDER BY Grade ASC
GO


-- If we execute the inner query as a separate, we see that Student10 is actually the second place with a grade of 96
SELECT TOP (2)
	StudentName
,	Grade 
FROM 
	Students
ORDER BY
	Grade DESC


-- Create a CTE
;WITH StudentsCTE
AS
(
	-- Syntax ROW_NUMBER()
	SELECT
		StudentName
	,	Grade
	,	ROW_NUMBER() OVER(ORDER BY Grade DESC) AS RowNumber
	-- Withouot PARTITION BY, it will use the entire set of rows
	FROM
		Students
)
SELECT
	*	-- Here's fine to use * because we selected what we wanted inside the CTE
FROM
	StudentsCTE
WHERE
	RowNumber = 2
	-- Simply select the number of row we want and that's it
GO