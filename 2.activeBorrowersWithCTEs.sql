USE LibraryManagementSystem;

WITH ActiveBorrowers_CTE AS(
    SELECT borrowers.BorrowerID, COUNT(books.BookID) AS "Number of books"
    FROM Borrowers AS borrowers
    INNER JOIN Loans as loans
    ON borrowers.BorrowerID = loans.BorrowerID
    INNER JOIN Books as books
    ON books.BookID = loans.BookID
    WHERE loans.DateReturned IS NULL
    GROUP BY borrowers.BorrowerID
    HAVING COUNT(books.BookID) >= 2 
)
SELECT * FROM ActiveBorrowers_CTE;