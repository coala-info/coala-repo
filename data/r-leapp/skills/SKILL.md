---
name: r-leapp
description: "These functions take a gene expression value matrix, a         primary covariate vector, an additional known covariates         matrix.  A two stage analysis is applied to counter the effects         of latent variables on the rankings of hypotheses.  The         estimation and adjustment of latent effects are proposed by         Sun, Zhang and Owen (2011).  \"leapp\" is developed in the         context of microarray experiments, but may be used as a general         tool for high throughput data sets where dependence may be         involved.</p>"
homepage: https://cran.r-project.org/web/packages/leapp/index.html
---

# r-leapp

name: r-leapp
description: Latent Effect Adjustment After Primary Projection (leapp) for high-throughput data. Use this skill when performing differential expression analysis or hypothesis testing in genomic data (microarrays, RNA-seq) where latent variables, batch effects, or unobserved confounders may bias results. It is particularly useful for ranking hypotheses and estimating latent effects in the presence of primary covariates.

## Overview

The `leapp` package implements a two-stage analysis to counter the effects of latent variables on the rankings of hypotheses. Developed primarily for microarray experiments, it serves as a general tool for high-throughput datasets where dependence between variables is suspected. It adjusts for latent effects by projecting the data onto the null space of primary and known covariates, then estimating the latent structure.

## Installation

```R
install.packages("leapp")
```

## Main Functions

- `leapp()`: The primary function for latent effect adjustment. It takes a gene expression matrix, a primary covariate, and optional known covariates.
- `fdr_leapp()`: Calculates the False Discovery Rate (FDR) for the adjusted statistics.
- `permute_leapp()`: Performs permutation tests to assess the significance of the latent effects.

## Workflow

1. **Data Preparation**: Ensure your data is in a matrix format (rows as features/genes, columns as samples). Define your primary covariate (e.g., treatment vs. control) and any known batch effects or covariates.

2. **Latent Effect Estimation**:
   Run the main adjustment function.
   ```R
   library(leapp)
   # data: matrix of expression values
   # pred: primary covariate vector
   # con: matrix of known covariates (optional)
   res <- leapp(data, pred = group_vector, con = known_covariates)
   ```

3. **Extract Results**:
   The output contains adjusted p-values and effect size estimates.
   ```R
   # Access p-values
   p_values <- res$p
   # Access adjusted statistics
   stats <- res$statistics
   ```

4. **FDR Control**:
   Apply FDR correction to the results.
   ```R
   fdr_results <- fdr_leapp(res$p)
   ```

## Tips

- **Latent Factor Selection**: By default, `leapp` attempts to estimate the number of latent factors. You can manually specify the number of factors using the `num.fac` argument if you have prior knowledge of the data structure.
- **Scaling**: Ensure your data is properly normalized (e.g., log-transformed for RNA-seq or microarray) before applying `leapp`.
- **Comparison**: `leapp` is often compared to SVA (Surrogate Variable Analysis). While SVA focuses on capturing surrogate variables to include in a model, `leapp` uses a projection-based approach to adjust the rankings directly.

## Reference documentation

- [leapp: Latent Effect Adjustment After Primary Projection](./references/home_page.md)