DROP TABLE IF EXISTS dbo.DimEmployees;
CREATE TABLE dbo.DimEmployees (
    EmployeeID INT PRIMARY KEY,
    Title NVARCHAR(255),
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    Country NVARCHAR(255),
    TerritoryName NVARCHAR(MAX),  
    RegionName NVARCHAR(MAX)  
);

WITH EmployeeRegion AS (
    SELECT 
        em.EmployeeID, 
        em.Title, 
        em.FirstName, 
        em.LastName, 
        em.Country,
        te.TerritoryDescription,
        reg.RegionDescription,
        ROW_NUMBER() OVER(PARTITION BY em.EmployeeID ORDER BY reg.RegionDescription) AS rn
    FROM dbo.Employees AS em
    JOIN dbo.EmployeeTerritories AS et ON et.EmployeeID = em.EmployeeID
    JOIN dbo.Territories AS te ON te.TerritoryID = et.TerritoryID
    JOIN dbo.Region AS reg ON te.RegionID = reg.RegionID
)
INSERT INTO dbo.DimEmployees (EmployeeID, Title, FirstName, LastName, Country, TerritoryName, RegionName)
SELECT 
    em.EmployeeID, 
    em.Title, 
    em.FirstName, 
    em.LastName, 
    em.Country, 
    STRING_AGG(te.TerritoryDescription, ', ') AS TerritoryName,
    er.RegionDescription
FROM dbo.Employees AS em
JOIN dbo.EmployeeTerritories AS et ON et.EmployeeID = em.EmployeeID
JOIN dbo.Territories AS te ON te.TerritoryID = et.TerritoryID
JOIN (SELECT EmployeeID, RegionDescription FROM EmployeeRegion WHERE rn = 1) AS er
    ON em.EmployeeID = er.EmployeeID
GROUP BY em.EmployeeID, em.Title, em.FirstName, em.LastName, em.Country, er.RegionDescription;
