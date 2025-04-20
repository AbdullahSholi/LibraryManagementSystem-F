USE LibraryManagementSystem;
GO

-- Create Indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Books_Current_Status' AND object_id = OBJECT_ID('Books'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Books_Current_Status
    ON Books (CurrentStatus);
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Books_Published_Date' AND object_id = OBJECT_ID('Books'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Books_Published_Date
    ON Books (PublishedDate);
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Borrowers_Composite_Date' AND object_id = OBJECT_ID('Borrowers'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Borrowers_Composite_Date
    ON Borrowers (DateOfBirth, MembershipDate);
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Borrowers_First_Name_Partial_Index' AND object_id = OBJECT_ID('Borrowers'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Borrowers_First_Name_Partial_Index
    ON Loans(LEFT(FirstName, 2));
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Loans_Borrowers_History' AND object_id = OBJECT_ID('Loans'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Loans_Borrowers_History
    ON Loans (BorrowerID, DateBorrowed DESC);
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Loans_Active_Loans' AND object_id = OBJECT_ID('Loans'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Loans_Active_Loans
    ON Loans (DateReturned)
    WHERE DateReturned IS NULL;
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Loans_BorrowerID_BookID' AND object_id = OBJECT_ID('Loans'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Loans_BorrowerID_BookID
    ON Loans(BorrowerID, BookID);
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Loans_Overdue' AND object_id = OBJECT_ID('Loans'))
BEGIN
    CREATE NONCLUSTERED INDEX IX_Loans_Overdue
    ON Loans(DueDate)
    INCLUDE (DateReturned)
    WHERE DateReturned IS NULL;
END;

SELECT 
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_unique,
    i.is_primary_key,
    i.is_unique_constraint,
    c.name AS ColumnName,
    ic.is_descending_key,
    ic.key_ordinal
FROM sys.indexes i
INNER JOIN sys.index_columns ic
    ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN sys.columns c
    ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE i.object_id = OBJECT_ID('dbo.Books') OR i.object_id = OBJECT_ID('dbo.Loans') OR i.object_id = OBJECT_ID('dbo.Borrowers')
ORDER BY i.name, ic.key_ordinal;