---
name: bioconductor-weitrix
description: This tool provides a framework for analyzing matrices with precision weights to handle data with uneven reliability or missing values. Use when user asks to calibrate precision weights, find rows with excess variability, perform weighted differential testing, or extract PCA-like components from matrices with missing values.
homepage: https://bioconductor.org/packages/release/bioc/html/weitrix.html
---


# bioconductor-weitrix

name: bioconductor-weitrix
description: Analysis of matrices with precision weights using the weitrix package. Use this skill to calibrate weights for measurements (like poly(A) tail length, alternative polyadenylation, or RNA-seq CPM), find rows with excess variability, perform differential testing using weighted linear models, and extract PCA-like components of variation from matrices with missing values or uneven weights.

## Overview

The `weitrix` package provides a framework for working with "weitrices"—SummarizedExperiment objects containing both measurements and associated precision weights. It is particularly powerful for handling data where some observations are more reliable than others or where many values are missing. It integrates with `limma` and `topconfects` for robust differential testing and provides a specialized PCA-like method (`weitrix_components`) that respects weights and supports varimax rotation for interpretability.

## Core Workflows

### 1. Creating a Weitrix
A weitrix is a `SummarizedExperiment` with two designated assays (measurements and weights).

```r
library(weitrix)

# From matrices
wei <- as_weitrix(measurement_matrix, weights_matrix)

# From SummarizedExperiment
wei <- bless_weitrix(se, x_name="counts", weights_name="precisions")

# Specialized constructors
# For alternative polyadenylation (APA) shift scores
wei_shift <- counts_shift(counts, groups) 
# For proportions (e.g., SLAM-Seq)
wei_prop <- as_weitrix(conversions/coverage, coverage)
```

### 2. Weight Calibration
Calibration ensures that weights accurately represent the inverse of residual variance. This is critical for downstream testing.

*   **`weitrix_calibrate_all`**: Fits a gamma GLM to squared residuals. Use this to account for trends related to the mean (`mu`), existing weights, or other covariates.
*   **`weitrix_calplot`**: Essential for diagnostic checking. In a well-calibrated weitrix, the red trend lines should be horizontal at 1 and -1.

```r
# 1. Fit a preliminary model
fit <- weitrix_components(wei, design=design)

# 2. Calibrate based on mean-variance trend
cal <- weitrix_calibrate_all(
    wei, 
    design = fit, 
    trend_formula = ~well_knotted_spline(mu, 5))

# 3. Diagnostic plot
weitrix_calplot(cal, fit, covar=mu)
```

### 3. Components of Variation (Weighted PCA)
`weitrix_components` finds low-rank structures in weighted matrices, even with missing data (weight=0).

```r
# Find 3 components with varimax rotation
comp <- weitrix_components(cal, p=3)

# View sample scores (scores for each column)
comp$col

# View gene loadings (loadings for each row)
comp$row

# Scree plot to determine number of components
comp_seq <- weitrix_components_seq(cal, p=6)
components_seq_screeplot(comp_seq)
```

### 4. Differential Testing
You can test for differences using the `topconfects` approach (ranking by confident effect size) or by converting to a `limma` EList.

```r
# Using topconfects (recommended for effect size)
confects <- weitrix_confects(cal, design, coef="treatment")

# Finding overdispersed genes (excess variability)
# Useful for finding marker genes or genes of biological interest
overdispersed <- weitrix_sd_confects(cal, design=~1)

# Using limma
elist <- weitrix_elist(cal)
fit <- lmFit(elist, design) %>% eBayes()
topTable(fit, coef="treatment")
```

## Practical Tips
*   **Missing Data**: Represent missing values with a weight of 0. `weitrix_components` will naturally impute these values.
*   **Large Datasets**: `weitrix` supports `DelayedArray` and `HDF5Array`. Use `DelayedArray::setRealizationBackend("HDF5Array")` for datasets that exceed memory.
*   **Parallelism**: Uses `BiocParallel`. If you encounter errors in interactive sessions, try `BiocParallel::register(BiocParallel::SerialParam())`.
*   **Dispersion**: In a calibrated weitrix, the expected dispersion is 1. Rows with dispersion significantly > 1 indicate biological variation beyond the modeled noise.

## Reference documentation

- [Concepts and practical details](./references/V1_overview.md)
- [PAT-Seq poly(A) tail length example](./references/V2_tail_length.md)
- [PAT-Seq alternative polyadenylation example](./references/V3_shift.md)
- [RNA-Seq expression example](./references/V4_airway.md)
- [SLAM-Seq proportion data example](./references/V5_slam_seq.md)