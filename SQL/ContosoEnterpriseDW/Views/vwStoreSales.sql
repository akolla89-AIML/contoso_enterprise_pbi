CREATE VIEW [dbo].[vwStoreSales]
AS

SELECT

    s.StoreAlternateKey,

    s.StoreName,

    s.StoreType,

    s.City,

    s.StateProvince,

    s.Country,

    COUNT(*) AS NumberOfSales,

    SUM(f.OrderQuantity) AS TotalQuantity,

    SUM(f.SalesAmount) AS TotalSales,

    SUM(f.DiscountAmount) AS TotalDiscount,

    SUM(f.TotalProductCost) AS TotalCost,

    SUM(f.ProfitAmount) AS TotalProfit,

    AVG(f.SalesAmount) AS AverageSaleAmount

FROM fact.FactSales AS f

INNER JOIN dimension.DimStore AS s
    ON f.StoreKey = s.StoreKey

GROUP BY

    s.StoreAlternateKey,

    s.StoreName,

    s.StoreType,

    s.City,

    s.StateProvince,

    s.Country;
GO