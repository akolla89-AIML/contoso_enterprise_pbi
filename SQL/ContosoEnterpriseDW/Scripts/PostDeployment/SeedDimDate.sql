PRINT 'Seeding dimension.DimDate...';

IF NOT EXISTS (SELECT 1 FROM [dimension].[DimDate])
BEGIN
    ;WITH DateSequence AS
    (
        SELECT CAST('2015-01-01' AS DATE) AS FullDate

        UNION ALL

        SELECT DATEADD(DAY, 1, FullDate)
        FROM DateSequence
        WHERE FullDate < '2035-12-31'
    )

    INSERT INTO [dimension].[DimDate]
    (
        DateKey,
        FullDate,
        CalendarYear,
        CalendarQuarter,
        MonthNumber,
        MonthName,
        DayOfMonth,
        DayOfWeek,
        DayName,
        IsWeekend
    )

    SELECT

        CONVERT(INT, CONVERT(CHAR(8), FullDate, 112)),

        FullDate,

        YEAR(FullDate),

        DATEPART(QUARTER, FullDate),

        MONTH(FullDate),

        DATENAME(MONTH, FullDate),

        DAY(FullDate),

        DATEPART(WEEKDAY, FullDate),

        DATENAME(WEEKDAY, FullDate),

        CASE
            WHEN DATENAME(WEEKDAY, FullDate) IN ('Saturday','Sunday')
                THEN 1
            ELSE 0
        END

    FROM DateSequence
    OPTION (MAXRECURSION 0);

END
GO