INSERT INTO intern.FactSalesQuota_VK (
    SalesQuotaKey,
    DateKey,
    ChannelKey,
    StoreKey,
    ProductKey,
    ScenarioKey,
    SalesQuantityQuota,
    SalesAmountQuota,
    GrossMarginQuota
)
SELECT
    SalesQuotaKey,
    DateKey,
    ChannelKey,
    StoreKey,
    ProductKey,
    ScenarioKey,
    SalesQuantityQuota,
    SalesAmountQuota,
    GrossMarginQuota
FROM intern.vw_FactSalesQuota_VK;
