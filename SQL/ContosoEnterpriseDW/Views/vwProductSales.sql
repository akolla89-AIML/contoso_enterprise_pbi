CREATE VIEW [dbo].[vwProductSales]
AS

SELECT

    p.ProductAlternateKey,

    p.ProductName,

    p.ProductCategory,

    p.ProductSubcategory,

    p.Brand,

    COUNT(*) AS NumberOfSales,

    SUM(f.OrderQuantity) AS TotalQuantity,

    SUM(f.SalesAmount) AS TotalSales,

    SUM(f.DiscountAmount) AS TotalDiscount,

    SUM(f.TotalProductCost) AS TotalCost,

    SUM(f.ProfitAmount) AS TotalProfit,

    AVG(f.UnitPrice) AS AverageSellingPrice

FROM fact.FactSales AS f

INNER JOIN dimension.DimProduct AS p
    ON f.ProductKey = p.ProductKey

GROUP BY

    p.ProductAlternateKey,

    p.ProductName,

    p.ProductCategory,

    p.ProductSubcategory,

    p.Brand;
GO