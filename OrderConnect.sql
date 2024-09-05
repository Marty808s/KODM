CREATE TABLE dbo.OrderConnect (
    OrderID INT,
    OrderDate DATE,
    ProductID INT,
    ProductName NVARCHAR(255)
);

INSERT INTO dbo.OrderConnect (OrderID, OrderDate, ProductID, ProductName)
SELECT
    o.OrderID,
    o.OrderDate,
    p.ProductID,
    p.ProductName
FROM
    Orders o
JOIN
    [Order Details] od ON o.OrderID = od.OrderID
JOIN
    Products p ON od.ProductID = p.ProductID;