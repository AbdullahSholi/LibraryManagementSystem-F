USE LibraryManagementSystem;
GO

CREATE PROCEDURE sp_GetOverdueBooks
AS 
BEGIN
    CREATE TABLE #OverdueBorrowers(
        BorrowerID INT
    );

    INSERT INTO #OverdueBorrowers(BorrowerID)
        SELECT DISTINCT BorrowerID
        FROM Loans
        WHERE DueDate < GETDATE() AND DateReturned IS NULL;

    SELECT loans.BorrowerID, loans.BookID, loans.DueDate
    FROM Loans loans 
    INNER JOIN #OverdueBorrowers AS o 
        ON loans.BorrowerID = o.BorrowerID
    WHERE loans.DueDate < GETDATE() AND loans.DateReturned IS NULL
    ORDER BY BorrowerID;

END;
GO

EXEC sp_GetOverdueBooks;