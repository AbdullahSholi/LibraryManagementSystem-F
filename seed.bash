#!/bin/bash
echo "Hello from Bash on WSL!"
sqlcmd -S 192.168.1.104,1433 -U testuser -P 'Sholi@971' <<EOF
# <<EOF for prevent sqlcmd works interactively ( To make it works in background ) 

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

IF OBJECT_ID('Borrowers', 'U') IS NULL
BEGIN
    CREATE TABLE Books (
        BookID INT PRIMARY KEY IDENTITY(1,1),
        Title VARCHAR(50) NOT NULL,
        Author VARCHAR(50) NOT NULL,
        ISBN VARCHAR(17) NOT NULL,
        PublishedData DATE NOT NULL,
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
        DataBorrowed DATE NOT NULL,
        DueDate DATE NOT NULL,
        DateReturned DATE NOT NULL,
        FOREIGN KEY(BookID) REFERENCES Books(BookID),
        FOREIGN KEY(BorrowerID) REFERENCES Borrowers(BorrowerID)
    );
END;
GO

