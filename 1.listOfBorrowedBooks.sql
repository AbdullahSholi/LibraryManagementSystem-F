USE LibraryManagementSystem;

SELECT loans.LoanID, borrowers.BorrowerID, books. BookID, books.CurrentStatus FROM Borrowers AS borrowers
INNER JOIN Loans as loans
ON borrowers.BorrowerID = loans.BorrowerID
INNER JOIN Books as books
ON books.BookID = loans.BookID
WHERE books.CurrentStatus = 'Borrowed';