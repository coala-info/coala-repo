---
name: bioconductor-kmcut
description: This tool identifies optimal numeric cutoffs for quantitative data to stratify samples into groups with significantly different survival outcomes. Use when user asks to find prognostic biomarkers, perform Kaplan-Meier analysis, optimize expression thresholds, or conduct univariate Cox regression.
homepage: https://bioconductor.org/packages/release/bioc/html/kmcut.html
---

# bioconductor-kmcut

name: bioconductor-kmcut
description: Identify prognostic biomarkers and optimal numeric cutoffs for survival analysis using the kmcut R package. Use this skill when analyzing gene expression or quantitative data to stratify samples into sub-groups with significantly different survival outcomes (Kaplan-Meier analysis, Cox regression, and permutation testing).

## Overview

The `kmcut` package is designed to find optimal thresholds for quantitative variables (like RNA-seq gene expression) that best separate subjects into high-risk and low-risk survival groups. It provides tools for automated cutoff optimization, statistical validation via permutation tests, univariate Cox regression, and data manipulation.

## Typical Workflow

### 1. Data Preparation
Input requires two tab-delimited files with matching sample identifiers:
- **Survival Data**: Columns `sample_id` (1st column), `stime` (survival time), and `scens` (censoring: 0 or 1).
- **Expression Data**: Features in rows, samples in columns. 1st column contains feature IDs.

```r
library(kmcut)
library(SummarizedExperiment)

# Create the required SummarizedExperiment object
se <- create_se_object(efile = "expression.txt", sfile = "survival.txt")
```

### 2. Finding Optimal Cutoffs
There are two primary methods for finding the "best" cutoff:

- **Permutation Test (`km_opt_pcut`)**: The most robust method. It finds the cutoff maximizing the log-rank statistic and validates it using a permutation test to avoid over-fitting.
- **Fast Search (`km_opt_scut`)**: Identifies the optimal cutoff without the time-consuming permutation test. Useful for initial screening.

```r
# Robust optimization with 1000 permutations
km_opt_pcut(obj = se, bfname = "output_prefix", n_iter = 1000, nproc = 4)

# Fast exploratory search
km_opt_scut(obj = se, bfname = "fast_output")
```

### 3. Fixed or Quantile Cutoffs
If optimization is not required, use fixed values or quantiles:

```r
# Use the median (50th quantile)
km_qcut(obj = se, bfname = "median_cut", quant = 50)

# Use a specific numeric value (e.g., 5.0)
km_ucut(obj = se, bfname = "fixed_cut", cutoff = 5.0)
```

### 4. Validation
Apply cutoffs discovered in a training set to a new validation dataset:

```r
# 'infile' is the results text file from a previous km_opt or km_qcut run
km_val_cut(infile = "training_results.txt", obj = validation_se, bfname = "validation")
```

### 5. Cox Regression
Perform univariate Cox proportional hazard modeling for all features:

```r
# Batch processing
ucox_batch(obj = se, bfname = "cox_results")

# Predict risk scores for a test set based on a training set
ucox_pred(obj1 = training_se, obj2 = test_se, bfname = "prediction")
```

## Interpreting Results

- **R (Spearman Correlation)**: In optimization plots, a high R (close to 1) indicates a "clean" optimization with a single clear peak in the test statistic.
- **P-value (Permutation)**: In `km_opt_pcut`, this is the true significance of the optimization.
- **Output Files**:
    - `.txt`: Contains cutoffs, Chi-square statistics, and p-values.
    - `_labels.csv`: Contains the stratification (1=Low, 2=High) for every sample.
    - `.pdf`: Visualizes Kaplan-Meier curves and optimization plots.

## Table Manipulation Utilities

- `extract_rows(fnamein, fids, fnameout)`: Subset features using a list of IDs.
- `extract_columns(fnamein, fids, fnameout)`: Subset samples using a list of IDs.
- `transpose_table(fnamein, fnameout)`: Swap rows and columns.

## Reference documentation

- [Introduction to kmcut](./references/kmcut_intro.md)