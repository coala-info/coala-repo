---
name: bioconductor-mscoreutils
description: MsCoreUtils provides low-level infrastructure functions for mass spectrometry data processing, including spectra manipulation and quantitative data analysis. Use when user asks to smooth spectra, estimate baselines, pick peaks, aggregate quantitative data, impute missing values, normalize matrices, or calculate spectral similarity.
homepage: https://bioconductor.org/packages/release/bioc/html/MsCoreUtils.html
---

# bioconductor-mscoreutils

## Overview

`MsCoreUtils` provides a suite of infrastructure-independent functions for mass spectrometry. It is designed to be a "low-level" dependency, meaning it operates on standard R data structures (matrices, vectors) rather than complex S4 objects. This makes it highly versatile for custom MS data processing pipelines involving spectra or quantitative proteomics/metabolomics data.

## Core Functions and Workflows

### 1. Spectra Processing
These functions are typically applied to m/z and intensity vectors.

*   **Smoothing**: Use `smooth()` with methods like "SavitzkyGolay" or "MovingAverage" to reduce high-frequency noise.
*   **Baseline Estimation**: Use `estimateBaseline()` (methods: "Snip", "TopHat", "ConvexHull", "Median") to identify the background signal.
*   **Binning**: Use `bin()` to aggregate intensities into discrete m/z bins.
*   **Peak Picking**: Use `localMaxima()` and `refineCentroids()` to identify and improve the precision of peak m/z values.

### 2. Quantitative Data Aggregation
Used to summarize peptide-level data into protein-level data or technical replicates into a single representative value.

*   **Robust Summarization**: `robustSummary(x)` calculates a robust summary of matrix columns (e.g., for protein quantification).
*   **Median Polish**: `medianPolish(x)` is used for normalization and summarization of two-way tables.
*   **Simple Aggregation**: `sumi(x)` and `maxi(x)` provide fast implementations for summing or finding maximums.

### 3. Missing Data Imputation
`MsCoreUtils` provides several methods for handling `NA` values in quantitative matrices:

*   **Methods**: `impute_knn`, `impute_mle`, `impute_min`, `impute_QRILC`, and `impute_RF`.
*   **Workflow**: Use `imputeMethods()` to see all available options and `impute_matrix(x, method = "...")` to apply them.

### 4. Normalization
*   **Methods**: `normalize_matrix(x, method = "...")` supports "sum", "max", "center.mean", "center.median", "quantiles", and "vsn".
*   **RLA**: `rla()` and `rowRla()` calculate Relative Log Abundances, useful for visualizing batch effects or sample quality.

### 5. Similarity and Distance
*   **Spectra Similarity**: `ndotproduct()`, `nentropy()`, and `nspectraangle()` calculate similarity scores between two spectra.
*   **GNPS**: `join_gnps()` and `gnps()` implement the Global Natural Products Social Molecular Networking similarity scoring.

## Typical R Workflow Example

```r
library(MsCoreUtils)

# 1. Process a single spectrum (m/z and intensity)
mz <- c(100.1, 100.2, 100.3, 200.5, 200.6)
ints <- c(10, 20, 10, 50, 60)

# Smooth intensities
ints_smooth <- smooth(ints, method = "MovingAverage", hws = 1)

# 2. Aggregate quantitative matrix (e.g., peptides to protein)
pep_matrix <- matrix(rnorm(20), nrow = 4)
protein_intensity <- robustSummary(pep_matrix)

# 3. Impute missing values
pep_matrix[1, 1] <- NA
pep_imputed <- impute_matrix(pep_matrix, method = "knn")
```

## Tips and Best Practices
*   **Vectorization**: Most functions are optimized for performance on large vectors or matrices.
*   **PPM Calculations**: Use `ppm(mz, ppm)` to calculate error windows and `closest()` to find the nearest match between two m/z vectors within a tolerance.
*   **Memory**: Since this package works on base R types, it is memory efficient, but ensure matrices are not unnecessarily duplicated when working with very large datasets.

## Reference documentation
- [Core Utils for Mass Spectrometry Data](./references/MsCoreUtils.Rmd)
- [Core Utils for Mass Spectrometry Data](./references/MsCoreUtils.md)