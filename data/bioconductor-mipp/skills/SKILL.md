---
name: bioconductor-mipp
description: This tool performs gene selection and classification modeling using Misclassification-Penalized Posteriors to identify parsimonious gene sets for LDA, QDA, or SVM classifiers. Use when user asks to identify optimal gene biomarkers, perform forward gene selection, evaluate classification models via cross-validation, or discover masked biomarkers through sequential gene selection.
homepage: https://bioconductor.org/packages/release/bioc/html/MiPP.html
---


# bioconductor-mipp

name: bioconductor-mipp
description: Perform gene selection and classification modeling using Misclassification-Penalized Posteriors (MiPP). Use this skill to identify parsimonious gene sets for LDA, QDA, or SVM classifiers, evaluate models using independent test sets or cross-validation, and perform sequential gene selection to discover masked biomarkers.

# bioconductor-mipp

## Overview

The **MiPP** package implements a gene selection strategy based on Misclassification-Penalized Posteriors. Unlike standard error rates that dichotomize results, MiPP utilizes the posterior probability of correct classification and penalizes misclassifications. This approach provides a more granular metric for model performance, where the standardized MiPP (sMiPP) ranges from -1 to 1 (with 1 being perfect classification).

The package is primarily used for:
1. **Preprocessing** microarray data (e.g., MAS4 or IQR normalization).
2. **Forward Gene Selection** using Linear Discriminant Analysis (LDA), Quadratic Discriminant Analysis (QDA), or Support Vector Machines (SVM).
3. **Model Evaluation** via independent test sets or repeated data splitting/cross-validation.
4. **Sequential Discovery** of gene models by removing previously selected "masking" genes.

## Basic Workflow

### 1. Data Preprocessing
Use `mipp.preproc` to prepare expression matrices.
```r
library(MiPP)
# For MAS4 type data
data_clean <- mipp.preproc(expression_matrix, data.type="MAS4")
# For general data
data_clean <- mipp.preproc(expression_matrix)
```

### 2. Classification with Independent Test Set
When you have distinct training and testing sets, use the `mipp` function.
```r
out <- mipp(
  x = x.train,          # Training features (genes in rows, samples in columns)
  y = y.train,          # Training labels (factor)
  x.test = x.test,      # Test features
  y.test = y.test,      # Test labels
  rule = "lda",         # "lda", "qda", or "svm"
  n.fold = 5,           # Folds for internal CV
  percent.cut = 0.05    # Pre-select top 5% genes via t-test to save time
)

# View selected models
out$model
```

### 3. Classification with Cross-Validation (No Test Set)
If no independent test set exists, MiPP can split the data automatically.
```r
out <- mipp(
  x = x, 
  y = y, 
  n.fold = 5, 
  p.test = 1/3,         # Proportion of data for testing
  n.split = 20,         # Number of random splits
  n.split.eval = 100,   # Number of splits for final evaluation
  rule = "lda"
)
```

### 4. Sequential Gene Selection
To find alternative gene models (discovering genes that might be masked by the primary predictors), use `mipp.seq`.
```r
# Performs selection n.seq times, removing genes found in previous iterations
out_seq <- mipp.seq(
  x = x.train, 
  y = y.train, 
  x.test = x.test, 
  y.test = y.test, 
  n.seq = 3
)
```

## Interpreting Results

The `out$model` dataframe contains several key columns:
*   **Tr.sMiPP / Te.sMiPP**: Standardized MiPP for Train/Test sets. Higher is better (max 1.0).
*   **Select**: The index of the gene added at that step.
*   **Asterisks**:
    *   `*`: Indicates the model with the absolute maximum sMiPP.
    *   `**`: Indicates the **parsimonious model** (the fewest number of genes that achieve an sMiPP within 0.01 of the maximum).

## Tips for Usage
*   **Computational Cost**: SVM and QDA are significantly slower than LDA. Use `percent.cut` (e.g., 0.01 to 0.1) to filter genes using a t-test before the MiPP wrapper begins.
*   **Dependencies**: Ensure the `e1071` package is installed if using `rule="svm"`, and `MASS` for `lda`/`qda`.
*   **Data Orientation**: Input matrices `x` should typically have genes as rows and samples as columns for `mipp.preproc`, but ensure your training/test objects match the expected dimensions of the classification rules.

## Reference documentation
- [How to use the MiPP Package](./references/MiPP.md)