---
name: bioconductor-tomoda
description: The bioconductor-tomoda package analyzes tomo-seq data to identify spatial zones and peak genes across consecutive tissue sections. Use when user asks to analyze tomo-seq data, identify anatomic zones, find spatially expressed peak genes, or visualize gene expression traces across tissue sections.
homepage: https://bioconductor.org/packages/release/bioc/html/tomoda.html
---


# bioconductor-tomoda

## Overview
The `tomoda` package is designed for the analysis of tomo-seq data, which consists of RNA-seq profiles from consecutive tissue sections. It enables the identification of anatomic zones with similar transcriptional profiles and the discovery of spatially expressed "peak genes." The package uses `SummarizedExperiment` objects as the primary data structure and provides integrated visualization tools based on `ggplot2`.

## Core Workflow

### 1. Data Initialization
Create a `tomoda` object from a count matrix where rows are genes and columns are sections ordered spatially.

```r
library(tomoda)
library(SummarizedExperiment)

# Load example data or your own matrix
data(zh.data) 

# Create object (filters genes in < 3 sections by default)
# Normalizes to median library size and calculates Z-scores (scaled assay)
zh <- createTomo(zh.data)

# Access assays
counts <- assay(zh, "count")
normalized <- assay(zh, "normalized")
scaled <- assay(zh, "scaled")
```

### 2. Identifying Spatial Zones
Use correlation and dimensionality reduction to find borders between tissue regions.

*   **Correlation Heatmap:** Identify abrupt changes in transcriptional similarity between adjacent sections.
    ```r
    corHeatmap(zh, max.cor = 0.3)
    ```
*   **Dimensionality Reduction:** Embed sections in 2D space to find clusters.
    ```r
    zh <- runPCA(zh)
    zh <- runTSNE(zh)
    zh <- runUMAP(zh)
    embedPlot(zh, method = "TSNE")
    ```
*   **Clustering:** Formally define zones using K-means or hierarchical clustering.
    ```r
    zh <- kmeansClust(zh, centers = 3)
    embedPlot(zh, group = 'kmeans_cluster')
    ```

### 3. Peak Gene Analysis
Find genes that are significantly upregulated in specific spatial regions.

*   **Find Peak Genes:** Identify genes exceeding a `threshold` for a minimum `length` of consecutive sections.
    ```r
    # nperm controls the permutation test for p-values
    peak_genes <- findPeakGene(zh, threshold = 1, length = 4, nperm = 1e5)
    ```
*   **Visualize Peaks:**
    ```r
    # Heatmap of peak gene expression across sections
    expHeatmap(zh, peak_genes$gene, size = 0)
    
    # Correlation between peak genes to find co-regulated modules
    geneCorHeatmap(zh, peak_genes, group = 'start', size = 0)
    ```

### 4. Expression Traces
Plot the expression of specific genes across the spatial axis.

```r
# Line plot with LOESS smoothing
linePlot(zh, c("GENE1", "GENE2"), facet = TRUE)

# Raw traces (no smoothing)
linePlot(zh, c("GENE1"), span = 0)
```

## Customization Tips
Since `tomoda` outputs `ggplot2` objects, you can extend them using standard ggplot syntax:
*   **Colors:** `plot + scale_fill_gradient2(...)`
*   **Themes:** `plot + theme_classic()`
*   **Axes:** `plot + scale_x_discrete(breaks = ...)`

## Reference documentation
- [tomoda for tomo-seq data analysis](./references/tomoda.Rmd)
- [tomoda for tomo-seq data analysis (Markdown)](./references/tomoda.md)