USE ContosoEnterpriseDW;
GO

CREATE TABLE dimension.DimCustomer
(
    CustomerKey INT IDENTITY(1,1) NOT NULL,

    CustomerID NVARCHAR(30) NOT NULL,

    CustomerName NVARCHAR(200) NOT NULL,

    City NVARCHAR(100),

    StateProvince NVARCHAR(100),

    Country NVARCHAR(100),

    CustomerSegment NVARCHAR(100),

    EffectiveDate DATE NOT NULL,

    ExpirationDate DATE NOT NULL,

    IsCurrent BIT NOT NULL,

    CONSTRAINT PK_DimCustomer
        PRIMARY KEY CLUSTERED (CustomerKey)
);