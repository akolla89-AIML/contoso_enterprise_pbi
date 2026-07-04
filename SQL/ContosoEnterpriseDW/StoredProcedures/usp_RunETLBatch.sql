CREATE PROCEDURE [dbo].[usp_RunETLBatch]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BatchKey INT;

    ---------------------------------------------------------
    -- Start Batch
    ---------------------------------------------------------
    INSERT INTO metadata.ETLBatch
    (
        BatchName,
        BatchStartTime,
        BatchStatus,
        InitiatedBy
    )
    VALUES
    (
        'Nightly Warehouse Load',
        SYSUTCDATETIME(),
        'Running',
        SUSER_SNAME()
    );

    SET @BatchKey = SCOPE_IDENTITY();

    BEGIN TRY

        ---------------------------------------------------------
        -- Execute ETL Procedures
        ---------------------------------------------------------

        EXEC dbo.usp_LoadDimProduct;

        ---------------------------------------------------------
        -- Mark Success
        ---------------------------------------------------------

        UPDATE metadata.ETLBatch
        SET
            BatchEndTime = SYSUTCDATETIME(),
            BatchStatus = 'Success'
        WHERE ETLBatchKey = @BatchKey;

    END TRY

    BEGIN CATCH

        UPDATE metadata.ETLBatch
        SET
            BatchEndTime = SYSUTCDATETIME(),
            BatchStatus = 'Failure'
        WHERE ETLBatchKey = @BatchKey;

        THROW;

    END CATCH

END;
GO