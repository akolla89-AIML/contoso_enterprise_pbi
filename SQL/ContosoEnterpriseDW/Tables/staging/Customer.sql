CREATE TABLE [staging].[Customer]
(
    CustomerAlternateKey NVARCHAR(50) NOT NULL,

    FirstName NVARCHAR(100) NOT NULL,

    LastName NVARCHAR(100) NOT NULL,

    Gender CHAR(1) NULL,

    BirthDate DATE NULL,

    EmailAddress NVARCHAR(255) NULL,

    PhoneNumber NVARCHAR(50) NULL,

    City NVARCHAR(100) NULL,

    StateProvince NVARCHAR(100) NULL,

    Country NVARCHAR(100) NULL,

    PostalCode NVARCHAR(20) NULL,

    IsActive BIT NOT NULL
);
GO