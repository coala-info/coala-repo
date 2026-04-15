---
name: bioconductor-condcomp
description: The condcomp package quantifies and characterizes distribution differences between two conditions within scRNA-seq cell clusters to identify biological shifts or clustering artifacts. Use when user asks to compare cell distributions between conditions, analyze intra-cluster heterogeneity, or calculate Z-scores and silhouette widths for condition-specific clusters.
homepage: https://bioconductor.org/packages/3.8/bioc/html/condcomp.html
---

# bioconductor-condcomp

## Overview

The `condcomp` package provides tools to characterize and quantify differences between two conditions within identified cell types or clusters in scRNA-seq data. It helps determine if the distribution of cells from different conditions within a cluster is heterogeneous, which can indicate biological shifts or clustering artifacts.

## Installation

Install the package using BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("condcomp")
```

## Core Workflow

The typical workflow involves preparing a Seurat or SingleCellExperiment object, generating a distance matrix, and running the comparison.

### 1. Prepare Data and Distance Matrix
The analysis requires a distance matrix, typically calculated from reduced dimensionality space (like PCA embeddings) to capture the relationships between cells.

```r
library(condcomp)
library(Seurat)

# Assuming 'seurat_obj' is processed and has 'Condition' and 'Cluster' metadata
# Extract PCA embeddings and compute Euclidean distance
pca_embeddings <- Embeddings(seurat_obj, reduction = "pca")[, 1:10]
dmatrix <- as.matrix(dist(pca_embeddings, method = "euclidean"))
```

### 2. Run condcomp Analysis
Execute the main analysis function. The `n` parameter determines the number of permutations; higher values increase reliability.

```r
# Run the comparison
ccomp_results <- condcomp(
  ident = seurat_obj$Cluster,        # Cluster assignments
  condition = seurat_obj$Condition,  # Condition labels (e.g., "Control", "Stim")
  dist_matrix = dmatrix,             # Pre-computed distance matrix
  n = 10000                          # Number of permutations (10k recommended)
)

# Always adjust p-values for multiple testing
ccomp_results$pval_adj <- p.adjust(ccomp_results$pval, method = "bonferroni")
```

### 3. Visualize Results
Use the built-in plotting function to visualize Z-scores, condition ratios, and IQR-based heterogeneity indicators.

```r
condcompPlot(ccomp_results, main = "Intra-cluster Heterogeneity Analysis")
```

## Interpreting Results

The output dataframe contains several key metrics for each cluster:

- **Z-score**: High Z-scores indicate significant heterogeneity between conditions within the cluster.
- **pval / pval_adj**: Low values (e.g., < 0.05) suggest the conditions are distributed differently than expected by chance.
- **Ratio (e.g., 24_ratio)**: Shows the predominance of one condition over the other.
- **IQR**: Labeled as "Same" or "Diff". "Diff" indicates that the interquartile range of distances suggests heterogeneity.
- **true_sil**: The silhouette width, providing another measure of how well conditions are separated within the cluster.

## Usage Tips

- **Parameter n**: For publication-quality results or large datasets, set `n = 10000` or higher. The default (1000) is suitable for quick exploratory runs.
- **Input Space**: While PCA is standard, you can use other embeddings (UMAP, t-SNE) for the distance matrix calculation depending on which aspect of the data geometry you wish to test.
- **Cluster Annotation**: This analysis is most powerful when clusters are already annotated with cell types, allowing you to identify specific cell populations that respond heterogeneously to a treatment.

## Reference documentation

- [scRNA-seq data heterogeneity with condcomp](./references/condcomp.md)