USE LibraryManagementSystem;
GO

CREATE PROCEDURE sp_BorrowedBooksReport
    @StartDate Date,
    @EndDate Date
AS
BEGIN
    SELECT books.BookID, books.Title, books.Author, borrowers.BorrowerID, borrowers.FirstName, loans.DateBorrowed 
    FROM Books AS books
    INNER JOIN Loans AS loans 
        ON books.BookID = loans.BookID
    INNER JOIN Borrowers AS borrowers 
        ON loans.BorrowerID = borrowers.BorrowerID
    WHERE loans.DateBorrowed >= @StartDate AND loans.DateBorrowed <= @EndDate
    ORDER BY loans.DateBorrowed ASC;
END;
GO

EXEC sp_BorrowedBooksReport 
    @StartDate = '2010-01-01',
    @EndDate = '2010-03-01'
GO
