PRINT 'Seeding metadata.SourceSystem...';

IF NOT EXISTS (SELECT 1 FROM metadata.SourceSystem)
BEGIN

    INSERT INTO metadata.SourceSystem
    (
        SourceSystemCode,
        SourceSystemName,
        SourceType
    )
    VALUES
    ('CSV', 'CSV Import', 'File'),
    ('ERP', 'Contoso ERP', 'Database'),
    ('CRM', 'Contoso CRM', 'Database'),
    ('API', 'Product REST API', 'API');

END;
GO