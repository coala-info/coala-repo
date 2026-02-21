---
name: bioconductor-cycle
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cycle.html
---

# bioconductor-cycle

name: bioconductor-cycle
description: Statistical assessment of periodic gene expression in time series data using Fourier analysis and various background models (specifically AR(1) models to account for autocorrelation). Use this skill when analyzing transcriptomic time series (e.g., cell cycle or circadian rhythms) to identify periodically expressed genes while controlling the False Discovery Rate (FDR).

# bioconductor-cycle

## Overview

The `cycle` package provides tools for detecting periodic signals in genomic time series data. Its primary advantage over simpler methods is the inclusion of an autoregressive AR(1) background model. Traditional methods often use random permutations or Gaussian models which neglect temporal autocorrelation, leading to an overestimation of significantly periodic genes. By accounting for the dependency between successive measurements, `cycle` provides a more robust statistical assessment of periodicity.

## Workflow and Usage

### 1. Data Preparation
The package operates on `ExpressionSet` objects. Data must be pre-processed to handle missing values and standardized.

```R
library(cycle)
data(yeast) # Example dataset

# 1. Filter genes with too many missing values (e.g., > 25%)
yeast <- filter.NA(yeast, thres=0.25)

# 2. Fill remaining missing values (required for Fourier analysis)
# 'knn' or 'wknn' are recommended; 'mean' is faster for illustration
yeast <- fill.NA(yeast, mode="mean")

# 3. Standardize (mean = 0, sd = 1) - Required for Fourier scores
yeast <- standardise(yeast)
```

### 2. Statistical Assessment of Periodicity
The core function is `fdrfourier`, which calculates Fourier scores and derives False Discovery Rates (FDR).

**Key Parameters:**
- `eset`: The standardized `ExpressionSet`.
- `T`: The estimated cycle period (e.g., 85 minutes for yeast cell cycle).
- `times`: A numeric vector of measurement time points.
- `background.model`: 
    - `"ar1"`: Autoregressive model (recommended to account for autocorrelation).
    - `"rr"`: Random permutations (standard but prone to false positives).
- `N`: Number of background datasets to generate (e.g., 100 for testing, 1000 for publication).

```R
# Define period and time points
T.yeast <- 85
times.yeast <- pData(yeast)$time

# Calculate FDR using the AR(1) background model
fdr.ar1 <- fdrfourier(eset=yeast, 
                      T=T.yeast, 
                      times=times.yeast, 
                      background.model="ar1", 
                      N=100, 
                      progress=TRUE)
```

### 3. Interpreting Results
The output of `fdrfourier` contains the calculated FDR for each gene.

```R
# Count genes with FDR < 0.25
significant_genes <- sum(fdr.ar1$fdr < 0.25)

# List significant genes and their FDR values
fdr.ar1$fdr[which(fdr.ar1$fdr < 0.25)]
```

## Tips and Best Practices
- **Autocorrelation Check**: You can manually check the autocorrelation of your data using `cor(exprs(eset)[,i-1], exprs(eset)[,i])`. If high autocorrelation exists, always prefer the `ar1` background model.
- **Replicates**: The package treats columns in the expression matrix as independent time points. Replicates should be averaged or handled separately before running `fdrfourier`.
- **Computational Time**: Calculating FDR with empirical background distributions for large datasets and high `N` can be computationally intensive. Use `progress=TRUE` to monitor status.
- **Period Selection**: The Fourier score is highly sensitive to the cycle period `T`. This value should be derived from prior biological knowledge or experimental design.

## Reference documentation
- [cycle](./references/cycle.md)