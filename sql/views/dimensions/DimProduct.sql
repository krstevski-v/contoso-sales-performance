CREATE VIEW intern.vw_DimProduct_VK AS
    SELECT
        dp.ProductKey,
        dp.ProductName,
        dpc.ProductCategoryKey,
        dpc.ProductCategoryName,
        dps.ProductSubcategoryKey,
        dps.ProductSubcategoryName,
        dp.Manufacturer,
        dp.BrandName,
        dp.ClassName,
        dp.StyleName,
        dp.ColorName,
        dp.[Size] AS ProductSize,
        dp.SizeRange AS ProductSizeRange,
        dp.UnitOfMeasureName,
        dp.StockTypeName,
        dp.UnitCost,
        dp.UnitPrice,
        dp.AvailableForSaleDate,
        dp.StopSaleDate,
        dp.[Status] AS ProductStatus
    FROM
        dbo.DimProduct dp
        LEFT JOIN dbo.DimProductSubcategory dps
        ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
        LEFT JOIN dbo.DimProductCategory dpc
        ON dps.ProductCategoryKey = dpc.ProductCategoryKey;
