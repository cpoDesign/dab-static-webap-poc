-- Create the pubs database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'pubs')
BEGIN
    CREATE DATABASE pubs;
END
GO

USE pubs;
GO

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
        ('BU2075', 'You Can Combat Computer Stress!', 'business', '0736', 2.99, 10125, 24, 18722, 'The latest medical and psychological techniques for living with the electronic office.', '2024-01-01'),
        ('BU7832', 'Straight Talk About Computers', 'business', '1389', 19.99, 5000, 10, 4095, 'Annotated analysis of what computers can do for you: a no-hype guide for the critical user.', '2024-01-01'),
        ('MC2222', 'Silicon Valley Gastronomic Treats', 'mod_cook', '0877', 19.99, 0, 12, 2032, 'Favorite recipes for quick, easy, and elegant meals.', '2024-01-01'),
        ('MC3021', 'The Gourmet Microwave', 'mod_cook', '0877', 2.99, 15000, 24, 22246, 'Traditional French gourmet recipes adapted for modern microwave cooking.', '2024-01-01'),
        ('MC3026', 'The Psychology of Computer Cooking', 'UNDECIDED', '0877', NULL, NULL, NULL, NULL, NULL, '2024-01-01'),
        ('PC1035', 'But Is It User Friendly?', 'popular_comp', '1389', 22.95, 7000, 16, 8780, 'A survey of software for the naive user, focusing on the ''friendliness'' of each.', '2024-01-01'),
        ('PC8888', 'Secrets of Silicon Valley', 'popular_comp', '1389', 20.00, 8000, 10, 4095, 'Muckraking reporting on the world''s largest computer hardware and software manufacturers.', '2024-01-01'),
        ('PC9999', 'Net Etiquette', 'popular_comp', '1389', NULL, NULL, NULL, NULL, 'A must-read for computer conferencing.', '2024-01-01'),
        ('PS1372', 'Computer Phobic AND Non-Phobic Individuals: Behavior Variations', 'psychology', '0877', 21.59, 7000, 10, 375, 'A must for the specialist, this book examines the difference between those who hate and fear computers and those who don''t.', '2024-01-01'),
        ('PS2091', 'Is Anger the Enemy?', 'psychology', '0736', 10.95, 2275, 12, 2045, 'Carefully researched study of the effects of strong emotions on the body.', '2024-01-01'),
        ('PS2091', 'Life Without Fear', 'psychology', '0736', 7.00, 6000, 10, 111, 'New exercise, meditation, and nutritional procedures that reduce the reader''s vulnerability to stress.', '2024-01-01'),
        ('PS2106', 'Prolonged Data Deprivation: Four Case Studies', 'psychology', '0736', 19.99, 2000, 10, 4072, 'What happens when the data runs dry?  Searching evaluations of information-shortage effects.', '2024-01-01'),
        ('TC3218', 'Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean', 'trad_cook', '0877', 20.95, 7000, 10, 375, 'Profusely illustrated in color, this makes a wonderful gift book for a cuisine-oriented friend.', '2024-01-01'),
        ('TC4203', 'Fifty Years in Buckingham Palace Kitchens', 'trad_cook', '0877', 11.95, 4000, 14, 15096, 'More anecdotes from the Queen''s favorite cook describing life among English royalty.', '2024-01-01'),
        ('TC7777', 'Sushi, Anyone?', 'trad_cook', '0877', 14.99, 8000, 10, 4095, 'Detailed instructions on improving your position in life by learning how to make authentic Japanese sushi in your spare time.', '2024-01-01');
END
GO 