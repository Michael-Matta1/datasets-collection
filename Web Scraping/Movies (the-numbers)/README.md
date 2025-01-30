# The Numbers Movie Scraping Project

## Dataset Overview
This project involves extracting movie data from [The Numbers](https://www.the-numbers.com/), focusing on movie budgets, box office revenue, and other financial metrics. The project consists of two main parts:

1. **Data Extraction**: Scraping movie details using Selenium and BeautifulSoup.
2. **Data Cleaning**: Refining and structuring the extracted data for analysis.

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
  - [Data Extraction](#data-extraction)
  - [Data Cleaning](#data-cleaning)
- [Files](#files)
- [Requirements](#requirements)
- [Limitations](#limitations)
- [Contributing](#contributing)

## Overview
The project scrapes financial and production details for movies, including:
- Movie name
- Production budget
- Domestic and worldwide box office revenue
- Opening weekend earnings
- Distributor and release date
- Additional metadata such as genre and director (when available)

After collecting the data, it is cleaned and formatted for analysis.

## Installation
To run this project, ensure you have Python installed. Install the required libraries using:

```bash
pip install selenium beautifulsoup4 pandas webdriver-manager fake-useragent
```

Since this project is designed to run on Google Colab, additional setup is required:

```bash
!apt-get update
!apt-get install -y chromium-browser
!apt install chromium-chromedriver
!wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
!dpkg -i google-chrome-stable_current_amd64.deb
!apt-get -f install -y
```

## Usage
### Data Extraction
Run the `Movies_Scaper V3.ipynb` script to scrape movie data from The Numbers. This script:
- Loads the required libraries and initializes a Selenium WebDriver with Google Chrome.
- Scrapes movie budget data from multiple pages.
- Extracts detailed financial and production data for each movie.
- Saves the raw data to `combined_movie_budgets.csv`.

#### you can edit the `budget_url` to scrape other lists of the website

```python
# Define base URL for scraping
base_url = "https://www.the-numbers.com"
budget_url = f"{base_url}/movie/budgets/all"

# Scrape and save data
df.to_csv('combined_movie_budgets.csv', index=False)
```

### Data Cleaning
Run the `Movies_Cleaner.ipynb` script to:
- Remove duplicates and handle missing values.
- Convert financial data to numerical format.
- Standardize text formats and fix inconsistencies.
- Save the cleaned dataset to `cleaned_movie_data.csv`.
- Note that after scrapping I renamed the csv to "Top Movies"

```python
df_cleaned = clean_movie_data('combined_movie_budgets.csv')
df_cleaned.to_csv('cleaned_movie_data.csv', index=False)
```

## Files
- `Movies_Scaper V3.ipynb`: Jupyter Notebook for scraping movie data.
- `Movies_Cleaner.ipynb`: Jupyter Notebook for cleaning the extracted data.
- `combined_movie_budgets.csv`: Raw scraped movie data.
- `cleaned_movie_data.csv`: Processed and cleaned movie dataset.

## Requirements
- Python 3.x
- Selenium
- BeautifulSoup4
- Pandas
- Webdriver-Manager
- Fake-UserAgent
- Google Chrome & ChromeDriver

## Limitations
- **Data Completeness**: Some movies may have missing or incomplete financial details.
- **Date**: This dataset is collected on the date of "Thursday, January 30, 2025"

## Contributing
Contributions are welcome! Fork the repository, make changes, and submit a pull request.

## **Disclaimer:**
This script is for educational purposes only. Ensure compliance with The Numbers' terms of service when scraping data.

