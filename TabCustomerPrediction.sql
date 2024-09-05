CREATE TABLE [Tab_CustomerOrderPred]
(
    [CustomerID] VARCHAR(64),
    [TotalValueOrders] FLOAT,
    [Year] INT,
    [Month] INT,
	[Day]INT,
);


INSERT INTO [Tab_CustomerOrderPred](
    [CustomerID], [TotalValueOrders], [Year], [Month], [Day]
)
SELECT
    fc.CustomerID,
    SUM(fc.TotalValue),
    dd.Year,
    dd.Month,
	dd.Day
FROM
    [FactTable] fc
JOIN [DimDate] dd ON dd.DateID = fc.OrderDateID
GROUP BY
    fc.CustomerID,
    dd.Year,
    dd.Month,
	dd.Day;