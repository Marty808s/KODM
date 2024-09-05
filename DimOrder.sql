DROP TABLE IF EXISTS dbo.DimOrder
CREATE TABLE dbo.DimOrder (
    OrderID INT
);

INSERT INTO dbo.DimOrder (OrderID)
SELECT DISTINCT
    O.OrderID
FROM
    Orders AS o;
