CREATE TABLE [dimension].[DimStore]
(
    StoreKey INT IDENTITY(1,1) NOT NULL,

    StoreAlternateKey NVARCHAR(50) NOT NULL,

    StoreName NVARCHAR(200) NOT NULL,

    StoreType NVARCHAR(50) NULL,

    City NVARCHAR(100) NULL,

    StateProvince NVARCHAR(100) NULL,

    Country NVARCHAR(100) NULL,

    PostalCode NVARCHAR(20) NULL,

    OpenDate DATE NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_DimStore_IsActive DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_DimStore_CreatedDate
        DEFAULT SYSUTCDATETIME(),

    ModifiedDate DATETIME2 NOT NULL
        CONSTRAINT DF_DimStore_ModifiedDate
        DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_DimStore
        PRIMARY KEY CLUSTERED (StoreKey),

    CONSTRAINT UQ_DimStore_AlternateKey
        UNIQUE (StoreAlternateKey)
);
GO