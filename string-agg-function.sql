USE WideWorldImporters
GO

-- Aggregate Customer Categories into a comma separated values list
SELECT 
	STRING_AGG(CustomerCategoryName, ',') AS Aggregate_List
FROM
	Sales.CustomerCategories
GO


-- Aggregate Email Addresses into a comma separated values list
-- But there's an error... s#%t
SELECT 
	STRING_AGG(pe.EmailAddress, ',') AS Aggregate_List
FROM
	Application.People AS pe
GO


-- Aggregate Email Addresses into a comma separated values list... Fixed it!
SELECT 
	STRING_AGG(CAST(pe.EmailAddress AS NVARCHAR(MAX)), ',') AS Aggregate_List
FROM
	Application.People AS pe
GO


-- Not using WITHIN GROUP
SELECT 
	st.StateProvinceName
,	STRING_AGG(CAST(c.CityName AS NVARCHAR(MAX)), ', ')  AS Cities
FROM
	Application.Cities AS c
INNER JOIN
	Application.StateProvinces AS st
ON c.StateProvinceID = st.StateProvinceID
GROUP BY st.StateProvinceName


-- Using WITHIN GROUP
SELECT 
	st.StateProvinceName
,	STRING_AGG(CAST(c.CityName AS NVARCHAR(MAX)), ', ') WITHIN GROUP(ORDER BY c.CityName ASC) AS Cities
FROM
	Application.Cities AS c
INNER JOIN
	Application.StateProvinces AS st
ON c.StateProvinceID = st.StateProvinceID
GROUP BY st.StateProvinceName







