---
name: r-plsgenomics
description: The r-plsgenomics package provides partial least squares methods for classification and integration of high-dimensional genomic data. Use when user asks to perform PLS-based classification, predict transcription factor activities, or conduct variable selection on gene expression datasets.
homepage: https://cran.r-project.org/web/packages/plsgenomics/index.html
---

# r-plsgenomics

## Overview
The `plsgenomics` package provides a comprehensive suite of PLS-based methods tailored for genomic data, where the number of variables (genes) typically far exceeds the number of samples. It is particularly useful for classification tasks and integrating gene expression with transcription factor binding data.

## Installation
To install the package from CRAN:
```R
install.packages("plsgenomics")
library(plsgenomics)
```

## Main Functions and Workflows

### 1. Classification with Microarray Data
The package implements several PLS variants for categorical outcome prediction:
- `pls.regression`: Standard PLS regression.
- `pls.lda`: PLS followed by Linear Discriminant Analysis.
- `rpls`: Ridge PLS for classification.
- `gsim`: Generalized SIR (Sliced Inverse Regression) for classification.
- `logit.spls`: Sparse PLS in a logistic regression context (combines variable selection and compression).

**Example Workflow:**
```R
# Load example data (e.g., Colon data)
data(Colon)
X <- Colon$X
Y <- Colon$Y

# Fit a logit-SPLS model
fit <- logit.spls(Xtrain=X, Ytrain=Y, lambda.l1=0.1, ncomp=2, adapt=TRUE)
```

### 2. Transcription Factor Activity Prediction
Use `TFA.estimate` to predict transcription factor activities by combining ChIP-chip data (connectivity matrix) and gene expression data.

### 3. Variable Selection
The `variable.selection` function helps identify the most relevant genes/features for the classification task using PLS weights or coefficients.

### 4. Cross-Validation
Most methods have associated cross-validation functions (e.g., `cv.logit.spls`, `cv.rpls`) to determine optimal hyperparameters like the number of components (`ncomp`) or regularization parameters (`lambda`).

## Tips and Best Practices
- **Data Scaling**: Genomic data should generally be centered and scaled before applying PLS. Most functions in `plsgenomics` have a `scale.X` argument.
- **Parallel Computing**: For computationally intensive tasks like cross-validation, the package utilizes the `parallel` package. 
- **Windows Parallelization**: On Windows, `mclapply` defaults to serial execution. If you require parallel performance on Windows, you must manually set up a cluster using `makeCluster` and `parLapply` or use a wrapper script to simulate forking.
- **Sparse PLS**: Use `adapt=TRUE` in sparse PLS functions to invoke the adaptive version, which often provides better variable selection properties.

## Reference documentation
- [README](./references/README.md)
- [Home Page](./references/home_page.md)