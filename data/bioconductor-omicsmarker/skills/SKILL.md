---
name: bioconductor-omicsmarker
description: This tool performs classification and feature selection for high-dimensional omics datasets to identify and evaluate biomarkers. Use when user asks to perform biomarker discovery, evaluate feature selection stability, run ensemble classification workflows, or conduct permutation analysis for statistical significance.
homepage: https://bioconductor.org/packages/3.8/bioc/html/OmicsMarkeR.html
---

# bioconductor-omicsmarker

name: bioconductor-omicsmarker
description: Tools for classification and feature selection in 'omics' datasets. Use this skill to perform biomarker discovery, evaluate model robustness through stability metrics (Jaccard, Kuncheva, etc.), run ensemble classification workflows, and conduct permutation analysis for statistical significance in high-dimensional biological data.

# bioconductor-omicsmarker

## Overview
OmicsMarkeR is designed to streamline the analysis of high-dimensional 'omics' data. It focuses on identifying the most important features (biomarkers) for group classification while providing robust metrics to evaluate the stability and performance of these selections. It supports various algorithms (PLSDA, Random Forest, etc.), ensemble methods, and automated tuning.

## Installation
Install the package using BiocManager:
```r
if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
BiocManager::install("OmicsMarkeR")
library(OmicsMarkeR)
```

## Data Generation and Preparation
Use internal functions to create synthetic multivariate datasets for testing or benchmarking:
- `create.random.matrix(nvar, nsamp)`: Create a null dataset.
- `create.corr.matrix(dat)`: Induce correlations.
- `create.discr.matrix(dat, D)`: Induce variables that discriminate between groups.

## Feature Selection and Stability Analysis
The core workflow uses `fs.stability` to run classification and feature selection across multiple bootstrap repetitions.

```r
# Basic workflow
fits <- fs.stability(vars, 
                     groups, 
                     method = c("plsda", "rf"), 
                     f = 10,           # Number of top features to select
                     k = 3,            # Bootstrap repetitions
                     k.folds = 10)     # Cross-validation folds
```

### Evaluating Results
- **Performance**: Use `performance.metrics(fits)` to see Accuracy, Kappa, ROC AUC, and Robustness-Performance Trade-off (RPT).
- **Feature Consistency**: Use `feature.table(fits, "method_name")` to see how often specific features were selected across runs.
- **Prediction**: Use `predictNewClasses(fits, "method", original_df, newdata)` to apply the fitted model to new samples.

## Ensemble Methods
To improve predictive performance, use bagging and aggregation techniques:
```r
fits_ensemble <- fs.ensembl.stability(vars, 
                                      groups, 
                                      method = c("plsda", "rf"), 
                                      bags = 10, 
                                      aggregation.metric = "CLA")
```
Supported aggregation metrics include:
- `CLA`: Complete Linear Aggregation
- `EM`: Ensemble Mean
- `ES`: Ensemble Stability
- `EE`: Ensemble Exponential

## Stability Metrics
Evaluate the similarity between sets of selected features (e.g., from different models or datasets):
- **Set Methods**: `jaccard(run1, run2)`, `sorensen(run1, run2)`, `ochiai(run1, run2)`.
- **Chance-corrected**: `kuncheva(run1, run2, total_features)`.
- **Pairwise**: Use `pairwise.stability(matrix_of_features, "metric")` for multiple runs.

## Custom Tuning
Fine-tune model parameters using `denovo.grid`:
```r
# Create custom grid for Random Forest with 5 levels
rf_grid <- denovo.grid(data_df, "rf", 5)
fits <- fs.stability(vars, groups, method = "rf", grid = list(rf = rf_grid))
```

## Permutation Analysis
Verify if results are better than chance:
- `perm.class`: Permutes group labels to check classification significance.
- `perm.features`: Permutes groups to evaluate the importance of specific variables.

## Parallel Processing
For large datasets, enable parallel execution by setting `allowParallel = TRUE` in main functions. Ensure a backend (like `doMC` for Unix or `doSNOW` for Windows) is registered first.

## Reference documentation
- [A Short Introduction to the OmicsMarkeR Package](./references/OmicsMarkeR.md)