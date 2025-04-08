-- Create the titles table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[titles]') AND type in (N'U'))
BEGIN
    CREATE TABLE titles (
        title_id varchar(6) NOT NULL PRIMARY KEY,
        title varchar(80) NOT NULL,
        type char(12) NOT NULL DEFAULT ('UNDECIDED'),
        pub_id char(4) NULL,
        price decimal(10,2) NULL,
        advance decimal(10,2) NULL,
        royalty int NULL,
        ytd_sales int NULL,
        notes varchar(200) NULL,
        pubdate datetime NOT NULL DEFAULT (GETDATE())
    );
END
GO

-- Insert sample data
IF NOT EXISTS (SELECT * FROM titles)
BEGIN
    INSERT INTO titles (title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate)
    VALUES
        ('BU1032', 'The Busy Executive''s Database Guide', 'business', '1389', 19.99, 5000, 10, 4095, 'An overview of available database systems with emphasis on common business applications.', '2024-01-01'),
        ('BU1111', 'Cooking with Computers: Surreptitious Balance Sheets', 'business', '1389', 11.95, 5000, 10, 3876, 'Helpful hints on how to use your electronic resources to the best advantage.', '2024-01-01'),
        ('BU2075', 'You Can Combat Computer Stress!', 'business', '0736', 2.99, 10125, 24, 18722, 'The latest medical and psychological techniques for living with the electronic office.', '2024-01-01');
END
GO 