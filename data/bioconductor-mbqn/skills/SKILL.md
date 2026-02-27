---
name: bioconductor-mbqn
description: This tool performs mean/median-balanced quantile normalization on omics intensity matrices to preserve rank-invariant features. Use when user asks to perform tail-robust quantile normalization, identify rank-invariant features, or normalize proteomics and transcriptomics data while preventing over-correction of stable features.
homepage: https://bioconductor.org/packages/release/bioc/html/MBQN.html
---


# bioconductor-mbqn

name: bioconductor-mbqn
description: Mean/Median-balanced quantile normalization (MBQN) for omics data. Use this skill to perform tail-robust quantile normalization on intensity matrices, specifically when dealing with rank-invariant (RI) or nearly rank-invariant (NRI) features that are prone to over-correction by classical quantile normalization.

## Overview
The `MBQN` package provides a modified version of quantile normalization (QN) designed for omics data (e.g., proteomics, transcriptomics) where global distortions in mean and scale exist. Standard QN can suppress biological variation in features that maintain a consistent rank across samples (RI/NRI features). MBQN balances these features before normalization to preserve their intensity profiles while still reducing systematic batch effects.

## Core Functions
- `mbqn()`: Applies standard QN or MBQN to a matrix.
- `mbqnNRI()`: Applies MBQN specifically to selected NRI/RI features based on a threshold.
- `mbqnGetNRIfeatures()`: Identifies RI/NRI features in a dataset and calculates their rank invariance frequency.
- `mbqnPlotRI()`: Visualizes RI/NRI features to check for saturation or rank stability.
- `mbqnBoxplot()`: Specialized boxplot to compare unnormalized and normalized intensities, highlighting specific features.

## Typical Workflow

### 1. Data Preparation
Load the library and ensure your data is in a matrix-like format (rows as features, columns as samples).
```r
library(MBQN)
# mtx is your intensity matrix (log-transformed recommended)
```

### 2. Identify RI/NRI Features
Before normalizing, check if your data contains features that are rank invariant.
```r
# low_thr defines the frequency threshold for rank invariance (e.g., 0.5)
nri_features <- mbqnGetNRIfeatures(mtx, low_thr = 0.5)
print(nri_features$ip) # Indices of potential RI/NRI features
```

### 3. Apply Normalization
Choose between global MBQN or targeted NRI balancing.

**Option A: Global MBQN**
```r
# Use FUN = "median" or "mean" for balancing; FUN = NULL performs classical QN
mbqn_mtx <- mbqn(mtx, FUN = "median", verbose = FALSE)
```

**Option B: Targeted NRI Balancing**
```r
# Only balances features meeting the low_thr criteria
mbqn_nri_mtx <- mbqnNRI(mtx, FUN = "median", low_thr = 0.5, verbose = FALSE)
```

### 4. Visualization and Validation
Compare the results to ensure that RI features have not been over-corrected.
```r
# Compare a specific RI feature (e.g., row 1) across normalization methods
qn_mtx <- mbqn(mtx, FUN = NULL) # Standard QN for comparison
mbqnBoxplot(mbqn_mtx, irow = 1, vals = data.frame(QN = qn_mtx[1,]), main = "MBQN vs QN")
```

## Tips for Success
- **Missing Values**: MBQN functions handle `NA` values natively.
- **Log Transformation**: It is standard practice to use log2-transformed intensities as input.
- **Choosing FUN**: `median` is generally more robust to outliers than `mean` when balancing RI features.
- **Saturation**: High-intensity features that are "saturated" often appear as RI features; use `mbqnPlotRI()` to identify if these are biological or technical artifacts.

## Reference documentation
- [MBQN Package Vignette (Rmd)](./references/MBQNpackage.Rmd)
- [MBQN Package Vignette (Markdown)](./references/MBQNpackage.md)