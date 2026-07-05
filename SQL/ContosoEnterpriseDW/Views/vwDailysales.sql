CREATE VIEW [dbo].[vwDailySales]
AS

SELECT

    d.FullDate,

    COUNT(*) AS NumberOfSales,

    SUM(f.OrderQuantity) AS TotalQuantity,

    SUM(f.SalesAmount) AS TotalSales,

    SUM(f.DiscountAmount) AS TotalDiscount,

    SUM(f.TotalProductCost) AS TotalCost,

    SUM(f.ProfitAmount) AS TotalProfit

FROM fact.FactSales f

INNER JOIN dimension.DimDate d
    ON f.DateKey = d.DateKey

GROUP BY

    d.FullDate;
GO