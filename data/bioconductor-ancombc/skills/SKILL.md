---
name: bioconductor-ancombc
description: "the package includes Analysis of Compositions of Microbiomes with Bias Correction 2 (ANCOM-BC2), Analysis of Compositions of Microbiomes with Bias Correction (ANCOM-BC), and Analysis of Composition of Microbiomes (ANCOM) for DA analysis, and Sparse Estimation of Correlations among Microbiomes (SECOM) for correlation analysis. Microbiome data are typically subject to two sources of biases: unequal sampling fractions (sample-specific biases) and differential sequencing efficiencies (taxon-specific biases). Methodologies included in the ANCOMBC package are designed to correct these biases and construct statistically consistent estimators."
homepage: https://bioconductor.org/packages/release/bioc/html/ANCOMBC.html
---

# bioconductor-ancombc

name: bioconductor-ancombc
description: Analysis of Compositions of Microbiomes with Bias Correction (ANCOM-BC, ANCOM-BC2), ANCOM, and SECOM. Use this skill for differential abundance (DA) analysis of microbiome data, correcting for sampling fractions and sequencing efficiencies, and for sparse correlation analysis (SECOM).

# bioconductor-ancombc

## Overview

The `ANCOMBC` package provides a suite of statistical methods for microbiome data analysis that account for compositionality and various biases (sampling fractions and sequencing efficiencies). It includes:
* **ANCOM-BC2**: The latest version for DA analysis, supporting bias correction, sensitivity analysis for pseudo-counts, and complex experimental designs (multi-group, longitudinal, and pattern analysis).
* **ANCOM-BC**: The original bias-corrected DA method.
* **ANCOM**: A heuristic DA method using log-ratio transformations.
* **SECOM**: Sparse Estimation of Correlations among Microbiomes for linear and non-linear correlation analysis.

## Core Workflows

### 1. Data Preparation
The package primarily works with `phyloseq` or `TreeSummarizedExperiment` (TSE) objects.

```r
library(ANCOMBC)
library(tidyverse)

# Example: Preparing a phyloseq object
data(atlas1006, package = "microbiome")
pseq = phyloseq::subset_samples(atlas1006, time == 0)

# Ensure categorical variables are factors with correct reference levels
sample_data(pseq)$bmi = factor(sample_data(pseq)$bmi_group, 
                               levels = c("obese", "overweight", "lean"))
```

### 2. Differential Abundance with ANCOM-BC2
`ancombc2` is the recommended function for most DA tasks. It handles structural zeros and provides sensitivity analysis.

```r
set.seed(123)
output = ancombc2(
  data = pseq, 
  tax_level = "Family",
  fix_formula = "age + region + bmi",
  p_adj_method = "holm",
  prv_cut = 0.10, 
  lib_cut = 1000,
  group = "bmi", 
  struc_zero = TRUE, 
  neg_lb = TRUE,
  alpha = 0.05, 
  global = TRUE, 
  pairwise = TRUE, 
  dunnet = TRUE, 
  trend = TRUE
)

# Access results
res_prim = output$res        # Primary DA results
res_global = output$res_global # Global test results
res_pair = output$res_pair   # Pairwise comparisons
```

### 3. Correlation Analysis with SECOM
Use `secom_linear` for Pearson/Spearman correlations and `secom_dist` for non-linear distance correlations.

```r
# Linear correlation between Genus and Phylum levels
res_linear = secom_linear(
  pseqs = list(c(genus_data, phylum_data)), 
  prv_cut = 0.5, 
  method = "pearson"
)

# Non-linear distance correlation
res_dist = secom_dist(
  pseqs = list(c(genus_data, phylum_data)), 
  R = 1000
)
```

### 4. Classic ANCOM
For studies where the heuristic W-statistic approach is preferred.

```r
out = ancom(
  data = pseq, 
  tax_level = "Family", 
  main_var = "bmi", 
  adj_formula = "age + region",
  struc_zero = TRUE
)
# W statistic represents the number of ALR models where taxon is DA
res = out$res 
```

## Key Parameters and Tips

* **Formula Syntax**: Use `fix_formula` for fixed effects. Interactions must use `*` (e.g., `age * bmi`). The `:` operator is not supported.
* **Structural Zeros**: Set `struc_zero = TRUE` to identify taxa present in one group but completely absent in another. These are automatically declared DA.
* **Sensitivity Analysis**: Always check `diff_robust`. If `TRUE`, the taxon's significance is stable across different pseudo-count values (0.1, 0.5, 1).
* **Multi-group Comparisons**: 
  * `global = TRUE`: Performs a Likelihood Ratio Test across all levels of the `group` variable.
  * `pairwise = TRUE`: Performs all possible pairwise comparisons with mdFDR control.
  * `dunnet = TRUE`: Compares all groups against the reference level.
* **Bias Correction**: Access bias-corrected log-abundances via `out$samp_frac`. Subtract these sampling fractions from log-observed counts to get corrected values.

## Reference documentation
- [ANCOM Tutorial](./references/ANCOM.md)
- [ANCOM-BC Vignette](./references/ANCOMBC.Rmd)
- [ANCOM-BC Methodology](./references/ANCOMBC.md)
- [ANCOM-BC2 Comprehensive Guide](./references/ANCOMBC2.md)
- [SECOM Correlation Analysis](./references/SECOM.md)
- [Data Sanity Checks](./references/data_sanity_check.md)