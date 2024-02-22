CREATE TABLE dbo.daily_profit
(
	date		DATE,
	profit		DECIMAL(10,2),
	revenue		DECIMAL(10,2),
	expenses	DECIMAL(10,2),
)

TRUNCATE TABLE daily_profit


WITH dates AS
(
	SELECT 
		DATEADD(DD,-value,cast(getdate() AS DATE)) AS DATE,
		CAST(ROUND(1000 + (ABS(CHECKSUM(NEWID())) % 1000000)/100.0, 2) AS DECIMAL(10, 2)) AS revenue,
		CAST(ROUND(500 + (ABS(CHECKSUM(NEWID())) % 1000000)/100.0, 2) AS DECIMAL(10, 2)) AS expenses
	FROM 
		GENERATE_SERIES(1,180)
)
INSERT INTO daily_profit(date, revenue, expenses, profit)
SELECT
	*, revenue - expenses AS profit
FROM
	dates
ORDER BY 
	date ASC;


select * from daily_profit





SELECT
	date,
	profit,
	CASE SIGN(profit)
	    WHEN 1 THEN 'is profitable'
		WHEN 0 THEN 'breakeven'
		WHEN -1 THEN 'loss making'
	END AS performance
FROM
	daily_profit
ORDER BY
	date ASC;




SELECT
  Date,
  profit,
  ABS(profit - LAG(profit) OVER (ORDER BY Date)) as ProfitChangeMagnitude
FROM
  Daily_Profit


SELECT
	Date,
	CASE SIGN(Profit - LAG(Profit) OVER (ORDER BY Date))
		WHEN  1 THEN 'Increased'
		WHEN 0 THEN 'No change'
		WHEN -1 THEN 'Decreased'
	END as ProfitChangeDirection
FROM
  Daily_Profit