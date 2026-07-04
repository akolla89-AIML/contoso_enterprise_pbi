CREATE TABLE [metadata].[ETLBatch]
(
    ETLBatchKey INT IDENTITY(1,1) NOT NULL,

    BatchName NVARCHAR(200) NOT NULL,

    BatchStartTime DATETIME2 NOT NULL,

    BatchEndTime DATETIME2 NULL,

    BatchStatus NVARCHAR(20) NOT NULL,

    InitiatedBy NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_ETLBatch
        PRIMARY KEY CLUSTERED (ETLBatchKey)
);
GO