# Indian Agricultural Market Price Intelligence

An end-to-end Data Analytics project focused on analysing agricultural wholesale market prices across Indian mandis using Python, MySQL, Excel and Tableau.

## Project Overview

Agriculture plays a significant role in India's economy, and understanding market price variations is important for farmers, traders and other agricultural stakeholders.

This project analyses mandi-level agricultural commodity prices to identify regional price differences, compare commodity prices, evaluate market coverage and examine price spreads across different agricultural markets.

The project follows a complete data analytics workflow, from data collection and cleaning to SQL analysis, spreadsheet analysis and interactive dashboard development.

## Business Problem

Agricultural commodity prices can vary across states, districts and wholesale markets. However, analysing these variations across multiple markets can be challenging without a structured analytical approach.

This project aims to answer questions such as:

- Which states have the highest mandi reporting coverage?
- Which commodities have the highest average modal prices?
- How do modal prices vary across states and markets?
- Which commodities have the largest average price spreads?
- Which markets report higher prices for a selected commodity?
- What data quality issues exist in the collected market records?

## Project Objectives

- Collect and analyse Indian agricultural mandi price data.
- Clean and validate the dataset using Python.
- Store and analyse structured data using MySQL.
- Perform exploratory and comparative analysis using Excel.
- Develop an interactive Tableau dashboard.
- Generate meaningful business insights from market price data.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| Python | Data cleaning, preprocessing and EDA |
| Pandas, NumPy | Data manipulation and analysis |
| Matplotlib, Seaborn | Exploratory data visualisation |
| MySQL | Database management and SQL analysis |
| Excel | PivotTables, KPI calculations, XLOOKUP and VLOOKUP |
| Tableau Public | Interactive dashboard development |
| Git and GitHub | Version control and project documentation |
| Google Colab / Jupyter Notebook | Python development environment |

## Dataset Description

**Data Source:** AGMARKNET / Government of India agricultural market price data.

The dataset contains mandi-level information about agricultural commodities and their reported wholesale prices.

### Dataset Attributes

| Column | Description |
|---|---|
| State | State where the market is located |
| District | District associated with the market |
| Market | Name of the agricultural wholesale market |
| Commodity | Agricultural commodity |
| Variety | Commodity variety |
| Grade | Quality grade |
| Arrival_Date | Date of price reporting |
| Min_x0020_Price | Minimum reported price |
| Max_x0020_Price | Maximum reported price |
| Modal_x0020_Price | Modal or most commonly reported price |

**Price unit:** Refer to the original source metadata before interpreting or labelling monetary values.

## Project Workflow

### 1. Data Collection and Cleaning – Python

- Imported the raw CSV dataset using Pandas.
- Inspected dataset dimensions, column names and data types.
- Checked for missing values and duplicate records.
- Validated price columns and date formats.
- Examined minimum, maximum and modal price consistency.
- Prepared a cleaned dataset for further analysis.

### 2. Exploratory Data Analysis – Python

Performed exploratory analysis to understand:

- State-wise market distribution.
- Commodity reporting frequency.
- Price distribution across commodities.
- Minimum, maximum and modal price patterns.
- Regional differences in reported prices.
- Price spread distribution.

### 3. Database Management and SQL Analysis – MySQL

Created a MySQL database named `mandi_intelligence` and stored the cleaned records in the `mandi_prices` table.

SQL analysis included:

- Overall dataset summary and reporting coverage.
- State-wise and district-wise market analysis.
- Commodity frequency and distribution.
- Average modal price comparison.
- Minimum and maximum price analysis.
- Market-level commodity comparisons.
- Price spread calculations.
- Ranking markets using window functions.
- Data quality and price validation checks.

### SQL Analysis Example

<img width="416" height="419" alt="image" src="https://github.com/user-attachments/assets/cdfa0137-6787-42eb-934e-68ca890d5758" />

<img width="590" height="525" alt="image" src="https://github.com/user-attachments/assets/dcbba5f9-1b51-4a70-a012-e27ff51402ec" />

<img width="547" height="800" alt="image" src="https://github.com/user-attachments/assets/5f5c1e3f-c551-45aa-87a5-281c45264d30" />

### 4. Excel Analysis

Used Excel for additional analytical exploration.

Key techniques:

- Data-quality checks.
- KPI calculations.
- PivotTables and PivotCharts.
- State-wise market coverage analysis.
- Commodity price comparisons.
- Market and variety analysis.
- Price spread analysis.
- XLOOKUP and VLOOKUP for data retrieval.

### Excel Analysis Example

<img width="1124" height="532" alt="Screenshot 2026-11-10 215003" src="https://github.com/user-attachments/assets/438d0b57-242e-421e-9ff5-0d7994e12041" />

<img width="1895" height="413" alt="Screenshot 2026-11-10 215052" src="https://github.com/user-attachments/assets/16691e0e-42d6-49e7-a7f0-1f6e5d17dfe0" />

<img width="1042" height="624" alt="Screenshot 2026-11-10 214946" src="https://github.com/user-attachments/assets/126b0361-1174-4093-9f59-e6b6f027f14e" />


### 5. Tableau Dashboard

Developed an interactive Tableau dashboard to communicate the analytical findings.

**Dashboard:** [View Interactive Tableau Dashboard](dashboard/dashboard.png)

Dashboard components:

- Total market records.
- Number of states.
- Total markets.
- Total commodities.
- Average modal price.
- Market coverage by state.
- Average modal price by commodity.
- Average modal price by state.
- Average price spread by commodity.
- Average modal price by market.

Interactive filters allow users to explore market prices by relevant geographical and commodity attributes.

### Dashboard Preview

<img width="1647" height="897" alt="dashboard" src="https://github.com/user-attachments/assets/609c7f6a-e6b4-430b-a5a9-6d32f6cc14f7" />

## Key Business Questions and Insights

The analysis is designed to investigate the following business questions:

| Business Question | Analytical Approach |
|---|---|
| Which states have the highest market coverage? | Count of distinct markets by state |
| Which commodities have the highest average prices? | Average modal price by commodity |
| How do prices differ across states? | State-wise average modal price |
| Which commodities have wider price spreads? | Average of maximum price minus minimum price |
| Which markets report higher prices? | Market-level modal price comparison |
| How reliable is the dataset? | Missing-value and price consistency checks |



## Repository Structure

```text
indian-agricultural-market-intelligence/
│
├── dashboard/
│       ├── dashboard.png
│       └── market_price_intelligence_dashboard.twt
│
├── excel_analysis/
│   ├── screenshots/
│   └── mandi_analysis.xlsx
│
├── notebook/
│   ├── indian_agricultural_market_intelligence.ipynb
│
├── sql/
│   ├── market_analysis.sql
├── .gitignore
├── README.md
└── requirements.txt
```
## Limitations

- The current analysis is based on a single reporting-date snapshot.
- Historical price trends and seasonal patterns cannot be established using one reporting date.
- Price comparisons across different commodities may be misleading because commodities have different price levels.
- Differences in variety, grade and reporting coverage can affect market comparisons.
- Further validation of source metadata is necessary before interpreting price units.

## Future Improvements

- Integrate multiple years of historical mandi price data.
- Develop commodity-level historical price trend analysis.
- Introduce automated data collection and ETL pipelines.
- Develop price forecasting models using machine learning.
- Build a regional agricultural price monitoring system.
- Incorporate additional data such as arrivals, demand and weather conditions.

## Conclusion

This project demonstrates an end-to-end data analytics workflow by combining Python-based data processing, SQL querying, Excel analysis and Tableau visualisation.

It provides a structured approach to understanding agricultural market price variations and extracting insights from mandi-level data.

## Author

**Adesh Vishwakarma**

Pursing MSc Data Science | BSc Data Science Graduate | Aspiring Data Scientist/Analyst

- GitHub: https://github.com/vishwakarmaadesh-datascience
- LinkedIn: https://www.linkedin.com/in/adesh-vishwakarma-53108b324
- Email : vishwakarmaadesh90@gmail.com
- Phone No : +91 9321569101
---

