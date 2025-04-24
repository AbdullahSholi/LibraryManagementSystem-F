IF EXISTS (SELECT name FROM sys.databases WHERE name = N'LibraryManagementSystem')
BEGIN
    ALTER DATABASE [LibraryManagementSystem] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [LibraryManagementSystem];
END   