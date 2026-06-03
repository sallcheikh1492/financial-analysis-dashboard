-- =====================================================================
-- 03 - Requêtes d'analyse financière
-- Compatible PostgreSQL (notes MySQL en commentaire si besoin)
-- =====================================================================

-- 1) KPI globaux : CA, coûts, profit, marge, ROI -----------------------
SELECT
    SUM(sales)                              AS chiffre_affaires,
    SUM(cogs)                               AS cout_des_ventes,
    SUM(discounts)                          AS remises_totales,
    SUM(profit)                             AS profit_total,
    ROUND(SUM(profit) / SUM(sales)  * 100, 2) AS marge_moyenne_pct,
    ROUND(SUM(profit) / SUM(cogs)   * 100, 2) AS roi_global_pct,
    SUM(units_sold)                         AS unites_vendues
FROM financial_data;

-- 2) Produits les plus rentables ---------------------------------------
SELECT
    product,
    SUM(sales)   AS chiffre_affaires,
    SUM(profit)  AS profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS marge_pct,
    SUM(units_sold) AS unites
FROM financial_data
GROUP BY product
ORDER BY profit DESC;

-- 3) Performance par pays ----------------------------------------------
SELECT
    country,
    SUM(sales)  AS chiffre_affaires,
    SUM(profit) AS profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS marge_pct
FROM financial_data
GROUP BY country
ORDER BY chiffre_affaires DESC;

-- 4) Performance par segment -------------------------------------------
SELECT
    segment,
    SUM(sales)  AS chiffre_affaires,
    SUM(profit) AS profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS marge_pct
FROM financial_data
GROUP BY segment
ORDER BY profit DESC;

-- 5) Ventes mensuelles + marge moyenne ---------------------------------
SELECT
    year_month,
    SUM(sales)  AS chiffre_affaires,
    SUM(profit) AS profit,
    ROUND(AVG(profit_margin_pct), 2) AS marge_moyenne_pct
FROM financial_data
GROUP BY year_month
ORDER BY year_month;

-- 6) Taux de croissance mensuel (fonction fenêtre) ---------------------
WITH mensuel AS (
    SELECT year_month, SUM(sales) AS ca
    FROM financial_data
    GROUP BY year_month
)
SELECT
    year_month,
    ca,
    LAG(ca) OVER (ORDER BY year_month) AS ca_mois_precedent,
    ROUND( (ca - LAG(ca) OVER (ORDER BY year_month))
           / NULLIF(LAG(ca) OVER (ORDER BY year_month), 0) * 100, 2) AS croissance_pct
FROM mensuel
ORDER BY year_month;

-- 7) Périodes de forte croissance (croissance > 20 %) ------------------
WITH mensuel AS (
    SELECT year_month, SUM(sales) AS ca
    FROM financial_data GROUP BY year_month
), croissance AS (
    SELECT year_month, ca,
           (ca - LAG(ca) OVER (ORDER BY year_month))
           / NULLIF(LAG(ca) OVER (ORDER BY year_month), 0) * 100 AS croissance_pct
    FROM mensuel
)
SELECT year_month, ca, ROUND(croissance_pct, 2) AS croissance_pct
FROM croissance
WHERE croissance_pct > 20
ORDER BY croissance_pct DESC;

-- 8) Impact des remises sur la marge -----------------------------------
SELECT
    discount_band,
    SUM(sales)                              AS chiffre_affaires,
    SUM(discounts)                          AS remises,
    ROUND(AVG(profit_margin_pct), 2)        AS marge_moyenne_pct
FROM financial_data
GROUP BY discount_band
ORDER BY marge_moyenne_pct DESC;

-- 9) Compte de résultat simplifié --------------------------------------
SELECT 'Ventes brutes'        AS poste, SUM(gross_sales)  AS montant FROM financial_data
UNION ALL
SELECT '(-) Remises',           -SUM(discounts)            FROM financial_data
UNION ALL
SELECT '= CA net (Sales)',       SUM(sales)               FROM financial_data
UNION ALL
SELECT '(-) Cout des ventes',   -SUM(cogs)                FROM financial_data
UNION ALL
SELECT '= Profit net',           SUM(profit)              FROM financial_data;

-- 10) Top 10 combinaisons Produit x Pays les plus rentables ------------
SELECT
    product, country,
    SUM(profit) AS profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS marge_pct
FROM financial_data
GROUP BY product, country
ORDER BY profit DESC
LIMIT 10;   -- MySQL : LIMIT 10  | SQL Server : utiliser TOP 10
