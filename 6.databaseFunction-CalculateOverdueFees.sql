USE LibraryManagementSystem;
GO 

CREATE FUNCTION dbo.fn_CalculateOverdueFees(@LoanID INT)
RETURNS INT
AS 
BEGIN 
    DECLARE @LoanIdResult INT
    DECLARE @DueDate DATE
    DECLARE @DateReturned DATE
    DECLARE @DayDiff INT 
    
    SELECT 
        @LoanIdResult = loans.LoanID,
        @DueDate = loans.DueDate,
        @DateReturned = loans.DateReturned
    FROM Loans AS loans
    WHERE loans.LoanID = @LoanID AND loans.DateReturned IS NOT NULL;

    SET @DayDiff = DATEDIFF(day, @DueDate, @DateReturned)

    IF @DayDiff > 0 AND @DayDiff <= 30
        RETURN @DayDiff * 1
    ELSE IF @DayDiff >  30
        RETURN 30 + (@DayDiff -30) * 2

    RETURN NULL    
    
END 
GO 

SELECT dbo.fn_CalculateOverdueFees(5) AS OverdueFees;
