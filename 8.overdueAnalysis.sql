USE LibraryManagementSystem;

SELECT 
    books.BookID,
    books.Title,
    borrowers.BorrowerID,
    borrowers.FirstName,
    DATEDIFF(day, loans.DueDate, loans.DateReturned) AS Overdue
FROM Books AS books
INNER JOIN Loans AS loans
ON books.BookID = loans.BookID
INNER JOIN Borrowers AS borrowers 
ON loans.BorrowerID = borrowers.BorrowerID
WHERE DATEDIFF(day, loans.DueDate, loans.DateReturned) > 30 AND loans.DateReturned IS NOT NULL
ORDER BY books.BookID;