USE Northwind
GO

-- Select all columns
SELECT * FROM Products;

--Select a subset of columns 
SELECT 
	ProductID
,	ProductName
,	UnitPrice 
FROM 
	Products; 

--Select a literal value 
SELECT 'Hello world!';
SELECT 120.50;

-- An arithmetic expression 
SELECT 12 * 4;

-- Get the product name of product id 1
SELECT 
	ProductName 
FROM 
	Products 
WHERE 
	ProductID = 1;


-- Get the product name and price of product ids 1, 2, 3, 4 and 5
SELECT 
	ProductID
,	ProductName
,	UnitPrice 
FROM 
	Products 
WHERE
	ProductID IN (1,2,3,4,5);


-- Get the product name and unit price of products which names start with the letter C
SELECT 
	ProductName
,	UnitPrice 
FROM 
	Products 
WHERE 
	ProductName LIKE 'C%';

-- Which of my products is the most expensive using ORDER BY
SELECT 
	ProductName
,	UnitPrice 
FROM 
	Products 
WHERE 
	ProductID IN (15, 28, 38, 55, 77, 12, 47, 22, 39, 10) 
ORDER BY 
	UnitPrice DESC;