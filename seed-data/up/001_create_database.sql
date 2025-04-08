-- Create the pubs database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'pubs')
BEGIN
    CREATE DATABASE pubs;
END
GO

USE pubs;
GO 