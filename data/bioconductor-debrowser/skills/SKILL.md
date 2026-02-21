---
name: bioconductor-debrowser
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/debrowser.html
---

# bioconductor-debrowser

name: bioconductor-debrowser
description: Interactive differential expression (DE) analysis and visualization using DESeq2, EdgeR, and Limma. Use this skill when you need to perform RNA-Seq data normalization, low-count filtering, batch effect correction, or generate interactive plots (Scatter, Volcano, MA, Heatmaps) and GO/KEGG enrichment analysis within an R environment.

# bioconductor-debrowser

## Overview
The `debrowser` package provides an interactive Shiny-based interface and a suite of R functions for differential expression analysis. It streamlines the workflow from raw count data to biological insight by integrating popular DE tools (DESeq2, edgeR, limma) with advanced visualization and quality control metrics. It is particularly useful for users who want to explore their data interactively while maintaining the ability to script specific parts of the analysis.

## Quick Start
To launch the interactive user interface:
```r
library(debrowser)
startDEBrowser()
```

## Core Workflow

### 1. Data Preparation
DEBrowser requires two main inputs:
*   **Count Data**: A matrix or data frame where the first column contains Gene IDs and subsequent columns contain raw integer counts for each sample.
*   **Metadata**: A data frame where rows correspond to samples and columns define conditions (e.g., treatment, batch).

### 2. Low Count Filtering
Filter out genes with low expression to improve statistical power.
*   **Max**: `max(count) < threshold`
*   **Mean**: `mean(count) < threshold`
*   **CPM**: Filter based on Counts Per Million.

### 3. Batch Effect Correction
If your metadata includes batch information, use `ComBat` or `Harman` via the interface or integrated modules to adjust for systematic biases before DE analysis.

### 4. Differential Expression Analysis
The package supports three primary methods:
*   **DESeq2**: Best for raw counts; uses a negative binomial distribution.
*   **EdgeR**: Suitable for raw counts; uses empirical Bayes estimation.
*   **Limma**: Preferred for normalized or transformed data (e.g., microarray or log-transformed RNA-Seq).

### 5. Visualization and Exploration
*   **Main Plots**: Generate interactive Scatter, Volcano, and MA plots.
*   **Heatmaps**: Use `getHeatmapUI` and `debrowserheatmap` for customizable, interactive heatmaps with various clustering (Ward, Complete, etc.) and distance (Euclidean, Correlation) metrics.
*   **QC Plots**: Assess sample replicates using PCA, All2All correlation plots, Density plots, and IQR boxplots.

## Specialized Functions
*   `startHeatmap()`: A standalone module to create heatmaps from any data frame (e.g., log2 fold change comparisons).
*   `getJSLine()`: Used in custom Shiny apps to include necessary JavaScript dependencies for DEBrowser modules.

## Tips for Success
*   **Normalization**: Always normalize data (e.g., MRN, TMM, or RLE) before generating heatmaps or performing PCA to ensure samples are comparable.
*   **Interactive Selection**: In the Shiny UI, use the "Lasso" or "Box Select" tools on scatter plots to dynamically generate heatmaps for specific gene subsets.
*   **Search**: Use the search field in the Data Options to highlight specific gene lists or use regex (e.g., `^Abc`) for advanced filtering.

## Reference documentation
- [DEBrowser user guide](./references/DEBrowser.Rmd)
- [DEBrowser user guide](./references/DEBrowser.md)