CREATE TABLE intern.DimChannel_VK (
    ChannelKey INT PRIMARY KEY,
    ChannelLabel NVARCHAR(10) NOT NULL,
    ChannelName NVARCHAR(20),
    ChannelDescription NVARCHAR(50),

    ETL_LoadTime DATETIME DEFAULT GETUTCDATE()

);
