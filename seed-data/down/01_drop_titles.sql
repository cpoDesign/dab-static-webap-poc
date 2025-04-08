-- Drop the titles table
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[titles]') AND type in (N'U'))
BEGIN
    DROP TABLE titles;
END
GO 