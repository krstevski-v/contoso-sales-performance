CREATE TABLE intern.FactSalesQuota_VK (
    SalesQuotaKey INT PRIMARY KEY,
    DateKey DATE NOT NULL,
    ChannelKey INT NOT NULL,
    StoreKey INT NOT NULL,
    ProductKey INT NOT NULL,
    ScenarioKey INT NOT NULL,
    SalesQuantityQuota DECIMAL(19,4) NOT NULL,
    SalesAmountQuota DECIMAL(19,4) NOT NULL,
    GrossMarginQuota DECIMAL(19,4) NOT NULL,
    ETL_LoadTime DATETIME DEFAULT GETUTCDATE(),
    CONSTRAINT FK_FactSalesQuota_DimChannel FOREIGN KEY(ChannelKey) REFERENCES intern.DimChannel_VK(ChannelKey),
    CONSTRAINT FK_FactSalesQuota_DimStore FOREIGN KEY(StoreKey) REFERENCES intern.DimStore_VK(StoreKey),
    CONSTRAINT FK_FactSalesQuota_DimProduct FOREIGN KEY(ProductKey) REFERENCES intern.DimProduct_VK(ProductKey),
    CONSTRAINT FK_FactSalesQuota_DimScenario FOREIGN KEY(ScenarioKey) REFERENCES intern.DimScenario_VK(ScenarioKey)
);
