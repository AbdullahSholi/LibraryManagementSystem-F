USE LibraryManagementSystem;

-- Solution (1)
SELECT 
    books.Author, 
    COUNT(borrowers.BorrowerID) AS TotalBorrowCount,
    RANK() OVER(ORDER BY COUNT(borrowers.BorrowerID) DESC) AS Rank
FROM Books AS books
INNER JOIN Loans AS loans
    ON books.BookID = loans.BookID
INNER JOIN Borrowers AS borrowers 
    ON loans.BorrowerID = borrowers.BorrowerID
GROUP BY books.Author
ORDER BY Rank; 

-- Solution (2)
-- SELECT books.Author, COUNT(borrowers.BorrowerID) AS TotalBorrowCount
-- FROM Books AS books
-- INNER JOIN Loans AS loans
-- ON books.BookID = loans.BookID
-- INNER JOIN Borrowers AS borrowers 
-- ON loans.BorrowerID = borrowers.BorrowerID
-- GROUP BY books.Author
-- ORDER BY TotalBorrowCount DESC;