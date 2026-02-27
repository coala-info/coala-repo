---
name: bioconductor-seventygenedata
description: This package provides the van't Veer and Van de Vijver breast cancer gene expression datasets as ExpressionSet objects for prognostic signature analysis. Use when user asks to load landmark breast cancer expression data, access clinical metadata for metastasis prediction, or analyze the 70-gene signature.
homepage: https://bioconductor.org/packages/release/data/experiment/html/seventyGeneData.html
---


# bioconductor-seventygenedata

## Overview

The `seventyGeneData` package provides two landmark breast cancer gene expression datasets as `ExpressionSet` objects: the **van't Veer** cohort (117 samples) and the **Van de Vijver** cohort (295 samples). These datasets were instrumental in developing and validating the 70-gene signature used for predicting breast cancer metastasis. The package includes normalized expression values (log ratios), p-values for significance, intensities, and comprehensive clinical metadata.

## Loading the Data

The package contains two primary datasets. Load them using the `data()` function:

```r
library(seventyGeneData)

# Load the van't Veer cohort (117 samples)
data(vantVeer)

# Load the Van de Vijver cohort (295 samples)
data(vanDeVijver)
```

## Working with ExpressionSets

Both datasets are stored as `ExpressionSet` objects. You can interact with them using standard `Biobase` methods:

### 1. Accessing Expression Data
The `assayData` contains multiple matrices. Use `exprs()` for the primary log-ratio data:

```r
# Get log-ratio expression values
exp_vtv <- exprs(vantVeer)

# Access additional assay data (pValue, intensity)
pvals <- assayDataElement(vantVeer, "pValue")
intensities <- assayDataElement(vantVeer, "intensity")
```

### 2. Accessing Clinical Metadata
Phenotypic information (age, tumor size, lymph node status, metastasis events) is stored in `pData`:

```r
clinical_vtv <- pData(vantVeer)
clinical_vdv <- pData(vanDeVijver)

# Key prognostic column: FiveYearMetastasis
# TRUE = metastasis within 5 years; FALSE = disease-free for 5+ years
table(clinical_vtv$FiveYearMetastasis)
```

### 3. Accessing Feature Annotation
The `featureData` includes gene symbols, accessions, and specific flags for the 70-gene signature:

```r
ann <- fData(vantVeer)

# Identify genes belonging to the original 70-gene signature
signature_genes <- ann[ann$genes70 == TRUE, ]
```

## Typical Workflow: Prognostic Analysis

A common use case is comparing the expression of the 70-gene signature across prognostic groups:

```r
# 1. Identify signature genes
sig_indices <- which(fData(vanDeVijver)$genes70 == TRUE)

# 2. Extract expression for these genes
sig_exprs <- exprs(vanDeVijver)[sig_indices, ]

# 3. Compare against 5-year metastasis status
prognosis <- pData(vanDeVijver)$FiveYearMetastasis

# Example: Simple heatmap or correlation check
# (Requires additional libraries like pheatmap or stats)
```

## Tips for Analysis

- **Data Scale**: The expression values are provided as pre-processed log10 ratios.
- **Sample Overlap**: Note that the Van de Vijver cohort (295 samples) includes some samples from the original van't Veer study. Use the `DataSetType` or clinical IDs to manage overlaps if merging.
- **Missing Values**: Check for `NA` values in clinical columns like `FiveYearMetastasis`, as some patients may not have reached the 5-year follow-up threshold or had confounding events.
- **Probes vs. Genes**: The feature data maps microarray reporters to accessions. Multiple reporters may map to the same gene symbol.

## Reference documentation

- [The seventyGenesData package: annotated gene expression data from the van’t Veer and Van de Vijver breast cancer cohorts](./references/seventyGeneData.md)