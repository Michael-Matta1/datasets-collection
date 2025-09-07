**Global Economic, Environmental, Health, and Social indicators Ready for Analysis**

---

### 📝 **Description**

This comprehensive dataset merges global economic, environmental, technological, and human development indicators from 2000 to 2020. Sourced and transformed from multiple public datasets via Google BigQuery, it is designed for advanced exploratory data analysis, machine learning, policy modeling, and sustainability research.

Curated by combining and transforming data from the [Google BigQuery Public Data program](https://cloud.google.com/bigquery/public-data), this dataset offers a harmonized view of global development across more than 40 key indicators spanning over two decades (2000–2020). It supports research across multiple domains such as:

* **Economic Growth**
* **Climate Sustainability**
* **Digital Transformation**
* **Public Health**
* **Human Development**
* **Resilience and Governance**

---

### 📅 **Temporal Coverage**

* **Years**: 2000–2020
* Includes calculated features:

  * `years_since_2000`
  * `years_since_century`
  * `is_pandemic_period` (binary indicator for pandemic periods)

---

### 🌍 **Geographic Scope**

* **Countries**: Global (identified by ISO country codes)
* **Regions** and **Income Groups** included for aggregated analysis

---

### 📊 **Key Feature Groups**

* **Economic Indicators**:

  * GDP (USD), GDP per capita
  * FDI, inflation, unemployment, economic growth index
* **Environmental Indicators**:

  * CO₂ emissions, renewable energy use
  * Forest area, green transition score, CO₂ intensity
* **Technology & Connectivity**:

  * Internet usage, mobile subscriptions
  * Digital readiness score, digital connectivity index
* **Health & Education**:

  * Life expectancy, child mortality
  * School enrollment, healthcare capacity, health development ratio
* **Governance & Resilience**:

  * Governance quality, global resilience
  * Human development composite, ecological preservation

---

### 🔍 **Use Cases**

* Trend analysis over time
* Country-level comparisons
* Modeling development outcomes
* Predictive analytics on sustainability or human development
* Correlation and clustering across multiple indicators

---

### ⚠️ **Note on Missing Region and Income Group Data**

Approximately 18% of the entries in the `region` and `income_group` columns are null. This is primarily due to the inclusion of aggregate regions (e.g., *Arab World*, *East Asia & Pacific*, *Africa Eastern and Southern*) and non-country classifications (e.g., *Early-demographic dividend*, *Central Europe and the Baltics*). These entries represent groups of countries with diverse income levels and geographic characteristics, making it inappropriate or misleading to assign a single region or income classification. In some cases, the data source may have intentionally left these fields blank to avoid oversimplification or due to a lack of standardized classification.

---

### 📋 **Column Descriptions**

* **year**: Year of the recorded data, representing a time series for each country.
* **country\_code**: Unique code assigned to each country (ISO-3166 standard).
* **country\_name**: Name of the country corresponding to the data.
* **region**: Geographical region of the country (e.g., Africa, Asia, Europe).
* **income\_group**: Income classification based on Gross National Income (GNI) per capita (low, lower-middle, upper-middle, high income).
* **currency\_unit**: Currency used in the country (e.g., USD, EUR).
* **gdp\_usd**: Gross Domestic Product (GDP) in USD (millions or billions).
* **population**: Total population of the country for the given year.
* **gdp\_per\_capita**: GDP divided by population (economic output per person).
* **inflation\_rate**: Annual rate of inflation (price level rise).
* **unemployment\_rate**: Percentage of the labor force unemployed but seeking employment.
* **fdi\_pct\_gdp**: Foreign Direct Investment (FDI) as a percentage of GDP.
* **co2\_emissions\_kt**: Total CO₂ emissions in kilotons (kt).
* **energy\_use\_per\_capita**: Energy consumption per person (kWh).
* **renewable\_energy\_pct**: Percentage of energy consumption from renewable sources.
* **forest\_area\_pct**: Percentage of total land area covered by forests.
* **electricity\_access\_pct**: Percentage of the population with access to electricity.
* **life\_expectancy**: Average life expectancy at birth.
* **child\_mortality**: Deaths of children under 5 per 1,000 live births.
* **school\_enrollment\_secondary**: Percentage of population enrolled in secondary education.
* **health\_expenditure\_pct\_gdp**: Percentage of GDP spent on healthcare.
* **hospital\_beds\_per\_1000**: Hospital beds per 1,000 people.
* **physicians\_per\_1000**: Physicians (doctors) per 1,000 people.
* **internet\_usage\_pct**: Percentage of population with internet access.
* **mobile\_subscriptions\_per\_100**: Mobile subscriptions per 100 people.
* **calculated\_gdp\_per\_capita**: Alternative calculation or updated GDP per capita data.
* **real\_economic\_growth\_indicator**: Real GDP growth, adjusted for inflation.
* **econ\_opportunity\_index**: Economic opportunities available (e.g., job availability, ease of doing business).
* **co2\_emissions\_per\_capita\_tons**: CO₂ emissions per person in tons.
* **co2\_intensity\_per\_million\_gdp**: CO₂ emissions per million units of GDP.
* **green\_transition\_score**: Score representing progress toward a greener economy.
* **ecological\_preservation\_index**: Index measuring ecological system preservation.
* **renewable\_energy\_efficiency**: Efficiency of renewable energy use.
* **human\_development\_composite**: Composite index combining health, education, and income indicators.
* **healthcare\_capacity\_index**: Index measuring healthcare system capacity.
* **digital\_connectivity\_index**: Digital connectivity score, including internet and mobile network access.
* **health\_development\_ratio**: Ratio of health indicators relative to overall development.
* **education\_health\_ratio**: Ratio of education indicators relative to health indicators.
* **years\_since\_2000**: Years since the year 2000, used for time series analysis.
* **years\_since\_century**: Years since the start of the current century (2001).
* **is\_pandemic\_period**: Binary indicator marking periods affected by a global pandemic (e.g., COVID-19).
* **human\_development\_index**: Measures achievements in health, education, and standard of living.
* **climate\_vulnerability\_index**: Measures vulnerability to climate change, including exposure to extreme weather and resilience.
* **digital\_readiness\_score**: Preparedness for the digital economy, including infrastructure and education.
* **governance\_quality\_index**: Measures governance quality (e.g., corruption control, political stability).
* **global\_resilience\_score**: Composite score of resilience to global crises.
* **global\_development\_resilience\_index**: Measures resilience to global challenges like climate change and economic shifts.


