# Datasets Acquisition & Analysis Repository

This repository serves as a centralized collection of datasets, and data acquisition methodologies/code (web scraping, API integration...etc). It includes raw and processed data, scraping scripts, and data cleaning notebooks.

> **Kaggle Datasets**: All datasets are published at [kaggle.com/michaelmatta0/datasets](https://www.kaggle.com/michaelmatta0/datasets), allowing you to directly apply your notebooks and analyze the data online.

## 📂 Repository Structure

The repository is organized into the following main projects:

### 1. 🌍 Global Development Indicators (2000-2020)
*Directory: `Global Development`*

A comprehensive dataset merging global economic, environmental, technological, and human development indicators.
*   **Source**: Derived from Google BigQuery Public Datasets (World Bank WDI, NOAA GSOD, COVID-19 Open Data).
*   **Contents**:
    *   Methodology documentation (`Methodology and Data Sources for Indices.pdf`) for composite indices like Climate Vulnerability and Green Transition.
    *   SQL scripts (`worldbank_climate_covid_analysis.sql`) used for data extraction.
    *   Final dataset CSV.

### 2. 🎬 Movies Metrics & Financials
*Directory: `Movies Metrics, Features and Statistics`*

A project focused on extracting and analyzing movie budget and box office revenue data from *The Numbers*.
*   **Methodology**: Web scraping using Selenium and BeautifulSoup.
*   **Contents**:
    *   `Movies_Scaper V3.ipynb`: Notebook for scraping movie data.
    *   `Movies_Cleaner.ipynb`: Notebook for data cleaning and standardization.
    *   Raw and cleaned datasets containing budgets, revenue, and metadata.

### 3. 📱 Amazon Cell Phones (Archived)
*Directory: `Amazon Cell Phones`*

An educational web scraping project targeting Amazon USA cell phone listings.
*   **Status**: **Archived** (The scraper is no longer functional due to Amazon site structure changes).
*   **Contents**:
    *   Python scripts for scraping (`Data_Extractor.py`) and cleaning (`Data_Cleaning.ipynb`).
    *   Datasets including product names, prices, ratings, and technical specs.

### 4. 📚 DataCamp Courses Metadata
*Directory: `DataCamp Courses Metadata`*

A dataset containing detailed metadata about DataCamp courses, learning tracks, and technology mappings.
*   **Contents**:
    *   Datasets (`courses.csv`, `all_tracks.csv`) covering course difficulty, XP, chapters, and topics.
    *   `notebook.ipynb`: Analysis and visualizations of the learning content.
    *   Visualizations folder.

### 5. 🍲 Recipe Site Traffic Analysis
*Directory: `Recipe Site Traffic`*

A data science case study aiming to predict high-traffic recipes to optimize homepage content.
*   **Goal**: Develop a model to correctly predict high-traffic recipes 80% of the time.
*   **Contents**:
    *   Analysis Notebooks: Simple (2 Models) vs. Extended (Meta-Model) approaches.
    *   Business Presentation (`Presentation.pptx`).
    *   Traffic and recipe feature dataset.

---

## 🛠️ Tools & Technologies

*   **Languages**: Python, SQL (BigQuery)
*   **Libraries**:
    *   **Scraping**: `selenium`, `beautifulsoup4`, `webdriver-manager`
    *   **Data Manipulation**: `pandas`, `numpy`
    *   **Visualization & Analysis**: `matplotlib`, `seaborn`, Jupyter Notebooks
