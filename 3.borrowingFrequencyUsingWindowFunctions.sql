USE LibraryManagementSystem;

SELECT 
    Aggregated.BorrowerID,
    Aggregated.TotalNumber,
    RANK() OVER(
        ORDER BY Aggregated.TotalNumber DESC
    ) AS Rank
FROM (
    SELECT borrowers.BorrowerID, COUNT(books.BookID) AS TotalNumber
    FROM 
        Borrowers AS borrowers
        INNER JOIN Loans as loans
        ON borrowers.BorrowerID = loans.BorrowerID
        INNER JOIN Books as books
        ON books.BookID = loans.BookID
    GROUP BY borrowers.BorrowerID
) AS Aggregated