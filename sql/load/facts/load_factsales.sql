INSERT INTO intern.FactSales_VK (
    SalesKey,
    DateKey,
    ChannelKey,
    StoreKey,
    ProductKey,
    SalesQuantity,
    ReturnQuantity,
    ReturnAmount,
    DiscountQuantity,
    DiscountAmount,
    TotalCost,
    SalesAmount
)
SELECT
    SalesKey,
    DateKey,
    ChannelKey,
    StoreKey,
    ProductKey,
    SalesQuantity,
    ReturnQuantity,
    ReturnAmount,
    DiscountQuantity,
    DiscountAmount,
    TotalCost,
    SalesAmount
FROM intern.vw_FactSales_VK;
