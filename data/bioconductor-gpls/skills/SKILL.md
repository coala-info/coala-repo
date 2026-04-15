---
name: bioconductor-gpls
description: The gpls package performs classification using Generalized Partial Least Squares with support for Firth’s bias reduction to handle high-dimensional data and nonconvergence. Use when user asks to perform binary or multi-group classification, fit multinomial models using MIRWPLS, or estimate classification error using cross-validation.
homepage: https://bioconductor.org/packages/release/bioc/html/gpls.html
---

# bioconductor-gpls

## Overview

The `gpls` package provides tools for classification using Generalized Partial Least Squares. It is particularly useful for datasets where the number of predictors is large relative to the number of observations. It extends Iteratively ReWeighted Least Squares (IRWPLS) and incorporates Firth’s bias reduction to handle separation or nonconvergence issues common in standard logistic regression.

## Core Workflows

### Two-Group Classification

For binary classification (0/1), use the `glpls1a` function.

```r
library(gpls)

# X: matrix of predictors (do not include intercept)
# y: vector of binary responses (0, 1)
fit <- glpls1a(x, y, br = TRUE) # br=TRUE enables Firth's bias reduction

# Specify number of PLS components
fit_k1 <- glpls1a(x, y, K.prov = 1, br = TRUE)
```

### Multi-Group Classification

For more than two classes, `gpls` offers two primary approaches:

1.  **MIRWPLS (Baseline Logit):** Fits a multinomial model.
    *   *Note:* The X matrix **must** include an intercept column (column of ones).
    ```r
    # x_with_intercept <- cbind(1, x)
    fit_multi <- glpls1a.mlogit(x_with_intercept, y, br = TRUE)
    ```
2.  **Separate Logit Fitting:** Fits $C$ two-group classifications against a baseline.
    ```r
    fit_sep <- glpls1a.logit.all(x, y, br = TRUE)
    ```

### Error Estimation and Prediction

The package includes built-in functions for Leave-One-Out Cross-Validation (LOOCV) and training/test set evaluation.

*   **Cross-Validation (Two-group):** `glpls1a.cv.error(x, y, br = TRUE)`
*   **Train/Test (Two-group):** `glpls1a.train.test.error(x_train, y_train, x_test, y_test, br = TRUE)`
*   **Cross-Validation (Multi-group):** `glpls1a.mlogit.cv.error(x, y, mlogit = TRUE, br = TRUE)`
    *   Set `mlogit = TRUE` to use `glpls1a.mlogit` or `FALSE` to use `glpls1a.logit.all`.

### High-Level Interface

The package also provides a formula-based interface compatible with standard R modeling patterns.

```r
# Fitting using formula
model <- gpls(type ~ ., data = training_data)

# Prediction
predictions <- predict(model, newdata = test_data)
```

## Usage Tips

*   **Bias Reduction:** Always consider setting `br = TRUE` if your model fails to converge or if you are working with small sample sizes where separation is likely.
*   **Component Selection:** If `K.prov` is not specified, the number of PLS components defaults to the smaller of the row or column rank of the design matrix.
*   **Data Preparation:** Ensure your response variables are correctly coded (0/1 for binary, or 1..N for multi-group) depending on the specific function used.

## Reference documentation

- [gpls](./references/gpls.md)