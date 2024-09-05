DROP TABLE IF EXISTS dbo.FactTable
CREATE TABLE dbo.FactTable (
    OrderID INT,
    CustomerID NVARCHAR(255),
    EmployeeID INT,
    ShipVia INT,
    OrderDateID NVARCHAR(8),
	ProductIDs NVARCHAR(MAX),
	TotalValue MONEY
);

INSERT INTO dbo.FactTable (
    OrderID, CustomerID, EmployeeID, ShipVia, OrderDateID, ProductIDs, TotalValue
)
SELECT
    o.OrderID,
    o.CustomerID,
    o.EmployeeID,
    o.ShipVia,
    CONVERT(NVARCHAR(8), dd1.DateID) AS OrderDateID,
	STRING_AGG(CAST(od.ProductID AS NVARCHAR(10)), ', ') AS ProductIDs,
	SUM(od.Quantity * p.UnitPrice) AS TotalValues

FROM
    Orders AS o
LEFT JOIN [Order Details] AS od ON od.OrderID = o.OrderID
LEFT JOIN [Products] AS p ON p.ProductID = od.ProductID
LEFT JOIN DimDate AS dd1 ON dd1.Date = o.OrderDate
GROUP BY
    o.OrderID,
    o.CustomerID,
    o.EmployeeID,
    o.ShipVia,
    dd1.DateID;