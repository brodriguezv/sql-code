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