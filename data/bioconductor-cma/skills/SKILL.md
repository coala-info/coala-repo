---
name: bioconductor-cma
description: The bioconductor-cma package provides a comprehensive framework for unbiased classification and variable selection in high-dimensional microarray data. Use when user asks to generate learning sets, perform gene selection, tune classifier hyperparameters, or evaluate class prediction performance using cross-validation.
homepage: https://bioconductor.org/packages/release/bioc/html/CMA.html
---


# bioconductor-cma

## Overview
The `CMA` (Classification Microarray Analysis) package provides a systematic framework for class prediction in high-dimensional settings (p >> n). It addresses the risks of overfitting and selection bias by ensuring that variable selection and hyperparameter tuning are performed strictly within resampling loops (nested cross-validation).

## Core Workflow

### 1. Generate Learning Sets
Resampling is the foundation of unbiased estimation in CMA. Use `GenerateLearningsets` to define how the data should be split.
```r
library(CMA)
# y is the class label vector
# method can be "LOOCV", "CV", "MCCV", or "bootstrap"
sets <- GenerateLearningsets(y = y_labels, method = "CV", fold = 5, strat = TRUE)
```

### 2. Variable Selection (Gene Selection)
To avoid selection bias, variables must be ranked for each learning set separately.
```r
# Common methods: "t.test", "wilcox.test", "limma", "rf", "lasso"
genesel <- GeneSelection(X = X_matrix, y = y_labels, learningsets = sets, method = "limma")

# View top genes for the first iteration
toplist(genesel, iter = 1)
```

### 3. Hyperparameter Tuning
For classifiers like SVM or Elastic Net, use `tune` to find optimal parameters via an inner cross-validation loop.
```r
# Example: Tuning 'cost' for SVM
tuned <- tune(X = X_matrix, y = y_labels, learningsets = sets, 
              genesel = genesel, nbgene = 100, classifier = svmCMA,
              grids = list(cost = c(0.1, 1, 10)))
best(tuned)
```

### 4. Classification
The `classification` function can perform the entire process or take the outputs of the previous steps.
```r
# Using pre-calculated selection and tuning
results <- classification(X = X_matrix, y = y_labels, learningsets = sets, 
                          genesel = genesel, nbgene = 100, classifier = svmCMA, 
                          tuningresult = tuned)

# Combine results for evaluation
joined_results <- join(results)
```

## Available Classifiers
CMA supports a wide range of algorithms via a uniform interface:
- **Discriminant Analysis**: `dldaCMA` (Diagonal), `ldaCMA` (Linear), `qdaCMA` (Quadratic), `scdaCMA` (Shrunken Centroids/PAM).
- **Modern Learners**: `svmCMA` (SVM), `rfCMA` (Random Forest), `knnCMA` (k-Nearest Neighbors).
- **Regularized/Boosting**: `LassoCMA`, `ElasticNetCMA`, `compBoostCMA`.
- **Dimension Reduction**: `pls_ldaCMA`, `pls_lrCMA`, `pls_rfCMA`.

## Evaluation and Visualization
Assess performance using multiple metrics and built-in plotting methods.

```r
# Performance measures: "misclassification", "sensitivity", "specificity", "auc", "brier score"
eval_metrics <- evaluation(results, measure = "misclassification")
summary(eval_metrics)

# Visualization
plot(joined_results)       # Probability/Voting plot
roc(joined_results)        # ROC curve
plot(genesel, iter = 1)    # Variable importance plot
```

## Tips for Success
- **Data Format**: Ensure `X` is a matrix (features in columns, observations in rows) and `y` is a factor or numeric vector of class labels.
- **Stratification**: Always set `strat = TRUE` in `GenerateLearningsets` if class sizes are imbalanced to ensure every class is represented in every fold.
- **Nested Loops**: If a classifier has hyperparameters, you **must** tune them inside the cross-validation loop to avoid over-optimistic performance estimates.
- **One-vs-All**: For multi-class problems where a classifier only supports binary tasks, CMA automatically handles the scheme if specified in `GeneSelection`.

## Reference documentation
- [CMA package vignette](./references/CMA_vignette.md)