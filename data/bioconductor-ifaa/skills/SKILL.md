---
name: bioconductor-ifaa
description: bioconductor-ifaa identifies robust associations between covariates and the absolute abundance of microbiome taxa while adjusting for confounders and controlling the false discovery rate. Use when user asks to estimate associations between variables and microbiome abundance, handle high-dimensional compositional data without zero-imputation, or analyze abundance ratios using multivariate zero-inflated logistic normal regression.
homepage: https://bioconductor.org/packages/release/bioc/html/IFAA.html
---

# bioconductor-ifaa

name: bioconductor-ifaa
description: Robust association identification and inference for absolute abundance (AA) in microbiome analyses. Use this skill to estimate and test associations between covariates and microbiome taxa while adjusting for confounders, handling high-dimensional data, and controlling FDR without requiring zero-imputation.

# bioconductor-ifaa

## Overview
The `IFAA` package (Inference For Absolute Abundance) addresses the fundamental challenge in microbiome analysis: observing only relative abundances (proportions) when the underlying biological interest often lies in absolute abundances. It provides a robust statistical framework to infer associations between covariates and absolute abundance.

Key features:
- **IFAA()**: Main function for associating covariates with absolute abundance.
- **MZILN()**: Multivariate Zero-Inflated Logistic Normal regression for analyzing abundance ratios.
- **No Imputation**: Handles zeros naturally without needing pseudo-counts.
- **High-Dimensional**: Uses regularization and parallel computing to handle many covariates.

## Typical Workflow

### 1. Data Preparation
`IFAA` requires data in a `SummarizedExperiment` object. Microbiome data (counts or relative abundance) should be in the `assays` slot, and covariate data in `colData`.

```r
library(IFAA)
library(SummarizedExperiment)

# Create SummarizedExperiment if starting from matrices
# microb_matrix: rows = taxa, cols = samples
# cov_matrix: rows = samples, cols = variables
se <- SummarizedExperiment(
  assays = list(MicrobData = microb_matrix),
  colData = cov_matrix
)
```

### 2. Running IFAA
Use `IFAA()` to test specific covariates (`testCov`) while adjusting for others (`ctrlCov`).

```r
results <- IFAA(
  experiment_dat = se,
  testCov = c("target_var1", "target_var2"),
  ctrlCov = c("confounder1"),
  sampleIDname = "ID_column",
  fdrRate = 0.05,
  paraJobs = NULL # Auto-detects cores
)

# Extract results
full_res <- results$full_results
significant_taxa <- subset(full_res, sig_ind == TRUE)
```

### 3. Analyzing Ratios with MZILN
If you are interested in the ratio of specific taxa (e.g., relative to a stable reference), use `MZILN()`.

```r
resultsRatio <- MZILN(
  experiment_dat = se,
  microbVar = c("TaxonA", "TaxonB"), # Numerators
  refTaxa = c("TaxonRef"),           # Denominator
  allCov = c("var1", "var2"),
  sampleIDname = "ID_column"
)
```

## Key Parameters
- `testCov`: The primary variables you want to test.
- `ctrlCov`: Variables to adjust for (confounders).
- `nRef`: Number of reference taxa for Phase 1 (default 40). For small datasets or quick tests, this can be lowered, but default is recommended for publication.
- `fdrRate`: Target False Discovery Rate (default 0.05).
- `bootB`: Number of bootstrap samples for confidence intervals (default 500).

## Interpreting Results
The `estimate` column in the results represents the regression coefficient $\beta^k$.
- **Interpretation**: A unit increase in the covariate is associated with an `(exp(estimate) - 1) * 100` percent change in the absolute abundance of the taxon.
- **Example**: An estimate of 0.075 means a unit increase in the covariate is associated with a $\approx 7.8\%$ increase in absolute abundance.

## Reference documentation
- [IFAA Vignette (Rmd)](./references/IFAA.Rmd)
- [IFAA Documentation (md)](./references/IFAA.md)