USE TestDB
GO

CREATE TABLE dbo.EmployeeShift
(
	EmployeeName	VARCHAR(40)
,	ShiftName		VARCHAR(20)
,	ShiftDate		DATE
)

INSERT INTO dbo.EmployeeShift
SELECT 'Bob',	'Afternoon',	'3/8/2015'		UNION ALL
SELECT 'Bob',	'Afternoon',	'3/29/2015'		UNION ALL
SELECT 'Bob',	'Afternoon',	'4/19/2015'		UNION ALL
SELECT 'Bob',	'Afternoon',	'5/10/2015'		UNION ALL
SELECT 'Bob',	'Afternoon',	'5/31/2015'		UNION ALL
SELECT 'Bob',	'Afternoon',	'6/21/2015'		UNION ALL
SELECT 'Kyle',	'Afternoon',	'3/8/2015'		UNION ALL
SELECT 'Kyle',	'Afternoon',	'3/29/2015'		UNION ALL
SELECT 'Kyle',	'Afternoon',	'4/19/2015'		UNION ALL
SELECT 'Kyle',	'Afternoon',	'5/10/2015'		UNION ALL
SELECT 'Kyle',	'Afternoon',	'5/31/2015'		UNION ALL
SELECT 'Kyle',	'Afternoon',	'6/21/2015'		UNION ALL
SELECT 'Steve',	'Afternoon',	'3/8/2015'		UNION ALL
SELECT 'Steve',	'Afternoon',	'3/29/2015'		UNION ALL
SELECT 'Steve',	'Afternoon',	'4/19/2015'		UNION ALL
SELECT 'Steve',	'Afternoon',	'5/10/2015'		UNION ALL
SELECT 'Steve',	'Afternoon',	'5/31/2015'		UNION ALL
SELECT 'Steve',	'Afternoon',	'6/21/2015'		UNION ALL
SELECT 'Joane',	'Afternoon',	'3/8/2015'		UNION ALL
SELECT 'Joane',	'Afternoon',	'3/29/2015'		UNION ALL
SELECT 'Joane',	'Afternoon',	'4/19/2015'		UNION ALL
SELECT 'Joane',	'Afternoon',	'5/10/2015'		UNION ALL
SELECT 'Joane',	'Afternoon',	'5/31/2015'		UNION ALL
SELECT 'Joane',	'Afternoon',	'6/21/2015'		UNION ALL
SELECT 'Mary',	'Afternoon',	'3/8/2015'		UNION ALL
SELECT 'Mary',	'Afternoon',	'3/29/2015'		UNION ALL
SELECT 'Mary',	'Afternoon',	'4/19/2015'		UNION ALL
SELECT 'Mary',	'Afternoon',	'5/10/2015'		UNION ALL
SELECT 'Mary',	'Afternoon',	'5/31/2015'		UNION ALL
SELECT 'Mary',	'Afternoon',	'6/21/2015'		UNION ALL
SELECT 'Jamie',	'Afternoon',	'3/8/2015'		UNION ALL
SELECT 'Jamie',	'Afternoon',	'3/29/2015'		UNION ALL
SELECT 'Jamie',	'Afternoon',	'4/19/2015'		UNION ALL
SELECT 'Jamie',	'Afternoon',	'5/10/2015'		UNION ALL
SELECT 'Jamie',	'Afternoon',	'5/31/2015'		UNION ALL
SELECT 'Jamie',	'Afternoon',	'6/21/2015'		UNION ALL
SELECT 'Bob',	'Morning',		'3/1/2015'		UNION ALL
SELECT 'Bob',	'Morning',		'3/22/2015'		UNION ALL
SELECT 'Bob',	'Morning',		'4/12/2015'		UNION ALL
SELECT 'Bob',	'Morning',		'5/3/2015'		UNION ALL
SELECT 'Bob',	'Morning',		'5/24/2015'		UNION ALL
SELECT 'Bob',	'Morning',		'6/14/2015'		UNION ALL
SELECT 'Kyle',	'Morning',		'3/1/2015'		UNION ALL
SELECT 'Kyle',	'Morning',		'3/22/2015'		UNION ALL
SELECT 'Kyle',	'Morning',		'4/12/2015'		UNION ALL
SELECT 'Kyle',	'Morning',		'5/3/2015'		UNION ALL
SELECT 'Kyle',	'Morning',		'5/24/2015'		UNION ALL
SELECT 'Kyle',	'Morning',		'6/14/2015'		UNION ALL
SELECT 'Steve',	'Morning',		'3/1/2015'		UNION ALL
SELECT 'Steve',	'Morning',		'3/22/2015'		UNION ALL
SELECT 'Steve',	'Morning',		'4/12/2015'		UNION ALL
SELECT 'Steve',	'Morning',		'5/3/2015'		UNION ALL
SELECT 'Steve',	'Morning',		'5/24/2015'		UNION ALL
SELECT 'Steve',	'Morning',		'6/14/2015'		UNION ALL
SELECT 'Joane',	'Morning',		'3/1/2015'		UNION ALL
SELECT 'Joane',	'Morning',		'3/22/2015'		UNION ALL
SELECT 'Joane',	'Morning',		'4/12/2015'		UNION ALL
SELECT 'Joane',	'Morning',		'5/3/2015'		UNION ALL
SELECT 'Joane',	'Morning',		'5/24/2015'		UNION ALL
SELECT 'Joane',	'Morning',		'6/14/2015'		UNION ALL
SELECT 'Mary',	'Morning',		'3/1/2015'		UNION ALL
SELECT 'Mary',	'Morning',		'3/22/2015'		UNION ALL
SELECT 'Mary',	'Morning',		'4/12/2015'		UNION ALL
SELECT 'Mary',	'Morning',		'5/3/2015'		UNION ALL
SELECT 'Mary',	'Morning',		'5/24/2015'		UNION ALL
SELECT 'Mary',	'Morning',		'6/14/2015'		UNION ALL
SELECT 'Jamie',	'Morning',		'3/1/2015'		UNION ALL
SELECT 'Jamie',	'Morning',		'3/22/2015'		UNION ALL
SELECT 'Jamie',	'Morning',		'4/12/2015'		UNION ALL
SELECT 'Jamie',	'Morning',		'5/3/2015'		UNION ALL
SELECT 'Jamie',	'Morning',		'5/24/2015'		UNION ALL
SELECT 'Jamie',	'Morning',		'6/14/2015'		UNION ALL
SELECT 'Bob',	'Night',		'3/15/2015'		UNION ALL
SELECT 'Bob',	'Night',		'4/5/2015'		UNION ALL
SELECT 'Bob',	'Night',		'4/26/2015'		UNION ALL
SELECT 'Bob',	'Night',		'5/17/2015'		UNION ALL
SELECT 'Bob',	'Night',		'6/7/2015'		UNION ALL
SELECT 'Bob',	'Night',		'6/28/2015'		UNION ALL
SELECT 'Kyle',	'Night',		'3/15/2015'		UNION ALL
SELECT 'Kyle',	'Night',		'4/5/2015'		UNION ALL
SELECT 'Kyle',	'Night',		'4/26/2015'		UNION ALL
SELECT 'Kyle',	'Night',		'5/17/2015'		UNION ALL
SELECT 'Kyle',	'Night',		'6/7/2015'		UNION ALL
SELECT 'Kyle',	'Night',		'6/28/2015'		UNION ALL
SELECT 'Steve',	'Night',		'3/15/2015'		UNION ALL
SELECT 'Steve',	'Night',		'4/5/2015'		UNION ALL
SELECT 'Steve',	'Night',		'4/26/2015'		UNION ALL
SELECT 'Steve',	'Night',		'5/17/2015'		UNION ALL
SELECT 'Steve',	'Night',		'6/7/2015'		UNION ALL
SELECT 'Steve',	'Night',		'6/28/2015'		UNION ALL
SELECT 'Joane',	'Night',		'3/15/2015'		UNION ALL
SELECT 'Joane',	'Night',		'4/5/2015'		UNION ALL
SELECT 'Joane',	'Night',		'4/26/2015'		UNION ALL
SELECT 'Joane',	'Night',		'5/17/2015'		UNION ALL
SELECT 'Joane',	'Night',		'6/7/2015'		UNION ALL
SELECT 'Joane',	'Night',		'6/28/2015'		UNION ALL
SELECT 'Mary',	'Night',		'3/15/2015'		UNION ALL
SELECT 'Mary',	'Night',		'4/5/2015'		UNION ALL
SELECT 'Mary',	'Night',		'4/26/2015'		UNION ALL
SELECT 'Mary',	'Night',		'5/17/2015'		UNION ALL
SELECT 'Mary',	'Night',		'6/7/2015'		UNION ALL
SELECT 'Mary',	'Night',		'6/28/2015'		UNION ALL
SELECT 'Jamie',	'Night',		'3/15/2015'		UNION ALL
SELECT 'Jamie',	'Night',		'4/5/2015'		UNION ALL
SELECT 'Jamie',	'Night',		'4/26/2015'		UNION ALL
SELECT 'Jamie',	'Night',		'5/17/2015'		UNION ALL
SELECT 'Jamie',	'Night',		'6/7/2015'		UNION ALL
SELECT 'Jamie',	'Night',		'6/28/2015'
