/*==============================================================
  Dimension Lookup Indexes
==============================================================*/

CREATE UNIQUE NONCLUSTERED INDEX IX_DimProduct_ProductAlternateKey
ON dimension.DimProduct(ProductAlternateKey);
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_DimCustomer_CustomerAlternateKey
ON dimension.DimCustomer(CustomerAlternateKey);
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_DimStore_StoreAlternateKey
ON dimension.DimStore(StoreAlternateKey);
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_DimDate_FullDate
ON dimension.DimDate(FullDate);
GO

/*==============================================================
  Fact Table Reporting Indexes
==============================================================*/

CREATE NONCLUSTERED INDEX IX_FactSales_DateKey
ON fact.FactSales(DateKey);
GO

CREATE NONCLUSTERED INDEX IX_FactSales_ProductKey
ON fact.FactSales(ProductKey);
GO

CREATE NONCLUSTERED INDEX IX_FactSales_CustomerKey
ON fact.FactSales(CustomerKey);
GO

CREATE NONCLUSTERED INDEX IX_FactSales_StoreKey
ON fact.FactSales(StoreKey);
GO