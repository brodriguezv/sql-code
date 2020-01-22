USE TestDB
GO
/*
	How to use RANK() AND DENSE_RANK()
*/

SELECT
	StudentName
,	Grade
,	RANK() OVER(ORDER BY Grade DESC) StudentRanking
,	DENSE_RANK() OVER(ORDER BY Grade DESC) StudentDenseRanking
FROM
	dbo.Students



/*
	Using NTILE
*/

SELECT
	StudentName
,	Grade
,	NTILE(3) OVER(ORDER BY Grade DESC) BucketNumber
FROM
	dbo.Students