USE AdventureWorks
GO


-- This is our base query. We're getting top level products and their corresponding bill of materials.
SELECT 
	p.ProductID
,	p.Name
,	1 AS ProductLevel
,	NULL AS ProductAssemblyID
,	CAST(p.Name AS VARCHAR(50)) AS BOMPath
FROM
	Production.Product AS p
	INNER JOIN
		Production.BillOfMaterials AS bom
			ON	bom.ComponentID = p.ProductID
			AND	bom.ProductAssemblyID IS NULL;


-- This is the CTE with both the anchor and the recursive members.
-- With this query, we're going to be able to get all the subcomponents.
WITH BOM
AS
(
	-- This query is the anchor member.
	SELECT 
		p.ProductID
	,	p.Name
	,	1 AS ProductLevel						-- This is our top level product.
	,	CAST(p.Name AS VARCHAR(50)) AS BOMPath	-- This column is just the path the products and subproducts are going. You'll see in the result set.
	FROM
		Production.Product AS p
		INNER JOIN
			Production.BillOfMaterials AS bom
				ON	bom.ComponentID = p.ProductID
				AND	bom.ProductAssemblyID IS NULL
	UNION ALL
	-- This part is the recursive member. Note that we have a call to our BOM cte there.
	SELECT 
		p.ProductID
	,	p.Name
	,	cte.ProductLevel + 1
	,	CAST(cte.BOMPath + '\' + p.Name AS VARCHAR(50))
	FROM
		BOM AS cte
		INNER JOIN Production.BillOfMaterials AS bom
			ON	bom.ProductAssemblyID = cte.ProductID
		INNER JOIN Production.Product AS p
			ON	bom.ComponentID = p.ProductID
)
-- We can use the * in the outer query, since we already know what columns are coming back.
SELECT
	*
FROM
	BOM
ORDER BY
	BOMPath;



-- Change databases.
USE TestDB
GO

-- This query will create an infinite loop.
WITH cte
AS
(
	SELECT 
		EmployeeID
	,	FirstName
	,	LastName
	,	ReportsTo
	FROM 
		dbo.Employees
	UNION ALL
	SELECT 
		c.EmployeeID
	,	c.FirstName
	,	c.LastName
	,	c.ReportsTo
	FROM 
		cte AS c
		INNER JOIN dbo.Employees AS e
			ON	c.EmployeeID = e.ReportsTo
)
SELECT * 
FROM
	cte
-- Include this hint to limit the number of recursion levels.
OPTION(MAXRECURSION 2);








