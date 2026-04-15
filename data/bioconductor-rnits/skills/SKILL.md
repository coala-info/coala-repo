---
name: bioconductor-rnits
description: This tool analyzes time-course microarray data using B-spline basis models to identify genes with differential expression trajectories. Use when user asks to perform normalization, clustering, and inference of differential expression for temporal gene expression studies.
homepage: https://bioconductor.org/packages/release/bioc/html/Rnits.html
---

# bioconductor-rnits

name: bioconductor-rnits
description: Analysis of time-course microarray data using B-spline basis models. Use this skill to perform normalization, clustering, and inference of differential expression for temporal gene expression studies. It is particularly useful for identifying genes with distinct trajectories across different treatments or conditions.

## Overview

The `Rnits` package provides a framework for the end-to-end analysis of time-series microarray experiments. It uses a model-driven approach based on B-splines to fit expression trajectories. Differential expression is inferred by comparing a null model (one curve for all conditions) against an alternative model (distinct curves for each condition) using a ratio statistic and bootstrap-based p-value estimation.

## Core Workflow

### 1. Data Preparation
`Rnits` requires specific columns in your phenotype data (`pData`):
*   **"Sample"**: The condition or treatment group.
*   **"Time"**: The numeric time points (must be identical across series).
*   **"GeneName"**: Required in feature data for gene-level summarization.

### 2. Building the Rnits Object
You can initialize an `Rnits` object from an `ExpressionSet`, `RGList`, `AffyBatch`, or a simple data matrix.

```R
library(Rnits)

# From an ExpressionSet 'dat'
rnitsobj <- build.Rnits(dat, logscale = TRUE, normmethod = "Between")

# From a data matrix
rnitsobj <- build.Rnits(dat_matrix, 
                        probedata = probe_df, 
                        phenodata = pheno_df, 
                        logscale = TRUE)
```

### 3. Fitting the Model
The `fit` function performs the core analysis. It can cluster genes to apply different spline complexities to different expression patterns.

```R
# Standard fit with gene-level summarization and clustering
rnitsobj <- fit(rnitsobj, gene.level = TRUE, clusterallsamples = TRUE)

# Alternative: Use Generalized Cross-Validation (GCV) to select the model
opt_model <- calculateGCV(rnitsobj)
rnitsobj <- fit(rnitsobj, gene.level = TRUE, model = opt_model)
```

### 4. Extracting Results
Retrieve statistics, p-values, and filtered gene lists.

```R
# Get all fit data (Ratio statistic, p-value, cluster ID)
fit_results <- getFitModel(rnitsobj)

# Get top genes at a specific False Discovery Rate (FDR)
top_genes_data <- topData(rnitsobj, fdr = 5)

# Summary of top 10 genes
summary(rnitsobj, top = 10)
```

### 5. Visualization
Visualize the trajectories of the most significant genes.

```R
# Plot trajectories for the top 16 genes
plotResults(rnitsobj, top = 16)
```

## Key Functions

*   `build.Rnits()`: Constructor for the Rnits object; handles normalization.
*   `getLR()`: Extracts normalized expression values (can perform K-nn imputation).
*   `fit()`: Main analysis function; performs B-spline modeling and bootstrapping.
*   `calculateGCV()`: Pre-calculates the optimal spline model using generalized cross-validation.
*   `getPval()` / `getStat()`: Accessors for p-values and ratio statistics.
*   `plotResults()`: Generates ggplot2-based trajectory plots.

## Tips for Success
*   **Imputation**: If your data has missing values, use `getLR(rnitsobj, impute = TRUE)` before fitting.
*   **Clustering**: If the model fails to converge, `Rnits` will automatically reduce the number of clusters. You can also manually specify the number of clusters in `fit()`.
*   **Control Series**: You can designate one series as a 'control' for the purpose of initial clustering.

## Reference documentation

- [The Rnits package for normalization and inference of differential expression in time series microarray data](./references/Rnits-vignette.md)