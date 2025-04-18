USE LibraryManagementSystem;

DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Books(Title, Author, ISBN, PublishedDate, Genre, ShelfLocation, CurrentStatus)
    VALUES (
        CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CAST(ABS(CHECKSUM(NEWID())) % 100 AS VARCHAR),
        CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CAST(ABS(CHECKSUM(NEWID())) % 100 AS VARCHAR),
        CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CAST(ABS(CHECKSUM(NEWID())) % 100 AS VARCHAR),
        DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 365), '2023-01-01'),
        CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CAST(ABS(CHECKSUM(NEWID())) % 100 AS VARCHAR),
        CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CAST(ABS(CHECKSUM(NEWID())) % 100 AS VARCHAR),
        (SELECT TOP 1 v FROM (VALUES ('Available'), ('Borrowed')) AS statuses(v) ORDER BY NEWID())
    );

    SET @i = @i + 1;
END;
GO

DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Borrowers(FirstName, LastName, Email, DateOfBirth, MembershipDate)
    VALUES (
        CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CAST(ABS(CHECKSUM(NEWID())) % 100 AS VARCHAR),
        CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CHAR(65 + ABS(CHECKSUM(NEWID())) % 26) + CAST(ABS(CHECKSUM(NEWID())) % 100 AS VARCHAR),
        LOWER(CHAR(97 + ABS(CHECKSUM(NEWID())) % 26) + CHAR(97 + ABS(CHECKSUM(NEWID())) % 26) + CAST(ABS(CHECKSUM(NEWID())) % 9999 AS VARCHAR) + '@example.com'),
        DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 365), '1950-01-01'),
        DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 365), '2010-01-01')
    );

    SET @i = @i + 1;
END;
GO

DECLARE @i INT = 1;
DECLARE @BookID INT;
DECLARE @BorrowerID INT;
WHILE @i <= 1000
BEGIN
    SELECT TOP 1 @BookID = BookID FROM Books Order BY NEWID();
    SELECT TOP 1 @BorrowerID = BorrowerID FROM Borrowers Order BY NEWID();
    

    INSERT INTO Loans(BookID, BorrowerID, DateBorrowed, DueDate, DateReturned)
    VALUES (
        @BookID,
        @BorrowerID,
        DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 365), '2010-01-01'),
        DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 365), '2020-01-01'),
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 
            THEN DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 365), '2021-01-01') 
            ELSE NULL 
        END
    );

    SET @i = @i + 1;
END;
GO