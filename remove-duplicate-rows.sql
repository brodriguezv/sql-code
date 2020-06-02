USE TestDB
GO

-- Total rows in the table
SELECT 
	COUNT(*) AS TotalRows
FROM 
	dbo.DuplicateData

-- USING DISTINCT
-- Total number of different rows in the table
SELECT
	COUNT(DISTINCT CustomerName) AS TotalUniqueCustomers
FROM
	dbo.DuplicateData

-- A temporary table as copy of the actual table.
SELECT
	*
INTO #DuplicateData
FROM
	dbo.DuplicateData
ORDER BY
	CustomerName


-- USING GROUP BY AND HAVING TO CHECK FOR DUPLICATES
-- Filter our groups to show records that have a count of more than one
SELECT 
	CustomerName
,	COUNT(*) NameCount
FROM
	dbo.#DuplicateData
GROUP BY
	CustomerName
HAVING
	COUNT(*) > 1


-- Non duplicates
SELECT
	DISTINCT * 
INTO #NonDuplicateData
FROM
	dbo.DuplicateData
ORDER BY
	CustomerName

SELECT * FROM #NonDuplicateData ORDER BY CustomerName

-- Truncate the table with the duplicates
TRUNCATE TABLE #DuplicateData

-- Insert unique rows to the table
INSERT INTO #DuplicateData
SELECT * FROM #NonDuplicateData

--Check for duplicates
SELECT * FROM #DuplicateData ORDER BY CustomerName

-- Check for duplicates using ROW_NUMBER window function
SELECT 
	CustomerName
,	ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY CustomerName ASC) AS rn
FROM 
	DuplicateData;


-- Create the CTE, and DELETE the ones greater than one.
WITH Duplicates
AS
(
	SELECT 
		CustomerName
	,	ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY CustomerName ASC) AS rn
	FROM 
		DuplicateData
)
DELETE
FROM
	Duplicates
WHERE
	rn > 1;


-- Check for duplicates again
SELECT 
	CustomerName
,	ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY CustomerName ASC) AS rn
FROM 
	DuplicateData



-- Housekeeping
DROP TABLE #DuplicateData, #NonDuplicateData
