CREATE PROCEDURE [dbo].[usp_LoadDimCustomer]
    @ETLBatchKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExecutionStartTime DATETIME2 = SYSUTCDATETIME();
    DECLARE @RowsInserted INT = 0;
    DECLARE @RowsUpdated INT = 0;

    BEGIN TRY

        ------------------------------------------------------------
        -- Insert New Customers
        ------------------------------------------------------------
        INSERT INTO dimension.DimCustomer
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
        SELECT
            s.CustomerAlternateKey,
            s.FirstName,
            s.LastName,
            s.Gender,
            s.BirthDate,
            s.EmailAddress,
            s.PhoneNumber,
            s.City,
            s.StateProvince,
            s.Country,
            s.PostalCode,
            s.IsActive
        FROM staging.Customer s
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM dimension.DimCustomer d
            WHERE d.CustomerAlternateKey = s.CustomerAlternateKey
        );

        SET @RowsInserted = @@ROWCOUNT;

        ------------------------------------------------------------
        -- Update Existing Customers (Type 1 SCD)
        ------------------------------------------------------------
        UPDATE d
        SET
            d.FirstName = s.FirstName,
            d.LastName = s.LastName,
            d.Gender = s.Gender,
            d.BirthDate = s.BirthDate,
            d.EmailAddress = s.EmailAddress,
            d.PhoneNumber = s.PhoneNumber,
            d.City = s.City,
            d.StateProvince = s.StateProvince,
            d.Country = s.Country,
            d.PostalCode = s.PostalCode,
            d.IsActive = s.IsActive,
            d.ModifiedDate = SYSUTCDATETIME()
        FROM dimension.DimCustomer d
        INNER JOIN staging.Customer s
            ON d.CustomerAlternateKey = s.CustomerAlternateKey
        WHERE
               ISNULL(d.FirstName,'') <> ISNULL(s.FirstName,'')
            OR ISNULL(d.LastName,'') <> ISNULL(s.LastName,'')
            OR ISNULL(d.Gender,'') <> ISNULL(s.Gender,'')
            OR ISNULL(d.BirthDate,'19000101') <> ISNULL(s.BirthDate,'19000101')
            OR ISNULL(d.EmailAddress,'') <> ISNULL(s.EmailAddress,'')
            OR ISNULL(d.PhoneNumber,'') <> ISNULL(s.PhoneNumber,'')
            OR ISNULL(d.City,'') <> ISNULL(s.City,'')
            OR ISNULL(d.StateProvince,'') <> ISNULL(s.StateProvince,'')
            OR ISNULL(d.Country,'') <> ISNULL(s.Country,'')
            OR ISNULL(d.PostalCode,'') <> ISNULL(s.PostalCode,'')
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
            'dbo.usp_LoadDimCustomer',
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
            'dbo.usp_LoadDimCustomer',
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