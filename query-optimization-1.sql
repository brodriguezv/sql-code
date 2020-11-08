USE StackOverflow2010
GO

-- Provides input / output and run time execuiton statistics of our query
SET STATISTICS IO, TIME ON

-- Listing only needed columns, SQL Server uses the index efficiently
SELECT 
	DisplayName, Reputation 
FROM 
	Users
WHERE
	Location = 'San Diego, CA';



-- Using SELECT *
SELECT 
	*
FROM 
	Users
WHERE
	Location = 'San Diego, CA';



/*
-- Missing Index SQL Server is recommending for our query.

USE [StackOverflow2010] 
GO 

CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] 
ON [dbo].[Users] ([Location]) 
INCLUDE ([AboutMe],[Age],[CreationDate],[DisplayName],[DownVotes],[EmailHash],[LastAccessDate],[Reputation],[UpVotes],[Views],[WebsiteUrl],[AccountId]) 
GO

*/