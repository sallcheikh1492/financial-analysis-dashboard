-- =====================================================================
-- 02 - Chargement des données nettoyées dans financial_data
-- Source : data/financial_data_clean.csv (produit par le notebook Python)
-- =====================================================================

-- --- Option A : PostgreSQL avec COPY (chemin serveur) -----------------
-- Adaptez le chemin absolu vers le fichier CSV.
COPY financial_data (
    segment, country, product, discount_band, units_sold,
    manufacturing_price, sale_price, gross_sales, discounts, sales,
    cogs, profit, sale_date, month_number, month_name, sale_year,
    profit_margin_pct, cost_ratio_pct, discount_rate_pct, roi_pct, year_month
)
FROM 'C:/projet/BI4/financial-analysis-dashboard/data/financial_data_clean.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

-- --- Option B : depuis psql côté client (si COPY serveur indisponible) -
-- \copy financial_data (segment, country, product, discount_band, units_sold,
--   manufacturing_price, sale_price, gross_sales, discounts, sales, cogs, profit,
--   sale_date, month_number, month_name, sale_year, profit_margin_pct,
--   cost_ratio_pct, discount_rate_pct, roi_pct, year_month)
--   FROM 'data/financial_data_clean.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

-- Contrôle de chargement
SELECT COUNT(*) AS nb_lignes,
       MIN(sale_date) AS premiere_date,
       MAX(sale_date) AS derniere_date
FROM financial_data;
