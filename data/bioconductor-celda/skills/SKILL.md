---
name: bioconductor-celda
description: This tool provides Bayesian hierarchical models for bi-clustering single-cell RNA-seq data and removing ambient RNA contamination. Use when user asks to perform cell and feature clustering, identify co-expression modules, or decontaminate counts from ambient RNA.
homepage: https://bioconductor.org/packages/release/bioc/html/celda.html
---


# bioconductor-celda

name: bioconductor-celda
description: Bayesian hierarchical models for bi-clustering single-cell RNA-seq data (celda) and estimating/removing ambient RNA contamination (DecontX). Use this skill when analyzing single-cell genomic data to perform cell and feature clustering, identify co-expression modules, or decontaminate counts from ambient RNA.

# bioconductor-celda

## Overview
The `celda` package provides a suite of Bayesian models for single-cell RNA-seq analysis. Its primary strengths are:
1. **Bi-clustering (celda)**: Simultaneously clustering cells into subpopulations and features (genes) into co-expression modules.
2. **Decontamination (DecontX)**: Estimating and removing ambient RNA contamination that occurs during droplet-based scRNA-seq (e.g., 10X Genomics).

The package integrates with the `SingleCellExperiment` (SCE) class, making it compatible with the broader Bioconductor ecosystem.

## Core Workflows

### 1. Ambient RNA Decontamination with DecontX
Use `DecontX` early in your pipeline, typically after generating a count matrix but before downstream clustering.

```r
library(celda)
# x can be a SingleCellExperiment or a count matrix
sce <- decontX(x = sce)

# Access results
contamination_scores <- colData(sce)$decontX_contamination
decont_counts <- decontXcounts(sce)

# Visualize contamination on UMAP
plotDecontXContamination(sce)
```
*Tip: If you have a "raw" matrix (including empty droplets), pass it to the `background` parameter to improve ambient RNA estimation.*

### 2. Feature Selection and Bi-clustering
`celda_CG` clusters both cells (K) and feature modules (L).

```r
# 1. Feature Selection (heuristic)
sce <- selectFeatures(sce)

# 2. Run Bi-clustering
# K = expected cell populations, L = expected gene modules
sce <- celda_CG(sce, K = 5, L = 10)

# 3. Access clusters and modules
cell_clusters <- celdaClusters(sce)
gene_modules <- celdaModules(sce)
```

### 3. Determining K and L (Model Selection)
If the number of clusters (K) or modules (L) is unknown, use recursive splitting or grid search.

```r
# Recursive splitting to find L (modules)
moduleSplit <- recursiveSplitModule(sce, initialL = 2, maxL = 15)
plotGridSearchPerplexity(moduleSplit)
plotRPC(moduleSplit) # Look for the "elbow"

# Once L is chosen, find K (cells)
sce_L10 <- subsetCeldaList(moduleSplit, params = list(L = 10))
cellSplit <- recursiveSplitCell(sce_L10, initialK = 3, maxK = 12)
plotRPC(cellSplit)
```

## Visualization and Utilities

### Dimensionality Reduction
`celda` provides wrappers for UMAP and tSNE that work with its clustering results.
```r
sce <- celdaUmap(sce)
plotDimReduceCluster(sce, reducedDimName = "celda_UMAP")
plotDimReduceModule(sce, reducedDimName = "celda_UMAP", module = 1)
```

### Heatmaps and Probability Maps
* **celdaHeatmap**: Shows normalized expression of top features in each module.
* **celdaProbabilityMap**: Visualizes the relationship between feature modules and cell populations.
* **moduleHeatmap**: Focuses on features within a specific module across cells.

### Utility Functions
* **featureModuleLookup**: Find which module a specific gene belongs to.
* **recodeClusterZ / recodeClusterY**: Rename or reorder cell/feature clusters for better interpretability.

## Reference documentation
- [Analysis of single-cell genomic data with celda](./references/celda.md)
- [Estimate and remove cross-contamination from ambient RNA in single-cell data with DecontX](./references/decontX.md)