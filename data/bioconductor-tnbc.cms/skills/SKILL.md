---
name: bioconductor-tnbc.cms
description: This tool classifies Triple-Negative Breast Cancer samples into consensus molecular subtypes using gene expression data. Use when user asks to classify TNBC samples, calculate gene expression signature scores, perform pathway enrichment analysis, or predict drug response and survival outcomes.
homepage: https://bioconductor.org/packages/3.9/bioc/html/TNBC.CMS.html
---

# bioconductor-tnbc.cms

name: bioconductor-tnbc.cms
description: Molecular subtype classification of Triple-Negative Breast Cancer (TNBC) using the TNBC.CMS R package. Use this skill to classify TNBC samples into four consensus molecular subtypes (MSL, IM, LAR, SL) and analyze their genomic, clinical, and drug response characteristics.

## Overview

The `TNBC.CMS` package provides a machine learning-based classifier for Triple-Negative Breast Cancer. It categorizes samples into four Consensus Molecular Subtypes (CMS):
- **MSL**: Mesenchymal-like
- **IM**: Immunomodulatory
- **LAR**: Luminal AR
- **SL**: Stem-like

The package supports classification from gene expression profiles (microarray or RNA-seq) and provides tools for signature scoring, pathway enrichment (GSVA), survival analysis, and drug response prediction.

## Core Workflow

### 1. Data Preparation
Input data should be a matrix or a `SummarizedExperiment` object.
- **Rows**: Gene symbols (required).
- **Columns**: Samples.
- **Scaling**: Do NOT scale or log-transform the expression data before input.

```r
library(TNBC.CMS)
# Example using SummarizedExperiment
data("GSE25055")
expr_matrix <- assays(GSE25055)[[1]]
```

### 2. CMS Classification
Use `predictCMS` to assign subtypes.

```r
predictions <- predictCMS(GSE25055)
# View distribution
table(predictions)
# Access classification probabilities
probs <- attr(predictions, "probabilities")
head(probs)
```

### 3. Genomic Characterization
Calculate signature scores (EMT, Stromal, Immune, etc.) and perform pathway analysis.

```r
# Calculate 7 gene expression signatures (GES)
# Set rnaseq = TRUE if using RNA-seq data
resultGES <- computeGES(expr = GSE25055, pred = predictions, rnaseq = FALSE)

# Perform GSVA for pathway enrichment (default: Hallmark pathways)
resultGSVA <- performGSVA(expr = GSE25055, pred = predictions, gene.set = NULL)
```

### 4. Clinical & Survival Analysis
Analyze the association between subtypes and patient outcomes.

```r
time <- colData(GSE25055)$DFS.month
event <- colData(GSE25055)$DFS.status

# Kaplan-Meier Plot
plotKM(pred = predictions, time = time, event = event)

# Hazard Ratios for specific genes
gs <- c("RECK", "RELN", "EHD4")
plotHR(expr = GSE25055, gene.symbol = gs, pred = predictions, 
       time = time, event = event, by.subtype = TRUE)
```

### 5. Drug Response Prediction
Predict sensitivity to various compounds based on MSigDB CGP collections.

```r
# Higher scores indicate higher likelihood of response
resultDS <- computeDS(expr = GSE25055, pred = predictions)
```

## Tips and Best Practices
- **Gene Symbols**: Ensure row names are official Gene Symbols; the classifier relies on specific gene sets.
- **RNA-seq Data**: When using RNA-seq counts, set `rnaseq = TRUE` in `computeGES` and consider setting `gsva.kcdf = "Poisson"` in `performGSVA`.
- **Probability Thresholds**: Always check the `probabilities` attribute. Samples with very close probabilities across multiple subtypes may represent transitional states.
- **Drug Names**: When providing custom gene sets for `computeDS`, follow the naming convention: `[DRUG]_[RESPONSE/RESISTANCE]_[UP/DN]`.

## Reference documentation
- [TNBC.CMS Prediction of TNBC Consensus Molecular Subtype](./references/TNBC.CMS.md)