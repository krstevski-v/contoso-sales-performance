INSERT INTO intern.DimChannel_VK (
    ChannelKey,
    ChannelLabel,
    ChannelName,
    ChannelDescription
)
SELECT
    ChannelKey,
    ChannelLabel,
    ChannelName,
    ChannelDescription
FROM intern.vw_DimChannel_VK;
