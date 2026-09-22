CREATE VIEW intern.vw_DimChannel_VK AS
    SELECT
        ChannelKey,
        ChannelLabel,
        ChannelName,
        ChannelDescription
    FROM
        dbo.DimChannel
