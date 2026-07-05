CREATE VIEW [dbo].[vwCustomerSales]
AS

SELECT

    c.CustomerAlternateKey,

    c.FullName,

    c.Gender,

    c.City,

    c.StateProvince,

    c.Country,

    COUNT(*) AS NumberOfSales,

    SUM(f.OrderQuantity) AS TotalQuantity,

    SUM(f.SalesAmount) AS TotalSales,

    SUM(f.DiscountAmount) AS TotalDiscount,

    SUM(f.TotalProductCost) AS TotalCost,

    SUM(f.ProfitAmount) AS TotalProfit,

    AVG(f.SalesAmount) AS AverageOrderValue

FROM fact.FactSales AS f

INNER JOIN dimension.DimCustomer AS c
    ON f.CustomerKey = c.CustomerKey

GROUP BY

    c.CustomerAlternateKey,

    c.FullName,

    c.Gender,

    c.City,

    c.StateProvince,

    c.Country;
GO