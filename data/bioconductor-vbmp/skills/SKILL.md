---
name: bioconductor-vbmp
description: This tool performs multi-class classification on high-dimensional biological data using Variational Bayesian Multinomial Probit Regression with Gaussian Process priors. Use when user asks to perform multi-class classification, use Automatic Relevance Determination for feature selection, or estimate class membership posterior probabilities using variational inference.
homepage: https://bioconductor.org/packages/release/bioc/html/vbmp.html
---


# bioconductor-vbmp

name: bioconductor-vbmp
description: Variational Bayesian Multinomial Probit Regression for Gaussian Process multi-class classification. Use this skill to perform multi-class classification on high-dimensional biological data (like gene expression) using Gaussian Process priors, Automatic Relevance Determination (ARD) for feature selection, and variational approximation for posterior estimation.

## Overview

The `vbmp` package provides a robust framework for multi-class classification using Multinomial Probit Regression with Gaussian Process (GP) priors. It is particularly effective for datasets where the number of features (e.g., genes) greatly exceeds the number of samples. Key features include:
- **Variational Inference**: Efficiently estimates class membership posterior probabilities.
- **Automatic Relevance Determination (ARD)**: Automatically weights or removes irrelevant features during the training process.
- **Covariance Functions**: Supports various kernels, including Radial Basis Function (RBF) and Linear Inner Product (`iprod`).

## Core Workflow

### 1. Data Preparation
The package expects training and testing matrices where rows are samples and columns are features. Target classes should be integers (1 to $n$) or factors.

```r
library(vbmp)

# X_train: matrix of predictors
# t_train: vector of class labels (1, 2, 3...)
# X_test: matrix of test predictors
# t_test: vector of test class labels
```

### 2. Model Training and Prediction
The primary function is `vbmp()`. It simultaneously trains the model and predicts on the test set.

```r
# Initialize scale parameters (theta) for each feature
theta <- rep(1.0, ncol(X_train))

# Run VBMP
res <- vbmp(
  X_train, t_train, 
  X_test, t_test, 
  theta, 
  control = list(
    bThetaEstimate = TRUE, # Enable ARD/Feature weighting
    maxIts = 50,           # Maximum iterations
    sKernelType = "rbf",   # "rbf" or "iprod"
    bMonitor = TRUE        # Track convergence
  )
)
```

### 3. Interpreting Results
Use helper functions to extract performance metrics and class assignments.

```r
# Get out-of-sample prediction error
error <- predError(res)

# Get predicted classes for the test set
predictions <- predClass(res)

# Get posterior probabilities for each class
probs <- predProb(res)
```

### 4. Convergence and Feature Importance
If `bMonitor = TRUE` or `bPlotFitting = TRUE` was set in the control list, you can visualize the training progress.

```r
# Plot convergence of marginal likelihood and ARD parameters
plotDiagnostics(res)

# Access the inferred feature weights (theta)
# High values indicate relevant features; low values indicate noise
final_theta <- res$theta
```

## Advanced Usage: Cross-Validation
For small datasets (e.g., clinical samples), Leave-One-Out Cross-Validation (LOO-CV) is often used.

```r
# Example LOO-CV loop logic
n <- nrow(X)
results <- rep(NA, n)
for (i in 1:n) {
  # Train on all but sample i, predict on sample i
  res_cv <- vbmp(X[-i,], t[-i], X[i,,drop=FALSE], t[i], ...)
  results[i] <- predClass(res_cv)
}
cv_error <- sum(results != t) / n
```

## Tips for Success
- **Feature Scaling**: While GP models are robust, centering and scaling gene expression data is generally recommended.
- **Kernel Selection**: Use `sKernelType="iprod"` (linear) for simpler, faster models, or `"rbf"` for capturing non-linear relationships.
- **ARD**: Setting `bThetaEstimate = TRUE` is powerful for high-dimensional data as it performs implicit feature selection, but it increases computational cost per iteration.
- **Iteration Limit**: Monitor the "Lower Bound" in diagnostics; if it hasn't flattened, increase `maxIts`.

## Reference documentation
- [vbmp](./references/vbmp.md)