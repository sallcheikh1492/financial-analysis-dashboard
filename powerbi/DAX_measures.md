# Mesures DAX — Dashboard « Analyse financière »

Créez ces mesures dans Power BI (table `financial_data`). Une table de dates dédiée
(`Calendar`) est recommandée pour la time-intelligence.

## 1. KPI de base
```DAX
CA Total        = SUM(financial_data[Sales])
COGS Total      = SUM(financial_data[COGS])
Remises Totales = SUM(financial_data[Discounts])
Profit Total    = SUM(financial_data[Profit])
Unités Vendues  = SUM(financial_data[Units_Sold])
Ventes Brutes   = SUM(financial_data[Gross_Sales])
```

## 2. Ratios financiers
```DAX
Marge Moyenne % =
DIVIDE([Profit Total], [CA Total], 0)

Taux de Coût % =
DIVIDE([COGS Total], [CA Total], 0)

ROI % =
DIVIDE([Profit Total], [COGS Total], 0)

Taux de Remise % =
DIVIDE([Remises Totales], [Ventes Brutes], 0)
```
> Format des ratios : **Pourcentage**. (Ex. `Marge Moyenne %` ≈ 14,2 %.)

## 3. Time-intelligence (nécessite une table Calendar reliée à Date)
```DAX
CA Mois Précédent =
CALCULATE([CA Total], DATEADD('Calendar'[Date], -1, MONTH))

Croissance CA % =
VAR prev = [CA Mois Précédent]
RETURN DIVIDE([CA Total] - prev, prev, BLANK())

CA Cumulé (YTD) =
TOTALYTD([CA Total], 'Calendar'[Date])

Profit YTD =
TOTALYTD([Profit Total], 'Calendar'[Date])
```

## 4. Mesures d'analyse
```DAX
Marge Produit % =
DIVIDE(
    CALCULATE([Profit Total]),
    CALCULATE([CA Total]),
    0
)

Rang Produit par Profit =
RANKX(ALL(financial_data[Product]), [Profit Total],, DESC, Dense)

Top 1 Produit (Profit) =
CALCULATE(
    SELECTEDVALUE(financial_data[Product]),
    TOPN(1, ALL(financial_data[Product]), [Profit Total], DESC)
)
```

## 5. Table calendrier (à créer en DAX)
```DAX
Calendar =
ADDCOLUMNS(
    CALENDAR(DATE(2013,9,1), DATE(2014,12,31)),
    "Année",      YEAR([Date]),
    "Mois N°",    MONTH([Date]),
    "Mois",       FORMAT([Date], "MMM"),
    "Année-Mois", FORMAT([Date], "YYYY-MM")
)
```
Reliez `Calendar[Date]` → `financial_data[Date]` (relation 1-à-plusieurs).
