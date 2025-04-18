#!/bin/bash
SERVER_IPv4="192.168.1.104"
PORT="1433"
USER_NAME="testuser"
PASSWORD="Sholi@971"

BASE_SQLCMD="sqlcmd -S ${SERVER_IPv4},${PORT} -U ${USER_NAME} -P ${PASSWORD}"

$BASE_SQLCMD -i DropDatabase.sql

$BASE_SQLCMD -i CreateDatabase.sql 

$BASE_SQLCMD -i CreateDatabaseTables.sql

$BASE_SQLCMD -i SeedDatabaseTables.sql

$BASE_SQLCMD -i 1.listOfBorrowedBooks.sql

$BASE_SQLCMD -i DeleteTablesData.sql

