/*
==========================================================
Database : ContosoEnterpriseDW
Purpose  : Enterprise Data Warehouse
Author   : Abhilash Kolla
==========================================================
*/

IF DB_ID('ContosoEnterpriseDW') IS NULL
BEGIN
    CREATE DATABASE ContosoEnterpriseDW;
END;
GO

USE ContosoEnterpriseDW;
GO