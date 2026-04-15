---
name: bioconductor-bprmeth
description: BPRMeth models, reconstructs, and clusters DNA methylation profiles using Basis Profile Regression to capture the functional shape of methylation landscapes. Use when user asks to represent methylation data as continuous functions, extract features for gene expression prediction, or cluster methylation patterns across genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/BPRMeth.html
---

# bioconductor-bprmeth

name: bioconductor-bprmeth
description: Modeling, reconstructing, and clustering DNA methylation profiles using Basis Profile Regression (BPR). Use this skill to represent noisy or irregularly sampled methylation data as continuous functions, extract features for gene expression prediction, and perform clustering on methylation patterns across genomic regions.

## Overview
BPRMeth (Basis Profile Regression for Methylation) is an R package designed to model DNA methylation profiles across genomic regions, such as promoters or enhancers. Instead of relying on simple summary statistics like mean methylation, BPRMeth uses basis functions (Radial Basis Functions, Polynomials, or Fourier series) to capture the "shape" of the methylation landscape. This functional representation is particularly useful for handling missing data, irregular sampling, and providing high-quality features for downstream machine learning tasks like predicting gene expression.

## Installation and Loading
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BPRMeth")
library(BPRMeth)
```

## Core Workflow

### 1. Data Preprocessing
BPRMeth expects methylation data to be formatted as a list of matrices, where each element represents a genomic region. Each matrix should have two columns: the first for genomic positions (relative to a landmark like a TSS) and the second for methylation levels (0 to 1).

```R
# Example: Preprocess raw methylation data
# 'data' should be a list of matrices or a GRanges object
met_data <- preprocess_methylation(data)
```

### 2. Defining Basis Functions
You must define the type and number of basis functions to use for the regression.
- `rbf`: Radial Basis Functions (recommended for most biological profiles).
- `poly`: Polynomial basis.
- `fourier`: Fourier basis.

```R
# Create a basis object with 3 RBFs
basis <- create_basis(k = 3, basis_type = "rbf", window_range = c(-1000, 1000))
```

### 3. Inferring Profiles
Use Maximum Likelihood Estimation (MLE) or Gibbs sampling to fit the BPR model to the data. This extracts the coefficients (w) that represent the profile shape.

```R
# Infer profiles using MLE
out <- infer_profiles_mle(X = met_data, basis = basis, parallel = TRUE)

# Access the learned coefficients
betas <- out$W
```

### 4. Predicting Gene Expression
A common use case is using the learned methylation features to predict mRNA expression levels.

```R
# Combine methylation features with expression data
# 'exp_data' is a vector of expression values corresponding to the regions
data_sim <- data.frame(expression = exp_data, out$W)

# Fit a regression model (e.g., linear regression or SVM)
fit <- predict_expr(formula = expression ~ ., data = data_sim, model_name = "lm")
```

### 5. Clustering Profiles
To identify groups of genomic regions with similar methylation patterns:

```R
# Cluster profiles into 3 groups
cl_out <- cluster_profiles_mle(X = met_data, K = 3, basis = basis)

# Plot the cluster centers
plot_cluster_profiles(cl_out)
```

## Key Functions Reference
- `create_basis()`: Initializes the basis function object.
- `preprocess_methylation()`: Formats input data into the required list structure.
- `infer_profiles_mle()` / `infer_profiles_gibbs()`: Fits the BPR model to the data.
- `predict_expr()`: High-level wrapper for predicting expression from methylation features.
- `cluster_profiles_mle()`: Performs EM-based clustering on functional profiles.
- `box_plot_met()`: Visualizes methylation distribution across regions.

## Tips for Success
- **Window Scaling**: Ensure the `window_range` in `create_basis` matches the relative coordinates used in your input data (e.g., -500 to 500 bp around TSS).
- **Basis Complexity**: A higher `k` (number of basis functions) captures more detail but risks overfitting. For promoter regions, `k = 3` to `k = 9` is typically sufficient.
- **Parallelization**: Use `parallel = TRUE` in inference functions when dealing with thousands of regions to significantly reduce computation time.
- **Data Quality**: BPRMeth handles missing values well, but regions with very few data points (e.g., < 3 CpGs) may result in unstable fits. Filter these out during preprocessing.

## Reference documentation
None