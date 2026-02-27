---
name: bioconductor-multimed
description: This tool performs permutation-based statistical testing for multiple biological mediators between an exposure and an outcome. Use when user asks to test multiple mediators simultaneously, identify biomarkers that mediate the effect of an exposure on an outcome, or perform mediation analysis with covariates and sampling weights.
homepage: https://bioconductor.org/packages/release/bioc/html/MultiMed.html
---


# bioconductor-multimed

name: bioconductor-multimed
description: Statistical testing for multiple biological mediators between an exposure and an outcome using a permutation-based approach. Use this skill when analyzing whether one or more biomarkers (e.g., metabolites, gene expression) mediate the relationship between a risk factor (exposure) and a disease (outcome), especially when needing to control for multiple comparisons without losing power like the Bonferroni correction.

# bioconductor-multimed

## Overview

The `MultiMed` package implements a permutation-based method to test multiple mediators simultaneously. It is designed to identify which biomarkers (M) mediate the effect of an exposure (E) on an outcome (Y). The core advantage of this package is its ability to handle many mediators while maintaining higher statistical power than standard correction methods. It supports both single and multiple mediator scenarios and allows for the inclusion of covariates (Z) and sampling weights (w).

## Core Workflow

### 1. Data Preparation
The main function `medTest` requires the following inputs:
- **E**: Exposure variable (vector or n x 1 matrix).
- **M**: Mediator(s) (n x K matrix, where K is the number of mediators).
- **Y**: Outcome variable (vector or n x 1 matrix).
- **Z**: (Optional) Covariates (n x p matrix). If provided, E, M, and Y are regressed on Z first.
- **w**: (Optional) Weights for the E-M association (e.g., for case-control studies).

### 2. Running the Mediation Test
Use the `medTest` function to calculate the test statistic (S) and the permutation-based p-value (p).

```r
library(MultiMed)

# Basic usage with 500 permutations
results <- medTest(E = exposure_data, 
                   M = mediator_matrix, 
                   Y = outcome_data, 
                   nperm = 500)

# Results is a matrix where each row corresponds to a mediator in M
# Column 'S' is the test statistic; column 'p' is the p-value
```

### 3. Handling Covariates and Weights
In complex study designs (like the Navy Colorectal Adenoma study), you may need to adjust for confounders and account for non-random sampling.

```r
# Example with covariates and sampling weights
results <- medTest(E = NavyAdenoma$Fish,
                   M = NavyAdenoma[, 6:154],
                   Y = NavyAdenoma$Adenoma,
                   Z = NavyAdenoma[, 2:5], # BMI, Age, etc.
                   w = sampling_weights,
                   nperm = 1000,
                   useWeightsZ = FALSE) # Use equal weights for initial Z regression
```

## Interpreting Results

- **Test Statistic (S)**: Represents the absolute value of the product of the correlations (specifically, the correlation between E and M, and the partial correlation between M and Y given E).
- **P-values (p)**: These p-values are already adjusted for the multiple mediators tested within the permutation framework. No further Bonferroni or FDR adjustment is strictly required for the mediators included in the single `medTest` call.
- **Identification**: To find the most significant mediator:
  ```r
  rownames(results) <- colnames(mediator_matrix)
  significant_mediators <- results[results[, "p"] < 0.05, , drop = FALSE]
  ```

## Tips for Success
- **Permutations**: The default `nperm = 100` is low for publication-quality results. Use `nperm = 1000` or higher for more precise p-values, especially near the 0.05 threshold.
- **Matrix Format**: Ensure `M` is a matrix even if testing a single mediator to avoid dimension errors.
- **Weights**: When using weights `w` for case-control studies, ensure they are calculated based on the prevalence of the outcome in the population versus the study sample.

## Reference documentation
- [MultiMed](./references/MultiMed.md)