CREATE TABLE intern.DimScenario_VK (
    ScenarioKey INT PRIMARY KEY,
    ScenarioLabel NVARCHAR(100) NOT NULL,
    ScenarioName NVARCHAR(20),
    ScenarioDescription NVARCHAR(50),

    ETL_LoadTime DATETIME DEFAULT GETUTCDATE()
);
