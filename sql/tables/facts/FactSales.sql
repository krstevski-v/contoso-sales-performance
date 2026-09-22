CREATE TABLE intern.FactSales_VK (
    SalesKey INT PRIMARY KEY,
    DateKey DATE NOT NULL,
    ChannelKey INT NOT NULL,
    StoreKey INT NOT NULL,
    ProductKey INT NOT NULL,
    SalesQuantity INT NOT NULL,
    ReturnQuantity INT NOT NULL,
    ReturnAmount DECIMAL(18,4),
    DiscountQuantity INT,
    DiscountAmount DECIMAL(18,4),
    TotalCost DECIMAL(18,4) NOT NULL,
    SalesAmount DECIMAL(19,4) NOT NULL,
    ETL_LoadTime DATETIME DEFAULT GETUTCDATE(),
    CONSTRAINT FK_FactSales_DimChannel FOREIGN KEY(ChannelKey) REFERENCES intern.DimChannel_VK(ChannelKey),
    CONSTRAINT FK_FactSales_DimStore FOREIGN KEY(StoreKey) REFERENCES intern.DimStore_VK(StoreKey),
    CONSTRAINT FK_FactSales_DimProduct FOREIGN KEY(ProductKey) REFERENCES intern.DimProduct_VK(ProductKey)
);
