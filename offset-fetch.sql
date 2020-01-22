USE TestDB
GO

-- Table Person has 34 rows with an ID
SELECT
	PersonID
,	FirstName
,	LastName
FROM
	dbo.Person


-- OFFSET - FETCH syntax
SELECT
	PersonID
,	FirstName
,	LastName
FROM 
	dbo.Person
ORDER BY
	PersonID
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY; 


-- Skipping 0 rows
SELECT
	PersonID
,	FirstName
,	LastName
FROM
	dbo.Person
ORDER BY
	PersonID
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;


-- Get the rest of rows
SELECT
	PersonID
,	FirstName
,	LastName
FROM
	dbo.Person
ORDER BY
	PersonID
OFFSET 1 ROW;


-- No skipping rows and getting the first N rows.
SELECT
	PersonID
,	FirstName
,	LastName
FROM
	dbo.Person
ORDER BY
	PersonID
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY;




USE TestDB
GO

-- Stored procedure to implement pagination
CREATE PROCEDURE dbo.uspPaginateReport
(
	-- Parameters to pass to the pagination stored procedure
	@page_number	INT = 1	-- This is the page number from 1 to N
,	@page_size		INT = 5		-- This is the number of rows to show
)
AS
BEGIN

	SELECT
		PersonID
	,	FirstName
	,	LastName
	,	Discriminator
	FROM 
		dbo.Person
	ORDER BY
		PersonID ASC
	OFFSET (@page_number - 1) * @page_size ROWS FETCH NEXT @page_size ROWS ONLY;

END
GO


-- Testing the stored procedure
DECLARE @page_number	INT = 2		-- This is the page number from 1 to N
	,	@page_size		INT = 3		-- This is the number of rows to show


EXEC uspPaginateReport @page_number, @page_size