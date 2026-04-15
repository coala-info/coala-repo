---
name: bioconductor-pmp
description: The bioconductor-pmp package provides a comprehensive suite of tools for the pre-processing of metabolomics datasets, including peak matrix filtering and signal drift correction. Use when user asks to filter peak matrices by missing values or RSD, perform missing value imputation, apply Probabilistic Quotient Normalization, or execute Quality Control-Robust Spline Correction for batch effect mitigation.
homepage: https://bioconductor.org/packages/release/bioc/html/pmp.html
---

# bioconductor-pmp

name: bioconductor-pmp
description: Expert guidance for the Bioconductor package 'pmp' (Peak Matrix Processing). Use this skill to perform metabolomics data pre-processing, including peak matrix filtering, missing value imputation, normalization, scaling, and signal drift/batch effect correction (QC-RSC).

# bioconductor-pmp

## Overview

The `pmp` package provides a comprehensive suite of tools for the (pre-)processing of metabolomics datasets. It is specifically designed to handle peak matrices (features vs. samples) to remove uninformative features and correct for technical variations. The package natively supports `SummarizedExperiment` objects but can also process standard R matrices. Key functionalities include missing value filtering, Probabilistic Quotient Normalization (PQN), various imputation methods, generalized logarithm (glog) transformations, and Quality Control-Robust Spline Correction (QC-RSC) for batch effect and signal drift mitigation.

## Core Workflow and Functions

### 1. Data Input and Integrity
While `pmp` accepts standard matrices, using `SummarizedExperiment` is recommended for metadata preservation.
- Use `data(MTBLS79)` to explore the built-in benchmark dataset.
- If using a matrix, `pmp` automatically transposes data to ensure features are in rows and samples are in columns (the largest dimension is assumed to be features).

### 2. Filtering Procedures
Filtering is typically performed sequentially to reduce the number of missing values (MV) and low-quality features.
- **Filter Samples by MV**: `filter_samples_by_mv(df, max_perc_mv=0.1)` removes samples exceeding a missing value threshold.
- **Filter Peaks by Fraction**: `filter_peaks_by_fraction(df, min_frac=0.9, method="QC", qc_label="QC")` removes features not detected in a minimum fraction of samples (can be restricted to QC samples or applied across all).
- **Filter Peaks by RSD**: `filter_peaks_by_rsd(df, max_rsd=30, qc_label="QC")` removes features with high technical variation based on the Relative Standard Deviation (Coefficient of Variation) in QC samples.

### 3. Normalization and Transformation
- **PQN**: `pqn_normalisation(df, classes, qc_label="QC")` performs Probabilistic Quotient Normalization.
- **Glog Transformation**: `glog_transformation(df, classes, qc_label="QC")` stabilizes variance. Use `glog_plot_optimised_lambda()` to visualize the optimization of the scaling factor.

### 4. Missing Value Imputation
The `mv_imputation()` function provides a unified interface for multiple algorithms:
- `method="knn"`: k-nearest neighbors (recommended).
- `method="rf"`: Random Forest.
- `method="bpca"`: Bayesian PCA.
- `method="mean"`, `"median"`, or `"mn"` (minimum value).

### 5. Signal Drift and Batch Correction (QC-RSC)
The Quality Control-Robust Spline Correction (QC-RSC) algorithm corrects for within-batch signal drift and between-batch effects.
- **Execution**: `QCRSC(df, order, batch, classes, spar=0, minQC=4)`
  - `order`: Numeric vector of injection order.
  - `batch`: Vector identifying measurement batches.
  - `classes`: Character vector where QC samples are labeled "QC".
- **Visualization**: `sbc_plot(df, corrected_df, classes, batch, indexes=c(1, 2, 3))` compares features before and after correction.

## Quality Assessment Metrics
- **D-ratio**: Calculate the ratio of technical variation (MAD of QCs) to biological variation (MAD of samples). A ratio > 1 indicates technical noise exceeds biological signal.
- **Processing History**: Use `processing_history(df)` on a `pmp` output object to retrieve the parameters and sequence of functions applied to the data.

## Reference documentation
- [Peak Matrix Processing for metabolomics datasets](./references/pmp_vignette_peak_matrix_processing_for_metabolomics_datasets.md)
- [Signal drift and batch effect correction and mass spectral quality assessment](./references/pmp_vignette_sbc_spectral_quality_assessment.md)
- [Signal drift and batch effect correction for mass spectrometry](./references/pmp_vignette_signal_batch_correction_mass_spectrometry.md)