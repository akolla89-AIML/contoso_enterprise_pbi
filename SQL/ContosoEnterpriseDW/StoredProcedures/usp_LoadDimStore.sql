CREATE PROCEDURE [dbo].[usp_LoadDimStore]
    @ETLBatchKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExecutionStartTime DATETIME2 = SYSUTCDATETIME();
    DECLARE @RowsInserted INT = 0;
    DECLARE @RowsUpdated INT = 0;

    BEGIN TRY

        ------------------------------------------------------------
        -- Insert New Stores
        ------------------------------------------------------------
        INSERT INTO dimension.DimStore
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
        SELECT
            s.StoreAlternateKey,
            s.StoreName,
            s.StoreType,
            s.City,
            s.StateProvince,
            s.Country,
            s.PostalCode,
            s.OpenDate,
            s.IsActive
        FROM staging.Store s
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dimension.DimStore d
            WHERE d.StoreAlternateKey = s.StoreAlternateKey
        );

        SET @RowsInserted = @@ROWCOUNT;

        ------------------------------------------------------------
        -- Type 1 SCD Updates
        ------------------------------------------------------------
        UPDATE d
        SET
            d.StoreName = s.StoreName,
            d.StoreType = s.StoreType,
            d.City = s.City,
            d.StateProvince = s.StateProvince,
            d.Country = s.Country,
            d.PostalCode = s.PostalCode,
            d.OpenDate = s.OpenDate,
            d.IsActive = s.IsActive,
            d.ModifiedDate = SYSUTCDATETIME()
        FROM dimension.DimStore d
        INNER JOIN staging.Store s
            ON d.StoreAlternateKey = s.StoreAlternateKey
        WHERE
               ISNULL(d.StoreName,'') <> ISNULL(s.StoreName,'')
            OR ISNULL(d.StoreType,'') <> ISNULL(s.StoreType,'')
            OR ISNULL(d.City,'') <> ISNULL(s.City,'')
            OR ISNULL(d.StateProvince,'') <> ISNULL(s.StateProvince,'')
            OR ISNULL(d.Country,'') <> ISNULL(s.Country,'')
            OR ISNULL(d.PostalCode,'') <> ISNULL(s.PostalCode,'')
            OR ISNULL(d.OpenDate,'19000101') <> ISNULL(s.OpenDate,'19000101')
            OR ISNULL(d.IsActive,0) <> ISNULL(s.IsActive,0);

        SET @RowsUpdated = @@ROWCOUNT;

        ------------------------------------------------------------
        -- Audit Success
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
            'dbo.usp_LoadDimStore',
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
            'dbo.usp_LoadDimStore',
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