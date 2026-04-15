---
name: bioconductor-breastcancernki
description: This package provides a standardized ExpressionSet containing gene expression data and clinical metadata from the van't Veer and van de Vijver breast cancer studies. Use when user asks to load the NKI breast cancer dataset, access MammaPrint-related expression data, or perform survival analysis on clinical prognostic indicators.
homepage: https://bioconductor.org/packages/release/data/experiment/html/breastCancerNKI.html
---

# bioconductor-breastcancernki

## Overview
The `breastCancerNKI` package provides a standardized `ExpressionSet` (eSet) containing gene expression data, clinical annotations, and platform metadata from two landmark studies by van't Veer et al. (2002) and van de Vijver et al. (2002). The dataset includes 24,481 features across 337 samples from young breast cancer patients, famously used to develop the 70-gene prognosis signature (MammaPrint).

## Data Loading and Inspection
The primary object in this package is named `nki`.

```r
# Load the package and the dataset
library(breastCancerNKI)
library(Biobase)
data(nki)

# Inspect the ExpressionSet
nki

# Access expression matrix (Agilent dual-channel)
exp_matrix <- exprs(nki)

# Access clinical metadata (phenoData)
clinical_data <- pData(nki)

# Access feature/probe annotations
feature_info <- fData(nki)
```

## Common Workflows

### 1. Clinical Data Exploration
The `pData` contains critical prognostic indicators such as lymph node status, histological grade, and survival outcomes.

```r
# View available clinical variables
colnames(pData(nki))

# Summary of patient age and node status
summary(pData(nki)[, c("age", "node")])
```

### 2. Subsetting for Specific Analysis
You can subset the `nki` object like a matrix to focus on specific samples (e.g., lymph node negative patients) or specific genes.

```r
# Subset for lymph node negative patients (node == 0)
nki_node_neg <- nki[, which(pData(nki)$node == 0)]

# Subset for a specific gene (if you know the probe ID)
# Example: first 10 probes
nki_subset <- nki[1:10, ]
```

### 3. Integration with Survival Analysis
The dataset is frequently used with the `survcomp` or `genefu` packages to validate prognostic signatures.

```r
# Example: Extracting survival time and event
surv_time <- pData(nki)$t.dmfs  # Time to distant metastasis-free survival
surv_event <- pData(nki)$e.dmfs # Event indicator
```

## Tips for Usage
- **Platform**: The data was generated using Agilent oligonucleotide microarrays.
- **Normalization**: The expression values are typically provided as log-ratios. Check `experimentData(nki)` for specific processing details.
- **Gene Symbols**: To map probe IDs to Gene Symbols, inspect `fData(nki)`. If symbols are missing, use Bioconductor annotation packages like `org.Hs.eg.db`.
- **Missing Values**: Always check for `NA` values in clinical columns before running survival models (e.g., `sum(is.na(pData(nki)$node))`).

## Reference documentation
- [Reference Manual](./references/reference_manual.md)