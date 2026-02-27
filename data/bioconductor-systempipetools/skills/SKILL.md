---
name: bioconductor-systempipetools
description: This package provides data visualization and exploration tools for high-throughput sequencing workflows within the systemPipeR ecosystem. Use when user asks to transform count data, perform dimensionality reduction, or generate plots for differential expression analysis such as volcano plots and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/systemPipeTools.html
---


# bioconductor-systempipetools

name: bioconductor-systempipetools
description: Data visualization and exploration for high-throughput sequencing workflows. Use when Claude needs to transform count data (vst, rlog), perform dimensionality reduction (PCA, MDS, t-SNE, GLM-PCA), or visualize differential expression results (MA plots, Volcano plots, Heatmaps) within the systemPipeR ecosystem.

# bioconductor-systempipetools

## Overview

The `systemPipeTools` package extends the `systemPipeR` (SPR) workflow environment by providing a specialized toolkit for data visualization and exploration. It automates the analysis of differentially expressed genes (DEGs) and provides high-level wrappers for transforming raw count data and generating publication-quality plots. It integrates seamlessly with `systemPipeR` targets files and count matrices.

## Core Workflow

### 1. Data Preparation
Load the necessary metadata (targets) and the raw count matrix.

```r
library(systemPipeTools)
library(systemPipeR)

# Load targets and comparisons
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
targets <- read.delim(targetspath, comment = "#")
cmp <- readComp(file = targetspath, format = "matrix", delim = "-")

# Load count table
countMatrixPath <- system.file("extdata", "countDFeByg.xls", package = "systemPipeR")
countMatrix <- read.delim(countMatrixPath, row.names = 1)
```

### 2. Data Transformation
Use `exploreDDS` to transform raw counts for visualization. This function is a wrapper for `DESeq2` methods.

```r
# Methods: "rlog" (default) or "vst"
exploredds <- exploreDDS(countMatrix, targets, cmp = cmp[[1]], transformationMethod = "rlog")
```

### 3. Exploratory Data Analysis (EDA)
Visualize sample relationships and transformation effects.

*   **Transformation Comparison**: Use `exploreDDSplot` to see the effect of different transformations on sample distributions.
*   **Hierarchical Clustering**: Use `hclustplot` for dendrograms.
*   **PCA/MDS**: Use `PCAplot` or `MDSplot` to identify batch effects or sample clusters.
*   **t-SNE**: Use `tSNEplot` for non-linear dimensionality reduction.
*   **GLM-PCA**: Use `GLMplot` for generalized principal component analysis on raw counts.

```r
# PCA Plot
PCAplot(exploredds, plotly = FALSE)

# t-SNE Plot (requires raw count matrix)
tSNEplot(countMatrix, targets, perplexity = 5)
```

### 4. Visualizing Differential Expression
After performing DEG analysis (e.g., via `systemPipeR::run_DESeq2`), visualize the results.

*   **Heatmaps**: Use `heatMaplot` for sample-to-sample distances or specific gene sets.
*   **MA Plot**: Use `MAplot` to view log2 fold changes against mean expression.
*   **Volcano Plot**: Use `volcanoplot` to view significance vs. magnitude of change.

```r
# Heatmap of samples
heatMaplot(exploredds, clust = "samples", plotly = FALSE)

# Volcano Plot for a specific comparison
# degseqDF is the output from systemPipeR::run_DESeq2
volcanoplot(degseqDF, comparison = "M12-A12", filter = c(Fold = 1, FDR = 20))
```

## Tips for Effective Usage

*   **Interactive Plots**: Many functions (like `heatMaplot`, `PCAplot`, `MDSplot`) support a `plotly = TRUE` argument to generate interactive web-based visualizations.
*   **Filtering**: Use the `preFilter` argument in `exploreDDS` to remove low-count genes before transformation, which can improve visualization quality.
*   **Gene Highlighting**: In `MAplot` and `volcanoplot`, use the `genes` argument to label specific genes of interest.
*   **Automatic Saving**: Most plotting functions include parameters to save the output directly to a file (e.g., `pdf`, `png`).

## Reference documentation

- [systemPipeTools](./references/systemPipeTools.md)