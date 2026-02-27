---
name: bioconductor-snagee
description: SNAGEE assesses the quality of gene expression data by calculating signal-to-noise ratios based on the consistency of gene-gene correlations. Use when user asks to estimate study quality, identify outlier samples in microarray data, or calculate signal-to-noise ratios for gene expression experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/SNAGEE.html
---


# bioconductor-snagee

## Overview

SNAGEE (Signal-to-Noise Gene Expression Experiment) provides a platform-independent method for assessing the quality of microarray and gene expression data. Unlike quality metrics that rely on raw data or platform-specific artifacts, SNAGEE uses the biological signal itself—specifically, the consistency of gene-gene correlations across different studies.

The package calculates:
1.  **Study SNR**: A measure of how well the gene correlations in a specific study match expected biological distributions (typically 0 to 1).
2.  **Sample SNR**: A relative measure identifying outlier samples within a study that may be contributing more noise than signal.

## Core Workflow

### 1. Data Preparation
SNAGEE requires gene expression data where probes are mapped to Gene IDs (Entrez IDs). The input can be a matrix of expression values or a Bioconductor `ExpressionSet`.

```r
library(SNAGEE)
# Ensure your data has Entrez IDs as row names
# If using an ExpressionSet (e.g., 'myData'), SNAGEE handles it directly
```

### 2. Estimating Study Quality
The `qualStudy` function calculates the SNR for the entire dataset.

```r
# Calculate study SNR
study_quality <- qualStudy(myData)

# Interpretation:
# ~0.20 - 0.30: Average quality (depends on platform)
# Near or below 0: Serious problems (annotation errors, normalization issues)
print(study_quality)
```

### 3. Estimating Sample Quality
The `qualSample` function identifies problematic samples by calculating the change in study SNR when each sample is removed.

```r
# Calculate sample SNRs
# Note: Input data cannot contain NAs for this function
sample_qualities <- qualSample(myData, multicore = FALSE)

# Identify suspicious samples (SNR < -5 is seriously suspicious)
bad_samples <- which(sample_qualities < -5)
print(bad_samples)
```

## Technical Considerations

*   **Gene ID Mapping**: The package relies on Entrez Gene IDs. If your data uses symbols or platform-specific IDs, you must map them to Entrez IDs first using `AnnotationDbi`.
*   **Duplicate Genes**: If multiple rows map to the same Gene ID, SNAGEE automatically collapses them using the mean.
*   **Missing Values**: `qualStudy` can handle NAs, but `qualSample` cannot. Use imputation (e.g., `impute` package) if your data has missing values before running sample-level diagnostics.
*   **Parallelization**: For large datasets, `qualSample` can be slow. Set `multicore = TRUE` (on non-Windows systems) to speed up the process using the `parallel` package.

## Reference documentation

- [An Introduction to the SNAGEE Package](./references/SNAGEE.md)