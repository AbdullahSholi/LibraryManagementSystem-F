USE LibraryManagementSystem;
GO 

CREATE FUNCTION dbo.fn_BookBorrowingFrequency(@BookID INT)
RETURNS @Result Table(
    ResultBookID INT,
    BorrowedFrequency INT
)
AS 
BEGIN 
    DECLARE @BorrowerID INT
    DECLARE @BookIdParam INT
    
    INSERT INTO @Result
    SELECT 
        books.BookID,
        COUNT(DISTINCT borrowers.BorrowerID) AS BorrowedFrequency
    FROM Books AS books
    INNER JOIN Loans AS loans
    ON books.BookID = loans.BookID
    INNER JOIN Borrowers AS borrowers 
    ON loans.BorrowerID = borrowers.BorrowerID
    WHERE books.BookID = @BookID
    GROUP BY books.BookID;
    
    RETURN;
END 
GO 

SELECT * FROM dbo.fn_BookBorrowingFrequency(1);
