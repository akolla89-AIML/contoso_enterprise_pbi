/*
==========================================================
Database : ContosoEnterpriseDW
Purpose  : Enterprise Data Warehouse
Author   : Abhilash K
==========================================================
*/

IF DB_ID('ContosoEnterpriseDW') IS NULL
BEGIN
    CREATE DATABASE ContosoEnterpriseDW;
END;
GO

USE ContosoEnterpriseDW;
GO