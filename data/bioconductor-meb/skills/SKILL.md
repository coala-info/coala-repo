---
name: bioconductor-meb
description: This tool identifies differentially expressed genes in bulk and single-cell RNA-seq data using the Minimum Enclosing Ball method. Use when user asks to detect differentially expressed genes in same-species or cross-species datasets, identify outliers in RNA-seq data without normalization, or perform clustering-independent single-cell differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/MEB.html
---


# bioconductor-meb

name: bioconductor-meb
description: Detect differentially expressed genes (DEGs) in RNA-seq and scRNA-seq data using the Minimum Enclosing Ball (MEB) method. Use this skill to identify DEGs in same-species or cross-species RNA-seq datasets (SFMEB/NIMEB) and single-cell RNA-seq datasets (scMEB) without requiring prior cell clustering or extensive normalization.

# bioconductor-meb

## Overview

The `MEB` package provides a non-parametric, scaling-free approach to identifying differentially expressed genes (DEGs). It works by defining a "Minimum Enclosing Ball" in feature space that covers non-DE genes (housekeeping or conserved genes). Genes falling outside this ball are classified as DEGs. This method is particularly useful because it does not require data normalization and can handle cross-species comparisons where gene lengths and distributions differ.

## Core Workflows

### 1. Bulk RNA-seq (SFMEB/NIMEB)
Used for comparing two samples or species. It requires a set of known "training" genes (e.g., housekeeping genes for same-species or conserved orthologs for cross-species).

```r
library(MEB)
library(SummarizedExperiment)

# Load data (countsTable should be a matrix or assay from SummarizedExperiment)
# For cross-species, include gene lengths: [length1, count1, length2, count2]
data(sim_data_sp)
counts <- assay(sim_data_sp)

# Define a range for the kernel parameter gamma
gamma_range <- seq(1e-06, 5e-05, 1e-06)

# Train the model
# train_id: indices of housekeeping/conserved genes
# ds: FALSE for same species, TRUE for different species
meb_model <- NIMEB(countsTable = counts, 
                   train_id = 1:1000, 
                   gamma = gamma_range, 
                   nu = 0.01, 
                   reject_rate = 0.05, 
                   ds = FALSE)

# Predict DEGs
# TRUE = non-DE (inside ball), FALSE = DE (outside ball/outlier)
predictions <- predict(meb_model$model, counts)
summary(predictions)
```

### 2. Single-Cell RNA-seq (scMEB)
A fast, clustering-independent method for scRNA-seq DE detection.

```r
library(SingleCellExperiment)

# Requires a SingleCellExperiment object and a vector of stable gene names/indices
data(sim_scRNA_data)
data(stable_gene)

# Run scMEB
sc_result <- scMEB(sce = sim_scRNA_data, 
                   stable_idx = stable_gene, 
                   filtered = TRUE, 
                   gamma = seq(1e-04, 0.001, 1e-05), 
                   nu = 0.01, 
                   reject_rate = 0.1)

# Predict using PCA-transformed data stored in the result
sc_preds <- predict(sc_result$model, sc_result$dat_pca)
summary(sc_preds)

# Rank genes by distance (larger distance = more likely to be a DEG)
gene_ranks <- data.frame(Gene = rownames(sim_scRNA_data), 
                         Distance = sc_result$dist)
```

## Key Parameters

*   `gamma`: A vector of candidate values for the radial basis function kernel. The function selects the optimal value based on the `reject_rate`.
*   `nu`: The upper bound on the fraction of training errors (default 0.01).
*   `reject_rate`: The expected proportion of outliers in the training set.
*   `ds`: Logical. Set to `TRUE` if the data involves different species (requires gene length columns).

## Interpreting Results

*   **Model Output**: Includes the trained SVM-based model, the selected `gamma`, and the `train_error`.
*   **Logical Predictions**: The `predict()` function returns `TRUE` for genes that match the training distribution (non-DE) and `FALSE` for genes that are outliers (DEGs).
*   **Distance**: In `scMEB`, the `dist` value represents the distance to the sphere. Positive values indicate the gene is outside the ball (potential DEG).

## Reference documentation
- [NIMEB](./references/NIMEB.md)