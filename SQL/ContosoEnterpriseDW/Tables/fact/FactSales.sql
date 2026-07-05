CREATE TABLE [fact].[FactSales]
(
    SalesKey BIGINT IDENTITY(1,1) NOT NULL,

    DateKey INT NOT NULL,

    ProductKey INT NOT NULL,

    CustomerKey INT NOT NULL,

    StoreKey INT NOT NULL,

    SalesOrderNumber NVARCHAR(50) NOT NULL,

    SalesOrderLineNumber INT NOT NULL,

    OrderQuantity INT NOT NULL,

    UnitPrice DECIMAL(18,2) NOT NULL,

    UnitCost DECIMAL(18,2) NOT NULL,

    SalesAmount DECIMAL(18,2) NOT NULL,

    DiscountAmount DECIMAL(18,2) NOT NULL
        CONSTRAINT DF_FactSales_DiscountAmount DEFAULT (0),

    TotalProductCost AS (OrderQuantity * UnitCost) PERSISTED,

    ProfitAmount AS (SalesAmount - DiscountAmount - (OrderQuantity * UnitCost)) PERSISTED,

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_FactSales_CreatedDate
        DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_FactSales
        PRIMARY KEY CLUSTERED (SalesKey),
CONSTRAINT UQ_FactSales_OrderLine
UNIQUE
(
    SalesOrderNumber,
    SalesOrderLineNumber
),

    CONSTRAINT FK_FactSales_DimDate
        FOREIGN KEY (DateKey)
        REFERENCES dimension.DimDate(DateKey),

    CONSTRAINT FK_FactSales_DimProduct
        FOREIGN KEY (ProductKey)
        REFERENCES dimension.DimProduct(ProductKey),

    CONSTRAINT FK_FactSales_DimCustomer
        FOREIGN KEY (CustomerKey)
        REFERENCES dimension.DimCustomer(CustomerKey),

    CONSTRAINT FK_FactSales_DimStore
        FOREIGN KEY (StoreKey)
        REFERENCES dimension.DimStore(StoreKey)
);
GO