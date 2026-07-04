PRINT 'Seeding staging.Customer...';

TRUNCATE TABLE [staging].[Customer];

INSERT INTO [staging].[Customer]
(
    CustomerAlternateKey,
    FirstName,
    LastName,
    Gender,
    BirthDate,
    EmailAddress,
    PhoneNumber,
    City,
    StateProvince,
    Country,
    PostalCode,
    IsActive
)
VALUES
('CUST000001', 'John', 'Smith', 'M', '1985-03-15', 'john.smith@contoso.com', '(206)555-0101', 'Seattle', 'Washington', 'USA', '98101', 1),

('CUST000002', 'Sarah', 'Johnson', 'F', '1990-07-22', 'sarah.johnson@contoso.com', '(425)555-0102', 'Bellevue', 'Washington', 'USA', '98004', 1),

('CUST000003', 'Michael', 'Brown', 'M', '1978-11-08', 'michael.brown@contoso.com', '(972)555-0103', 'Dallas', 'Texas', 'USA', '75201', 1),

('CUST000004', 'Emily', 'Davis', 'F', '1995-01-30', 'emily.davis@contoso.com', '(602)555-0104', 'Phoenix', 'Arizona', 'USA', '85001', 1),

('CUST000005', 'David', 'Wilson', 'M', '1982-09-18', 'david.wilson@contoso.com', '(305)555-0105', 'Miami', 'Florida', 'USA', '33101', 1);
GO