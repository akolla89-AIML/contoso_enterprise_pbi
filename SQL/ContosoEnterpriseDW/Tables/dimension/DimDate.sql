
CREATE TABLE [dimension].[DimDate]
(
    [DateKey]           INT             NOT NULL,
    [FullDate]          DATE            NOT NULL,
    [CalendarYear]      SMALLINT        NOT NULL,
    [CalendarQuarter]   TINYINT         NOT NULL,
    [MonthNumber]       TINYINT         NOT NULL,
    [MonthName]         NVARCHAR(20)    NOT NULL,
    [DayOfMonth]        TINYINT         NOT NULL,
    [DayOfWeek]         TINYINT         NOT NULL,
    [DayName]           NVARCHAR(20)    NOT NULL,
    [IsWeekend]         BIT             NOT NULL,

    CONSTRAINT [PK_DimDate]
        PRIMARY KEY CLUSTERED ([DateKey] ASC),
    CONSTRAINT [UQ_DimDate_FullDate]
        UNIQUE NONCLUSTERED ([FullDate])
);
GO