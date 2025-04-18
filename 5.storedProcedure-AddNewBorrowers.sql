USE LibraryManagementSystem;
GO

CREATE PROCEDURE sp_AddNewBorrower
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(50),
    @DateOfBirth Date,
    @MembershipDate Date
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Borrowers WHERE Email = @Email)
    BEGIN
        PRINT 'Borrower with this email already exists.';
    End
    ELSE
    BEGIN
        INSERT INTO Borrowers(FirstName, LastName, Email, DateOfBirth, MembershipDate)
        VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);
    END
END;
GO

EXEC sp_AddNewBorrower 
    @FirstName = 'Abdullah',
    @LastName = 'Sholi',
    @Email = 'abdullah.ghassan.sholi@gmail.com',
    @DateOfBirth = '2004-01-01',
    @MembershipDate = '2024-05-05';
GO
