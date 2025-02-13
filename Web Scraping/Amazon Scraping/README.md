---
# Amazon Web Scraping Project
---
## 🚨 Important Notice 🚨

⚠️ **This project is no longer functional** because Amazon has changed its website HTML structure.  
As of now, I am **not considering updating this project**, as it was primarily for practice. However, I might update it in the future.

---
## Dataset URL in Kaggle:
https://www.kaggle.com/datasets/michaelmatta0/amazon-cell-phones-cleaned-scraped-data/data
---
This project involves extracting data from Amazon, specifically focusing on cell phone listings. It consists of two parts: 
1. **Data Extraction**: Scraping product details from Amazon using Selenium and BeautifulSoup.
2. **Data Cleaning**: Cleaning and refining the extracted data to make it useful for analysis.

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

The project scrapes various details about cell phones listed on Amazon, such as product name, price, rating, number of ratings, and technical specifications like RAM, storage, screen size, and more. After data collection, the project cleans and organizes the data for further analysis.

## Installation

To run this project, you will need Python installed on your machine and a few libraries. Install the dependencies using the following:

```bash
pip install selenium beautifulsoup4 pandas webdriver-manager numpy
```

Or you may use the attached requirements file 
   ```bash
   pip install -r requirements.txt
   ```

Additionally, ensure you have Google Chrome installed, and you may need to set up the appropriate ChromeDriver, which is managed by `webdriver-manager`.


If you're running this on Google Colab, you may also need to install Google Chrome manually:

```bash
# In Google Colab:
!apt-get update
!apt-get install -y wget
!wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
!dpkg -i google-chrome-stable_current_amd64.deb
!apt-get -f install -y
```
and also (check the code for more details)
```
chrome_options.add_argument("--headless")  # Run headless mode (Needed in Colab)
```


## Usage

### Data Extraction

To scrape data from Amazon, use the `data_extraction.py` script. This script will:
- Scrape product details such as name, price, ratings, and technical specs from Amazon cell phone listings.
- Store the extracted data in a CSV file (`Raw_Data.csv`).

- **`parse_product_details(product)`**: Extracts basic product information such as name, image link, price, and ratings.
- **`parse_product_extra_details(product_url, driver)`**: Retrieves additional details from the product's individual page.
- **`scrape_amazon_cellphones(base_url, pages_to_scrape)`**: Main function to scrape multiple pages of products.

#### Example:

1. Define the URL for the product category you want to scrape.
2. Run the scraping process for the specified number of pages.

```python
url = 'https://www.amazon.com/s?i=mobile&rh=n%3A7072561011&s=featured-rank&fs=true&ref=lp_7072561011_sar'
scraped_data = scrape_amazon_cellphones(url, 250)
```

This will generate a CSV file (`Raw_Data.csv`) with the scraped data.

### Data Cleaning

After extracting the data, run the `data_cleaning.py` script to:
- Clean the extracted data (remove duplicates, handle missing values, correct data types, remove commas from numerical fields).
- Calculate the discount percentage based on the regular and discounted prices.
- Standardize units for RAM, storage, and screen size.
- Output the cleaned data to a new CSV file (`Data_After_Cleaning.csv`).

```python
df = pd.read_csv('Raw_Data.csv')
# Clean and process the data
df_cleaned.to_csv('Data_After_Cleaning.csv', index=False)
```

## Files

- `data_extraction.py`: Python script to scrape data from Amazon.
- `data_cleaning.py`: Python script to clean and refine the extracted data.
- `Raw_Data.csv`: Output file from the scraping process.
- `Data_After_Cleaning.csv`: Cleaned and processed data.

## Requirements

- Python 3.x
- Selenium
- BeautifulSoup4
- Pandas
- Webdriver-Manager
- Google Chrome (or ChromeDriver for automated browsing)

## Limitations

- **Captcha Handling**: If Amazon triggers a CAPTCHA, the scraping process may pause or fail. A delay then redirection is introduced to help bypass it.
- **Data Completeness**: Depending on the Amazon page layout or product availability, some fields may be missing or incomplete.
- **Rate Limiting**: Scraping Amazon too frequently may result in rate-limiting or IP bans.

## Contributing

Contributions are welcome! Please fork this repository, make your changes, and submit a pull request.

## **Disclaimer:**

This script is for educational purposes only. Please be respectful of Amazon's terms of service when scraping data. 
