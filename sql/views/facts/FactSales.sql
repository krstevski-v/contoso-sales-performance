CREATE VIEW intern.vw_FactSales_VK AS
    SELECT
        SalesKey,
        CAST(DateKey AS DATE) AS DateKey,
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
    FROM
        dbo.FactSales
