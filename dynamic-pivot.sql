USE TestDB
GO

-- Unpivoting data and inserting into a new table.
SELECT 
	Company		-- This is the column we already had.
,	[Year]		-- We're creating this column
,	[Revenue]	-- And this column from the values we are unpivoting.
INTO CompanyDataTransactions
FROM
	CompanyData
	UNPIVOT
	(
		-- Name we are giving this name to the column we're creating.
		[Revenue]
		-- Set of columns that we are unpivoting
		FOR [Year] IN ([2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019])
	) AS u;


-- Insert more data to our transactions table
INSERT INTO CompanyDataTransactions
SELECT 'SQL Inc',			2011, 766843	UNION ALL
SELECT 'SQL Inc',			2020, 974278	UNION ALL
SELECT 'Facenotebook',		2011, 556322	UNION ALL
SELECT 'Facenotebook',		2020, 993721	UNION ALL
SELECT 'Twister',			2011, 553098	UNION ALL
SELECT 'Twister',			2020, 785986	UNION ALL
SELECT 'Yulp',				2011, 387926	UNION ALL
SELECT 'Yulp',				2020, 968301	UNION ALL
SELECT 'JourneyAdvisor',	2011, 548769	UNION ALL
SELECT 'JourneyAdvisor',	2020, 849210




-- Dynamic PIVOT
DECLARE @columns NVARCHAR(1000);
-- Create a list of distinct values that will become our columns.
SELECT @columns = STRING_AGG([Year], ',') FROM
(
	SELECT DISTINCT QUOTENAME([Year]) AS [Year] 
	FROM CompanyDataTransactions
) C;

-- Now, we need to write our PIVOT statement the same way we always do it.
DECLARE @pivot_stmt NVARCHAR(MAX);
SET @pivot_stmt = 
'
SELECT
	*
FROM
(
	SELECT
		Company
	,	[Year]
	,	Revenue
	FROM
		CompanyDataTransactions
) AS CompanyData
PIVOT
(
	MAX(Revenue)
	FOR [Year] IN (
'

-- Add the colums in our list
SELECT @pivot_stmt = @pivot_stmt + (SELECT @columns) + ')) AS P;'
EXEC sp_executesql @pivot_stmt



-- Dynamic PIVOT alternatives

-- Using a table variable
DECLARE @columns TABLE
(
	column_name NVARCHAR(200)
);

-- Create a list of distinct values that will become our columns.
INSERT INTO @columns
SELECT DISTINCT [Year] AS [Year]
FROM CompanyDataTransactions;

-- Now, we need to write our PIVOT statement the same way we always do it.
DECLARE @pivot_stmt NVARCHAR(MAX);
SET @pivot_stmt = 
'
SELECT
	*
FROM
(
	SELECT
		Company
	,	[Year]
	,	Revenue
	FROM
		CompanyDataTransactions
) AS CompanyData
PIVOT
(
	MAX(Revenue)
	FOR [Year] IN (
'

-- Add the colums as a comma separated list.
SELECT @pivot_stmt = @pivot_stmt + '[' + column_name + '],'
FROM @columns;

-- We need to remove the last comma from the list.
SELECT @pivot_stmt = SUBSTRING(@pivot_stmt, 1, LEN(@pivot_stmt)-1); 

SELECT @pivot_stmt = @pivot_stmt + ')) AS P;'

EXEC sp_executesql @pivot_stmt




-- Adding the values directly in the dynamic statement.
-- Here, we just need to write our PIVOT statement the same way we always do it.
DECLARE @pivot_stmt NVARCHAR(MAX);
SET @pivot_stmt = 
'
SELECT
	*
FROM
(
	SELECT
		Company
	,	[Year]
	,	Revenue
	FROM
		CompanyDataTransactions
) AS CompanyData
PIVOT
(
	MAX(Revenue)
	FOR [Year] IN (
'

-- Add the colums as a comma separated list querying directly from the table.
SELECT @pivot_stmt = @pivot_stmt + '[' + [Year] + '],' FROM CompanyDataTransactions GROUP BY [Year]

-- We need to remove the last comma from the list.
SELECT @pivot_stmt = SUBSTRING(@pivot_stmt, 1, LEN(@pivot_stmt)-1); 

SELECT @pivot_stmt = @pivot_stmt + ')) AS P;'

EXEC sp_executesql @pivot_stmt



