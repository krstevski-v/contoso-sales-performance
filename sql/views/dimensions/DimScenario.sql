CREATE VIEW intern.vw_DimScenario_VK AS
    SELECT
        ScenarioKey,
        ScenarioLabel,
        ScenarioName,
        ScenarioDescription
    FROM
        dbo.DimScenario
    WHERE
        ScenarioKey IN (2, 3); -- 2 = Budget/Target, 3 = Forecast
