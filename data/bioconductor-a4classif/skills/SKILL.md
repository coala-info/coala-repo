---
name: bioconductor-a4classif
description: The a4Classif package provides a streamlined interface for classifying microarray data using Lasso, PAM, and Random Forest methods. Use when user asks to classify ExpressionSet data, perform feature selection on microarray datasets, or evaluate gene diagnostic power using ROC curves.
homepage: https://bioconductor.org/packages/release/bioc/html/a4Classif.html
---


# bioconductor-a4classif

## Overview

The `a4Classif` package is part of the Automated Affymetrix Array Analysis (a4) suite. It provides a streamlined interface for classifying microarray data (ExpressionSet objects) using three primary methods: Lasso (penalized regression), PAM (Prediction Analysis of Microarrays), and Random Forest. It simplifies the workflow from model fitting to gene selection and visualization.

## Core Workflow

### 1. Data Preparation
Ensure your data is an `ExpressionSet` and that the grouping variable is a factor.

```r
library(a4Classif)
library(a4Preproc) # Often used for addGeneInfo

# Example using the ALL dataset
data(ALL, package = "ALL")
ALL <- addGeneInfo(ALL)
ALL$group <- as.factor(ALL$type) # Ensure factor for classification
```

### 2. Lasso Classification
Lasso performs simultaneous classification and feature selection by penalizing coefficients.

```r
# Fit Lasso model
resultLasso <- lassoClass(object = ALL, groups = "group")

# Visualize penalization paths
plot(resultLasso, label = TRUE)

# Extract top predictive genes
topTable(resultLasso, n = 15)
```

### 3. PAM (Nearest Shrunken Centroids)
PAM is effective for high-dimensional data where many features may be noise.

```r
# Fit PAM model
resultPam <- pamClass(object = ALL, groups = "group")

# Plot misclassification error to find optimal threshold
plot(resultPam)

# View confusion matrix for cross-validated performance
confusionMatrix(resultPam)

# List selected genes
topTable(resultPam)
```

### 4. Random Forest
Random Forest provides a non-linear approach to classification and feature importance.

```r
# Fit Random Forest
resultRf <- rfClass(object = ALL, groups = "group")

# Plot variable importance or error rates
plot(resultRf)

# List most important genes
topTable(resultRf)
```

### 5. Individual Gene Analysis (ROC)
To evaluate the diagnostic power of a single gene/probeset:

```r
ROCcurve(gene = "SYMBOL_NAME", object = ALL, groups = "group")
```

## Tips and Interpretation

- **Feature Selection**: All three `*Class` functions automatically handle feature selection. Use `topTable()` to retrieve the specific probesets/genes that the models identified as most discriminative.
- **Visualization**: The `plot()` method is overloaded for each result type:
  - Lasso: Shows coefficient paths.
  - PAM: Shows error rates across different numbers of genes.
  - Random Forest: Shows the importance of variables.
- **Gene Annotation**: The package works best when the `ExpressionSet` has been processed with `a4Preproc::addGeneInfo`, allowing `topTable` to display readable Gene Symbols instead of just Probeset IDs.

## Reference documentation

- [Vignette of the a4Classif package](./references/a4Classif-vignette.md)