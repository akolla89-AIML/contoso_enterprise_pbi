CREATE TABLE [staging].[Store]
(
    StoreAlternateKey NVARCHAR(50) NOT NULL,

    StoreName NVARCHAR(200) NOT NULL,

    StoreType NVARCHAR(50) NULL,

    City NVARCHAR(100) NULL,

    StateProvince NVARCHAR(100) NULL,

    Country NVARCHAR(100) NULL,

    PostalCode NVARCHAR(20) NULL,

    OpenDate DATE NULL,

    IsActive BIT NOT NULL
);
GO