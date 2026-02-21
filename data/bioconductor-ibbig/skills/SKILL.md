---
name: bioconductor-ibbig
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/iBBiG.html
---

# bioconductor-ibbig

## Overview
iBBiG is a bi-clustering algorithm specifically optimized for sparse binary data. Unlike many other algorithms, it is designed to find overlapping biclusters of varying sizes and aspect ratios. It is particularly effective for meta-analysis of gene set enrichment results across hundreds of datasets, as it handles noise well and does not require matching probes across different platforms.

## Core Workflow

### 1. Data Preparation
iBBiG requires a binary matrix (1s and 0s). If your data is continuous (e.g., gene expression or p-values), you must binarize or discretize it first using functions from the `biclust` package, which `iBBiG` extends.

```r
library(iBBiG)

# Example: Binarizing gene expression data
data(BicatYeast)
binData <- binarize(BicatYeast, threshold=0.2)

# Or discretize
discData <- discretize(BicatYeast)
```

### 2. Running iBBiG
The primary function is `iBBiG()`. You should specify the expected number of modules (`nModules`). It is better to over-estimate this number as the algorithm will assign low scores to non-informative modules.

```r
# Run iBBiG
# nModules: number of clusters to search for
# selection: 'score' (default) or 'f-stat'
res <- iBBiG(binData, nModules=10)
```

### 3. Inspecting Results
The result object is of class `iBBiG` (extending `biclust`).

```r
# Summary of clusters found
res

# Get number of clusters
Number(res)

# Access cluster scores (unique to iBBiG)
Clusterscores(res)

# Access row/column membership (logical matrices)
RowxNumber(res)
NumberxCol(res)

# Extract specific clusters as sub-matrices
modules <- bicluster(binData, res, 1:3)
```

### 4. Visualization
iBBiG provides specialized plotting methods to visualize the discovered modules and their scores.

```r
# Plot module scores and sizes
plot(res)

# Heatmap of a specific cluster (e.g., cluster 4)
drawHeatmap2(binData, res, number=4)

# Standard biclust plots
biclustbarchart(binData, Bicres=res)
```

### 5. Validation and Comparison
If a gold standard (GS) or previous result is available, use `JIdist` or `analyzeClust` to compare.

```r
# Calculate Jaccard Index distance
# margin can be "row", "col", or "both"
ji_dist <- JIdist(res, gold_standard_obj, margin="both")

# Detailed performance statistics (accuracy, sensitivity, specificity)
stats <- analyzeClust(res, gold_standard_obj)
```

## Tips and Best Practices
- **Module Selection**: Use `Clusterscores(res)` to identify which modules are statistically significant. Low scores typically indicate noise-driven clusters.
- **Subsetting**: You can subset the result object like a list: `res[1:3]` returns only the first three clusters.
- **Exporting**: Use `writeBiclusterResults("filename.txt", res, ...)` to save results for external use.
- **Artificial Data**: Use `makeArtificial()` to generate a test dataset with known overlapping modules to practice or benchmark the algorithm.

## Reference documentation
- [Introduction to iBBiG](./references/tutorial.md)