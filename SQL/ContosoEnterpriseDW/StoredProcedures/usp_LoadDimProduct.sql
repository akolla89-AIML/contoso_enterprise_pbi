CREATE PROCEDURE [dbo].[usp_LoadDimProduct]
AS
BEGIN
    SET NOCOUNT ON;

    -----------------------------------------------------------------
    -- Insert new products
    -----------------------------------------------------------------

    INSERT INTO [dimension].[DimProduct]
    (
        ProductAlternateKey,
        ProductName,
        ProductCategory,
        ProductSubcategory,
        Brand,
        Color,
        Size,
        StandardCost,
        ListPrice,
        IsActive
    )
    SELECT
        s.ProductAlternateKey,
        s.ProductName,
        s.ProductCategory,
        s.ProductSubcategory,
        s.Brand,
        s.Color,
        s.Size,
        s.StandardCost,
        s.ListPrice,
        s.IsActive
    FROM staging.Product s
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM dimension.DimProduct d
        WHERE d.ProductAlternateKey = s.ProductAlternateKey
    );

END;
GO