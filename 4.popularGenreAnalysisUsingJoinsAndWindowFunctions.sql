USE LibraryManagementSystem;

-- Solution (1)
SELECT TOP 1 MONTH(loans.DateBorrowed) AS Month ,COUNT(books.Genre) AS "Numbers of Books"
FROM Books AS books
INNER JOIN Loans AS loans
ON books.BookID = loans.BookID
GROUP BY MONTH(loans.DateBorrowed)
ORDER BY COUNT(books.Genre) DESC;

-- Solution (2)
SELECT TOP 1 MONTH(Aggregated.DateBorrowed) AS "Month",
    COUNT(Aggregated.Genre)
    OVER(
        PARTITION BY MONTH(Aggregated.DateBorrowed)
    ) AS result
FROM (
    SELECT books.Genre, loans.DateBorrowed
    FROM Books AS books
    INNER JOIN Loans AS loans
    ON books.BookID = loans.BookID
) AS Aggregated
ORDER BY result DESC
  