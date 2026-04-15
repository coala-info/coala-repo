---
name: bioconductor-antiprofilesdata
description: This package provides curated gene expression z-scores from normal and cancerous colon tissue samples for developing anti-profile signatures. Use when user asks to access the apColonData ExpressionSet, analyze gene expression variability in colon cancer, or retrieve frma-normalized data from hypomethylation blocks.
homepage: https://bioconductor.org/packages/release/data/experiment/html/antiProfilesData.html
---

# bioconductor-antiprofilesdata

## Overview
The `antiProfilesData` package is a Bioconductor experiment data package. It contains curated gene expression data from Affymetrix hgu133plus2 arrays, specifically focused on normal colon tissue and colon cancer samples. The data is provided as z-scores calculated using the `frma` (Frozen Robust Multiarray Analysis) barcode method. This dataset was specifically developed to support the "anti-profiles" approach, which identifies genomic regions with increased expression variability in cancer compared to normal tissues.

## Data Structure
The primary object in this package is `apColonData`, an `ExpressionSet` object.

### Expression Data (z-scores)
- The `exprs(apColonData)` matrix contains z-scores.
- These scores represent the deviation of gene expression from a distribution of "unexpressed" genes.
- The probes included are specifically mapped to genes within colon cancer hypomethylation blocks.

### Phenotype Data (Metadata)
The `pData(apColonData)` contains several critical columns for analysis:
- `Status`: Indicator where `0` is Normal and `1` is Cancer.
- `Tissue`: The tissue type.
- `SubType`: Sample sub-type annotation.
- `ClinicalGroup`: Clinical annotations.
- `DB_ID`: The GSM sample ID from GEO.

## Typical Workflow

### 1. Loading the Data
To use the dataset, you must load the package and then use the `data()` function.

```r
library(antiProfilesData)
data(apColonData)
```

### 2. Inspecting the Dataset
Since the data is an `ExpressionSet`, use standard `Biobase` methods to inspect it.

```r
# View metadata
head(pData(apColonData))

# Check sample sizes for Normal vs Cancer
table(apColonData$Status)

# Access expression z-scores
z_scores <- exprs(apColonData)
dim(z_scores)
```

### 3. Basic Analysis Example
You can use the `Status` column to compare expression variability or mean z-scores between normal and cancer groups.

```r
# Example: Compare mean z-scores for the first 5 probes across groups
group_means <- apply(exprs(apColonData)[1:5, ], 1, function(x) {
  tapply(x, apColonData$Status, mean)
})
print(group_means)
```

## Usage Tips
- **Anti-Profile Building**: This data is intended for use with the `antiProfiles` package (if available) to build signatures based on variance rather than just mean expression changes.
- **Z-score Interpretation**: A z-score significantly above 0 suggests the gene is "expressed" or "active" relative to the background noise defined by the `frma` barcode algorithm.
- **Hypomethylation Blocks**: Remember that this specific dataset is filtered for probes within hypomethylation blocks; it is not a whole-genome representation.

## Reference documentation
- [antiProfilesData Reference Manual](./references/reference_manual.md)