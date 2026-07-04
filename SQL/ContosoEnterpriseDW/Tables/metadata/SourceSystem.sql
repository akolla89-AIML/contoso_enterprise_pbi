CREATE TABLE [metadata].[SourceSystem]
(
    SourceSystemKey INT IDENTITY(1,1) NOT NULL,

    SourceSystemCode NVARCHAR(50) NOT NULL,

    SourceSystemName NVARCHAR(200) NOT NULL,

    SourceType NVARCHAR(50) NOT NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_SourceSystem_IsActive DEFAULT (1),

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_SourceSystem_CreatedDate
        DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_SourceSystem
        PRIMARY KEY CLUSTERED (SourceSystemKey),

    CONSTRAINT UQ_SourceSystem_Code
        UNIQUE (SourceSystemCode)
);
GO