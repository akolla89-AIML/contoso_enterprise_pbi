PRINT 'Seeding staging.Store...';

TRUNCATE TABLE [staging].[Store];

INSERT INTO [staging].[Store]
(
    StoreAlternateKey,
    StoreName,
    StoreType,
    City,
    StateProvince,
    Country,
    PostalCode,
    OpenDate,
    IsActive
)
VALUES
('STORE001', 'Seattle Downtown', 'Retail', 'Seattle', 'Washington', 'USA', '98101', '2018-01-15', 1),

('STORE002', 'Bellevue Mall', 'Retail', 'Bellevue', 'Washington', 'USA', '98004', '2019-06-10', 1),

('STORE003', 'Dallas Central', 'Retail', 'Dallas', 'Texas', 'USA', '75201', '2017-03-22', 1),

('STORE004', 'Phoenix West', 'Retail', 'Phoenix', 'Arizona', 'USA', '85001', '2020-09-05', 1),

('STORE005', 'Miami Beach', 'Retail', 'Miami', 'Florida', 'USA', '33101', '2021-04-12', 1);
GO