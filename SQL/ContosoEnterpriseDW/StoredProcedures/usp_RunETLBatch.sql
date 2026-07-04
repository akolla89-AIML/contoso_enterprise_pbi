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

        EXEC dbo.usp_LoadDimProduct
            @ETLBatchKey = @BatchKey;

        EXEC dbo.usp_LoadDimCustomer
            @ETLBatchKey = @BatchKey;
        ---------------------------------------------------------
        -- Complete Batch
        ---------------------------------------------------------
        UPDATE metadata.ETLBatch
        SET
            BatchEndTime = SYSUTCDATETIME(),
            BatchStatus = 'Success'
        WHERE ETLBatchKey = @BatchKey;

    END TRY

    BEGIN CATCH

        ---------------------------------------------------------
        -- Mark Batch Failed
        ---------------------------------------------------------
        UPDATE metadata.ETLBatch
        SET
            BatchEndTime = SYSUTCDATETIME(),
            BatchStatus = 'Failure'
        WHERE ETLBatchKey = @BatchKey;

        THROW;

    END CATCH

END;
GO