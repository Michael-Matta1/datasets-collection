# Global Economic, Environmental, Health, and Social Indicators Dataset

A comprehensive dataset merging global economic, environmental, technological, and human development indicators from 2000 to 2020, sourced and transformed from multiple public datasets via Google BigQuery.

## 📊 Dataset Overview

This dataset offers a harmonized view of global development across more than 40 key indicators spanning over two decades (2000–2020). It supports research across multiple domains including economic growth, climate sustainability, digital transformation, public health, human development, and resilience governance.

### Key Statistics
- **Temporal Coverage**: 2000–2020
- **Geographic Scope**: Global (identified by ISO country codes)
- **Indicators**: 40+ key development metrics
- **Data Sources**: World Bank WDI, NOAA GSOD, COVID-19 Open Data

## 🌍 Geographic and Temporal Scope

- **Countries**: Global coverage with ISO country codes
- **Regions**: Includes regional classifications and income groups
- **Time Period**: 21 years of data (2000-2020)
- **Special Features**: Pandemic period indicators for COVID-19 analysis

## 📈 Key Feature Groups

### Economic Indicators
- GDP (USD), GDP per capita
- Foreign Direct Investment (FDI), inflation, unemployment
- Economic growth and opportunity indices

### Environmental Indicators
- CO₂ emissions and intensity metrics
- Renewable energy consumption
- Forest area coverage
- Green transition scores
- Ecological preservation indices

### Technology & Connectivity
- Internet usage and mobile subscriptions
- Digital readiness and connectivity indices

### Health & Education
- Life expectancy and child mortality
- School enrollment rates
- Healthcare capacity and expenditure
- Health development ratios

### Governance & Resilience
- Government effectiveness and corruption control
- Political stability indicators
- Global resilience scores
- Climate vulnerability indices

## 🔧 Data Sources

The dataset combines data from several Google BigQuery public datasets:

1. **World Bank World Development Indicators (WDI)**
   - `bigquery-public-data.world_bank_wdi.indicators_data`
   - `bigquery-public-data.world_bank_wdi.country_summary`

2. **NOAA Global Surface Summary of the Day (GSOD)**
   - `bigquery-public-data.noaa_gsod.gsod20*`
   - `bigquery-public-data.noaa_gsod.stations`

3. **COVID-19 Open Data**
   - `bigquery-public-data.covid19_open_data.covid19_open_data`

## 📋 Files in This Repository

- **`worldbank_climate_covid_analysis.sql`**: Complete SQL query used to generate the dataset
- **`about-dataset.md`**: Detailed dataset description and column definitions
- **`sources.md`**: Comprehensive list of data sources
- **`Methodology_and_Data_Sources_for_Indices.pdf`**: Detailed methodology documentation (see note below)

## 📚 Methodology Documentation

The file `Methodology_and_Data_Sources_for_Indices.pdf` was created in response to a user inquiry email requesting detailed information about the calculation methods and data sources for key composite indices in the dataset, specifically:

- Climate Vulnerability Index
- Ecological Preservation Index  
- Green Transition Score
- Global Resilience Score

This document provides complete formulas, data sources, and methodological explanations for these indices. It has been uploaded to this repository in hopes that it will provide valuable additional information for anyone working with these metrics or seeking to understand their construction.

### Key Composite Indices Formulas

**Climate Vulnerability Index:**
```
0.25 × (Extreme Heat Days / 30) + 
0.25 × (Heavy Precipitation Days / 20) + 
0.25 × (1 - Forest Area % / 100) + 
0.25 × (1 - Renewable Energy % / 100)
```

**Ecological Preservation Index:**
```
(Forest Area % / 100) × √(Renewable Energy % / 100)
```

**Green Transition Score:**
```
Renewable Energy % × (1 - (CO₂ Emissions (kt) / GDP (US$) × 0.00001))
```

**Global Resilience Score (2020+):**
```
0.2 × (GDP per capita / 50000) + 
0.2 × (1 - CO₂ emissions intensity) + 
0.2 × (Life expectancy / 85) + 
0.15 × (Internet usage % / 100) + 
0.15 × ((Government effectiveness + 2.5) / 5) + 
0.1 × (1 - Case fatality rate)
```

## 🔄 Reproducing the Dataset

To regenerate this dataset:

1. Access Google BigQuery through the [Google Cloud Console](https://console.cloud.google.com/)
2. Run the SQL query provided in `worldbank_climate_covid_analysis.sql`
3. All referenced datasets are publicly available in BigQuery

## ⚠️ Data Considerations

- **Missing Values**: Approximately 18% of entries in `region` and `income_group` columns are null due to inclusion of aggregate regions and non-country classifications
- **Temporal Adjustments**: Formulas for composite indices are adjusted for pre-2020 and post-2020 periods to account for pandemic impacts
- **Data Quality**: Filters are applied to exclude non-populated areas and erroneous data points

## 🎯 Use Cases

This dataset is ideal for:

- **Trend Analysis**: Multi-decade development patterns
- **Country Comparisons**: Cross-national development assessments  
- **Predictive Modeling**: Machine learning applications for development outcomes
- **Policy Research**: Evidence-based policy analysis and modeling
- **Sustainability Research**: Environmental and climate impact studies
- **Correlation Studies**: Multi-domain indicator relationships
- **Academic Research**: Development economics and policy studies

## 📊 Sample Analysis Ideas

- Correlation between economic growth and environmental sustainability
- Impact of digital connectivity on human development outcomes
- Climate vulnerability patterns across different income groups
- Pandemic resilience factors and recovery patterns
- Green transition progress across regions and time periods

---

*Dataset curated and processed from Google BigQuery Public Data program sources. Last updated: 2024*