CREATE VIEW intern.vw_FactSalesQuota_VK AS
    SELECT
        SalesQuotaKey,
        CAST(DateKey AS DATE) AS DateKey,
        ChannelKey,
        StoreKey,
        ProductKey,
        ScenarioKey,
        SalesQuantityQuota,
        SalesAmountQuota,
        GrossMarginQuota
    FROM
        dbo.FactSalesQuota
    WHERE
        ScenarioKey IN (2,3)
