CREATE TABLE [audit].[ETLExecutionLog]
(
    ETLExecutionLogKey INT IDENTITY(1,1) NOT NULL,

    ETLBatchKey INT NOT NULL,

    ProcedureName NVARCHAR(200) NOT NULL,

    ExecutionStartTime DATETIME2 NOT NULL,

    ExecutionEndTime DATETIME2 NOT NULL,

    RowsInserted INT NOT NULL,

    RowsUpdated INT NOT NULL,

    ExecutionStatus NVARCHAR(20) NOT NULL,

    ErrorMessage NVARCHAR(MAX) NULL,

    CONSTRAINT PK_ETLExecutionLog
        PRIMARY KEY CLUSTERED (ETLExecutionLogKey),

    CONSTRAINT FK_ETLExecutionLog_ETLBatch
    FOREIGN KEY (ETLBatchKey)
    REFERENCES metadata.ETLBatch (ETLBatchKey)
);
GO