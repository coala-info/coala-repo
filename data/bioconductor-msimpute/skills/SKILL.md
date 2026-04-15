---
name: bioconductor-msimpute
description: This tool imputes missing peptide intensities in proteomics data using low-rank approximation while preserving biological signals. Use when user asks to diagnose missingness patterns, perform structured imputation for MAR or MNAR data, or assess imputation quality using structural metrics.
homepage: https://bioconductor.org/packages/release/bioc/html/msImpute.html
---

# bioconductor-msimpute

name: bioconductor-msimpute
description: Imputation of peptide intensity in proteomics experiments using low-rank approximation. Use this skill when you need to diagnose missingness patterns (MAR vs MNAR) in mass spectrometry data, perform structured imputation, or assess the impact of imputation on data distribution and structural metrics.

## Overview

The `msImpute` package provides a framework for imputing missing peptide intensities in proteomics data. It is particularly effective because it uses low-rank approximation to recover missing values while preserving the biological signal. It includes tools to determine if missing values are Missing At Random (MAR) or Missing Not At Random (MNAR), allowing users to choose the most appropriate imputation strategy (e.g., supervised MNAR imputation using experimental design).

## Core Workflow

### 1. Data Preparation and Normalization
Data should be log-transformed. If zero values exist, add a small offset before transformation.

```r
library(msImpute)
library(limma)

# Load data (example using package data)
data(pxd014777)
y <- pxd014777

# Log transformation with offset if zeros are present
y <- log2(y + 0.25)

# Normalization (e.g., quantile or cyclic loess)
y <- normalizeBetweenArrays(y, method = "quantile")
```

### 2. Diagnosing Missingness Patterns
Use `selectFeatures` to identify peptides with structured missingness. This helps determine if the data is MNAR (e.g., batch-specific or group-specific dropouts).

```r
# Define experimental groups
batch <- as.factor(gsub("(2018.*)_RF.*","\\1", colnames(y)))

# Identify informative features
# method="ebm" (Entropy-based) detects peptides missing in specific groups (NaN EBM)
# method="hvp" (High Variable Proportion) detects high dropout at high abundance
hdp <- selectFeatures(y, method = "ebm", group = batch)

# Check for structured missingness (NaN values in EBM column)
table(is.nan(hdp$EBM))
```

### 3. Imputation
Choose the method based on the diagnosis from step 2.

*   **MAR Data:** Use `method = "v2"`. No design matrix required.
*   **MNAR Data:** Use `method = "v2-mnar"`. Requires a `design` matrix or `group` factor to perform supervised imputation.

```r
# For MNAR data
group <- as.factor(sample_annot$group)
design <- model.matrix(~0+group)
y_imputed <- msImpute(y, method = "v2-mnar", design = design)

# For MAR data
y_imputed_mar <- msImpute(y, method = "v2")
```

### 4. Post-Imputation Assessment
Evaluate the quality of imputation using structural metrics and CV plots.

```r
# 1. Visual assessment of Variance preservation
par(mfrow=c(1,2))
plotCV2(y, main = "Original")
plotCV2(y_imputed, main = "Imputed")

# 2. Structural Metrics (Withinness, Betweenness)
# Returns metrics measuring preservation of local and global structures
metrics <- computeStructuralMetrics(y_imputed, group, y = NULL)
print(metrics$withinness)
print(metrics$betweenness)
```

## Key Functions

*   `selectFeatures(y, method, group)`: Identifies informative peptides for missingness diagnosis.
*   `msImpute(y, method, design, rank.max)`: Main imputation function. `rank.max` can be adjusted (default is determined automatically).
*   `plotCV2(y)`: Diagnostic plot of $CV^2$ vs mean log-expression to check for variance inflation.
*   `computeStructuralMetrics(y_imputed, group, y_raw)`: Calculates "withinness" (local structure) and "betweenness" (global structure). Can also compute Gromov-Wasserstein (GW) distance if a Python environment with `POT` is configured.

## Tips
*   **Filtering:** It is recommended to retain peptides with at least 4 observed values across all samples before running `msImpute`.
*   **MNAR vs MAR:** If only a very small fraction of missing peptides show structured patterns (e.g., < 10%), the MAR method (`v2`) may be sufficient and more robust.
*   **Low-Rank Approximation:** This method is generally superior to simple constant or distribution-based imputation (like QRILC) because it doesn't drastically inflate the variance of the peptides.

## Reference documentation
- [msImpute: Imputation of peptide intensity by low-rank approximation](./references/msImpute-vignette.md)
- [msImpute: proteomics missing values imputation and diagnosis](./references/msImpute-vignette.Rmd)