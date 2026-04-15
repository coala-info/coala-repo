---
name: bioconductor-sc3
description: SC3 performs unsupervised clustering of single-cell RNA-seq data using a consensus approach to ensure high accuracy and robustness. Use when user asks to cluster scRNA-seq data, estimate the optimal number of clusters, identify marker genes, or visualize consensus matrices and silhouette plots.
homepage: https://bioconductor.org/packages/release/bioc/html/SC3.html
---

# bioconductor-sc3

## Overview

SC3 is a Bioconductor package for unsupervised clustering of single-cell RNA-seq (scRNA-seq) data. It achieves high accuracy and robustness by integrating multiple clustering solutions through a consensus approach. SC3 is designed to work with the `SingleCellExperiment` class and integrates with `scater` for quality control and visualization.

## Core Workflow

### 1. Data Preparation
SC3 requires a `SingleCellExperiment` (SCE) object containing both `counts` and `logcounts` assays. It also requires a `feature_symbol` column in the `rowData`.

```r
library(SingleCellExperiment)
library(SC3)

# Create SCE if starting from a matrix
sce <- SingleCellExperiment(
    assays = list(
        counts = as.matrix(counts_matrix),
        logcounts = log2(as.matrix(counts_matrix) + 1)
    )
)

# Required: Define feature_symbol
rowData(sce)$feature_symbol <- rownames(sce)
# Required: Remove duplicated feature names
sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]
```

### 2. Running the Clustering Pipeline
The `sc3()` function is a wrapper that executes the entire pipeline.

```r
# Run SC3 for a range of k (number of clusters)
# biology = TRUE calculates DE genes, marker genes, and outliers
sce <- sc3(sce, ks = 2:5, biology = TRUE, n_cores = 1)
```

### 3. Detailed Step-by-Step Execution
For more control, you can run the internal steps individually:

1. `sc3_prepare(sce)`: Initialize parameters.
2. `sc3_estimate_k(sce)`: Estimate the optimal number of clusters using Tracy-Widom theory.
3. `sc3_calc_dists(sce)`: Calculate Euclidean, Pearson, and Spearman distances.
4. `sc3_calc_transfs(sce)`: Perform PCA and Graph Laplacian transformations.
5. `sc3_kmeans(sce, ks = 2:4)`: Perform k-means clustering on transformations.
6. `sc3_calc_consens(sce)`: Build the consensus matrix.
7. `sc3_calc_biology(sce)`: Calculate biological features (DE, markers).

### 4. Large Datasets (> 5,000 cells)
For large datasets, SC3 uses a hybrid SVM approach to maintain performance.

```r
# Trigger SVM by specifying training cells
sce <- sc3(sce, ks = 2:4, svm_num_cells = 500)

# Predict labels for the remaining cells
sce <- sc3_run_svm(sce, ks = 2:4)
```

## Visualization and Results

### Accessing Results
Results are stored in `colData` (cell clusters and outlier scores) and `rowData` (DE and marker gene statistics), prefixed with `sc3_`.

```r
# View cluster assignments for k=3
colData(sce)$sc3_3_clusters

# View marker gene stats for k=3
rowData(sce)$sc3_3_markers_auroc
```

### Plotting Functions
SC3 provides specific plotting functions to evaluate clustering quality:

*   **Consensus Matrix**: `sc3_plot_consensus(sce, k = 3)` - Look for clean diagonal blocks.
*   **Silhouette Plot**: `sc3_plot_silhouette(sce, k = 3)` - Measures clustering stability.
*   **Expression Heatmap**: `sc3_plot_expression(sce, k = 3)` - Visualizes gene expression across clusters.
*   **Marker Genes**: `sc3_plot_markers(sce, k = 3)` - Shows top markers for each cluster.
*   **DE Genes**: `sc3_plot_de_genes(sce, k = 3)` - Shows differentially expressed genes.

## Tips
*   **Parallelization**: By default, SC3 uses all but one core. Use `n_cores` in `sc3()` or `sc3_prepare()` to limit memory usage.
*   **Interactive Mode**: Use `sc3_interactive(sce)` to launch a Shiny app for manual exploration of clusters.
*   **Export**: Use `sc3_export_results_xls(sce)` to save all clustering and biological results to an Excel file.

## Reference documentation
- [SC3 package manual](./references/SC3.md)
- [SC3 R Markdown Source](./references/SC3.Rmd)