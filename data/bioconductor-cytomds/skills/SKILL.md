---
name: bioconductor-cytomds
description: This tool performs low-dimensional visualization and quality assessment of cytometry samples by calculating Earth Mover's Distance and Multi-Dimensional Scaling. Use when user asks to identify batch effects, detect outliers, visualize sample clusters, calculate pairwise distances between cytometry samples, or generate Shepard diagrams and bi-plots.
homepage: https://bioconductor.org/packages/release/bioc/html/CytoMDS.html
---


# bioconductor-cytomds

name: bioconductor-cytomds
description: Use for low-dimensional visualization and quality assessment of cytometry samples. It calculates Earth Mover's Distance (EMD) between samples and performs Multi-Dimensional Scaling (MDS) to identify batch effects, outliers, or sample clusters. Includes tools for projection quality (Shepard diagrams) and axis interpretation (bi-plots).

# bioconductor-cytomds

## Overview

CytoMDS provides a workflow for comparing cytometry samples by calculating the Earth Mover's Distance (EMD) between them and projecting those distances into a low-dimensional space using Multi-Dimensional Scaling (MDS). This is particularly useful for identifying batch effects, outliers, and biological clusters across multiple samples.

## Core Workflow

### 1. Data Preparation
CytoMDS works with `flowCore::flowSet` objects or lists of expression matrices. Data should be transformed (e.g., `arcsinh`) before processing.

```r
library(CytoMDS)
library(flowCore)

# Example: Arcsinh transformation with cofactor 5
trans <- arcsinhTransform(a = 0, b = 1/5, c = 0)
fs_trans <- transform(fs, transformList(channels, trans))
```

### 2. Calculate Pairwise Distances
Use `pairwiseEMDDist` to compute the EMD between all sample pairs.

```r
# Calculate distances
pwDist <- pairwiseEMDDist(fs_trans, channels = chMarkers)

# View individual marker contributions to the distance
distByFeature(pwDist)
ggplotDistFeatureImportance(pwDist)
```

### 3. Compute MDS Projection
Use `computeMetricMDS` to perform the projection. By default, it targets a pseudo R-square of 0.95.

```r
# Compute MDS with a fixed seed for reproducibility
mdsObj <- computeMetricMDS(pwDist, seed = 42)

# Check quality indicators
show(mdsObj)
```

### 4. Visualization and Diagnostics
Visualize the samples and check the projection quality using a Shepard diagram.

```r
# Plot MDS (axes 1 and 2)
ggplotSampleMDS(mdsObj, pData = pData(fs_trans), pDataForColour = "condition")

# Diagnostic: Shepard diagram (closer to the diagonal is better)
ggplotSampleMDSShepard(mdsObj)
```

### 5. Interpreting Projection Axes (Bi-plots)
To understand which markers drive the separation in the MDS plot, use bi-plots to correlate sample statistics (like medians) with the projection axes.

```r
# Calculate medians for bi-plot
medians <- channelSummaryStats(fs_trans, channels = chLabels, statFUNs = median)

# Generate bi-plot
ggplotSampleMDS(mdsObj, 
                pData = pData(fs_trans), 
                biplot = TRUE, 
                extVariables = medians,
                arrowThreshold = 0.8)
```

## Advanced Usage

### Large Datasets
For datasets that don't fit in RAM, `pairwiseEMDDist` supports dynamic loading and parallelization via `BiocParallel`.

```r
# Parallel computation
bp <- BiocParallel::SnowParam(workers = 4)
pwDist <- pairwiseEMDDist(x = nSamples, 
                          loadExprMatrixFUN = my_load_func, 
                          BPPARAM = bp)
```

### Generic Expression Matrices
If your data is not in a `flowSet`, you can pass a list of matrices where rows are cells and columns are features.

```r
# list_of_matrices is a list of R matrices
pwDist <- pairwiseEMDDist(list_of_matrices)
```

## Tips
* **Reproducibility:** Always set a `seed` in `computeMetricMDS` as the Smacof algorithm is stochastic.
* **Dimensions:** If the Shepard diagram shows poor fit, increase the `targetPseudoRSq` or manually set `nDim` in `computeMetricMDS`.
* **Axis Interpretation:** Use `ggplotSampleMDSWrapBiplots` to compare multiple statistics (mean, SD, quantiles) across axes simultaneously.

## Reference documentation
- [Low Dimensional Projection of Cytometry Samples](./references/CytoMDS.md)
- [CytoMDS Vignette Source](./references/CytoMDS.Rmd)