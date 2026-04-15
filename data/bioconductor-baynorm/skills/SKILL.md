---
name: bioconductor-baynorm
description: This tool provides a Bayesian approach for normalizing single-cell RNA-seq data by estimating gene-specific priors and cell-specific capture efficiencies. Use when user asks to normalize scRNA-seq counts, estimate capture efficiencies, or generate posterior distributions of transcript counts for downstream analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/bayNorm.html
---

# bioconductor-baynorm

## Overview
The `bayNorm` package provides a Bayesian approach for normalizing single-cell RNA-seq (scRNA-seq) data. It addresses the high level of noise and dropout events by estimating gene-specific prior parameters (mean $\mu$ and dispersion $\phi$) and cell-specific capture efficiencies ($\beta$). It produces a posterior distribution of original transcript counts, allowing for more robust downstream analyses compared to simple global scaling.

## Core Workflow

### 1. Data Preparation
`bayNorm` accepts `SummarizedExperiment`, `SingleCellExperiment`, or standard R matrices (genes as rows, cells as columns).

```r
library(bayNorm)
library(SummarizedExperiment)

# Example with a matrix
data('EXAMPLE_DATA_list')
raw_matrix <- EXAMPLE_DATA_list$inputdata[, 1:30]
se <- SummarizedExperiment(assays = list(counts = raw_matrix))
```

### 2. Estimating Capture Efficiencies ($\beta$)
Capture efficiency represents the probability that an original transcript is observed. You can provide a vector of $\beta$ values or estimate them using `BetaFun`.

```r
# Estimate beta assuming a mean capture efficiency of 6%
BETA_est <- BetaFun(Data = se, MeanBETA = 0.06)
beta_vector <- BETA_est$BETA
```

### 3. Running bayNorm
The main function `bayNorm` performs prior estimation and generates normalized data.

*   **3D Array (Samples):** Set `S` > 1 to draw multiple samples from the posterior.
*   **2D Matrix (MAP):** Set `mode_version = TRUE`.
*   **2D Matrix (Mean):** Set `mean_version = TRUE`.

```r
# Generate a 2D MAP (Maximum A Posteriori) normalized matrix
bayNorm_map <- bayNorm(
    Data = se,
    BETA_vec = beta_vector,
    mode_version = TRUE,
    mean_version = FALSE,
    verbose = FALSE,
    parallel = TRUE
)

normalized_counts <- bayNorm_map$Bay_out
```

### 4. Multi-group Normalization
If cells belong to different conditions, use the `Conditions` parameter to estimate priors locally ("LL" procedure), which is recommended for Differential Expression (DE) analysis.

```r
# Conditions is a vector of group labels
conditions <- c(rep("Group1", 15), rep("Group2", 15))
bayNorm_local <- bayNorm(
    Data = se,
    Conditions = conditions,
    Prior_type = "LL",
    mode_version = TRUE
)
```

### 5. Non-UMI Data
For non-UMI datasets, provide a scaling factor `UMI_sffl`. The data is divided by this factor and rounded to mimic UMI-like distributions.

```r
bayNorm_nonUMI <- bayNorm(
    Data = se,
    UMI_sffl = 20, # Example scaling factor
    mode_version = TRUE
)
```

## Supplementary Functions

### bayNorm_sup
Use `bayNorm_sup` to generate different output formats (e.g., switching from 3D samples to 2D MAP) without re-estimating prior parameters.

```r
# Using priors from a previous 3D run to get a 2D mean matrix
bayNorm_mean <- bayNorm_sup(
    Data = se,
    PRIORS = bayNorm_3D$PRIORS,
    input_params = bayNorm_3D$input_params,
    mode_version = FALSE,
    mean_version = TRUE
)
```

### SyntheticControl
Simulates control data based on estimated parameters to help identify "noisy" genes that deviate from technical noise models.

```r
# Simulate control data
control_data <- SyntheticControl(Data = se, BETA_vec = beta_vector)
```

## Tips for Success
*   **Parallelization:** Set `parallel = TRUE` for large datasets to speed up the computationally intensive prior estimation.
*   **Prior Type:** Use `Prior_type = "GG"` (Global) to remove batch effects across all cells, or `"LL"` (Local) to preserve/amplify biological differences between conditions for DE testing.
*   **Memory:** 3D arrays (multiple samples) consume significantly more memory than 2D matrices. Use 2D versions for standard visualization and clustering.

## Reference documentation
- [Introduction to bayNorm](./references/bayNorm.md)
- [bayNorm R Markdown Source](./references/bayNorm.Rmd)