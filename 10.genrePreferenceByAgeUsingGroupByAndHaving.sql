USE LibraryManagementSystem;

SELECT 
    CASE 
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
        ELSE '60+' 
    END AS AgeGroup,
    books.Genre, 
    COUNT(borrowers.BorrowerID) AS BorrowerCount
FROM Books AS books
INNER JOIN Loans AS loans 
    ON books.BookID = loans.BookID
INNER JOIN Borrowers AS borrowers 
    ON loans.BorrowerID = borrowers.BorrowerID
GROUP BY 
    CASE 
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
        WHEN DATEDIFF(YEAR, borrowers.DateOfBirth, GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
        ELSE '60+' 
    END, 
    books.Genre
HAVING COUNT(borrowers.BorrowerID) > 1
ORDER BY AgeGroup, BorrowerCount DESC;
