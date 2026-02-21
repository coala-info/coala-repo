---
name: bioconductor-hoodscanr
description: the package are built based on the SpatialExperiment object, allowing integration into various spatial transcriptomics-related packages from Bioconductor. The package can result in cell-level neighborhood annotation output, along with funtions to perform neighborhood colocalization analysis and neighborhood-based cell clustering.
homepage: https://bioconductor.org/packages/release/bioc/html/hoodscanR.html
---

# bioconductor-hoodscanr

name: bioconductor-hoodscanr
description: Cellular neighborhood analysis for spatial transcriptomics data with single-cell resolution. Use this skill to perform neighborhood scanning, colocalization analysis, and neighborhood-based cell clustering using the SpatialExperiment infrastructure.

# bioconductor-hoodscanr

## Overview
`hoodscanR` is a Bioconductor package designed for analyzing the spatial microenvironment of cells in single-cell spatial transcriptomics data. It utilizes a modified softmax algorithm to calculate the probability of a cell belonging to specific cellular neighborhoods based on its k-nearest neighbors. The package integrates seamlessly with the `SpatialExperiment` class and provides tools for neighborhood annotation, colocalization metrics, and spatial clustering.

## Core Workflow

### 1. Data Preparation
The package expects a `SpatialExperiment` object. Use `readHoodData` to ensure the object is formatted correctly, specifically identifying the column containing cell type annotations.

```r
library(hoodscanR)
library(SpatialExperiment)

# Format SpatialExperiment object
# anno_col: the column name in colData containing cell type labels
spe <- readHoodData(spe, anno_col = "cell_type_column")

# Visualize initial tissue layout
plotTissue(spe, color = cell_type_column)
```

### 2. Neighborhood Scanning
Neighborhood identification is a multi-step process involving finding nearest neighbors and calculating association probabilities.

```r
# Step A: Find k-nearest cells (e.g., k = 100)
# Returns a list with 'cells' (annotations) and 'distance' matrices
fnc <- findNearCells(spe, k = 100)

# Step B: Calculate neighborhood probabilities using modified softmax
pm <- scanHoods(fnc$distance)

# Step C: Merge probabilities by cell type groups
hoods <- mergeByGroup(pm, fnc$cells)

# Step D: Integrate results back into the SpatialExperiment object
spe <- mergeHoodSpe(spe, hoods)
```

### 3. Neighborhood Analysis & Metrics
Quantify the complexity of the microenvironment using entropy and perplexity.

```r
# Calculate entropy and perplexity
spe <- calcMetrics(spe, pm_cols = colnames(hoods))

# Visualize perplexity (1 = distinct neighborhood, 2 = 50/50 mix)
plotTissue(spe, color = perplexity)
```

### 4. Colocalization and Clustering
Analyze how different cell types interact spatially and group cells by their neighborhood profiles.

```r
# Colocalization: Pearson correlation of neighborhood distributions
plotColocal(spe, pm_cols = colnames(hoods))

# Clustering: Group cells based on neighborhood probability distribution (k-means)
spe <- clustByHood(spe, pm_cols = colnames(hoods), k = 10)

# Visualize clusters on tissue
plotTissue(spe, color = clusters)

# Plot probability distributions for each cluster
plotProbDist(spe, pm_cols = colnames(hoods), by_cluster = TRUE)
```

## Tips for Success
- **Choosing K**: The `k` parameter in `findNearCells` defines the scale of the "neighborhood." Larger values capture broader tissue patterns, while smaller values focus on immediate local interactions.
- **Visualization**: `plotHoodMat` is useful for inspecting the neighborhood probabilities of specific "targetCells" to validate the scanning results.
- **Integration**: Since the output is stored in `colData(spe)`, you can easily export these neighborhood features for downstream machine learning or differential expression analysis.

## Reference documentation
- [Quick start](./references/Quick_start.md)