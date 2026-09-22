CREATE TABLE intern.DimStore_VK (
    StoreKey INT PRIMARY KEY,
    StoreName NVARCHAR(100) NOT NULL,
    StoreType NVARCHAR(15),
    StoreManagerID INT,
    StoreStatus NVARCHAR(20),
    OpenDate DATE,
    CloseDate DATE,
    CloseReason NVARCHAR(20),
    EmployeeCount INT,
    SellingAreaSize FLOAT,

    GeographyKey INT,
    CityName NVARCHAR(100),
    StateProvinceName NVARCHAR(100),
    RegionCountryName NVARCHAR(100),
    ContinentName NVARCHAR(50) NOT NULL,

    SalesTerritoryKey INT NOT NULL,
    SalesTerritoryName NVARCHAR(50) NOT NULL,
    SalesTerritoryCountry NVARCHAR(50) NOT NULL,
    SalesTerritoryGroup NVARCHAR(50),
    SalesTerritoryManagerID INT,

    ETL_LoadTime DATETIME DEFAULT GETUTCDATE()
);
