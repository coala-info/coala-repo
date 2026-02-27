---
name: bioconductor-debcam
description: bioconductor-debcam performs fully unsupervised deconvolution of heterogeneous biological samples using the Convex Analysis of Mixtures algorithm. Use when user asks to deconvolve gene expression or methylation data, identify subpopulation marker genes, or estimate cell type proportions and profiles without prior knowledge.
homepage: https://bioconductor.org/packages/release/bioc/html/debCAM.html
---


# bioconductor-debcam

## Overview

The `debCAM` package implements the Convex Analysis of Mixtures (CAM) algorithm for the fully unsupervised deconvolution of heterogeneous samples. It operates on the principle that in a linear mixing model ($X = AS$), marker genes for specific subpopulations will be located at the vertices of a scatter simplex in a dimension-reduced space. The package supports gene expression, proteomics, and DNA methylation data.

## Core Workflow: Unsupervised Deconvolution

The most common entry point is the `CAM()` function, which wraps preprocessing, marker identification, and matrix estimation.

### 1. Data Preparation
Input data must be in **non-log linear space** with non-negative values.
```r
library(debCAM)
# data: matrix where rows are molecules and columns are samples
# K: range of subpopulation numbers to test
# thres.low/high: percentage of low/high-expressed molecules to filter
rCAM <- CAM(data, K = 2:5, thres.low = 0.30, thres.high = 0.95)
```

### 2. Model Selection
Use the Minimum Description Length (MDL) criterion to determine the optimal number of subpopulations ($K$).
```r
plot(MDL(rCAM), data.term = TRUE)
# Look for the minimum point on the MDL curve
```

### 3. Extracting Results
Once $K$ is selected (e.g., $K=3$), extract the proportion ($A$) and expression ($S$) matrices.
```r
Aest <- Amat(rCAM, 3) # Proportion matrix
Sest <- Smat(rCAM, 3) # Expression profile matrix
MGlist <- MGsforA(rCAM, K = 3) # Marker genes used for estimation
```

### 4. Visualizing the Simplex
Visualize the data distribution and detected markers in 2D space.
```r
simplexplot(data, Aest, MGlist)
```

## Refined Marker Selection and Re-estimation

To improve results, you can re-identify markers based on Fold Change (OVE-FC) and re-run the estimation.

```r
# Calculate statistics for all genes
MGstat <- MGstatistic(data, Aest)

# Filter markers (e.g., OVE-FC > 10)
MGlist.FC <- lapply(1:3, function(x) rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC > 10])

# Re-estimate A and S using Alternating Least Squares (ALS)
# Set methy = TRUE for DNA methylation data (S constrained to [0,1])
rre <- redoASest(data, MGlist.FC, maxIter = 10, methy = FALSE)
A_final <- rre$Aest
S_final <- rre$Sest
```

## Supervised and Semi-supervised Deconvolution

If partial information is known, use specific functions to bypass the full CAM discovery phase.

- **Known Markers:** Use `AfromMarkers(data, MGlist)` to get $A$.
- **Known S Matrix:** Use `MGstatistic(S, ...)` to find markers from the reference, then `AfromMarkers()`.
- **Known A Matrix:** Use `NMF::.fcnnls(A, t(data))` to estimate $S$.

## Key Parameters for Large Datasets
- `dim.rdc`: Reduced data dimension (default is $K-1$).
- `cluster.num`: Number of clusters for marker gene detection.
- `cores`: Set for parallel processing (uses `BiocParallel`).
- `quick.select`: Use for high-dimensional data (e.g., methylation) to speed up vertex identification.

## Reference documentation
- [debCAM User Manual](./references/debcam.Rmd)