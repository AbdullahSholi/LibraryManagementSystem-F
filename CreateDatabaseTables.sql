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