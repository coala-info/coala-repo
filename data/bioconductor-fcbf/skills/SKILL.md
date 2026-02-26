---
name: bioconductor-fcbf
description: This tool performs feature selection in high-dimensional biological data using the Fast Correlation-Based Filter algorithm to identify relevant, non-redundant features. Use when user asks to select features using Symmetrical Uncertainty, reduce dimensionality in single-cell RNA-Seq data, or filter genes for machine learning models.
homepage: https://bioconductor.org/packages/3.8/bioc/html/FCBF.html
---


# bioconductor-fcbf

name: bioconductor-fcbf
description: Fast Correlation-Based Filter (FCBF) for feature selection in high-dimensional biological data. Use this skill to identify a subset of features (e.g., genes) that are highly correlated with a target class variable but have low redundancy with each other using Symmetrical Uncertainty (SU).

# bioconductor-fcbf

## Overview
The `FCBF` package implements a classifier-independent feature selection algorithm. It is particularly useful for high-dimensional datasets like single-cell RNA-Seq where reducing the number of features is necessary to prevent overfitting and reduce computational time. The algorithm uses Symmetrical Uncertainty (SU) based on information theory to identify "predominant correlations," ensuring selected features are relevant to the target variable without being redundant with one another.

## Core Workflow

### 1. Data Preparation and Discretization
FCBF requires discrete data because its underlying entropy calculations are based on categorical classes.

```r
library(FCBF)

# Assuming 'exprs' is a matrix of continuous expression values (genes x samples)
# discretize_exprs uses a gene-dependent range-based approach (low/high)
discrete_expression <- as.data.frame(discretize_exprs(exprs))
```

### 2. Determining the SU Threshold
The default threshold for Symmetrical Uncertainty is 0.25. If this is too high for your dataset (resulting in zero features), use `su_plot` to visualize the distribution of correlations and select a more appropriate threshold.

```r
# 'target' is the vector of class labels for the samples
su_plot(discrete_expression, target)

# Look for a threshold where a reasonable number of features are above the line
```

### 3. Feature Selection
Run the main `fcbf` function to perform the filtering.

```r
# thresh: SU threshold (e.g., 0.05)
# verbose: TRUE to see the rounds of redundancy removal
fcbf_features <- fcbf(discrete_expression, target, thresh = 0.05, verbose = TRUE)

# The output contains:
# fcbf_features$index : indices of selected features
# fcbf_features$su    : SU values for selected features
```

### 4. Downstream Analysis
Use the indices to subset your original continuous data for machine learning or visualization.

```r
# Subset the original continuous expression matrix
selected_data <- exprs[fcbf_features$index, ]

# Example: Prepare for caret-based machine learning
dataset_fcbf <- cbind(as.data.frame(t(selected_data)), target_variable = target)
```

## Tips for Success
- **Threshold Sensitivity:** If the `fcbf` function returns an error or no features, it is almost always because the `thresh` parameter is too high. Use `su_plot` to find the "elbow" or a reasonable cutoff.
- **Discretization:** While `discretize_exprs` is provided, you can use other discretization methods as long as the input to `fcbf` is a data frame of factors or discrete values.
- **Memory Efficiency:** FCBF is significantly more memory-efficient than fitting models on the full feature set (e.g., SVM on 20,000 genes), making it an ideal pre-filtering step.

## Reference documentation
- [FCBF : Fast Correlation Based Filter for Feature Selection](./references/FCBF-Vignette.md)