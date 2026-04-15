---
name: bioconductor-ipath
description: This tool performs individual-level pathway analysis to quantify pathway alterations within single tumor samples. Use when user asks to calculate individualized enrichment scores, identify perturbed pathways, perform survival association analysis, or visualize pathway score distributions and Kaplan-Meier curves.
homepage: https://bioconductor.org/packages/release/bioc/html/iPath.html
---

# bioconductor-ipath

## Overview
The `iPath` package provides a computational framework for individual-level pathway analysis. Unlike traditional methods that compare groups of samples, iPath quantifies the magnitude of alteration for a specific pathway within a single tumor sample. This allows for the identification of "normal-like" vs. "perturbed" samples for each pathway, which can then be linked to clinical outcomes like overall survival.

## Core Workflow

### 1. Data Preparation
iPath requires a normalized gene expression matrix (e.g., RPKM/TPM) and a Gene Set Database (GSDB).
- **Expression Matrix**: Rows are genes, columns are samples.
- **GSDB**: A list where each element is a character vector of gene symbols representing a pathway.
- **Phenotype Vector**: A binary vector (`0` for normal/control, `1` for tumor/case).

```r
library(iPath)
# Load example data
data(PRAD_data) # contains prad_exprs, prad_inds, prad_cli
data(GSDB_example)
```

### 2. Calculating Individualized Enrichment Scores (iES)
The `iES_cal2` function calculates the iES for every sample across all provided pathways.

```r
# Calculate iES matrix (Pathways x Samples)
iES_mat <- iES_cal2(Y = prad_exprs, GSDB = GSDB_example)
```

### 3. Survival Association Analysis
The `iES_surv` function identifies pathways where the perturbation status (determined via Gaussian Mixture Modeling using normal samples as a reference) is significantly associated with survival.

```r
# Test association with clinical outcomes
# cli: data frame with 'time' and 'status' columns
# indVec: binary vector (0=normal, 1=tumor)
surv_results <- iES_surv(iES_mat = iES_mat, cli = prad_cli, indVec = prad_inds)
head(surv_results)
```

## Visualization

### Waterfall and Density Plots
Use these to visualize the distribution of iES scores across samples for a specific pathway.

```r
# Waterfall plot of iES scores
water_fall(iES_mat, gs_str = "SimPathway2", indVec = prad_inds)

# Density plot of iES scores
density_fall(iES_mat, gs_str = "SimPathway2", indVec = prad_inds)
```

### Survival Plots
Visualize Kaplan-Meier curves comparing "perturbed" vs. "normal-like" groups for a specific pathway.

```r
iES_survPlot(iES_mat = iES_mat, 
             cli = prad_cli, 
             gs_str = "SimPathway1", 
             indVec = prad_inds, 
             title = TRUE)
```

## Tips for Success
- **Gene Identifiers**: Ensure the gene symbols in your expression matrix match the identifiers used in the GSDB (e.g., MSigDB).
- **Normal Samples**: iPath relies on normal samples to establish a baseline for "normal" pathway activity. Ensure your `indVec` correctly identifies these samples with `0`.
- **Filtering**: The package internally filters genes based on standard deviation to remove low-variance noise.

## Reference documentation
- [The iPath User's Guide (Rmd)](./references/iPath.Rmd)
- [The iPath User's Guide (Markdown)](./references/iPath.md)