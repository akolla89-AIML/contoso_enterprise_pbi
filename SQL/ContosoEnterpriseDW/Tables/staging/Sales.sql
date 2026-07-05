CREATE TABLE [staging].[Sales]
(
    SalesOrderNumber NVARCHAR(50) NOT NULL,

    SalesOrderLineNumber INT NOT NULL,

    OrderDate DATE NOT NULL,

    ProductAlternateKey NVARCHAR(50) NOT NULL,

    CustomerAlternateKey NVARCHAR(50) NOT NULL,

    StoreAlternateKey NVARCHAR(50) NOT NULL,

    OrderQuantity INT NOT NULL,

    UnitPrice DECIMAL(18,2) NOT NULL,

    UnitCost DECIMAL(18,2) NOT NULL,

    DiscountAmount DECIMAL(18,2) NOT NULL
        CONSTRAINT DF_StagingSales_DiscountAmount DEFAULT (0)
);
GO