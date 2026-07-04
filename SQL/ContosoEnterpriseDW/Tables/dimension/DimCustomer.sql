CREATE TABLE [dimension].[DimCustomer]
(
    CustomerKey INT IDENTITY(1,1) NOT NULL,

    CustomerAlternateKey NVARCHAR(50) NOT NULL,

    FirstName NVARCHAR(100) NOT NULL,

    LastName NVARCHAR(100) NOT NULL,

    FullName AS (FirstName + N' ' + LastName) PERSISTED,

    Gender CHAR(1) NULL,

    BirthDate DATE NULL,

    EmailAddress NVARCHAR(255) NULL,

    PhoneNumber NVARCHAR(50) NULL,

    City NVARCHAR(100) NULL,

    StateProvince NVARCHAR(100) NULL,

    Country NVARCHAR(100) NULL,

    PostalCode NVARCHAR(20) NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_DimCustomer_IsActive DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_DimCustomer_CreatedDate
        DEFAULT SYSUTCDATETIME(),

    ModifiedDate DATETIME2 NOT NULL
        CONSTRAINT DF_DimCustomer_ModifiedDate
        DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_DimCustomer
        PRIMARY KEY CLUSTERED (CustomerKey),

    CONSTRAINT UQ_DimCustomer_AlternateKey
        UNIQUE(CustomerAlternateKey)
);
GO