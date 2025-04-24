IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'LibraryManagementSystem')
BEGIN 
    CREATE DATABASE LibraryManagementSystem;
END;
GO