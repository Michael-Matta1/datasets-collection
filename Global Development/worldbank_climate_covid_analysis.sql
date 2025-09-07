WITH
-- Core development indicators from World Bank
base_indicators AS (
SELECT
year,
country_code,
-- Economic indicators
MAX(IF(indicator_name = 'GDP (current US$)', value, NULL)) AS gdp_usd,
MAX(IF(indicator_name = 'Population, total', value, NULL)) AS population,
MAX(IF(indicator_name = 'GDP per capita (current US$)', value, NULL)) AS gdp_per_capita,
MAX(IF(indicator_name = 'Inflation, consumer prices (annual %)', value, NULL)) AS inflation_rate,
MAX(IF(indicator_name = 'Unemployment, total (% of total labor force) (modeled ILO estimate)', value, NULL)) AS unemployment_rate,
MAX(IF(indicator_name = 'Foreign direct investment, net inflows (% of GDP)', value, NULL)) AS fdi_pct_gdp,
-- Governance and stability
MAX(IF(indicator_name = 'Government effectiveness: Estimate', value, NULL)) AS govt_effectiveness,
MAX(IF(indicator_name = 'Political Stability and Absence of Violence/Terrorism: Estimate', value, NULL)) AS political_stability,
MAX(IF(indicator_name = 'Control of corruption: Estimate', value, NULL)) AS corruption_control,
-- Environmental indicators
MAX(IF(indicator_name = 'CO2 emissions (kt)', value, NULL)) AS co2_emissions_kt,
MAX(IF(indicator_name = 'Energy use (kg of oil equivalent per capita)', value, NULL)) AS energy_use_per_capita,
MAX(IF(indicator_name = 'Renewable energy consumption (% of total final energy consumption)', value, NULL)) AS renewable_energy_pct,
MAX(IF(indicator_name = 'Forest area (% of land area)', value, NULL)) AS forest_area_pct,
MAX(IF(indicator_name = 'Access to electricity (% of population)', value, NULL)) AS electricity_access_pct,
-- Health/Social indicators
MAX(IF(indicator_name = 'Life expectancy at birth, total (years)', value, NULL)) AS life_expectancy,
MAX(IF(indicator_name = 'Mortality rate, under-5 (per 1,000 live births)', value, NULL)) AS child_mortality,
MAX(IF(indicator_name = 'School enrollment, secondary (% gross)', value, NULL)) AS school_enrollment_secondary,
MAX(IF(indicator_name = 'Current health expenditure (% of GDP)', value, NULL)) AS health_expenditure_pct_gdp,
MAX(IF(indicator_name = 'Hospital beds (per 1,000 people)', value, NULL)) AS hospital_beds_per_1000,
MAX(IF(indicator_name = 'Physicians (per 1,000 people)', value, NULL)) AS physicians_per_1000,
-- Digital/Technology indicators
MAX(IF(indicator_name = 'Individuals using the Internet (% of population)', value, NULL)) AS internet_usage_pct,
MAX(IF(indicator_name = 'Mobile cellular subscriptions (per 100 people)', value, NULL)) AS mobile_subscriptions_per_100
FROM
bigquery-public-data.world_bank_wdi.indicators_data
WHERE
year >= 2000
AND indicator_name IN (
'GDP (current US$)',
'Population, total',
'GDP per capita (current US$)',
'Inflation, consumer prices (annual %)',
'Unemployment, total (% of total labor force) (modeled ILO estimate)',
'Foreign direct investment, net inflows (% of GDP)',
'Government effectiveness: Estimate',
'Political Stability and Absence of Violence/Terrorism: Estimate',
'Control of corruption: Estimate',
'CO2 emissions (kt)',
'Energy use (kg of oil equivalent per capita)',
'Renewable energy consumption (% of total final energy consumption)',
'Forest area (% of land area)',
'Access to electricity (% of population)',
'Life expectancy at birth, total (years)',
'Mortality rate, under-5 (per 1,000 live births)',
'School enrollment, secondary (% gross)',
'Current health expenditure (% of GDP)',
'Hospital beds (per 1,000 people)',
'Physicians (per 1,000 people)',
'Individuals using the Internet (% of population)',
'Mobile cellular subscriptions (per 100 people)'
)
GROUP BY
year, country_code
),
-- Country metadata
country_metadata AS (
SELECT
country_code,
short_name AS country_name,
region,
income_group,
currency_unit
FROM
bigquery-public-data.world_bank_wdi.country_summary
),
-- Climate data aggregation (temperature & precipitation patterns)
climate_data AS (
SELECT
EXTRACT(YEAR FROM date) AS year,
s.country AS country_code,
AVG(temp) AS avg_temp,
AVG(max) AS avg_max_temp,
AVG(min) AS avg_min_temp,
AVG(prcp) AS avg_precipitation,
STDDEV(temp) AS temp_volatility,
STDDEV(prcp) AS precip_volatility,
COUNT(DISTINCT CASE WHEN prcp > 25.4 THEN date ELSE NULL END) AS heavy_precip_days,
COUNT(DISTINCT CASE WHEN max > 35 THEN date ELSE NULL END) AS extreme_heat_days
FROM
`bigquery-public-data.noaa_gsod.gsod20*` g
JOIN
bigquery-public-data.noaa_gsod.stations s
ON g.stn = s.usaf AND g.wban = s.wban
WHERE
s.country IS NOT NULL
AND temp != 9999.9
AND max != 9999.9
AND min != 9999.9
GROUP BY
year, s.country
),
-- COVID-19 response metrics aggregation
covid_data AS (
SELECT
country_code,
EXTRACT(YEAR FROM date) AS year,
-- Cumulative metrics for the year
MAX(cumulative_confirmed) AS total_covid_cases,
MAX(cumulative_deceased) AS total_covid_deaths,
MAX(cumulative_recovered) AS total_covid_recovered,
-- Peak pandemic metrics
MAX(new_confirmed) AS peak_daily_cases,
MAX(new_deceased) AS peak_daily_deaths,
-- Healthcare system response metrics
MAX(cumulative_persons_fully_vaccinated) AS total_fully_vaccinated,
-- Calculate case fatality rate
SAFE_DIVIDE(MAX(cumulative_deceased), NULLIF(MAX(cumulative_confirmed), 0)) AS case_fatality_rate
FROM
bigquery-public-data.covid19_open_data.covid19_open_data
WHERE
date >= '2020-01-01'
GROUP BY
country_code, year
)
-- Main query joining all data sources
SELECT
-- Core identifiers
i.year,
i.country_code,
m.country_name,
m.region,
m.income_group,
m.currency_unit,
-- Economic indicators
i.gdp_usd,
i.population,
i.gdp_per_capita,
i.inflation_rate,
i.unemployment_rate,
i.fdi_pct_gdp,
i.govt_effectiveness,
i.political_stability,
i.corruption_control,
-- Environmental indicators
i.co2_emissions_kt,
i.energy_use_per_capita,
i.renewable_energy_pct,
i.forest_area_pct,
i.electricity_access_pct,
-- Health/Social indicators
i.life_expectancy,
i.child_mortality,
i.school_enrollment_secondary,
i.health_expenditure_pct_gdp,
i.hospital_beds_per_1000,
i.physicians_per_1000,
i.internet_usage_pct,
i.mobile_subscriptions_per_100,
-- Climate metrics
c.avg_temp,
c.avg_max_temp,
c.avg_min_temp,
c.avg_precipitation,
c.temp_volatility,
c.precip_volatility,
c.heavy_precip_days,
c.extreme_heat_days,
-- COVID-19 metrics
cd.total_covid_cases,
cd.total_covid_deaths,
cd.total_covid_recovered,
cd.peak_daily_cases,
cd.peak_daily_deaths,
cd.total_fully_vaccinated,
cd.case_fatality_rate,
-- *** CALCULATED METRICS FROM ALL QUERIES ***
-- Economic metrics (from queries 1, 2, and 3)
i.gdp_usd / NULLIF(i.population, 0) AS calculated_gdp_per_capita,
SAFE_DIVIDE(i.gdp_per_capita, i.inflation_rate) AS real_economic_growth_indicator,
SAFE_DIVIDE(i.gdp_per_capita, POWER(i.unemployment_rate, 0.5)) AS econ_opportunity_index,
CASE
WHEN i.year >= 2020 THEN
i.gdp_per_capita / NULLIF(LAG(i.gdp_per_capita, 1) OVER(PARTITION BY i.country_code ORDER BY i.year), 0) - 1
ELSE NULL
END AS gdp_growth_rate,
-- Environmental sustainability metrics
i.co2_emissions_kt / NULLIF(i.population, 0) * 1000 AS co2_emissions_per_capita_tons,
i.co2_emissions_kt / NULLIF(i.gdp_usd, 0) * 1000000 AS co2_intensity_per_million_gdp,
i.renewable_energy_pct * (1 - COALESCE(i.co2_emissions_kt / NULLIF(i.gdp_usd, 0) * 0.00001, 0)) AS green_transition_score,
(i.forest_area_pct / 100) * SQRT(COALESCE(i.renewable_energy_pct, 0)) AS ecological_preservation_index,
i.renewable_energy_pct / NULLIF(i.energy_use_per_capita, 0) * 100 AS renewable_energy_efficiency,
-- Human development metrics
(i.life_expectancy / 85) * (1 - COALESCE(i.child_mortality / 100, 0)) * SQRT(COALESCE(i.school_enrollment_secondary / 100, 0)) AS human_development_composite,
i.health_expenditure_pct_gdp * COALESCE(i.hospital_beds_per_1000, 0) * COALESCE(i.physicians_per_1000, 0) AS healthcare_capacity_index,
SQRT(COALESCE(i.internet_usage_pct, 0) * COALESCE(i.mobile_subscriptions_per_100, 0) / 100) AS digital_connectivity_index,
-- Development ratios (from first query)
i.life_expectancy / NULLIF(i.child_mortality, 0) AS health_development_ratio,
i.school_enrollment_secondary / NULLIF(i.child_mortality, 0) AS education_health_ratio,
-- Year metrics (from first and third queries)
i.year - 2000 AS years_since_2000,
i.year - 2000 AS years_since_century,
CASE WHEN i.year >= 2020 THEN 1 ELSE 0 END AS is_pandemic_period,
-- Climate vulnerability metrics
c.temp_volatility * LOG(COALESCE(c.extreme_heat_days + 1, 1)) AS climate_stress_indicator,
c.precip_volatility * LOG(COALESCE(c.heavy_precip_days + 1, 1)) AS precipitation_risk_factor,
-- Human Development Index (from second query)
(i.life_expectancy / 85 * 0.33 +
(100 - COALESCE(i.child_mortality, 0)) / 100 * 0.33 +
COALESCE(i.school_enrollment_secondary, 0) / 100 * 0.33) AS human_development_index,
-- Pandemic response metrics (from second and third queries)
CASE
WHEN i.year >= 2020 THEN
(0.4 * (1 - COALESCE(cd.case_fatality_rate, 0)) +
0.3 * COALESCE(i.hospital_beds_per_1000 / 10, 0) +
0.3 * COALESCE(cd.total_fully_vaccinated / NULLIF(i.population, 0), 0))
ELSE NULL
END AS pandemic_resilience_score,
-- Climate vulnerability index (from second query)
(0.25 * COALESCE(c.extreme_heat_days / 30, 0) +
0.25 * COALESCE(c.heavy_precip_days / 20, 0) +
0.25 * (1 - COALESCE(i.forest_area_pct / 100, 0)) +
0.25 * (1 - COALESCE(i.renewable_energy_pct / 100, 0))) AS climate_vulnerability_index,
-- Digital readiness score (from second query)
(0.5 * COALESCE(i.internet_usage_pct / 100, 0) +
0.5 * COALESCE(i.mobile_subscriptions_per_100 / 150, 0)) AS digital_readiness_score,
-- Governance quality index (from second query)
(0.5 * (COALESCE(i.govt_effectiveness, 0) + 2.5) / 5 +
0.5 * (COALESCE(i.corruption_control, 0) + 2.5) / 5) AS governance_quality_index,
-- COVID-19 response effectiveness (from third query)
CASE
WHEN i.year >= 2020 THEN
(0.4 * (1 - COALESCE(cd.case_fatality_rate, 0)) +
0.3 * COALESCE(i.hospital_beds_per_1000 / 10, 0) +
0.3 * COALESCE(cd.total_fully_vaccinated / NULLIF(i.population, 0), 0))
ELSE NULL
END AS covid_response_effectiveness,
-- COMPREHENSIVE GLOBAL RESILIENCE SCORE (from second query)
CASE
WHEN i.year >= 2020 THEN
(0.2 * (i.gdp_per_capita / 50000) + -- Economic component
0.2 * (1 - COALESCE(i.co2_emissions_kt / NULLIF(i.gdp_usd, 0) * 1000000000 / 1000, 0)) + -- Environmental component
0.2 * (i.life_expectancy / 85) + -- Health component
0.15 * (COALESCE(i.internet_usage_pct, 0) / 100) + -- Digital component
0.15 * ((COALESCE(i.govt_effectiveness, 0) + 2.5) / 5) + -- Governance component
0.1 * (CASE WHEN cd.case_fatality_rate IS NOT NULL
THEN (1 - COALESCE(cd.case_fatality_rate, 0))
ELSE 0.5 END)) -- Pandemic component
ELSE
(0.25 * (i.gdp_per_capita / 50000) + -- Economic component (higher weight pre-pandemic)
0.25 * (1 - COALESCE(i.co2_emissions_kt / NULLIF(i.gdp_usd, 0) * 1000000000 / 1000, 0)) + -- Environmental component
0.2 * (i.life_expectancy / 85) + -- Health component
0.15 * (COALESCE(i.internet_usage_pct, 0) / 100) + -- Digital component
0.15 * ((COALESCE(i.govt_effectiveness, 0) + 2.5) / 5)) -- Governance component
END AS global_resilience_score,
-- Global Development & Resilience Index (from third query)
CASE
WHEN i.year >= 2020 THEN
-- Post-2020 includes COVID response
(
COALESCE((i.gdp_per_capita / 50000) * 0.15, 0) +
COALESCE(i.life_expectancy / 85 * 0.15, 0) +
COALESCE((1 - (i.child_mortality / 100)) * 0.1, 0) +
COALESCE(i.renewable_energy_pct / 100 * 0.1, 0) +
COALESCE(i.school_enrollment_secondary / 100 * 0.1, 0) +
COALESCE(i.govt_effectiveness * 0.05, 0) +
COALESCE(i.political_stability * 0.05, 0) +
COALESCE(i.health_expenditure_pct_gdp / 15 * 0.05, 0) +
COALESCE(i.internet_usage_pct / 100 * 0.05, 0) +
COALESCE((1 - (cd.case_fatality_rate)) * 0.1, 0)
) * 100
ELSE
-- Pre-2020 excludes COVID response
(
COALESCE((i.gdp_per_capita / 50000) * 0.15, 0) +
COALESCE(i.life_expectancy / 85 * 0.15, 0) +
COALESCE((1 - (i.child_mortality / 100)) * 0.15, 0) +
COALESCE(i.renewable_energy_pct / 100 * 0.1, 0) +
COALESCE(i.school_enrollment_secondary / 100 * 0.15, 0) +
COALESCE(i.govt_effectiveness * 0.1, 0) +
COALESCE(i.political_stability * 0.05, 0) +
COALESCE(i.health_expenditure_pct_gdp / 15 * 0.05, 0) +
COALESCE(i.internet_usage_pct / 100 * 0.1, 0)
) * 100
END AS global_development_resilience_index
FROM
base_indicators i
LEFT JOIN
country_metadata m
ON i.country_code = m.country_code
LEFT JOIN
climate_data c
ON i.country_code = c.country_code AND i.year = c.year
LEFT JOIN
covid_data cd
ON i.country_code = cd.country_code AND i.year = cd.year
WHERE
i.population > 0 -- Filter out non-populated areas or erroneous data
ORDER BY
m.region, i.country_code, i.year