# Guide de construction du dashboard Power BI

> ✅ **Le dashboard final est livré : [`Financial_Analysis.pbix`](Financial_Analysis.pbix)**
> (4 pages : Accueil · Vue d'ensemble · Marges & Coûts · Prévisions).
> Les arrière-plans de page sont dans [`assets/`](assets) (`page_accueil.png`, `page_background.png`).
>
> Ce guide documente la **reconstruction** du dashboard (~20 min) à partir de
> `data/financial_data_clean.csv`, pour ceux qui veulent comprendre ou reproduire la démarche.

## Étape 1 — Importer les données
1. **Accueil → Obtenir les données → Texte/CSV**
2. Sélectionner `data/financial_data_clean.csv` (encodage 65001 / UTF-8).
3. Vérifier les types : `Date` = Date, montants = Nombre décimal, `Year` = Nombre entier.
4. **Charger**.

## Étape 2 — Modèle de données
1. Créer la table **`Calendar`** (voir [DAX_measures.md](DAX_measures.md) §5).
2. Vue *Modèle* → relier `Calendar[Date]` → `financial_data[Date]`.
3. Marquer `Calendar` comme **table de dates**.

## Étape 3 — Créer les mesures
Copier toutes les mesures de [DAX_measures.md](DAX_measures.md) (KPI, ratios, time-intelligence).

## Étape 4 — Page 1 : « Vue d'ensemble »
**Bandeau de cartes KPI** (visuel *Carte*), une par mesure :
`CA Total` · `Profit Total` · `Marge Moyenne %` · `Croissance CA %` · `COGS Total`

**Visualisations :**
| Visuel | Champs |
|---|---|
| Courbe — *Évolution mensuelle du CA et du Profit* | Axe : `Calendar[Année-Mois]` · Valeurs : `CA Total`, `Profit Total` |
| Barres horizontales — *Top produits par profit* | Axe : `Product` · Valeur : `Profit Total` |
| Carte / Map — *CA par pays* | Localisation : `Country` · Taille : `CA Total` |
| Anneau — *Répartition du CA par segment* | Légende : `Segment` · Valeur : `CA Total` |

## Étape 5 — Page 2 : « Marges & Coûts »
| Visuel | Champs |
|---|---|
| Barres — *Marge moyenne par segment* | Axe : `Segment` · Valeur : `Marge Moyenne %` |
| Courbe — *Marge selon niveau de remise* | Axe : `Discount_Band` · Valeur : `Marge Moyenne %` |
| Histogramme empilé — *COGS vs Profit par produit* | Axe : `Product` · Valeurs : `COGS Total`, `Profit Total` |
| **Compte de résultat** (matrice ou cartes) | Ventes Brutes → −Remises → CA net → −COGS → Profit |

## Étape 6 — Page 3 : « Prévisions »
1. Courbe `CA Total` par `Calendar[Date]`.
2. Volet *Analyse → Prévision* : activer, horizon = **6 mois**, IC = 95 %.
   (Reproduit la prévision du notebook ; le CSV `data/forecast_6m.csv` peut aussi être importé
   comme série superposée.)

## Étape 7 — Filtres (slicers) — sur toutes les pages
Ajouter des segments (*slicers*) pour : `Year` · `Month_Name` · `Country` · `Product` · `Segment`.
Utiliser **Synchroniser les segments** pour les partager entre les pages.

## Étape 8 — Mise en forme
- Thème cohérent (Accueil → Thèmes), titres explicites, format monétaire `$ # ##0`.
- Info-bulles, et bouton de réinitialisation des filtres.
- **Fichier → Enregistrer sous** → `powerbi/Financial_Analysis.pbix`.

## Aperçu attendu
Les 6 figures du dossier `reports/figures/` illustrent le rendu cible de chaque visuel.
