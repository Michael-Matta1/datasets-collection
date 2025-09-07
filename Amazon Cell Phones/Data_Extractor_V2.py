#### Might be needed for google colab: ##
#!apt-get update
#!apt-get install -y wget
#!wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#!dpkg -i google-chrome-stable_current_amd64.deb
#!apt-get -f install -y

#!pip install selenium beautifulsoup4 pandas webdriver-manager  #(Libraries)

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
# from selenium.webdriver.common.by import By
# from selenium.webdriver.support.ui import WebDriverWait
# from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import pandas as pd
# import numpy as np
import time

# Setup WebDriver with webdriver-manager
chrome_options = Options()
chrome_options.add_argument("--headless")  # Run headless mode (Needed in Colab)
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")
service = Service(ChromeDriverManager().install())
driver = webdriver.Chrome(service=service, options=chrome_options)
# driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)


def parse_product_details(product):
    details = {}
    details['product_name'] = product.find('span', {
        'class': 'a-size-base-plus a-color-base a-text-normal'}).text if product.find('span', {
        'class': 'a-size-base-plus a-color-base a-text-normal'}) else 'N/A'
    details['image_link'] = product.find('img', {'class': 's-image'})['src'] if product.find('img', {
        'class': 's-image'}) else 'N/A'
    details['rating'] = product.find('span', {'class': 'a-icon-alt'}).text if product.find('span', {
        'class': 'a-icon-alt'}) else 'N/A'
    whole_price = product.find('span', {'class': 'a-price-whole'}).text if product.find('span', {
        'class': 'a-price-whole'}) else '0'
    fraction_price = product.find('span', {'class': 'a-price-fraction'}).text if product.find('span', {
        'class': 'a-price-fraction'}) else '00'
    details['price'] = f"{whole_price}{fraction_price}"
    details['number_of_ratings'] = product.find('span', {'class': 'a-size-base s-underline-text'}).text if product.find(
        'span', {'class': 'a-size-base s-underline-text'}) else 'N/A'
    link_element = product.find('a', {
        'class': 'a-link-normal s-underline-text s-underline-link-text s-link-style a-text-normal'})
    details['product_link'] = link_element['href'] if link_element else 'N/A'

    # Extract price before discount
    try:
        price_before_discount = product.find('span', {'class': 'a-price a-text-price'})
        if price_before_discount:
            details['price_before_discount'] = price_before_discount.find('span', {'class': 'a-offscreen'}).text
        else:
            details['price_before_discount'] = 'N/A'
    except Exception as e:
        print(f'Could not extract price before discount: {e}')
        details['price_before_discount'] = 'N/A'

    return details


def parse_product_extra_details(product_url, driver):
    driver.get(f"https://www.amazon.com{product_url}")
    time.sleep(2)  # Wait for the page to load fully
    soup = BeautifulSoup(driver.page_source, 'html.parser')

    extra_details = {
        'brand': soup.find('tr', {'class': 'a-spacing-small po-brand'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr',
                                                                     {'class': 'a-spacing-small po-brand'}) else 'N/A',
        'operating_system': soup.find('tr', {'class': 'a-spacing-small po-operating_system'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr', {
            'class': 'a-spacing-small po-operating_system'}) else 'N/A',
        'RAM': soup.find('tr', {'class': 'a-spacing-small po-ram_memory.installed_size'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr', {
            'class': 'a-spacing-small po-ram_memory.installed_size'}) else 'N/A',
        'CPU': soup.find('tr', {'class': 'a-spacing-small po-cpu_model.speed'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr', {
            'class': 'a-spacing-small po-cpu_model.speed'}) else 'N/A',
        'storage': soup.find('tr', {'class': 'a-spacing-small po-memory_storage_capacity'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr', {
            'class': 'a-spacing-small po-memory_storage_capacity'}) else 'N/A',
        'screen_size': soup.find('tr', {'class': 'a-spacing-small po-display.size'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr', {
            'class': 'a-spacing-small po-display.size'}) else 'N/A',
        'cellular_technology': soup.find('tr', {'class': 'a-spacing-small po-cellular_technology'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr', {
            'class': 'a-spacing-small po-cellular_technology'}) else 'N/A',
        'model_name': soup.find('tr', {'class': 'a-spacing-small po-model_name'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr', {
            'class': 'a-spacing-small po-model_name'}) else 'N/A',
        'cpu_model': soup.find('tr', {'class': 'a-spacing-small po-cpu_model.family'}).find('span', {
            'class': 'a-size-base po-break-word'}).text if soup.find('tr', {
            'class': 'a-spacing-small po-cpu_model.family'}) else 'N/A',
        'available_colors': 'N/A'
    }

    # Try extracting available colors from the primary location
    try:
        colors_div = soup.find('div', {'id': 'variation_color_name'})
        color_elements = colors_div.find_all('li') if colors_div else []
        colors = [color.find('img')['alt'] for color in color_elements if color.find('img')]
        if colors:
            extra_details['available_colors'] = ', '.join(colors)
        else:
            # Search in the secondary location if no colors are found in the primary location
            colors_div_secondary = soup.find('div', {'id': 'twisterContainer'})
            if colors_div_secondary:
                color_span = colors_div_secondary.find('span', {'class': 'selection'})
                if color_span:
                    extra_details['available_colors'] = color_span.text.strip()
                else:
                    extra_details['available_colors'] = 'N/A'
            else:
                extra_details['available_colors'] = 'N/A'
    except Exception as e:
        print(f'Could not extract available colors: {e}')

    return extra_details


def scrape_amazon_cellphones(base_url, pages_to_scrape):
    data = []
    driver = webdriver.Chrome()
    driver.get("https://www.amazon.com")
    time.sleep(5)  # a trick i discovered to overcome the captcha

    for page_num in range(1, pages_to_scrape + 1):
        url = f"{base_url}&page={page_num}"
        driver.get(url)
        time.sleep(2)  # Wait for the page to load fully
        soup = BeautifulSoup(driver.page_source, 'html.parser')

        # Locate the product container
        product_container = soup.find('div', {'class': 's-main-slot s-result-list s-search-results sg-row'})
        if not product_container:
            print(f"Product container not found on page {page_num}.")
            break

        products = product_container.find_all('div', {
            'class': 'sg-col-4-of-24 sg-col-4-of-12 s-result-item s-asin sg-col-4-of-16 sg-col s-widget-spacing-small sg-col-4-of-20 gsx-ies-anchor'})

        if not products:
            print(f"No products found on page {page_num}.")
            break

        for product in products:
            details = parse_product_details(product)
            extra_details = parse_product_extra_details(details['product_link'], driver)
            details.update(extra_details)
            data.append(details)

    driver.quit()
    return data


# Define the URL for cell phones
url = 'https://www.amazon.com/s?i=mobile&rh=n%3A7072561011&s=featured-rank&fs=true&ref=lp_7072561011_sar'

# Scrape pages
scraped_data = scrape_amazon_cellphones(url, 250)
df = pd.DataFrame(scraped_data)
df.to_csv('Raw_Data.csv', index=False)
