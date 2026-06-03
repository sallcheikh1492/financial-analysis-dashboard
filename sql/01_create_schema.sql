-- =====================================================================
-- Projet BI : Analyse financière d'une entreprise
-- 01 - Création du schéma et de la table financial_data (PostgreSQL)
-- =====================================================================

DROP TABLE IF EXISTS financial_data;

CREATE TABLE financial_data (
    id                  SERIAL PRIMARY KEY,
    segment             VARCHAR(50)    NOT NULL,
    country             VARCHAR(60)    NOT NULL,
    product             VARCHAR(50)    NOT NULL,
    discount_band       VARCHAR(20)    NOT NULL,
    units_sold          NUMERIC(12,2)  NOT NULL,
    manufacturing_price NUMERIC(12,2)  NOT NULL,
    sale_price          NUMERIC(12,2)  NOT NULL,
    gross_sales         NUMERIC(16,2)  NOT NULL,
    discounts           NUMERIC(16,2)  NOT NULL,
    sales               NUMERIC(16,2)  NOT NULL,   -- chiffre d'affaires net
    cogs                NUMERIC(16,2)  NOT NULL,   -- coût des ventes
    profit              NUMERIC(16,2)  NOT NULL,
    sale_date           DATE           NOT NULL,
    month_number        SMALLINT       NOT NULL,
    month_name          VARCHAR(20)    NOT NULL,
    sale_year           SMALLINT       NOT NULL,
    profit_margin_pct   NUMERIC(8,4),
    cost_ratio_pct      NUMERIC(8,4),
    discount_rate_pct   NUMERIC(8,4),
    roi_pct             NUMERIC(8,4),
    year_month          VARCHAR(7)                  -- ex. '2014-01'
);

-- Index pour accélérer les agrégations du dashboard
CREATE INDEX idx_fd_date    ON financial_data (sale_date);
CREATE INDEX idx_fd_product ON financial_data (product);
CREATE INDEX idx_fd_segment ON financial_data (segment);
CREATE INDEX idx_fd_country ON financial_data (country);
