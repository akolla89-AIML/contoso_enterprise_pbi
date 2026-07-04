PRINT 'Seeding staging.Product...';

TRUNCATE TABLE [staging].[Product];

INSERT INTO [staging].[Product]
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
VALUES
('BK-M68B-38', 'Mountain Bike 38', 'Bikes', 'Mountain Bikes', 'Contoso', 'Black', '38', 1250.00, 1999.99, 1),

('BK-M68B-42', 'Mountain Bike 42', 'Bikes', 'Mountain Bikes', 'Contoso', 'Black', '42', 1250.00, 1999.99, 1),

('HL-U509', 'Sport Helmet', 'Accessories', 'Helmets', 'Contoso', 'Red', 'M', 25.00, 49.99, 1),

('GL-100', 'Cycling Gloves', 'Accessories', 'Gloves', 'Contoso', 'Black', 'L', 12.00, 24.99, 1),

('TJ-001', 'Trail Jersey', 'Clothing', 'Jerseys', 'Contoso', 'Blue', 'XL', 35.00, 69.99, 1);
GO