---
name: bioconductor-scrapper
description: This tool provides high-performance R bindings to C++ libraries for fast and memory-efficient single-cell RNA-seq, CITE-seq, and CRISPR data analysis. Use when user asks to perform quality control, normalize counts, select highly variable genes, run dimensionality reduction, cluster cells, or detect marker genes within the Bioconductor ecosystem.
homepage: https://bioconductor.org/packages/release/bioc/html/scrapper.html
---

# bioconductor-scrapper

name: bioconductor-scrapper
description: Expert guidance for analyzing single-cell data using the scrapper R package. Use this skill when performing single-cell RNA-seq (scRNA-seq), CITE-seq (multi-modal), or CRISPR analysis workflows within the Bioconductor ecosystem. It covers quality control, normalization, feature selection, dimensionality reduction (PCA, t-SNE, UMAP), clustering, and marker detection using high-performance C++ bindings.

# bioconductor-scrapper

## Overview

The `scrapper` package provides R bindings to the **libscran** C++ libraries for high-performance single-cell data analysis. It is designed to be fast, memory-efficient, and thread-aware. While it is often used by developers to build pipelines, it offers a comprehensive suite of functions for end-to-end analysis, from raw counts to clustered data with identified markers.

## Core Workflows

### 1. The All-in-One Pipeline
For a standard analysis, use the `analyze()` function. It handles QC, normalization, PCA, clustering, and visualization coordinates in one call.

```r
library(scrapper)

# Basic RNA-seq analysis
res <- analyze(
    counts_matrix,
    rna.subsets = list(mito = is.mito), # logical vector for mitochondrial genes
    num.threads = 4
)

# Accessing results
res$clusters  # Cluster assignments
res$tsne      # t-SNE coordinates
res$umap      # UMAP coordinates
res$rna.markers # Marker statistics
```

### 2. Multi-modal Analysis (CITE-seq)
`scrapper` can jointly process RNA and ADT (Antibody Derived Tags) data.

```r
multi_res <- analyze(
    rna.counts,
    adt.x = adt.counts,
    rna.subsets = list(mito = is.mito),
    adt.subsets = list(igg = is.igg),
    num.threads = 4
)
```

### 3. Batch Correction
When working with multiple datasets, use the `block` argument to perform MNN (Mutual Nearest Neighbors) correction.

```r
res_blocked <- analyze(combined_counts, block = batch_vector)
```

## Step-by-Step Manual Workflow

If you need more control than `analyze()` provides, follow this sequence:

1.  **Quality Control**:
    *   `computeRnaQcMetrics(counts, subsets)`
    *   `suggestRnaQcThresholds(metrics)`
    *   `filterRnaQcMetrics(thresholds, metrics)`
2.  **Normalization**:
    *   `centerSizeFactors(metrics$sum)`
    *   `normalizeCounts(filtered_counts, size_factors)`
3.  **Feature Selection & PCA**:
    *   `modelGeneVariances(normalized)`
    *   `chooseHighlyVariableGenes(variances$statistics$residuals)`
    *   `runPca(normalized[hvgs,])`
4.  **Clustering & Visualization**:
    *   `runAllNeighborSteps(pca$components)` (Runs UMAP, t-SNE, and SNN clustering in parallel)
    *   Alternatively: `buildSnnGraph()` followed by `clusterGraph()`.
5.  **Marker Detection**:
    *   `scoreMarkers(normalized, groups = clusters)`
    *   Use `reportGroupMarkerStatistics(markers, group_id)` to extract results for a specific cluster.

## Interoperability

To move from `scrapper` results back into the standard Bioconductor `SingleCellExperiment` (SCE) format:

```r
sce <- convertAnalyzeResults(res)
```

## Specialized Functions

*   **Gene Set Scoring**: Use `scoreGeneSet()` to calculate per-cell activity scores for pathways.
*   **Subsampling**: Use `subsampleByNeighbors()` to select a representative subset of cells for faster downstream processing.
*   **CRISPR QC**: Use `computeCrisprQcMetrics()` for guide-based single-cell screens.
*   **Aggregation**: Use `aggregateAcrossCells()` to create pseudo-bulk profiles for differential expression.

## Reference documentation

- [Using scrapper to analyze single-cell data](./references/userguide.md)