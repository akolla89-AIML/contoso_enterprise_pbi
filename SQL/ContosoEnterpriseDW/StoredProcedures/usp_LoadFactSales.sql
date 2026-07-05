CREATE PROCEDURE [dbo].[usp_LoadFactSales]
    @ETLBatchKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExecutionStartTime DATETIME2 = SYSUTCDATETIME();
    DECLARE @RowsInserted INT = 0;

    BEGIN TRY

        INSERT INTO fact.FactSales
        (
            DateKey,
            ProductKey,
            CustomerKey,
            StoreKey,
            SalesOrderNumber,
            SalesOrderLineNumber,
            OrderQuantity,
            UnitPrice,
            UnitCost,
            SalesAmount,
            DiscountAmount
        )
        SELECT

            d.DateKey,

            p.ProductKey,

            c.CustomerKey,

            st.StoreKey,

            s.SalesOrderNumber,

            s.SalesOrderLineNumber,

            s.OrderQuantity,

            s.UnitPrice,

            s.UnitCost,

            s.OrderQuantity * s.UnitPrice,

            s.DiscountAmount

        FROM staging.Sales s

        INNER JOIN dimension.DimDate d
            ON d.FullDate = s.OrderDate

        INNER JOIN dimension.DimProduct p
            ON p.ProductAlternateKey = s.ProductAlternateKey

        INNER JOIN dimension.DimCustomer c
            ON c.CustomerAlternateKey = s.CustomerAlternateKey

        INNER JOIN dimension.DimStore st
            ON st.StoreAlternateKey = s.StoreAlternateKey

        WHERE NOT EXISTS
        (
            SELECT 1
            FROM fact.FactSales f
            WHERE
                f.SalesOrderNumber = s.SalesOrderNumber
            AND f.SalesOrderLineNumber = s.SalesOrderLineNumber
        );

        SET @RowsInserted = @@ROWCOUNT;

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
            'dbo.usp_LoadFactSales',
            @ExecutionStartTime,
            SYSUTCDATETIME(),
            @RowsInserted,
            0,
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
            'dbo.usp_LoadFactSales',
            @ExecutionStartTime,
            SYSUTCDATETIME(),
            @RowsInserted,
            0,
            'Failure',
            ERROR_MESSAGE()
        );

        THROW;

    END CATCH

END;
GO