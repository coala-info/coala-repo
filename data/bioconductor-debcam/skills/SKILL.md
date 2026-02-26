---
name: bioconductor-debcam
description: debCAM performs unsupervised deconvolution of molecular mixture data to estimate subpopulation-specific expression profiles and proportions using convex analysis. Use when user asks to perform unsupervised deconvolution, identify molecular markers from mixture data, estimate cell type proportions, or visualize data distributions using simplex plots.
homepage: https://bioconductor.org/packages/release/bioc/html/debCAM.html
---


# bioconductor-debcam

## Overview

The `debCAM` package implements Convex Analysis of Mixtures (CAM), a fully unsupervised method for deconvolution. It assumes a linear mixing model ($X = AS$) where $X$ is the observed mixture, $A$ is the proportion matrix, and $S$ is the subpopulation-specific expression matrix. It is particularly powerful because it can identify molecular markers directly from the mixture data to estimate the constituent parts.

## Core Workflow: Unsupervised Deconvolution

The most common entry point is the `CAM()` function, which wraps preprocessing, marker detection, and matrix estimation.

### 1. Data Preparation
Input data must be in **non-log linear space** with non-negative values.
```r
library(debCAM)
# data should be a matrix: genes (rows) x samples (columns)
# Remove missing values and all-zero rows beforehand.
```

### 2. Running CAM
Specify a range for $K$ (number of subpopulations) and filtering thresholds.
```r
set.seed(111) # For reproducible clustering
rCAM <- CAM(data, K = 2:5, thres.low = 0.30, thres.high = 0.95)
```
- `thres.low`: Percentage of low-expressed genes to remove (typically 0.3-0.5 for RNA-seq).
- `cluster.num`: Number of clusters for dimension reduction (default is often sufficient).

### 3. Model Selection
Use the Minimum Description Length (MDL) criterion to find the optimal $K$.
```r
plot(MDL(rCAM), data.term = TRUE)
# Look for the minimum point on the curve
```

### 4. Extracting Results
Once $K$ is chosen (e.g., $K=3$):
```r
Aest <- Amat(rCAM, 3)      # Proportion matrix
Sest <- Smat(rCAM, 3)      # Expression profile matrix
MGlist <- MGsforA(rCAM, 3) # Markers used for estimation
```

## Advanced Workflows

### Marker Refinement and Re-estimation
After initial deconvolution, you can refine the marker list based on Fold Change (OVE-FC) and re-estimate the matrices using Alternating Least Squares (ALS).
```r
# Identify markers with OVE-FC > 10
MGstat <- MGstatistic(data, Aest)
MGlist.FC <- lapply(1:3, function(x) rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC > 10])

# Re-estimate A and S
rre <- redoASest(data, MGlist.FC, maxIter = 10, methy = FALSE)
# Set methy = TRUE for DNA methylation data to enforce S in [0,1]
```

### Supervised Deconvolution
If markers or one of the matrices ($A$ or $S$) are already known:
- **Known Markers:** `AfromMarkers(data, MGlist)`
- **Known S Matrix:** Identify markers from $S$ using `MGstatistic(S)`, then use `AfromMarkers()`.
- **Known A Matrix:** Estimate $S$ using `NMF::.fcnnls(A, t(data))`.

### Visualization
The simplex plot is the primary tool for visualizing how well the markers define the vertices of the data distribution.
```r
simplexplot(data, Aest, MGlist)
```

## Tips for Specific Data Types
- **RNA-seq/Microarray:** Filter 30-50% low-expressed genes.
- **Proteomics:** Filter very few low-expressed proteins (0-10%).
- **Methylation:** Use **beta-values** (not M-values). Remove sex chromosomes if samples are mixed gender. Downsample CpG sites (e.g., to 50k) to maintain performance.

## Reference documentation
- [debCAM User Manual](./references/debcam.Rmd)