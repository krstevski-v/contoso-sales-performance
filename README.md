# Contoso Sales Performance Analysis

## Overview

This project is an end-to-end Business Intelligence solution built with **SQL Server** and **Power BI** to analyze Contoso sales performance against planned and expected results.

The report focuses on two core business metrics:

- **Sales Amount**
- **Sales Quantity**

These metrics are evaluated across three business scenarios:

- **Actual** — realized business performance
- **Target** — the planned business objective (`Budget` in the source data)
- **Forecast** — the expected business outcome

The main analytical goal is to determine whether actual performance is above or below Target and Forecast, and then identify the **territories, stores, products, and channels** contributing most to those results.


## Business Questions

The solution was designed to answer questions such as:

- Are Actual Sales and Quantity above or below Target and Forecast?
- Which territories contribute most to overall performance variance?
- Which stores are the strongest and weakest performers?
- Which product categories and individual products drive the largest positive or negative differences?
- How do sales channels rank over time?
- Are there noticeable seasonal patterns by channel?
- How does current-year performance compare with the previous year?


## Solution Architecture

The project separates source data, SQL transformation logic, reporting tables, the Power BI semantic model, and the final report.

```text
Contoso Source Database
        |
        v
SQL Reporting Views
        |
        v
Physical Reporting Tables
        |
        v
Power BI Semantic Model
        |
        v
DAX Measures & Business Logic
        |
        v
Interactive Report Pages
```

This approach keeps transformation logic outside the visualization layer and allows Power BI to connect only to reporting-ready tables.


## Data Preparation

### Source tables

The reporting layer was built from the following Contoso source tables:

- `dbo.FactSales`
- `dbo.FactSalesQuota`
- `dbo.DimStore`
- `dbo.DimGeography`
- `dbo.DimSalesTerritory`
- `dbo.DimProduct`
- `dbo.DimProductSubcategory`
- `dbo.DimProductCategory`
- `dbo.DimChannel`
- `dbo.DimScenario`

Source objects that were not required for the reporting scope were excluded.

### SQL reporting layer

The SQL preparation process follows this structure:

```text
Source Tables
    -> Reporting Views
    -> Reporting Tables
```

The views perform the required transformation and flattening, while the physical reporting tables act as the final SQL layer consumed by Power BI.

Key design choices included:

- retaining the original business keys;
- selecting only attributes required for reporting;
- flattening normalized dimensions where appropriate;
- separating actual sales from planning/scenario data;
- keeping detailed Actual data instead of pre-aggregating it in SQL.


## Data Model

The Power BI model is a **fact constellation (galaxy schema)** containing two fact tables that share conformed dimensions.

### Fact tables

#### `FactSales`

`FactSales` is the authoritative source for Actual Sales and Quantity.

Its original detailed grain was preserved rather than being aggregated to month level in SQL. Power BI measures therefore aggregate Actual values dynamically according to the active filter context.

This allows analysis by:

- date;
- month;
- quarter;
- year;
- store;
- territory;
- product;
- channel.

#### `FactSalesQuota`

`FactSalesQuota` contains monthly planning and scenario values.

Its grain is:

```text
Month + Channel + Store + Product + Scenario
```

The reporting version includes:

- **Budget**, presented in the report as **Target**
- **Forecast**

The source Actual scenario was excluded from the reporting fact because Actual performance is calculated from `FactSales`.

### Why two fact tables?

The two facts represent different business processes and different grains.

Combining them into a single table would require either:

1. aggregating Actual Sales to monthly level and losing lower-level analytical detail; or
2. repeating monthly quota values across detailed sales rows, creating a risk of double-counting.

For that reason, the facts remain separate and are compared through shared dimensions.

### Dimensions

The model contains the following core dimensions:

- **Date**
- **Store**
- **Product**
- **Channel**
- **Scenario**

The relationship pattern is:

```text
Date        1 ---- * FactSales
Date        1 ---- * FactSalesQuota

DimStore    1 ---- * FactSales
DimStore    1 ---- * FactSalesQuota

DimProduct  1 ---- * FactSales
DimProduct  1 ---- * FactSalesQuota

DimChannel  1 ---- * FactSales
DimChannel  1 ---- * FactSalesQuota

DimScenario 1 ---- * FactSalesQuota
```

The fact tables are **not directly related to each other**.

---

## Dimension Design

### Store dimension

Geography and sales-territory attributes were flattened into the Store dimension to avoid unnecessary snowflaking.

The reporting dimension includes attributes such as:

- Store
- Store Type
- City
- Country
- Continent
- Sales Territory
- Store Status

### Product dimension

Product Category and Product Subcategory were flattened into the Product dimension.

The resulting table contains attributes such as:

- Product
- Product Category
- Product Subcategory
- Manufacturer
- Brand
- Color
- Class
- Style
- Size

This structure produces a cleaner semantic model and simplifies filtering in Power BI.

---

## Core Measures

### Actual values

```DAX
Actual Sales =
SUM(FactSales[SalesAmount])
```

```DAX
Actual Quantity =
SUM(FactSales[SalesQuantity])
```

### Dynamic metric selection

A disconnected selector allows users to switch between Sales and Quantity without duplicating visuals.

```DAX
Selected Metric =
SELECTEDVALUE(
    'Metric Selector'[Metric],
    "Sales"
)
```

```DAX
Selected Actual Value =
SWITCH(
    [Selected Metric],
    "Quantity", [Actual Quantity],
    [Actual Sales]
)
```

### Dynamic scenario selection

Users can dynamically compare Actual values against either Target or Forecast.

```DAX
Selected Scenario =
SELECTEDVALUE(
    'Scenario Selector'[Scenario],
    "Target"
)
```

```DAX
Selected Scenario Value =
SWITCH(
    TRUE(),
    [Selected Metric] = "Sales"
        && [Selected Scenario] = "Target", [Target Sales],

    [Selected Metric] = "Sales"
        && [Selected Scenario] = "Forecast", [Forecast Sales],

    [Selected Metric] = "Quantity"
        && [Selected Scenario] = "Target", [Target Quantity],

    [Selected Metric] = "Quantity"
        && [Selected Scenario] = "Forecast", [Forecast Quantity],

    [Target Sales]
)
```

### Variance

```DAX
Selected Variance =
[Selected Actual Value]
    - [Selected Scenario Value]
```

```DAX
Selected Variance % =
DIVIDE(
    [Selected Variance],
    [Selected Scenario Value]
)
```

Variance percentage therefore answers:

> How far above or below the selected benchmark did Actual performance finish?

---

## Time Intelligence

The report also contains time-intelligence measures for previous-year and YTD analysis.

Examples include:

```DAX
Selected Actual PY =
CALCULATE(
    [Selected Actual Value],
    SAMEPERIODLASTYEAR('Date'[Date])
)
```

```DAX
Selected Actual YoY Change % =
DIVIDE(
    [Selected Actual Value] - [Selected Actual PY],
    [Selected Actual PY]
)
```

```DAX
Selected Actual YTD =
TOTALYTD(
    [Selected Actual Value],
    'Date'[Date]
)
```

Because the available dataset begins in 2007, prior-year values are not available for that year.

---

## Report Pages

### 1. Home

An executive landing page containing headline KPI cards for:

- Actual Sales
- Sales Target
- Sales Forecast
- Actual Quantity
- Quantity Target
- Quantity Forecast

The page is designed to provide a quick summary before deeper analysis.

### 2. Performance Overview

Provides a broad comparison of Actual performance against the selected scenario.

The page supports:

- Sales / Quantity switching;
- Target / Forecast switching;
- time filtering;
- territory comparison;
- product-category comparison;
- channel comparison;
- Actual vs Scenario analysis over time.

### 3. Territory & Store Performance

Focuses on geographic performance and store-level analysis.

Key features include:

- geographic performance visualization;
- territory-level Actual vs Scenario comparison;
- store ranking;
- store-level variance analysis;
- matrix-based detail;
- Store Detail drillthrough.

### 4. Product Performance

Focuses on product and portfolio performance.

The page includes:

- Product Category comparisons;
- product rankings;
- Top 5 positive/negative variance analysis;
- dynamic ranking based on the selected metric and scenario;
- Product Detail drillthrough.

The Top 5 difference analysis evaluates each product using its **net variance within the current filter context**.

### 5. Channel Trends & Performance

Focuses on how performance is distributed across sales channels.

The page includes:

- a ribbon chart showing channel ranking over time;
- a monthly seasonality heatmap.

The heatmap measures each month's contribution to the selected channel's annual Actual performance.

---

## Interactive Features

The report includes several interactive elements designed to improve usability:

- dynamic Metric selector;
- dynamic Scenario selector;
- Year / Quarter / Month filtering;
- report-page navigation;
- cross-filtering between visuals;
- dynamic chart titles;
- conditional formatting;
- Top N ranking;
- positive/negative variance selection;
- Store and Product drillthrough pages;
- store-ranking pagination;
- matrix heatmaps;
- report tooltips.

---

## Validation

The solution was validated at both SQL and Power BI levels.

Validation checks included:

- source-to-reporting row counts;
- duplicate primary-key checks;
- null-key checks;
- orphan foreign-key checks;
- scenario record counts;
- date-range validation;
- reconciliation of Actual Sales and Quantity;
- reconciliation of Target and Forecast values;
- dimensional checks across Territory, Store, Product, and Channel;
- verification of selector and ranking behavior.

The purpose of validation was to ensure that transformations and semantic-model relationships did not alter the intended business totals.

---

## Assumptions and Limitations

- The available reporting period is **2007–2009**.
- Actual data is available at a detailed daily level, while Target and Forecast values are available at **monthly grain**.
- Actual-vs-Scenario comparisons are therefore intended for **month level or higher**.
- Monthly quota values are not distributed across individual days.
- The source `Budget` scenario is presented to users as **Target**.
- Target and Forecast quotas are treated as source-provided planning inputs. Their original business calculation methodology is not available in the dataset.
- All relevant source records use the same currency key, so no currency conversion was applied.
- Prior-year measures are blank for 2007 because 2006 data is not available.
- The report does not attempt to reconstruct or recalculate the original Target or Forecast methodology.

---


## Screenshots


### Home

```text
docs/images/01_home.png
```

### Performance Overview

```text
docs/images/02_overview.png
```

### Territory & Store Performance

```text
docs/images/03_territories-stores.png
```

### Product Performance

```text
docs/images/04_products.png
```

### Channel Trends & Performance

```text
docs/images/05_channels.png
```

