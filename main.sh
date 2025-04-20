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

$BASE_SQLCMD -i 2.activeBorrowersWithCTEs.sql

$BASE_SQLCMD -i 3.borrowingFrequencyUsingWindowFunctions.sql

$BASE_SQLCMD -i 4.popularGenreAnalysisUsingJoinsAndWindowFunctions.sql

$BASE_SQLCMD -i 5.storedProcedure-AddNewBorrowers.sql

$BASE_SQLCMD -i 6.databaseFunction-CalculateOverdueFees.sql

$BASE_SQLCMD -i 7.databaseFunction-BookBorrowingFrequency.sql

$BASE_SQLCMD -i 8.overdueAnalysis.sql

$BASE_SQLCMD -i 9.authorPopularityUsingAggregation.sql

$BASE_SQLCMD -i 10.genrePreferenceByAgeUsingGroupByAndHaving.sql

$BASE_SQLCMD -i 11.storedProcedure-BorrowedBooksReport.sql

$BASE_SQLCMD -i 12.triggerImplementation.sql

$BASE_SQLCMD -i 13.tempTable.sql

$BASE_SQLCMD -i databaseIndexing.sql

$BASE_SQLCMD -i DeleteTablesData.sql


