USE TestDB
GO

-- Let's create two database users
CREATE USER DataAnalyst WITHOUT LOGIN;
CREATE USER FinanceGuy	WITHOUT LOGIN;


-- Dynamic Data Masking Example
CREATE TABLE dbo.SuperSensitiveCustomerData
(
	ID INT IDENTITY(1,1) PRIMARY KEY
,	FirstName VARCHAR(100)
,	LastName VARCHAR(100) MASKED WITH(FUNCTION = 'partial(1,"xxxx", 0)')
,	HomeAddress VARCHAR(250) MASKED WITH(FUNCTION = 'default()')
,	SSN VARCHAR(15) MASKED WITH(FUNCTION = 'partial(6, "xxxx", 0)')
,	Email VARCHAR(50) MASKED WITH(FUNCTION = 'email()')
,	CreditCard VARCHAR(40) MASKED WITH(FUNCTION = 'partial(12,"xxxx", 0)')
,	DateOfBirth DATE MASKED WITH(FUNCTION = 'default()')
);


-- We need to grant SELECT to both users we created
GRANT SELECT ON dbo.SuperSensitiveCustomerData TO DataAnalyst, FinanceGuy;


-- Test how both users can see the data
EXECUTE(N'SELECT * FROM dbo.SuperSensitiveCustomerData') AS USER = N'DataAnalyst';
EXECUTE(N'SELECT * FROM dbo.SuperSensitiveCustomerData') AS USER = N'FinanceGuy';


-- Let's grant DataAnalyst the UNMASK permission
GRANT UNMASK TO DataAnalyst;

-- Test again
EXECUTE(N'SELECT * FROM dbo.SuperSensitiveCustomerData') AS USER = N'DataAnalyst';
EXECUTE(N'SELECT * FROM dbo.SuperSensitiveCustomerData') AS USER = N'FinanceGuy';


-- Create a new table as a copy of the first, but with no masking functions.
CREATE TABLE dbo.MoreSuperSensitiveCustomerData
(
	ID			INT IDENTITY(1,1) PRIMARY KEY
,	FirstName	VARCHAR(100)
,	LastName	VARCHAR(100)		
,	HomeAddress VARCHAR(250)	
,	SSN			VARCHAR(15)				
,	Email		VARCHAR(50)			
,	CreditCard	VARCHAR(40)		
,	DateOfBirth DATE			
);

-- Copy the data from our first table
INSERT INTO MoreSuperSensitiveCustomerData(FirstName, LastName, HomeAddress, SSN, Email, CreditCard, DateOfBirth)
SELECT FirstName, LastName, HomeAddress, SSN, Email, CreditCard, DateOfBirth FROM SuperSensitiveCustomerData;

-- Grant select to the new table
GRANT SELECT ON dbo.MoreSuperSensitiveCustomerData TO DataAnalyst, FinanceGuy;

-- Query as the users
EXECUTE(N'SELECT * FROM dbo.MoreSuperSensitiveCustomerData') AS USER = N'DataAnalyst';
EXECUTE(N'SELECT * FROM dbo.MoreSuperSensitiveCustomerData') AS USER = N'FinanceGuy';


-- Alter the table to define masking functions
ALTER TABLE dbo.MoreSuperSensitiveCustomerData
ALTER COLUMN LastName ADD MASKED WITH(FUNCTION = 'partial(1,"xxxx", 0)');

ALTER TABLE dbo.MoreSuperSensitiveCustomerData
ALTER COLUMN HomeAddress ADD MASKED WITH(FUNCTION = 'default()');

ALTER TABLE dbo.MoreSuperSensitiveCustomerData
ALTER COLUMN SSN ADD MASKED WITH(FUNCTION = 'partial(6, "xxxx", 0)');

ALTER TABLE dbo.MoreSuperSensitiveCustomerData
ALTER COLUMN Email ADD MASKED WITH(FUNCTION = 'email()');

ALTER TABLE dbo.MoreSuperSensitiveCustomerData
ALTER COLUMN CreditCard ADD MASKED WITH(FUNCTION = 'partial(12,"xxxx", 0)');

ALTER TABLE dbo.MoreSuperSensitiveCustomerData
ALTER COLUMN DateOfBirth ADD MASKED WITH(FUNCTION = 'default()');

-- Test one more time
EXECUTE(N'SELECT * FROM dbo.MoreSuperSensitiveCustomerData') AS USER = N'DataAnalyst';
EXECUTE(N'SELECT * FROM dbo.MoreSuperSensitiveCustomerData') AS USER = N'FinanceGuy';

