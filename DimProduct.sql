CREATE TABLE dbo.DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(255),
    UnitPrice DECIMAL(10, 2),
    QuantityPerUnit NVARCHAR(100),
    CategoryName NVARCHAR(255)
);


INSERT INTO dbo.DimProduct (ProductID, ProductName, UnitPrice, QuantityPerUnit, CategoryName)
SELECT
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    p.QuantityPerUnit,
    c.CategoryName
FROM
    Products p
JOIN
    Categories c ON p.CategoryID = c.CategoryID;