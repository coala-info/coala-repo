---
name: bioconductor-mai
description: The MAI package provides a two-step framework that classifies missingness mechanisms and applies mechanism-aware imputation to metabolomics data. Use when user asks to predict missingness mechanisms, impute missing values in metabolomics datasets, or handle MCAR and MNAR data simultaneously.
homepage: https://bioconductor.org/packages/release/bioc/html/MAI.html
---

# bioconductor-mai

## Overview

The `MAI` package provides a two-step framework for handling missing data in metabolomics. It first uses a random forest classifier to predict the missingness mechanism for each missing value: either Missing Completely at Random/Missing at Random (MCAR/MAR) or Missing Not at Random (MNAR). In the second step, it applies appropriate imputation algorithms based on these predictions. This approach is particularly effective for metabolomics data where both stochastic (MCAR/MAR) and left-censored (MNAR) missingness often coexist.

## Core Workflow

### 1. Data Preparation
MAI accepts data as a `matrix`, `data.frame`, or `SummarizedExperiment` object. Ensure your data is log-transformed if required by the chosen imputation algorithms.

### 2. Running the Imputation
The primary function is `MAI()`. It handles the classification and imputation in one call.

```r
library(MAI)

# Set seed for reproducibility (classification involves random sampling)
set.seed(123)

# Basic imputation for a matrix or data.frame
results <- MAI(
  data_miss = my_data,
  MCAR_algorithm = "BPCA",   # Options: "BPCA", "Multi_nsKNN", "RF"
  MNAR_algorithm = "Single", # Options: "Single", "nsKNN"
  verbose = TRUE
)

# Access the imputed matrix
imputed_matrix <- results[["Imputed_data"]]

# Access estimated parameters (Alpha, Beta, Gamma)
params <- results[["Estimated_Params"]]
```

### 3. Working with SummarizedExperiment
If using a `SummarizedExperiment`, specify the assay index.

```r
results_se <- MAI(
  data_miss = my_se,
  MCAR_algorithm = "BPCA",
  MNAR_algorithm = "Single",
  assay_ix = 1
)

# Access imputed assay
imputed_assay <- assay(results_se)

# Access metadata
meta <- metadata(results_se)[["meta_assay_1"]]
```

## Algorithm Selection

- **MCAR/MAR Algorithms**:
  - `BPCA`: Bayesian Principal Component Analysis.
  - `Multi_nsKNN`: Multiple Imputation No-Skip K-Nearest Neighbors.
  - `RF`: Random Forest (via `missForest`).
- **MNAR Algorithms**:
  - `Single`: Single imputation (often used for left-censored data).
  - `nsKNN`: No-Skip K-Nearest Neighbors.

## Parameters and Tuning

- `forest_list_args`: A list of arguments passed to the random forest classifier (e.g., `list(ntree = 300)`).
- `Alpha`, `Beta`, `Gamma`: These internal parameters (estimated during the first step) define the relationship between abundance and missingness. 
    - Small `Alpha`: More MCAR/MAR.
    - Large `Beta`/`Gamma`: More MNAR.

## Tips for Success
- **Reproducibility**: Always use `set.seed()` before calling `MAI()` because the mechanism estimation involves imposing artificial missingness to train the classifier.
- **Data Scale**: Ensure the input data is on a scale appropriate for the chosen algorithms (typically log2 or log10 for metabolomics).
- **Missingness Patterns**: If the data has very few missing values, the classifier may struggle to train effectively.

## Reference documentation
- [Utilizing Mechanism-Aware Imputation (MAI)](./references/UsingMAI.md)
- [Utilizing Mechanism-Aware Imputation (MAI) Rmd](./references/UsingMAI.Rmd)