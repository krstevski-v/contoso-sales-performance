CREATE TABLE intern.DimProduct_VK (
    ProductKey INT PRIMARY KEY,
    ProductName NVARCHAR(500),

    ProductCategoryKey INT NOT NULL,
    ProductCategoryName NVARCHAR(100),

    ProductSubcategoryKey INT NOT NULL,
    ProductSubcategoryName NVARCHAR(50),

    Manufacturer NVARCHAR(50),
    BrandName NVARCHAR(50),
    ClassName NVARCHAR(20),
    StyleName NVARCHAR(20),
    ColorName NVARCHAR(20),
    ProductSize NVARCHAR(50),
    ProductSizeRange NVARCHAR(50),
    UnitOfMeasureName NVARCHAR(40),
    StockTypeName NVARCHAR(40),

    UnitCost DECIMAL(10,4),
    UnitPrice DECIMAL(10,4),

    AvailableForSaleDate DATE,
    StopSaleDate DATE,
    ProductStatus NVARCHAR(7),

    ETL_LoadTime DATETIME DEFAULT GETUTCDATE()
);
