---
name: bioconductor-adaptest
description: The adaptest package performs a two-stage data-adaptive procedure to identify significant biomarkers in high-dimensional biological data while controlling the false discovery rate. Use when user asks to perform differential expression analysis, reduce biomarker dimensionality based on exposure variables, or conduct multiple testing with FDR control on SummarizedExperiment objects.
homepage: https://bioconductor.org/packages/3.8/bioc/html/adaptest.html
---

# bioconductor-adaptest

## Overview

The `adaptest` package implements a two-stage procedure for high-dimensional biological data analysis. It first performs a data-mining stage to reduce the dimensionality of biomarkers based on their association with an exposure variable, followed by a multiple testing stage to control the False Discovery Rate (FDR). It is particularly useful for differential expression studies where the number of potential biomarkers (genes, transcripts) greatly exceeds the sample size.

## Core Workflow

### 1. Data Preparation
The package requires three primary data structures:
- **Y**: A matrix or data frame of biomarkers (e.g., gene expression measures).
- **A**: A binary exposure or treatment variable (must be 0/1).
- **W**: A matrix of baseline covariates to control for potential confounding (optional).

### 2. Data-Adaptive Testing
Use the `adaptest()` function to perform the discovery and testing process. This function is resource-intensive as it evaluates associations for each biomarker using the SuperLearner algorithm.

```r
library(adaptest)

# Basic execution
adaptest_out <- adaptest(
  Y = simulated_array,
  A = simulated_treatment,
  W = NULL,
  n_top = 35,                # Number of top biomarkers to select
  n_fold = 5,               # Folds for cross-validation
  learning_library = c("SL.glm", "SL.mean"),
  parameter_wrapper = adaptest::rank_DE
)
```

### 3. Bioconductor Integration
For standard Bioconductor objects like `SummarizedExperiment`, use the `bioadaptest` wrapper.

```r
library(SummarizedExperiment)

airway_out <- bioadaptest(
  data_in = simple_air,      # SummarizedExperiment object
  var_int = dex_var,         # Binary treatment vector
  cntrl_set = NULL,          # Control variables
  n_top = 5,
  n_fold = 2,
  parameter_wrapper = rank_DE
)
```

## Interpreting Results

The output object (class `data_adapt`) contains several key slots:
- `top_index`: Indices of selected biomarkers.
- `top_colname_significant_q`: Names of biomarkers significant after FDR adjustment.
- `p_value` / `q_value`: Raw and adjusted p-values for the selected biomarkers.
- `DE`: Effect sizes (differential expression).

### Summary and Visualization
- **Summary**: Use `summary(adaptest_out)` to view a table of effect sizes, p-values, and q-values.
- **Composition**: Use `get_composition(adaptest_out, type = "small")` to see the stability of data-adaptive parameters across CV folds.
- **Plotting**: `plot(adaptest_out)` generates two plots: sorted average CV-ranks and sorted q-values.

## Usage Tips
- **Sample Size**: Data-adaptive parameters require a relatively large sample size for stable estimation.
- **Positivity**: Ensure the exposure variable `A` is binary to avoid violations of the positivity assumption in TMLE.
- **Library Selection**: The `learning_library` argument determines the machine learning algorithms used. Including "SL.glm" and "SL.mean" is a common baseline, but more complex libraries can be used if the sample size permits.

## Reference documentation
- [Data-Mining Biomarkers and High-Dimensional Testing](./references/differentialExpression.md)
- [Data-Mining Biomarkers and High-Dimensional Testing (Rmd)](./references/differentialExpression.Rmd)