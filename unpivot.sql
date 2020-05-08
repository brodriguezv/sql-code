use TestDB
go

-- Base query
SELECT * FROM CompanyData;


-- UNPIVOT Basic Syntax
/*
SELECT 
	< column list >, 
	< the name you want to give to the target column(s) >, 
	< values to unpivot >
FROM 
	< source table >
UNPIVOT
	( 
		< values to unpivot > 
		FOR < name you want for target column > IN( <source columns> ) 
	) AS U;
*/


-- Changing columns to rows
SELECT 
	Company		-- This is the column we already had.
,	[Year]		-- We're creating this column
,	[Revenue]	-- And this column from the values we are unpivoting.
FROM
	CompanyData
	UNPIVOT
	(
		-- Name we are giving this name to the column we're creating.
		[Revenue]
		-- Set of columns that we are unpivoting
		FOR [Year] IN ([2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019])
	) AS u;


