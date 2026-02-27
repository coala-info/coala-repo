---
name: bioconductor-ropls
description: This tool performs multivariate analysis of omics data using PCA, PLS, and OPLS for dimensionality reduction, regression, and classification. Use when user asks to perform principal component analysis, run PLS-DA or OPLS-DA models, validate model performance with permutation testing, or identify significant features using Variable Importance in Projection scores.
homepage: https://bioconductor.org/packages/release/bioc/html/ropls.html
---


# bioconductor-ropls

name: bioconductor-ropls
description: Multivariate analysis of omics data using PCA, PLS(-DA), and OPLS(-DA). Use this skill to perform dimensionality reduction, regression, classification, and feature selection (VIP) on metabolomics or other high-throughput datasets. It supports standard R matrices, SummarizedExperiment, and MultiAssayExperiment objects.

## Overview
The `ropls` package provides a unified interface for Principal Component Analysis (PCA), Partial Least Squares (PLS), and Orthogonal Partial Least Squares (OPLS). It is specifically designed for "omics" data where the number of variables often exceeds the number of samples. Key features include NIPALS-based algorithms, R2/Q2 quality metrics, permutation testing to prevent overfitting, and Variable Importance in Projection (VIP) for feature selection.

## Core Workflow

### 1. Data Preparation
The package expects a data matrix (samples as rows, variables as columns) or a Bioconductor container.
```R
library(ropls)
data(sacurine)
# Standard matrix approach
data_matrix <- sacurine$dataMatrix
# Metadata for coloring/classification
gender_fc <- sacurine$sampleMetadata[, "gender"]
```

### 2. Principal Component Analysis (PCA)
Use PCA for unsupervised exploration and outlier detection.
```R
# Default PCA (computes components until 50% variance is reached)
pca_model <- opls(data_matrix)

# Plotting scores colored by a factor
plot(pca_model, typeVc = "x-score", parAsColFcVn = gender_fc)
```

### 3. PLS and OPLS (Regression or Classification)
Provide a response `y` (numeric for regression, factor for classification/DA).
```R
# PLS-DA
plsda_model <- opls(data_matrix, gender_fc)

# OPLS-DA (1 predictive component + orthogonal components)
# Set orthoI = NA for automatic determination of orthogonal components
oplsda_model <- opls(data_matrix, gender_fc, predI = 1, orthoI = NA)
```

### 4. Model Validation and Performance
- **R2X, R2Y, Q2**: Check these in the model summary. High Q2 indicates good predictive power.
- **Permutation Testing**: Automatically performed for single-response models (default `permI = 20`). Increase to `permI = 1000` for publication-quality p-values.
- **Training/Test Sets**: Use the `subset` argument.
```R
# Train on half the data
opls_sub <- opls(data_matrix, gender_fc, subset = "odd")
# Predict on the remaining half
predictions <- predict(opls_sub, data_matrix[getSubsetVi(opls_sub) == FALSE, ])
```

### 5. Feature Selection (VIP)
Extract Variable Importance in Projection to identify significant features.
```R
# Predictive VIPs (standard)
vips <- getVipVn(oplsda_model)

# Orthogonal VIPs (for OPLS models)
vips_ortho <- getVipVn(oplsda_model, orthoL = TRUE)
```

## Working with Bioconductor Containers

### SummarizedExperiment
`ropls` integrates directly with `SummarizedExperiment`. It appends results to `rowData` and `colData`.
```R
# y is the name of the column in colData
se_result <- opls(my_summarized_experiment, "response_column")

# Access the underlying opls object
model_list <- getOpls(se_result)
```

### MultiAssayExperiment
Perform parallel modeling across multiple omics layers.
```R
# Builds models for every experiment in the MAE
mae_result <- opls(my_mae, "response_column")
```

## Tips and Best Practices
- **Scaling**: By default, `opls` performs unit-variance scaling.
- **Missing Values**: The NIPALS algorithm handles moderate amounts of missing data; no prior imputation is strictly required.
- **Overfitting**: Always check the `pQ2` value. If `pQ2 > 0.05`, the model may be overfitted, especially if the number of variables is much larger than the number of samples.
- **Visualization**: The `plot()` function is highly versatile. Use `typeVc` to switch between "overview", "x-score", "x-loading", "outlier", and "significance".

## Reference documentation
- [ropls: PCA, PLS(-DA) and OPLS(-DA) for multivariate analysis and feature selection of omics data](./references/ropls-vignette.md)