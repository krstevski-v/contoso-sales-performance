INSERT INTO intern.DimScenario_VK (
    ScenarioKey,
    ScenarioLabel,
    ScenarioName,
    ScenarioDescription
)
SELECT
    ScenarioKey,
    ScenarioLabel,
    ScenarioName,
    ScenarioDescription
FROM intern.vw_DimScenario_VK;
