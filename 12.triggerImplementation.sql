USE LibraryManagementSystem;
GO 

CREATE TABLE AuditLog(
    AuditID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT,
    OldStatus VARCHAR(50),
    NewStatus VARCHAR(50),
    ChangeDate DATETIME DEFAULT GETDATE()
);
GO 

CREATE TRIGGER BookAvailabilityTracker
ON Books
AFTER UPDATE
AS 
BEGIN
    INSERT INTO AuditLog(BookID, OldStatus, NewStatus)
    SELECT 
        d.BookID,
        d.CurrentStatus AS OldStatus,
        i.CurrentStatus AS NewStatus
    FROM DELETED AS d
    JOIN INSERTED AS i ON d.BookID = i.BookID
    WHERE d.CurrentStatus <> i.CurrentStatus 
        AND (
            (d.CurrentStatus = 'Available' AND i.CurrentStatus = 'Borrowed') OR 
            (d.CurrentStatus = 'Borrowed' AND i.CurrentStatus = 'Available')
        );
END;
GO

UPDATE Books SET CurrentStatus = 'Available' WHERE BookID = 1;
UPDATE Books SET CurrentStatus = 'Available' WHERE BookID = 2;
UPDATE Books SET CurrentStatus = 'Available' WHERE BookID = 3;
UPDATE Books SET CurrentStatus = 'Available' WHERE BookID = 4;

SELECT * FROM AuditLog;