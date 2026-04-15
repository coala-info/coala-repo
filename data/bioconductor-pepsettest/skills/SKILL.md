---
name: bioconductor-pepsettest
description: This tool performs peptide-centric differential expression analysis for proteomics data to identify differentially expressed proteins. Use when user asks to perform competitive or self-contained peptide set tests, identify differentially expressed proteins without aggregating peptide abundances, or run aggregation-based limma workflows on LC-MS/MS data.
homepage: https://bioconductor.org/packages/release/bioc/html/PepSetTest.html
---

# bioconductor-pepsettest

name: bioconductor-pepsettest
description: Peptide-centric differential expression analysis for proteomics data. Use this skill when performing statistical inference on LC-MS/MS data to identify differentially expressed proteins without aggregating peptide abundances first. It supports competitive and self-contained peptide set tests, as well as traditional aggregation-based workflows (limma).

# bioconductor-pepsettest

## Overview

The `PepSetTest` package implements a peptide-centric strategy for proteomics differential expression analysis. Instead of the traditional approach of collapsing peptide abundances into protein-level data before statistical testing, `PepSetTest` fits linear models directly to peptide data. This approach often provides improved statistical power while maintaining correct Type I error control.

## Core Workflows

### 1. Competitive Peptide Set Test
This is the primary method. It compares coordinated changes in peptides from a specific protein against the rest of the peptidome.

```r
library(PepSetTest)

# Required inputs:
# dat: Matrix or SummarizedExperiment of peptide abundances
# contrasts.par: String format "GroupA-GroupB"
# group: Vector of group labels (or colData column name)
# pep_mapping_tbl: Data frame mapping peptides to proteins (or rowData column name)

result <- CompPepSetTestWorkflow(
  dat, 
  contrasts.par = "D-H",
  group = group,
  pep_mapping_tbl = pep_mapping_tbl,
  stat = "t",
  correlated = TRUE,        # Recommended: accounts for inter-peptide correlation
  equal.correlation = TRUE,
  pepC.estim = "mad",       # Estimator for background standard deviation
  logged = FALSE            # Set to TRUE if data is already log-transformed
)
```

### 2. Self-Contained Peptide Set Test
Determines if peptides belonging to a protein are differentially expressed without comparing them to other proteins.

```r
result_sc <- SelfContPepSetTestWorkflow(
  dat.se, 
  contrasts.par = "D-H",
  group = "group_col",
  pep_mapping_tbl = "protein_col",
  logged = FALSE
)
```

### 3. Aggregation-based (Limma) Workflow
A convenience function to run traditional protein-level aggregation followed by `limma`.

```r
result_limma <- AggLimmaWorkflow(
  dat.se, 
  contrasts.par = "D-H",
  group = "group_col",
  pep_mapping_tbl = "protein_col",
  method = "robreg", # Robust regression for aggregation
  logged = FALSE
)
```

## Data Preparation and Tips

*   **Input Formats**: Accepts standard R `matrix` objects or Bioconductor `SummarizedExperiment` objects.
*   **Mapping Table**: Ensure your mapping table contains at least two columns: one for peptide IDs (matching rownames of your data) and one for protein IDs.
*   **Missing Values**: Peptide data often contains many NAs. It is recommended to filter out peptides with >30% missing values or perform imputation before running the tests.
*   **Log Transformation**: Most functions include a `logged` parameter. If your input matrix is already log2-transformed, set `logged = TRUE`.
*   **Covariates**: All workflow functions support a `covar` argument to include additional variables (e.g., `covar = c("sex", "age")`) in the linear model.
*   **Correlation**: Unless there is a specific reason otherwise, always set `correlated = TRUE` in `CompPepSetTestWorkflow` to allow the package to estimate inter-peptide correlations using mixed models.

## Reference documentation

- [A Tutorial for PepSetTest](./references/PepSetTest.md)
- [PepSetTest Vignette Source](./references/PepSetTest.Rmd)