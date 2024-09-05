DROP TABLE IF EXISTS dbo.DimDate
CREATE TABLE DimDate (
    DateID CHAR(8) PRIMARY KEY,
    Date DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT,
    MonthName VARCHAR(20),
    DayOfWeek INT,
    WeekOfYear INT
);

DECLARE @MinDate DATE, @MaxDate DATE;

SELECT 
    @MinDate = MIN(OrderDate),
    @MaxDate = MAX(ShippedDate)
FROM 
    Orders;

-- Generování všech dat mezi @MinDate a @MaxDate
;WITH DateRange AS (
    SELECT @MinDate AS Date
    UNION ALL
    SELECT DATEADD(DAY, 1, Date)
    FROM DateRange 
    WHERE Date < @MaxDate
)
INSERT INTO DimDate (DateID, Date, Year, Quarter, Month, Day, MonthName, DayOfWeek, WeekOfYear)
SELECT
    CONVERT(VARCHAR, Date, 112) AS DateID,  -- Formát YYYYMMDD
    Date,
    YEAR(Date) AS Year,
    DATEPART(QUARTER, Date) AS Quarter,
    MONTH(Date) AS Month,
    DAY(Date) AS Day,
    DATENAME(MONTH, Date) AS MonthName,
    DATEPART(WEEKDAY, Date) AS DayOfWeek,
    DATEPART(WEEK, Date) AS WeekOfYear
FROM
    DateRange
OPTION (MAXRECURSION 0);  -- Toto umožní neomezenou rekurzi v CTE