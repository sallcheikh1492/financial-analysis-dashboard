# 📊 Corporate Financial Analysis — Business Intelligence Project

🌐 **Language:** [🇫🇷 Français](README.md) · **🇬🇧 English**

### 🔗 [**▶ View the live demo (GitHub Pages)**](https://kheuch1492.github.io/financial-analysis-dashboard/)

End-to-end BI project analyzing a company's financial performance: data cleaning,
financial KPIs, income statement, forecasting and an interactive dashboard.
Built with **Python · SQL · Power BI**.

> **Dataset:** Microsoft *Financial Sample* — 700 transactions, Sept. 2013 → Dec. 2014.
> 5 segments · 5 countries · 6 products.

---

## 🎯 Objectives

1. Assess revenue evolution
2. Measure margins and profitability
3. Study costs and expenses (including discounts)
4. Identify the most profitable products / segments
5. Produce financial forecasts
6. Support strategic decision-making

## 📈 Key results

| KPI | Value |
|---|---:|
| Revenue (Sales) | **$118.7M** |
| Cost of goods sold (COGS) | $101.8M |
| Commercial discounts | $9.2M |
| Total profit | **$16.9M** |
| Average margin | **14.2%** |
| Global ROI | 16.6% |
| Units sold | 1,125,806 |

**Main insights:**
- 🥇 Most profitable product: **Paseo** (≈ $4.8M profit); best margin: **Amarilla**.
- 🏢 Top contributing segment: **Government**; best margin: **Channel Partners**.
- 🌍 Largest market: **United States** (≈ $25M revenue).
- 💸 Margin drops sharply under high discounts (*Discount Band = High*).
- 🔮 6-month revenue forecast ≈ $9.9M/month (model selected after comparing 3 approaches).

## 🗂️ Project structure

```
financial-analysis-dashboard/
├── data/
│   ├── Financial_Sample.xlsx          # raw dataset (Microsoft source)
│   ├── financial_data_clean.csv       # cleaned data + engineered features
│   └── forecast_6m.csv                # 6-month revenue forecast
├── notebooks/
│   └── financial_analysis.ipynb       # cleaning, EDA, KPIs, forecasting (executed)
├── sql/
│   ├── 01_create_schema.sql           # financial_data table + indexes
│   ├── 02_load_data.sql               # CSV import (COPY / \copy)
│   └── 03_analysis_queries.sql        # 10 analytical queries
├── powerbi/
│   ├── Financial_Analysis.pbix        # final dashboard (4 interactive pages)
│   ├── DAX_measures.md                # all DAX measures
│   ├── Power_BI_Build_Guide.md        # step-by-step dashboard guide
│   └── assets/                        # page backgrounds (cover + content)
├── reports/
│   ├── Financial_Analysis_Report.pdf  # executive summary (3 pages)
│   └── figures/                       # 6 exported charts
├── requirements.txt
└── README.md
```

## ⚙️ Setup & run

```bash
# 1. Python dependencies
pip install -r requirements.txt

# 2. Run the notebook (cleaning + analysis + forecasting)
jupyter notebook notebooks/financial_analysis.ipynb
#   -> produces data/financial_data_clean.csv, forecast_6m.csv and reports/figures/*.png

# 3. Database (PostgreSQL)
psql -d my_db -f sql/01_create_schema.sql
psql -d my_db -f sql/02_load_data.sql      # adjust the CSV path
psql -d my_db -f sql/03_analysis_queries.sql

# 4. Power BI dashboard
#   Follow powerbi/Power_BI_Build_Guide.md using financial_data_clean.csv
```

## 🛠️ Methodology

1. **Data understanding** — variable dictionary and financial indicators.
2. **Cleaning (Python)** — normalized column names (stray spaces), handling of missing
   `Discount Band`, duplicates, types, dates, outlier detection (IQR), and accounting-identity
   checks (Sales = Gross − Discounts; Profit = Sales − COGS).
3. **Engineered features** — `Profit_Margin_%`, `Cost_Ratio_%`, `Discount_Rate_%`, `ROI_%`.
4. **SQL analysis** — global KPIs, top products, country/segment performance, monthly sales,
   growth (`LAG` window functions), income statement.
5. **Simplified income statement** — Gross Sales → Discounts → Net Sales → COGS → Net Profit.
6. **Forecasting** — comparison of **moving average / linear regression / SARIMA** on a
   hold-out (MAE, RMSE), then a 6-month projection with the best model.
7. **Financial KPIs** — revenue, profit, margin, growth, cost, profitability, ROI.
8. **Power BI dashboard** — KPIs, trends, top products, country map, margins,
   income statement, forecasts + filters (year, month, country, product, segment).
9. **Business recommendations**.

## 💡 Business recommendations

- **Grow** the most profitable products and high-margin segments.
- **Control** high discounts that erode margin.
- **Reduce** the cost of low-ROI products (renegotiation / price repositioning).
- **Anticipate** cash flow and inventory using the 6-month forecast.

## 🧰 Tech stack

`Python` · `Pandas` · `NumPy` · `Matplotlib` · `Seaborn` · `scikit-learn` · `statsmodels`
· `SQL (PostgreSQL)` · `Power BI` · `Jupyter`

## 🎓 Skills demonstrated

Finance Analytics · Financial KPIs · Forecasting · SQL · Python · Power BI ·
Financial analysis · Data Visualization · Business Intelligence

---

### 📌 Power BI dashboard
The finished dashboard is included: **`powerbi/Financial_Analysis.pbix`** — 4 interactive pages
(Home · Overview · Margins & Costs · Forecasting). The `powerbi/` folder also provides all DAX
measures, a step-by-step rebuild guide, and the page background images in `assets/`.
