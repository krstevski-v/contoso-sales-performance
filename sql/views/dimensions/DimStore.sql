CREATE VIEW intern.vw_DimStore_VK AS
    SELECT
        ds.StoreKey,
        ds.StoreName,
        ds.StoreType,
        ds.StoreManager AS StoreManagerID,
        ds.[Status] AS StoreStatus,
        ds.OpenDate,
        ds.CloseDate,
        ds.CloseReason,
        ds.EmployeeCount,
        ds.SellingAreaSize,
        dg.GeographyKey,
        dg.CityName,
        dg.StateProvinceName,
        dg.RegionCountryName,
        dg.ContinentName,
        dst.SalesTerritoryKey,
        dst.SalesTerritoryName,
        dst.SalesTerritoryCountry,
        dst.SalesTerritoryGroup,
        dst.SalesTerritoryManager AS SalesTerritoryManagerID
    FROM
        dbo.DimStore ds
        LEFT JOIN dbo.DimGeography dg
        ON ds.GeographyKey = dg.GeographyKey
        LEFT JOIN dbo.DimSalesTerritory dst
        ON ds.GeographyKey = dst.GeographyKey;
