---
name: bioconductor-sccomp
description: This tool performs differential composition and variability analysis for single-cell data using a robust Bayesian framework. Use when user asks to analyze cell type proportions across conditions, identify composition outliers, or perform mixed-effect modeling for hierarchical single-cell datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/sccomp.html
---


# bioconductor-sccomp

name: bioconductor-sccomp
description: Differential composition and variability analysis for single-cell data (RNA-seq, CyTOF, microbiome). Use when analyzing cell type proportions across conditions, identifying outliers in composition, or performing mixed-effect modeling for hierarchical single-cell datasets.

# bioconductor-sccomp

## Overview

The `sccomp` package provides a robust Bayesian framework for differential composition and variability analysis. Unlike methods that only look at proportions, `sccomp` models data as counts using a sum-constrained Beta-binomial distribution. This allows it to account for compositionality, group-specific variability, and the mean-variability association while remaining robust to outliers.

Key capabilities:
- **Differential Composition**: Testing if cell type proportions change between groups.
- **Differential Variability**: Testing if the spread/uncertainty of cell type proportions changes.
- **Outlier Detection**: Probabilistic identification and exclusion of anomalous samples.
- **Mixed Effects**: Support for random intercepts and slopes (e.g., nested patient/batch effects).

## Installation

`sccomp` requires `cmdstanr` for Bayesian inference.

```r
if (!requireNamespace("BiocManager")) install.packages("BiocManager")
BiocManager::install("sccomp")

# Required backend setup
install.packages("cmdstanr", repos = c("https://stan-dev.r-universe.dev/", getOption("repos")))
cmdstanr::install_cmdstan()
```

## Core Workflow

### 1. Basic Estimation
You can pass Seurat objects, SingleCellExperiment objects, or tidy count data frames directly.

```r
library(sccomp)

# Using a Seurat or SCE object
result <- seurat_obj |>
  sccomp_estimate(
    formula_composition = ~ group,
    sample = "sample_id",
    cell_group = "cell_type",
    cores = 1
  ) |>
  sccomp_test()
```

### 2. Outlier Removal
To improve robustness, chain `sccomp_remove_outliers` between estimation and testing.

```r
result <- counts_df |>
  sccomp_estimate(
    formula_composition = ~ condition,
    sample = "sample",
    cell_group = "cell_type",
    abundance = "count"
  ) |>
  sccomp_remove_outliers() |>
  sccomp_test()
```

### 3. Mixed-Effect Modeling
Use lme4-style syntax for random effects in the `formula_composition`.

```r
# Random intercept for 'batch'
result <- sccomp_estimate(
  data,
  formula_composition = ~ condition + (1 | batch),
  sample = "sample",
  cell_group = "cell_type"
)
```

### 4. Differential Variability
To test if a condition affects the consistency of cell type proportions:

```r
result <- sccomp_estimate(
  data,
  formula_composition = ~ condition,
  formula_variability = ~ condition,
  sample = "sample",
  cell_group = "cell_type"
)
```

## Interpreting Results

The output is a tibble where:
- `c_effect`: The logit fold change for composition.
- `c_pH0`: The probability of the null hypothesis (not a p-value; lower is more significant).
- `c_FDR`: False Discovery Rate.
- `v_`: Prefixes denote variability parameters (if `formula_variability` was used).

To get human-readable statements:
```r
result |> sccomp_proportional_fold_change(formula_composition = ~ condition, from = "control", to = "treated")
```

## Visualization

`sccomp` provides specialized plotting functions:

- `plot(result)`: Returns a list of summary plots (1D/2D intervals).
- `sccomp_boxplot(result, factor = "condition")`: Visualizes observed vs. predicted proportions.
- `plot_1D_intervals(result)`: Shows credible intervals for effects.

## Recommended Settings

- **scRNA-seq**: Set `bimodal_mean_variability_association = TRUE`.
- **CyTOF / Microbiome**: Set `bimodal_mean_variability_association = FALSE` (default).
- **Deconvolution Data**: If you only have proportions (no counts), set `abundance = "proportion"`. Note: This is less accurate than using counts.

## Reference documentation

- [sccomp: Differential Composition and Variability Analysis for Single-Cell Data](./references/introduction.md)
- [sccomp: Differential Composition and Variability Analysis for Single-Cell Data (Rmd)](./references/introduction.Rmd)