#!/bin/bash
echo "Hello from Bash on WSL!"
sqlcmd -S 192.168.1.104,1433 -U testuser -P 'Sholi@971' <<EOF


IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'LibraryManagementSystem')
BEGIN 
    CREATE DATABASE LibraryManagementSystem;
END;
GO

USE LibraryManagementSystem;
GO 

IF OBJECT_ID('Borrowers', 'U') IS NULL
BEGIN
    CREATE TABLE Borrowers (
        BorrowerID INT PRIMARY KEY IDENTITY(1,1),
        FirstName VARCHAR(50) NOT NULL,
        LastName VARCHAR(50) NOT NULL,
        Email VARCHAR(50) NOT NULL,
        DateOfBirth DATE NOT NULL,
        MembershipDate Date NOT NULL
    );
END;
GO

IF OBJECT_ID('Books', 'U') IS NULL
BEGIN
    CREATE TABLE Books (
        BookID INT PRIMARY KEY IDENTITY(1,1),
        Title VARCHAR(50) NOT NULL,
        Author VARCHAR(50) NOT NULL,
        ISBN VARCHAR(17) NOT NULL,
        PublishedDate DATE NOT NULL,
        Genre VARCHAR(50) NOT NULL,
        ShelfLocation VARCHAR(50) NOT NULL,
        CurrentStatus VARCHAR(50) NOT NULL CHECK (CurrentStatus IN('Available', 'Borrowed'))
    );
END;
GO

IF OBJECT_ID('Loans', 'U') IS NULL
BEGIN
    CREATE TABLE Loans (
        LoanID INT PRIMARY KEY IDENTITY(1,1),
        BookID INT NOT NULL,
        BorrowerID INT NOT NULL,
        DateBorrowed DATE NOT NULL,
        DueDate DATE NOT NULL,
        DateReturned DATE,
        FOREIGN KEY(BookID) REFERENCES Books(BookID),
        FOREIGN KEY(BorrowerID) REFERENCES Borrowers(BorrowerID)
    );
END;
GO

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


DELETE FROM Loans;
DELETE FROM Books;
DELETE FROM Borrowers;

