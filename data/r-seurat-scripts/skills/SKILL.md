---
name: r-seurat-scripts
description: R package seurat-scripts (documentation from project home).
homepage: https://cran.r-project.org/web/packages/seurat-scripts/index.html
---

# r-seurat-scripts

## Overview
The `seurat-scripts` package provides a collection of R scripts and functions designed to wrap the Seurat (v4.4.0) internal workflow into modular, executable steps. It is primarily used to build reproducible single-cell analysis pipelines, offering native support for converting between Seurat objects, SingleCellExperiment (SCE), Loom, and AnnData formats.

## Installation
To install the package within an R environment:
```R
install.packages("seurat-scripts")
```
*Note: This package is also commonly deployed via Bioconda for workflow integration.*

## Core Workflow Functions

### Data Loading and Preprocessing
*   **Read 10X Data**: Use `seurat-read-10x.R` logic to load 10X Genomics matrix directories.
*   **Cell Filtering**: Filter poor-quality cells based on metrics like `nFeature_RNA` (nGene) and `nCount_RNA` (nUMI).
*   **Normalization**: Apply `NormalizeData` logic using methods such as "LogNormalize" with configurable scale factors.

### Feature Selection and Scaling
*   **Variable Gene Discovery**: Identify highly variable features using mean-dispersion relationships or "vst" methods.
*   **Data Scaling**: Scale and center data, with the ability to regress out unwanted sources of variation (e.g., mitochondrial content or batch effects).

### Dimensionality Reduction and Clustering
*   **PCA**: Run Principal Component Analysis and export embeddings or loadings.
*   **t-SNE/UMAP**: Generate non-linear dimensional reductions for visualization.
*   **Clustering**: Construct SNN graphs and identify clusters using the Louvain or Leiden algorithms at specified resolutions.

### Integration and Reference Mapping
*   **Transfer Anchors**: Project a reference dataset onto a query dataset using `FindTransferAnchors`.
*   **Map Query**: Transfer labels and embeddings from a reference to a query object.

## Format Conversion
The package provides robust utilities for interoperability:
*   **Input Formats**: Seurat, AnnData, Loom, SingleCellExperiment.
*   **Output Formats**: Seurat, Loom, SingleCellExperiment.
*   **Usage**: `seurat-convert.R` logic allows for seamless transitions between R-based single-cell objects and Python-compatible formats (AnnData/Loom).

## Tips for Success
*   **Assay Management**: Always specify the assay (e.g., "RNA" or "SCT") when working with multi-modal data or after running SCTransform.
*   **Memory Efficiency**: When converting to Loom, ensure table headers do not contain characters that are illegal in R data frames.
*   **Visualization**: Use the `seurat-dim-plot.R` logic for standardized ggplot2-based dimensionality reduction plots.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)