---
name: bioconductor-cancerclass
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cancerclass.html
---

# bioconductor-cancerclass

## Overview

The `cancerclass` package provides a specialized framework for building and validating molecular classifiers. It is designed to address the "high-dimensional data" problem (many features, few samples) by using robust, simple classification methods like the nearest-centroid approach. The package emphasizes rigorous validation through a multiple random validation protocol and provides tools for visualizing prediction scores, ROC curves, and logistic regression models to determine clinical cutoffs.

## Core Workflow

### 1. Data Preparation
The package works with `ExpressionSet` objects. Ensure your data has a binary classification column in the `phenoData`.

```r
library(cancerclass)
data(GOLUB1) # Example leukemia dataset
# GOLUB1 contains a 'class' variable with levels 'ALL' and 'AML'
```

### 2. Multiple Random Validation
Use `nvalidate` to explore how the number of genes (features) affects the misclassification rate. This helps identify the optimal feature set size.

```r
# Test accuracy for different gene counts (e.g., 5, 10, 20, 50)
nval <- nvalidate(GOLUB1, ngenes=c(5, 10, 20, 50), nrepl=200)
plot(nval) # Visualizes error rates with 95% CI
```

To evaluate the impact of training set size:
```r
val <- validate(GOLUB1, ngenes=10, ntrain="balanced")
plot(val)
```

### 3. Predictor Construction (Fitting)
Use the `fit` function to select features and calculate centroids. The default method is `welch.test` for feature filtering.

```r
# Fit a predictor using a training set
predictor <- fit(VEER, method="welch.test")
```

### 4. Prediction and Scoring
Apply the fitted predictor to a new dataset. You can specify the distance metric (`euclidean`, `center`, `angle`, or `cor`).

```r
# Predict on an independent validation set
# 'positive' defines the class of interest (e.g., "DM" for distant metastasis)
prediction <- predict(predictor, VIJVER2, positive="DM", dist="cor")
```

### 5. Visualization and Interpretation
The `predict` method returns a `prediction` object that can be visualized in three ways using the `type` argument:

*   **Histogram**: Shows the distribution of prediction scores (`zeta`, `z`, or `ratio`) between classes.
    ```r
    plot(prediction, type="histogram", score="zeta")
    ```
*   **ROC Curve**: Evaluates sensitivity and specificity across cutoffs.
    ```r
    plot(prediction, type="roc", score="zeta")
    ```
*   **Logistic Regression**: Estimates the probability of the positive class based on the score.
    ```r
    plot(prediction, type="logistic", score="zeta")
    ```

## Key Functions and Parameters

| Function | Purpose | Key Parameters |
| :--- | :--- | :--- |
| `nvalidate` | Cross-validation across feature counts | `ngenes` (vector), `nrepl` (reiterations) |
| `validate` | Cross-validation for specific gene count | `ntrain` (size of training set) |
| `fit` | Build the predictor | `method` ("welch.test") |
| `predict` | Apply predictor to data | `dist` ("cor", "euclidean"), `positive` (target class) |
| `plot` | Visualize results | `type` ("histogram", "roc", "logistic"), `score` ("zeta", "z", "ratio") |

## Tips for Success
*   **Score Selection**: The `zeta` score is a normalized continuous prediction score often used for clinical cutoff definitions.
*   **Computational Time**: Validation protocols (`nvalidate`) can be computationally intensive. For large datasets, start with a smaller number of replications (`nrepl`) or a subset of genes to test your code.
*   **Balanced Training**: When using `validate`, setting `ntrain="balanced"` ensures the training set has an equal number of samples from both classes, which is critical for avoiding bias in skewed datasets.

## Reference documentation
- [Cancerclass: Development and validation of diagnostic tests](./references/vignette_cancerclass.md)