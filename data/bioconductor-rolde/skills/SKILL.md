---
name: bioconductor-rolde
description: RolDE detects longitudinal differential expression between two conditions by combining regression-based and direct comparison modules. Use when user asks to identify varying expression trends in longitudinal datasets, analyze high-dimensional data with non-aligned time points, or visualize longitudinal differential expression results.
homepage: https://bioconductor.org/packages/release/bioc/html/RolDE.html
---


# bioconductor-rolde

## Overview

RolDE is a composite R package designed to detect longitudinal differential expression (DE) between two conditions. It combines three independent modules—RegROTS (regression-based), DiffROTS (direct comparison), and PolyReg (polynomial regression)—to robustly identify varying expression trends. It is particularly effective for proteomics and other high-dimensional longitudinal datasets where replicates may have missing values or non-aligned time points.

## Core Workflow

### 1. Data Preparation
RolDE requires a data matrix (features as rows, samples as columns) and a specific 4-column design matrix. Data should be log-transformed and normalized prior to use.

**Design Matrix Structure:**
1. **Sample Names**: Must match `colnames(data)`.
2. **Condition**: Group factor (e.g., "Control", "Case").
3. **Time point**: Numeric values (aligned integers or continuous time/age).
4. **Replicate/Individual**: Identifier for the source of the sample.

### 2. Running RolDE
The primary function is `RolDE()`. It is highly recommended to use parallel processing via `n_cores`.

```r
library(RolDE)

# Basic execution with parallel processing
set.seed(1) # Recommended for reproducibility
results <- RolDE(data = data_matrix, 
                 des_matrix = design_matrix, 
                 n_cores = 3)

# Using SummarizedExperiment
library(SummarizedExperiment)
se <- SummarizedExperiment(assays = list(counts = data_matrix), 
                           colData = design_matrix)
results <- RolDE(data = se, n_cores = 3)
```

### 3. Handling Non-Aligned Time Points
If samples were not collected at identical time points across individuals, set `aligned = FALSE`.

```r
results <- RolDE(data = data_matrix, 
                 des_matrix = design_matrix, 
                 aligned = FALSE, 
                 n_cores = 3)
```

### 4. Interpreting Results
The output is a list. The primary results are in the first element.

```r
# Extract main results
de_results <- results$RolDE_Results

# Columns: Feature ID, RolDE Rank Product, Estimated Significance Value, 
# Adjusted Estimated Significance Value (FDR by default)

# Sort by significance
de_results <- de_results[order(de_results$`RolDE Rank Product`), ]
head(de_results)
```

### 5. Visualization
Use `plotFindings` to visualize the longitudinal trends of top-ranked features.

```r
# Plot the top differentially expressed feature
plotFindings(RolDE_res = results, top_n = 1)

# Plot top 10 features to a PDF
plotFindings(file_name = "top_findings.pdf", 
             RolDE_res = results, 
             top_n = 1:10)
```

## Advanced Settings

*   **Significance Estimation**: Controlled by `sigValSampN` (default is 1000). Set to 0 to skip p-value calculation for speed.
*   **P-value Adjustment**: Change via `sig_adj_meth` (e.g., "bonferroni", "BH", "qvalue").
*   **Model Complexity**: 
    *   `degree_RegROTS` and `degree_PolyReg`: Set polynomial degrees manually (default "auto").
    *   `model_type`: Choose "fixed", "mixed0" (random intercept), or "mixed1" (random intercept and slope).
*   **Missing Values**: `min_feat_obs` sets the minimum non-missing values required per replicate to include it in the analysis.

## Reference documentation

- [Introduction to the Robust longitudinal Differential Expression (RolDE) method](./references/Introduction.md)