---
name: bioconductor-scater
description: bioconductor-scater provides tools for quality control, visualization, and dimensionality reduction of single-cell RNA-seq data. Use when user asks to calculate QC metrics, plot gene expression, perform PCA, t-SNE, or UMAP, and visualize SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/scater.html
---


# bioconductor-scater

name: bioconductor-scater
description: Tools for visualization, quality control, and dimensionality reduction of single-cell RNA-seq data. Use this skill to perform exploratory data analysis (EDA) on SingleCellExperiment objects, including plotting QC metrics, visualizing gene expression, and generating/plotting reduced dimension representations like PCA, t-SNE, and UMAP.

# bioconductor-scater

## Overview
`scater` (Single-cell analysis toolkit for expression in R) provides a suite of tools for the visualization and quality control of single-cell transcriptomic data. It operates on the `SingleCellExperiment` (SCE) class, ensuring interoperability with other Bioconductor packages like `scran` and `scuttle`. Its primary strengths are automated QC metric calculation, high-level plotting functions for diagnostic analysis, and wrappers for common dimensionality reduction algorithms.

## Core Workflow

### 1. Quality Control and Diagnostic Plots
Before analysis, calculate QC metrics and visualize them to identify low-quality cells (e.g., high mitochondrial content or low library size).

```r
library(scater)

# Calculate QC metrics (often uses scuttle under the hood)
sce <- addPerCellQC(sce, subsets=list(Mito=grep("mt-", rownames(sce))))

# Plot metadata variables (e.g., total counts vs detected genes)
plotColData(sce, x = "sum", y="detected", colour_by="tissue")

# Plot mitochondrial percentage faceted by a condition
plotColData(sce, x = "sum", y="subsets_Mito_percent") + facet_wrap(~tissue)

# Identify most highly expressed genes
plotHighestExprs(sce, exprs_values = "counts")
```

### 2. Normalization and Variance Analysis
`scater` provides utilities to normalize data and assess which experimental factors contribute to expression variance.

```r
# Log-normalize counts
sce <- logNormCounts(sce)

# Calculate variance explained by specific variables
vars <- getVarianceExplained(sce, variables=c("batch", "sex", "age"))
plotExplanatoryVariables(vars)
```

### 3. Visualizing Expression
Use `plotExpression()` to visualize the distribution of expression values for specific genes across different cell groups.

```r
# Violin plots for specific genes across a categorical variable
plotExpression(sce, features = c("Gene1", "Gene2"), x = "cell_type")

# Scatter plot of one gene vs another
plotExpression(sce, features = "Gene1", x = "Gene2")
```

### 4. Dimensionality Reduction
`scater` provides wrappers to run and store dimensionality reduction results in the `reducedDims` slot of the SCE object.

```r
# PCA: Uses top 500 variable genes by default
sce <- runPCA(sce, ncomponents = 50)

# t-SNE: Requires a seed for reproducibility
set.seed(100)
sce <- runTSNE(sce, dimred = "PCA", n_dimred = 10)

# UMAP
sce <- runUMAP(sce, dimred = "PCA")
```

### 5. Plotting Reduced Dimensions
Visualize cells in reduced space, colored by gene expression or metadata.

```r
# Generic plotting function
plotReducedDim(sce, dimred = "PCA", colour_by = "cell_type")

# Specialized wrappers
plotPCA(sce, colour_by = "Gene1")
plotTSNE(sce, colour_by = "batch")
```

## Custom Visualization with ggplot2
For plots not covered by standard functions, `ggcells()` and `ggfeatures()` extract data into a `ggplot2`-friendly data frame format while maintaining access to all SCE slots.

```r
# Custom boxplot using ggcells
ggcells(sce, mapping=aes(x=cell_type, y=Gene1)) + 
    geom_boxplot() + 
    facet_wrap(~batch)

# Custom t-SNE with density contours
ggcells(sce, mapping=aes(x=TSNE.1, y=TSNE.2, colour=Gene1)) +
    geom_point() +
    stat_density_2d()
```

## Reference documentation
- [Single-cell analysis toolkit for expression in R](./references/overview.md)