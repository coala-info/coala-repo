---
name: bioconductor-censcyt
description: This tool performs differential abundance analysis in cytometry data when a covariate is subject to right censoring. Use when user asks to analyze cell population abundance associated with survival time, perform differential abundance testing with censored variables, or apply multiple imputation to cytometry datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/censcyt.html
---

# bioconductor-censcyt

name: bioconductor-censcyt
description: Perform differential abundance analysis in cytometry when a covariate is subject to right censoring (e.g., survival time). Use this skill when analyzing cytometry data where the primary variable of interest is a time-to-event or censored variable, extending the diffcyt workflow with multiple imputation methods.

# bioconductor-censcyt

## Overview

The `censcyt` package extends the `diffcyt` framework to handle differential abundance (DA) analysis when a covariate is right-censored. In cytometry, this is common when trying to associate cell population abundance with survival time or other time-to-event data. 

Because censored variables cannot be used directly as covariates in standard GLMMs without introducing bias, `censcyt` employs **Multiple Imputation**. The workflow follows three steps:
1. **Imputation**: Generating multiple complete datasets by replacing censored values with random draws from a predictive distribution.
2. **Analysis**: Fitting a Generalized Linear Mixed Model (GLMM) on each imputed dataset.
3. **Pooling**: Combining results using Rubin's rules to account for imputation uncertainty.

## Typical Workflow

### 1. Prepare Data and Metadata
Data should be in a `SummarizedExperiment` (cluster counts) or a list of flow frames. Metadata must include the censored covariate and an event indicator (1 for observed, 0 for censored).

```r
library(censcyt)

# Example metadata
experiment_info <- data.frame(
  sample_id = 1:50,
  survival_time = X_obs,    # The observed time (min of event or censoring)
  event_status = Event_ind  # 1 = event observed, 0 = censored
)
```

### 2. Create Formula and Contrast
Use `createFormula` with the `event_indicator` argument. This associates the indicator with the first fixed effect provided.

```r
da_formula <- createFormula(
  experiment_info = experiment_info,
  cols_fixed = "survival_time",
  cols_random = "sample_id",
  event_indicator = "event_status"
)

# Contrast for the survival_time coefficient
contrast <- matrix(c(0, 1))
```

### 3. Differential Testing
The `testDA_censoredGLMM` function performs the multiple imputation and testing.

```r
da_out <- testDA_censoredGLMM(
  d_counts = d_counts,      # SummarizedExperiment of counts
  formula = da_formula,
  contrast = contrast,
  mi_reps = 30,             # Number of imputations
  imputation_method = "km", # Kaplan-Meier imputation
  verbose = TRUE
)
```

### 4. Evaluate Results
Use the `topTable` function from `diffcyt` to view significant clusters.

```r
topTable(da_out)
```

## Imputation Methods

Specify the method via the `imputation_method` argument:

| Method | Abbr. | Description |
| :--- | :--- | :--- |
| **Risk Set** | `rs` | Replaces censored values with a random value from the risk set. |
| **Kaplan-Meier** | `km` | Draws from a survival function fit on the risk set. |
| **Mean Residual Life** | `mrl` | Adds expected time until event given the censoring time. |
| **Complete Case** | `cc` | Removes incomplete samples (not recommended for high censoring). |

**Tail Handling**: If the largest value is censored, use `km_exp`, `km_wei`, or `km_os` to approximate the tail of the survival function.

## The censcyt Wrapper
For a complete pipeline (clustering to testing), use the `censcyt()` wrapper, which mirrors the `diffcyt()` wrapper but includes imputation parameters.

```r
out_DA <- censcyt(
  d_input = d_input,        # List of flowFrames or fcs files
  experiment_info = experiment_info,
  marker_info = marker_info,
  formula = da_formula,
  contrast = contrast,
  mi_reps = 20,
  imputation_method = "km",
  meta_k = 10               # Number of clusters
)
```

## Tips and Best Practices
- **Number of Imputations (`mi_reps`)**: More imputations are required as the censoring rate increases. Setting `verbose = TRUE` will display a suggested number of imputations based on the quadratic rule.
- **Parallelization**: Use the `BPPARAM` argument (e.g., `BiocParallel::MulticoreParam()`) to speed up the analysis step across imputed datasets.
- **diffcyt Compatibility**: Since `censcyt` depends on `diffcyt`, all standard `diffcyt` visualization functions like `plotHeatmap` work on `censcyt` output objects.

## Reference documentation
- [Censored covariate in cytometry](./references/censored_covariate.Rmd)
- [Censored covariate in cytometry](./references/censored_covariate.md)