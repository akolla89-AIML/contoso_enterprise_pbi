CREATE VIEW [dbo].[vwSales]
AS
SELECT
    f.SalesKey,

    d.FullDate,

    p.ProductName,
    p.ProductCategory,
    p.Brand,

    c.FullName,
    c.City AS CustomerCity,
    c.StateProvince AS CustomerState,

    s.StoreName,
    s.City AS StoreCity,
    s.StateProvince AS StoreState,

    f.OrderQuantity,
    f.UnitPrice,
    f.UnitCost,
    f.SalesAmount,
    f.DiscountAmount,
    f.TotalProductCost,
    f.ProfitAmount

FROM fact.FactSales AS f

INNER JOIN dimension.DimDate AS d
    ON f.DateKey = d.DateKey

INNER JOIN dimension.DimProduct AS p
    ON f.ProductKey = p.ProductKey

INNER JOIN dimension.DimCustomer AS c
    ON f.CustomerKey = c.CustomerKey

INNER JOIN dimension.DimStore AS s
    ON f.StoreKey = s.StoreKey;
GO