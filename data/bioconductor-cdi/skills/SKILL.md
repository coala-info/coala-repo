---
name: bioconductor-cdi
description: This tool evaluates and selects optimal clustering labels for single-cell RNA-sequencing UMI counts using the Clustering Deviation Index. Use when user asks to compare different clustering results, determine the optimal number of clusters, or evaluate clustering performance across single or multiple batches using AIC or BIC criteria.
homepage: https://bioconductor.org/packages/release/bioc/html/CDI.html
---


# bioconductor-cdi

name: bioconductor-cdi
description: Select optimal clustering labels for single-cell RNA-sequencing (scRNA-seq) UMI counts using the Clustering Deviation Index (CDI). Use this skill when you need to compare different clustering results (e.g., from Seurat or K-Means), determine the optimal number of clusters, or evaluate clustering performance across single or multiple batches using AIC/BIC criteria.

# bioconductor-cdi

## Overview

The `CDI` package provides a statistical framework to evaluate and select the optimal clustering labels for scRNA-seq UMI count data. It models raw UMI counts using a cell-type-specific and gene-specific Negative Binomial (NB) model. Unlike many methods that require normalized data, CDI works directly with raw counts to avoid artifacts introduced by normalization or imputation. It is particularly useful for deciding between different clustering resolutions or algorithms.

## Core Workflow

### 1. Data Preparation
CDI requires a raw UMI count matrix (genes as rows, cells as columns). If working with multiple batches, a batch label vector is also required.

```r
library(CDI)

# X: Raw UMI count matrix
# cand_lab_df: Data frame where each column is a set of candidate labels
# batch_label: Vector of batch identifiers (optional)
```

### 2. Feature Gene Selection
Select genes that vary across cell types to reduce computational burden and noise. The "Working Dispersion Score" (WDS) method is recommended.

```r
feature_gene_indx <- feature_gene_selection(
  X = count_matrix, 
  batch_label = batch_vector, # NULL if single batch
  method = "wds", 
  nfeature = 500
)
sub_matrix <- count_matrix[feature_gene_indx, ]
```

### 3. Calculate Size Factors
Calculate gene-specific size factors before computing the CDI.

```r
sf <- size_factor(X = count_matrix)
```

### 4. Compute CDI
Calculate the index for all candidate label sets. This returns a data frame containing CDI-AIC and CDI-BIC values.

```r
cdi_results <- calculate_CDI(
  X = sub_matrix, 
  cand_lab_df = label_dataframe, 
  batch_label = batch_vector, 
  cell_size_factor = sf
)
```

## Interpreting Results

*   **CDI-BIC**: Recommended for selecting **main cell types**. It applies a heavier penalty on model complexity (number of clusters).
*   **CDI-AIC**: Recommended for selecting **subtypes** or finer-grained clusters.
*   **Optimal Labels**: The label set with the **minimum** CDI value (AIC or BIC) is considered the optimal clustering.

## Visualization

### Line Plots
Visualize the CDI values across different numbers of clusters and methods.

```r
# Red triangle indicates the minimum value
CDI_lineplot(cdi_dataframe = cdi_results, cdi_type = "CDI_BIC")
```

### Contingency Heatmaps
Compare the selected optimal labels against a benchmark (if available).

```r
contingency_heatmap(
  benchmark_label = true_labels,
  candidate_label = cdi_results_best_column,
  rename_candidate_clusters = TRUE
)
```

## Tips for Multi-batch Data
*   Candidate labels should be generated after batch effect correction (e.g., using Seurat Integration or Harmony).
*   However, `calculate_CDI` must be run on the **raw UMI counts** while providing the `batch_label` argument to account for batch effects in the underlying NB model.

## Reference documentation

- [Clustering Deviation Index (CDI) Tutorial](./references/CDI.md)
- [CDI Vignette Source](./references/CDI.Rmd)