---
name: bioconductor-biotmle
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/biotmle.html
---

# bioconductor-biotmle

name: bioconductor-biotmle
description: Targeted Maximum Likelihood Estimation (TMLE) for biomarker discovery. Use this skill to identify genomic biomarkers (genes, proteins, etc.) associated with a binary exposure variable while adjusting for confounding covariates using causal inference methods.

## Overview

The `biotmle` package implements a causal inference framework for biomarker discovery. It uses Targeted Maximum Likelihood Estimation (TMLE) to transform biomarker expression data into influence curve (IC) representations of the Average Treatment Effect (ATE). These transformed values are then analyzed using moderated t-statistics (via `limma`) to identify significant associations. This approach provides a causal interpretation of biomarker-exposure relationships while accounting for potential confounding.

## Core Workflow

### 1. Data Preparation
The package requires three components, typically stored in a `SummarizedExperiment` object:
- **W**: Baseline covariates (confounders).
- **A**: The binary exposure of interest.
- **Y**: Biomarker expression measures.

**Note:** Continuous covariates in $W$ and $A$ should be discretized to ensure the positivity assumption is met.

```r
library(biotmle)
library(SummarizedExperiment)
library(dplyr)

# Example: Discretize a covariate in colData
colData(se) <- colData(se) %>%
  data.frame() %>%
  mutate(age_bin = as.numeric(age > median(age))) %>%
  DataFrame()

# Identify the index of the exposure variable
exp_idx <- which(names(colData(se)) == "exposure_var")
```

### 2. Biomarker Assessment (`biomarkertmle`)
This function computes the TML estimates for each biomarker. It is resource-intensive and supports parallelization via `BiocParallel`.

```r
biotmle_out <- biomarkertmle(
  se = se,
  varInt = exp_idx,
  g_lib = c("SL.mean", "SL.glm"),        # SuperLearner library for treatment mechanism
  Q_lib = c("SL.bayesglm", "SL.ranger"), # SuperLearner library for outcome mechanism
  cv_folds = 2,
  bppar_type = BiocParallel::SerialParam()
)
```

### 3. Statistical Testing (`modtest_ic`)
After computing the IC-based transformations, use `modtest_ic` to perform moderated t-tests. This function wraps `limma` logic.

```r
# Performs the moderated t-test on the influence curve representations
modtmle_results <- modtest_ic(biotmle = biotmle_out)

# Results are stored in the topTable slot
results_df <- modtmle_results@topTable
```

## Visualization

The package provides specialized plotting functions for `bioTMLE` objects:

- **P-value Histograms**: `plot(modtmle_results, type = "pvals_adj")` to check the distribution of adjusted p-values.
- **Heatmaps**: `heatmap_ic()` visualizes how biomarker contributions to the ATE vary across exposure groups.
  ```r
  heatmap_ic(modtmle_results, design = exposure_vector, top = 20, FDRcutoff = 0.05)
  ```
- **Volcano Plots**: `volcano_ic()` displays the relationship between the change in ATE contribution and the statistical significance.
  ```r
  volcano_ic(biotmle = modtmle_results)
  ```

## Implementation Tips
- **Design Matrix**: When using `modtest_ic`, do not include additional covariates in the design. The TMLE transformation already accounts for confounders specified in the `biomarkertmle` step.
- **SuperLearner**: Use a diverse set of algorithms in `g_lib` and `Q_lib` for robust estimation, but be mindful of computational time.
- **Parallelization**: For large datasets (e.g., >20,000 probes), always use `MulticoreParam()` or `SnowParam()` from `BiocParallel`.

## Reference documentation
- [Identifying Biomarkers from an Exposure Variable](./references/exposureBiomarkers.md)
- [Identifying Biomarkers from an Exposure Variable (Rmd)](./references/exposureBiomarkers.Rmd)