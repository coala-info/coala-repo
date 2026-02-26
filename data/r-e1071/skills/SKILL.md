---
name: r-e1071
description: The e1071 package provides a suite of statistical and machine learning tools including Support Vector Machines, Naive Bayes classifiers, and fuzzy clustering. Use when user asks to train SVM models, perform Naive Bayes classification, execute fuzzy C-means clustering, or calculate statistical moments like skewness and kurtosis.
homepage: https://cloud.r-project.org/web/packages/e1071/index.html
---


# r-e1071

## Overview
The `e1071` package provides a wide range of statistical and machine learning tools. It is most notably the R interface to `libsvm`, providing powerful Support Vector Machine (SVM) capabilities. It also includes implementations for Naive Bayes classifiers, fuzzy C-means clustering, and various helper functions for statistical distributions (skewness, kurtosis).

## Installation
To install the package from CRAN:
```R
install.packages("e1071")
```

## Support Vector Machines (SVM)
The `svm()` function is the core of the package. It automatically detects whether to perform classification or regression based on the type of the response variable.

### Basic Workflow
1. **Classification**: Triggered when the dependent variable is a `factor`.
2. **Regression**: Triggered when the dependent variable is `numeric`.
3. **Novelty Detection**: Triggered when the dependent variable is omitted.

```R
library(e1071)

# Fit a model (Formula interface)
# Kernels: "linear", "polynomial", "radial" (default), "sigmoid"
model <- svm(Species ~ ., data = iris, kernel = "radial", cost = 10, gamma = 0.1)

# Predict
predictions <- predict(model, iris[, -5])

# Evaluation
table(predictions, iris$Species)
```

### Key Parameters
- `cost`: Constraints violation cost (default: 1). High cost penalizes misclassifications heavily.
- `gamma`: Parameter for all kernels except linear (default: 1/data dimension).
- `kernel`: The kernel function used in training and predicting.
- `cross`: Number of folds for k-fold cross-validation to assess accuracy/MSE.
- `class.weights`: Named vector to handle imbalanced classes (e.g., `c(A = 0.1, B = 0.9)`).

## Parameter Tuning
Use `tune.svm()` to perform a grid search over parameter ranges to find the optimal model configuration.

```R
# Grid search for best cost and gamma
tuned_model <- tune.svm(Species ~ ., data = iris, 
                        gamma = 10^(-3:-1), 
                        cost = 10^(0:2))

summary(tuned_model)
best_model <- tuned_model$best.model
```

## Other Key Functions
- `naiveBayes()`: Implementation of the Naive Bayes classifier.
- `cmeans()`: Fuzzy C-means clustering.
- `skewness()` / `kurtosis()`: Calculate higher-order moments of a distribution.
- `classAgreement()`: Calculate coefficients like Cohen's Kappa for classification performance.
- `shortestPaths()`: Compute all-pairs shortest paths in a graph.

## Tips for Practical Use
- **Scaling**: `svm()` scales data by default (subtracts mean, divides by SD). This is critical for SVM performance. If you disable it, ensure manual scaling.
- **Large Datasets**: SVM training time increases quadratically with the number of observations. For very large datasets, consider using a subset for parameter tuning.
- **Factor Levels**: Ensure that the test data has the same factor levels as the training data to avoid prediction errors.

## Reference documentation
- [Support Vector Machines - Interface to libsvm](./references/svmdoc.md)
- [SVM Internals and Prediction Formulas](./references/svminternals.md)