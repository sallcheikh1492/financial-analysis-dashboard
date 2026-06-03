# 📊 Analyse financière d'une entreprise — Projet Business Intelligence

🌐 **Langue :** **🇫🇷 Français** · [🇬🇧 English](README.en.md)

Projet BI de bout en bout analysant les performances financières d'une entreprise :
nettoyage des données, KPI financiers, compte de résultat, prévisions et dashboard interactif.
Réalisé avec **Python · SQL · Power BI**.

> **Dataset :** Microsoft *Financial Sample* — 700 transactions, sept. 2013 → déc. 2014.
> 5 segments · 5 pays · 6 produits.

---

## 🎯 Objectifs

1. Évaluer l'évolution du chiffre d'affaires
2. Mesurer les marges et la rentabilité
3. Étudier les coûts et dépenses (dont les remises)
4. Identifier les produits / segments les plus rentables
5. Réaliser des prévisions financières
6. Aider à la prise de décision stratégique

## 📈 Résultats clés

| KPI | Valeur |
|---|---:|
| Chiffre d'affaires (Sales) | **118,7 M$** |
| Coût des ventes (COGS) | 101,8 M$ |
| Remises commerciales | 9,2 M$ |
| Profit total | **16,9 M$** |
| Marge moyenne | **14,2 %** |
| ROI global | 16,6 % |
| Unités vendues | 1 125 806 |

**Insights principaux :**
- 🥇 Produit le plus profitable : **Paseo** (≈ 4,8 M$ de profit) ; meilleure marge : **Amarilla**.
- 🏢 Segment le plus contributeur : **Government** ; meilleure marge : **Channel Partners**.
- 🌍 Premier marché : **États-Unis** (≈ 25 M$ de CA).
- 💸 La marge se dégrade fortement avec les remises élevées (*Discount Band = High*).
- 🔮 Prévision CA à 6 mois ≈ 9,9 M$/mois (modèle retenu après comparaison de 3 approches).

## 🗂️ Structure du projet

```
financial-analysis-dashboard/
├── data/
│   ├── Financial_Sample.xlsx          # dataset brut (source Microsoft)
│   ├── financial_data_clean.csv       # données nettoyées + variables calculées
│   └── forecast_6m.csv                # prévision du CA sur 6 mois
├── notebooks/
│   └── financial_analysis.ipynb       # nettoyage, EDA, KPI, prévisions (exécuté)
├── sql/
│   ├── 01_create_schema.sql           # table financial_data + index
│   ├── 02_load_data.sql               # import du CSV (COPY / \copy)
│   └── 03_analysis_queries.sql        # 10 requêtes d'analyse
├── powerbi/
│   ├── DAX_measures.md                # toutes les mesures DAX
│   └── Power_BI_Build_Guide.md        # guide pas-à-pas du dashboard
├── reports/
│   ├── Financial_Analysis_Report.pdf  # rapport synthétique (3 pages)
│   └── figures/                       # 6 graphiques exportés
├── requirements.txt
└── README.md
```

## ⚙️ Installation & exécution

```bash
# 1. Dépendances Python
pip install -r requirements.txt

# 2. Lancer le notebook (nettoyage + analyse + prévisions)
jupyter notebook notebooks/financial_analysis.ipynb
#   -> produit data/financial_data_clean.csv, forecast_6m.csv et reports/figures/*.png

# 3. Base de données (PostgreSQL)
psql -d ma_base -f sql/01_create_schema.sql
psql -d ma_base -f sql/02_load_data.sql      # adapter le chemin du CSV
psql -d ma_base -f sql/03_analysis_queries.sql

# 4. Dashboard Power BI
#   Suivre powerbi/Power_BI_Build_Guide.md à partir de financial_data_clean.csv
```

## 🛠️ Étapes méthodologiques

1. **Compréhension des données** — dictionnaire des variables et indicateurs financiers.
2. **Nettoyage (Python)** — noms de colonnes normalisés (espaces parasites), gestion des
   `Discount Band` manquants, doublons, types, dates, détection d'outliers (IQR),
   contrôle des identités comptables (Sales = Gross − Discounts ; Profit = Sales − COGS).
3. **Variables calculées** — `Profit_Margin_%`, `Cost_Ratio_%`, `Discount_Rate_%`, `ROI_%`.
4. **Analyse SQL** — KPI globaux, top produits, performances pays/segment, ventes mensuelles,
   croissance (fonctions fenêtre `LAG`), compte de résultat.
5. **Compte de résultat simplifié** — Ventes brutes → Remises → CA net → COGS → Profit net.
6. **Prévisions** — comparaison **moyenne mobile / régression linéaire / SARIMA** sur un
   hold-out (MAE, RMSE), puis projection à 6 mois avec le meilleur modèle.
7. **KPI financiers** — CA, profit, marge, croissance, coût, rentabilité, ROI.
8. **Dashboard Power BI** — KPI, évolutions, top produits, carte par pays, marges,
   compte de résultat, prévisions + filtres (année, mois, pays, produit, segment).
9. **Recommandations business**.

## 💡 Recommandations business

- **Développer** les produits les plus profitables et les segments à forte marge.
- **Encadrer** les remises élevées qui érodent la marge.
- **Réduire** le coût des produits à faible ROI (renégociation / repositionnement prix).
- **Anticiper** trésorerie et stocks via la prévision à 6 mois.

## 🧰 Technologies

`Python` · `Pandas` · `NumPy` · `Matplotlib` · `Seaborn` · `scikit-learn` · `statsmodels`
· `SQL (PostgreSQL)` · `Power BI` · `Jupyter`

## 🎓 Compétences démontrées

Finance Analytics · KPI financiers · Forecasting · SQL · Python · Power BI ·
Analyse financière · Data Visualization · Business Intelligence

---

### 📌 Note sur le fichier `.pbix`
Le format `.pbix` de Power BI est binaire et ne peut pas être généré par script. Le dossier
`powerbi/` fournit **toutes les mesures DAX** et un **guide de reconstruction pas-à-pas**
(~20 min) à partir du CSV nettoyé. Enregistrez le résultat sous
`powerbi/Financial_Analysis.pbix`.
