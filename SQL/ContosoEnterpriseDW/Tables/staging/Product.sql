CREATE TABLE [staging].[Product]
(
    ProductAlternateKey NVARCHAR(50) NOT NULL,

    ProductName NVARCHAR(200) NOT NULL,

    ProductCategory NVARCHAR(100) NULL,

    ProductSubcategory NVARCHAR(100) NULL,

    Brand NVARCHAR(100) NULL,

    Color NVARCHAR(50) NULL,

    Size NVARCHAR(50) NULL,

    StandardCost DECIMAL(18,2) NULL,

    ListPrice DECIMAL(18,2) NULL,

    IsActive BIT NOT NULL
);
GO