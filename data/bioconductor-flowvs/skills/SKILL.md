---
name: bioconductor-flowvs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/flowVS.html
---

# bioconductor-flowvs

## Overview

The `flowVS` package provides a method for variance stabilization (VS) in flow cytometry and microarray data. It utilizes an inverse hyperbolic sine (asinh) transformation, `asinh(z/c)`, where the normalization cofactor `c` is optimized to minimize Bartlett's likelihood-ratio test statistics. This ensures that the variances of cell populations (density peaks) are approximately equal across a collection of samples.

Key features:
- Stabilizes variance separately for each fluorescence channel.
- Uses the same transformation parameter for the same channel across all samples.
- Requires a collection of samples to effectively stabilize variance (cannot be done on a single sample).
- Applicable to both flow cytometry (`flowSet` objects) and microarray data (matrix objects).

## Typical Workflow

### 1. Flow Cytometry Data

The workflow involves identifying optimum cofactors for specific channels and then applying the transformation to the entire dataset.

```r
library(flowVS)
library(flowCore)

# Load data (e.g., a flowSet object)
data(HD)

# Step 1: Estimate optimum cofactors for specific channels
# It is recommended to use a subset of samples for estimation to save time
channels_to_transform <- c('CD3', 'CD4')
cofactors <- estParamFlowVS(HD[1:5], channels = channels_to_transform)

# Step 2: Apply the transformation to the full flowSet
HD.VS <- transFlowVS(HD, channels = channels_to_transform, cofactors = cofactors)

# Step 3: Visualize results to verify stabilization
library(flowViz)
densityplot(~CD3+CD4, HD.VS, main="Transformed Channels")
```

### 2. Microarray Data

For microarrays, a single cofactor is selected for all genes in the experiment.

```r
library(flowVS)
library(vsn)
data(kidney)

# Perform variance stabilization on the expression matrix
# microVS returns the transformed matrix
kidney.microVS <- microVS(exprs(kidney))

# Compare results using the built-in plotting function
plotMeanSd(kidney.microVS, main="Kidney data: VS by flowVS")
```

## Main Functions

- `estParamFlowVS(fSet, channels)`: Searches for the optimum cofactor `c` for each specified channel in a `flowSet`. It outputs search intervals and Bartlett's statistics.
- `transFlowVS(fSet, channels, cofactors)`: Applies the `asinh(z/c)` transformation to the specified channels of a `flowSet` using the provided cofactors.
- `microVS(data, cfLow, cfHigh)`: Stabilizes variance in microarray data matrix by minimizing Bartlett's statistics within the specified cofactor range.
- `lymphs(fFrame, ...)`: A helper function to identify/gate lymphocyte populations in flow cytometry samples.
- `plotMeanSd(x, ...)`: Plots the standard deviation of rows against the rank of their means to visualize the effectiveness of variance stabilization.

## Tips and Best Practices

- **Sample Selection**: When using `estParamFlowVS`, you don't need to use every sample in a large dataset to find the optimum cofactor; a representative subset (e.g., 5-10 samples) is usually sufficient and much faster.
- **Channel-Specific**: Remember that `flowVS` treats channels independently. If you have 5 channels, you should estimate parameters for all 5 if they all require stabilization.
- **Comparison with vsn**: For microarray data, `flowVS` performs similarly to the `vsn` package but uses a different optimization criterion (Bartlett's test).
- **Data Requirements**: The method relies on identifying density peaks (1-D clusters). If the data is extremely noisy or lacks clear populations, the variance stabilization may be less effective.

## Reference documentation

- [flowVS](./references/flowVS.md)