---
name: bioconductor-aroma.light
description: This package provides robust methods for the normalization and calibration of microarray data using basic R data types like matrices and vectors. Use when user asks to perform scanner calibration, affine normalization, quantile normalization, or allele-specific copy number preprocessing using TumorBoost.
homepage: https://bioconductor.org/packages/release/bioc/html/aroma.light.html
---

# bioconductor-aroma.light

name: bioconductor-aroma.light
description: Expert guidance for using the aroma.light R package for microarray data normalization and calibration. Use this skill when performing scanner calibration (multiscan), affine normalization, quantile normalization, or allele-specific copy number preprocessing (TumorBoost) using basic R data types like matrices and vectors.

# bioconductor-aroma.light

## Overview
The `aroma.light` package provides light-weight, robust methods for the normalization and visualization of microarray data. Unlike higher-level frameworks, it operates directly on basic R data types (matrices and vectors), making it highly versatile for custom pipelines. It is particularly strong in handling multi-scan calibration, affine transformations to correct channel biases, and allele-specific normalization for genotyping arrays.

## Core Workflows

### 1. Scanner Calibration (Multiscan)
If an array is scanned multiple times at different PMT settings to extend the dynamic range or estimate scanner bias.
```r
# X is an NxK matrix (N probes, K scans) for ONE channel
Xc <- calibrateMultiscan(X)
# Returns an Nx1 matrix of calibrated signals
```

### 2. Affine Normalization
Corrects for offset and scale differences between channels (e.g., Red vs. Green). This is more robust than lowess for removing intensity-dependent bias at low intensities.
```r
# X is an Nx2 matrix (Red and Green channels)
Xn <- normalizeAffine(X)

# For multiple arrays, pass an NxK matrix (all channels/arrays)
# This ensures all arrays are on the same scale
Xn_all <- normalizeAffine(X_all)
```

### 3. Quantile Normalization
Ensures different samples or channels have the same empirical distribution.
```r
# Rank-based (standard)
Xn <- normalizeQuantileRank(X)

# Spline-based (smoother, less prone to tail artifacts)
Xn <- normalizeQuantileSpline(X, xTarget = target_distribution)
```

### 4. TumorBoost Normalization
Normalizes allele B fractions (BAF) in tumor samples using a matched normal to reduce noise in copy number analysis.
```r
# betaT: tumor BAFs, betaN: normal BAFs
# muN: normal genotypes (0, 0.5, 1) - can be called via callNaiveGenotypes
muN <- callNaiveGenotypes(betaN)
betaT_norm <- normalizeTumorBoost(betaT, betaN, muN)
```

## Key Functions Reference

| Function | Purpose |
| :--- | :--- |
| `calibrateMultiscan()` | Calibrate multiple scans of the same channel. |
| `normalizeAffine()` | Robust affine normalization (multi-dimensional). |
| `normalizeCurveFit()` | Intensity-dependent normalization (loess/lowess/spline). |
| `normalizeTumorBoost()` | Normalize tumor BAFs using matched normal. |
| `fitPrincipalCurve()` | Fit a principal curve through K-dimensional data. |
| `callNaiveGenotypes()` | Simple genotype calling from allele fractions. |
| `medianPolish()` | Fast implementation of Tukey's median polish. |

## Tips for Success
- **Data Types**: Ensure input is a `matrix` or `numeric` vector. The package does not use `ExpressionSet` or other Biobase classes directly.
- **Negative Values**: `normalizeAffine` handles and even expects some negative values (representing noise around zero). Do not floor them to zero before normalization.
- **Weights**: Most functions support a `weights` argument. Use this to down-weight known outliers or low-quality probes.
- **Visualization**: Use `plotMvsA()` and `plotDensity()` to assess the effectiveness of normalization.

## Reference documentation
- [aroma.light Reference Manual](./references/reference_manual.md)