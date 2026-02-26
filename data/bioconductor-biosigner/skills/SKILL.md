---
name: bioconductor-biosigner
description: The biosigner package implements a wrapper feature selection algorithm using PLS-DA, Random Forest, and SVM to identify stable molecular signatures from high-throughput omics data. Use when user asks to identify significant feature signatures, perform binary classification with feature selection, or rank omics variables into significance tiers.
homepage: https://bioconductor.org/packages/release/bioc/html/biosigner.html
---


# bioconductor-biosigner

## Overview

The `biosigner` package implements a wrapper feature selection algorithm to identify restricted and stable molecular signatures from high-throughput omics data. It supports three binary classifiers: **Partial Least Square Discriminant Analysis (PLS-DA)**, **Random Forest (RF)**, and **Support Vector Machines (SVM)**. The algorithm uses bootstrapping and binary search to rank features into tiers (S, A, B, C, D, E), where Tier **S** represents the final, most significant signature.

## Core Workflow

### 1. Data Preparation
`biosigner` requires a numeric matrix of intensities (samples as rows) and a factor/character vector for binary class labels. It also supports Bioconductor containers like `SummarizedExperiment`.

```r
library(biosigner)
data(diaplasma)
x <- diaplasma$dataMatrix
y <- diaplasma$sampleMetadata[, "type"]
```

### 2. Feature Selection (biosign)
The `biosign` function is the primary entry point. It runs the selection algorithm for the specified classifiers.

```r
# Run selection with all three classifiers
# bootI: number of bootstraps (default 50 recommended for stability)
sig <- biosign(x, y, methodVc = "all", bootI = 50)

# Print summary of signatures and accuracies
print(sig)

# Plot the tiers of selected features
plot(sig, typeC = "tier")
```

### 3. Interpreting Tiers
*   **Tier S**: The final signature; features significant in all selection steps.
*   **Tier A-E**: Features discarded in successive rounds of backward selection.
*   **Accuracy**: The package reports "Balanced Accuracy" for the Full model, the S+A model (AS), and the S model.

### 4. Visualization
You can visualize the relevance of features or their individual distributions.

```r
# Boxplots of features in the complete signature
plot(sig, typeC = "boxplot")

# View features from S and A tiers specifically
plot(sig, tierMaxC = "A")
```

### 5. Prediction
Use the trained models to predict classes for new data.

```r
# Predict on training data (fitted values)
predictions <- predict(sig)

# Predict on new data
new_preds <- predict(sig, newdata = new_matrix)
```

## Working with Bioconductor Containers

### SummarizedExperiment
When using `SummarizedExperiment`, pass the object as `x` and the column name of the metadata as `y`.

```r
# Returns an updated SummarizedExperiment with tiers in rowData
se_result <- biosign(my_se, y = "group_column")

# Extract the biosign model from metadata
model <- getBiosign(se_result)
```

### MultiAssayExperiment
`biosigner` can process multi-omics datasets in parallel.

```r
# Performs selection for each experiment in the MAE
mae_result <- biosign(my_mae, y = "response_column")
```

## Tips for Success
*   **Binary Classification**: Currently, `biosigner` only supports datasets with exactly two classes.
*   **Missing Values**: Random Forest and SVM will remove features with `NA` values. PLS-DA (via NIPALS) can handle them.
*   **Stability**: Use at least 50 bootstraps (`bootI = 50`) for publication-quality signatures.
*   **Feature Extraction**: Use `getSignatureLs(sig)` to retrieve a list of feature names for each classifier and the "complete" (union) signature.

## Reference documentation
- [biosigner: A new method for signature discovery from omics data](./references/biosigner-vignette.md)