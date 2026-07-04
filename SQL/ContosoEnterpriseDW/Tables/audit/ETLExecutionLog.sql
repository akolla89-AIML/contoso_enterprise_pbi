CREATE TABLE [audit].[ETLExecutionLog]
(
    ETLExecutionLogKey INT IDENTITY(1,1) NOT NULL,

    ProcedureName NVARCHAR(200) NOT NULL,

    ExecutionStartTime DATETIME2 NOT NULL,

    ExecutionEndTime DATETIME2 NOT NULL,

    RowsInserted INT NOT NULL,

    RowsUpdated INT NOT NULL,

    ExecutionStatus NVARCHAR(20) NOT NULL,

    ErrorMessage NVARCHAR(MAX) NULL,

    CONSTRAINT PK_ETLExecutionLog
        PRIMARY KEY CLUSTERED (ETLExecutionLogKey)
);
GO