CREATE TABLE dbo.DimShippers (
    ShipperID INT PRIMARY KEY,
    CompanyName NVARCHAR(255),
    Phone NVARCHAR(50)
);

INSERT INTO dbo.DimShippers (ShipperID, CompanyName, Phone)
SELECT
    ShipperID,
    CompanyName,
    Phone
FROM
    Shippers;