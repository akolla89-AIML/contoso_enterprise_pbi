CREATE PROCEDURE [dbo].[usp_LoadDimProduct]
    @ETLBatchKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExecutionStartTime DATETIME2 = SYSUTCDATETIME();
    DECLARE @RowsInserted INT = 0;
    DECLARE @RowsUpdated INT = 0;

    BEGIN TRY

        ------------------------------------------------------------
        -- Insert New Products
        ------------------------------------------------------------
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

        SET @RowsInserted = @@ROWCOUNT;

        ------------------------------------------------------------
        -- Update Existing Products (Type 1 SCD)
        ------------------------------------------------------------
        UPDATE d
        SET
            d.ProductName = s.ProductName,
            d.ProductCategory = s.ProductCategory,
            d.ProductSubcategory = s.ProductSubcategory,
            d.Brand = s.Brand,
            d.Color = s.Color,
            d.Size = s.Size,
            d.StandardCost = s.StandardCost,
            d.ListPrice = s.ListPrice,
            d.IsActive = s.IsActive,
            d.ModifiedDate = SYSUTCDATETIME()
        FROM dimension.DimProduct d
        INNER JOIN staging.Product s
            ON d.ProductAlternateKey = s.ProductAlternateKey
        WHERE
               ISNULL(d.ProductName,'') <> ISNULL(s.ProductName,'')
            OR ISNULL(d.ProductCategory,'') <> ISNULL(s.ProductCategory,'')
            OR ISNULL(d.ProductSubcategory,'') <> ISNULL(s.ProductSubcategory,'')
            OR ISNULL(d.Brand,'') <> ISNULL(s.Brand,'')
            OR ISNULL(d.Color,'') <> ISNULL(s.Color,'')
            OR ISNULL(d.Size,'') <> ISNULL(s.Size,'')
            OR ISNULL(d.StandardCost,0) <> ISNULL(s.StandardCost,0)
            OR ISNULL(d.ListPrice,0) <> ISNULL(s.ListPrice,0)
            OR ISNULL(d.IsActive,0) <> ISNULL(s.IsActive,0);

        SET @RowsUpdated = @@ROWCOUNT;

        ------------------------------------------------------------
        -- Audit Log
        ------------------------------------------------------------
        INSERT INTO audit.ETLExecutionLog
        (
            ETLBatchKey,
            ProcedureName,
            ExecutionStartTime,
            ExecutionEndTime,
            RowsInserted,
            RowsUpdated,
            ExecutionStatus,
            ErrorMessage
        )
        VALUES
        (
            @ETLBatchKey,
            'dbo.usp_LoadDimProduct',
            @ExecutionStartTime,
            SYSUTCDATETIME(),
            @RowsInserted,
            @RowsUpdated,
            'Success',
            NULL
        );

    END TRY

    BEGIN CATCH

        INSERT INTO audit.ETLExecutionLog
        (
            ETLBatchKey,
            ProcedureName,
            ExecutionStartTime,
            ExecutionEndTime,
            RowsInserted,
            RowsUpdated,
            ExecutionStatus,
            ErrorMessage
        )
        VALUES
        (
            @ETLBatchKey,
            'dbo.usp_LoadDimProduct',
            @ExecutionStartTime,
            SYSUTCDATETIME(),
            @RowsInserted,
            @RowsUpdated,
            'Failure',
            ERROR_MESSAGE()
        );

        THROW;

    END CATCH

END;
GO