---
name: bioconductor-methyvim
description: This tool performs targeted data-adaptive estimation and inference for differential methylation analysis using nonparametric variable importance measures. Use when user asks to estimate average treatment effects or risk ratios for DNA methylation data, perform targeted minimum loss-based estimation on CpG sites, or adjust for neighboring site methylation in epigenetic studies.
homepage: https://bioconductor.org/packages/3.8/bioc/html/methyvim.html
---

# bioconductor-methyvim

name: bioconductor-methyvim
description: Targeted data-adaptive estimation and inference for differential methylation analysis using the methyvim R package. Use this skill when performing nonparametric variable importance measure (VIM) estimation on DNA methylation data (450k/850k arrays), specifically for computing Average Treatment Effects (ATE) or Risk Ratios (RR) while controlling for neighboring CpG site methylation.

# bioconductor-methyvim

## Overview

The `methyvim` package provides a framework for differential methylation analysis using Targeted Minimum Loss-based Estimation (TMLE). Unlike standard linear models, `methyvim` treats CpG sites as variable importance measures (VIMs), allowing for nonparametric estimation of effects (ATE or RR) while adjusting for the methylation status of neighboring sites. It integrates with the `minfi` ecosystem and supports both machine learning (Super Learner) and GLM-based estimation.

## Core Workflow

### 1. Data Preparation
The package primarily operates on `GenomicRatioSet` objects from the `minfi` package.

```r
library(methyvim)
library(minfi)

# Convert MethylSet to GenomicRatioSet if necessary
mset <- mapToGenome(MsetEx)
grs <- ratioConvert(mset)

# Define binary exposure/treatment variable (must be numeric 0/1)
var_int <- as.numeric(as.factor(colData(grs)$status)) - 1
```

### 2. Running the Main Analysis
The `methyvim` function handles pre-screening, TMLE estimation, and neighborhood clustering in one call.

```r
# Basic ATE estimation using GLMs for speed
results <- methyvim(
  data_grs = grs,
  var_int = var_int,
  vim = "ate",           # "ate" for additive, "rr" for multiplicative
  type = "Beta",         # "Beta" or "Mval"
  tmle_type = "glm",     # "glm" or "sl" (Super Learner)
  filter = "limma",      # Pre-screening method
  filter_cutoff = 0.1,   # p-value cutoff for screening
  sites_comp = 50        # Max sites to estimate after screening
)
```

### 3. Extracting Results
The output is a `methytmle` object, a subclass of `GenomicRatioSet`.

```r
# Extract the VIM table
vim_results <- vim(results)

# Apply FDR correction for multi-stage analysis (FDR-MSA)
fdr_pvals <- fdr_msa(
  pvals = vim_results$pval,
  total_obs = nrow(results)
)
```

## Visualization

`methyvim` provides specialized plotting functions for the `methytmle` class:

*   `plot(results)`: Side-by-side histograms of raw and FDR-corrected p-values.
*   `methyvolc(results)`: Volcano plot (Effect size vs -log10 p-value).
*   `methyheat(results)`: Heatmap of top differentially methylated sites using the `superheat` package.

## Key Parameters

*   `vim`: Choose `"ate"` for Average Treatment Effect (difference in means) or `"rr"` for Risk Ratio (multiplicative).
*   `tmle_type`: Use `"sl"` for robust, data-adaptive estimation (requires `SuperLearner`) or `"glm"` for faster parametric estimation.
*   `obs_per_covar`: Controls the number of neighbors adjusted for. Default is 20; lower values reduce the adjustment set.
*   `parallel`: Set to `TRUE` to use `future` based parallelization for site-wise estimation.

## Reference documentation

- [Targeted Data-Adaptive Estimation and Inference for Differential Methylation Analysis](./references/using_methyvim.md)
- [Targeted Data-Adaptive Estimation and Inference for Differential Methylation Analysis (Rmd)](./references/using_methyvim.Rmd)