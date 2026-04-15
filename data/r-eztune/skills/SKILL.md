---
name: r-eztune
description: The eztune package automates the tuning of hyperparameters for supervised learning models using optimization algorithms to maximize accuracy or minimize error. Use when user asks to tune models for gbm, svm, ada, or glmnet, optimize hyperparameters using genetic algorithms or Hooke-Jeeves, or compute cross-validated performance metrics for tuned models.
homepage: https://cran.r-project.org/web/packages/eztune/index.html
---

# r-eztune

## Overview
The `eztune` package is designed to simplify the tuning process for popular supervised learning algorithms. It automates the selection of tuning parameters using optimization algorithms (Genetic Algorithm or Hooke-Jeeves) to maximize accuracy (classification) or minimize error (regression). It supports optimization based on resubstitution, validation sets, or cross-validation.

## Installation
```R
install.packages("eztune")
```

## Main Functions

### eztune()
The primary function for tuning a model.
- **Arguments**:
  - `x`: Matrix or data frame of predictors.
  - `y`: Response vector.
  - `method`: Model type (`"gbm"`, `"svm"`, `"ada"`, or `"glmnet"`).
  - `optimizer`: Optimization method (`"ga"` for Genetic Algorithm or `"hj"` for Hooke-Jeeves).
  - `fast`: Logical. If `TRUE`, uses a small subset of data for faster tuning.
  - `cross`: Number of folds for cross-validation (if using CV for optimization).

### eztune_cv()
Computes cross-validated error metrics for a model tuned with `eztune`. This is essential when `eztune` was run using resubstitution or a validation set to get an unbiased estimate of performance.
- Returns: Accuracy and AUC for classification; MSE and MAE for regression.

## Workflows

### Basic Tuning (SVM Example)
```R
library(eztune)
data(iris)

# Tune an SVM model using Genetic Algorithm
model_fit <- eztune(x = iris[, 1:4], y = iris[, 5], method = "svm", optimizer = "ga")

# View best parameters and performance
model_fit
```

### Fast Tuning for Large Datasets
```R
# Use fast = TRUE to speed up the optimization process
fast_model <- eztune(x = my_x, y = my_y, method = "gbm", fast = TRUE)
```

### Regression with MAE
```R
# Tune a GBM model to minimize Mean Absolute Error
reg_model <- eztune(x = train_x, y = train_y, method = "gbm")
# Verify performance with cross-validation
results <- eztune_cv(x = train_x, y = train_y, model = reg_model)
```

## Tips
- **Optimizer Selection**: Use `"ga"` (Genetic Algorithm) for a more robust search of the parameter space, though it may be slower. Use `"hj"` (Hooke-Jeeves) for faster convergence if the starting point is reasonable.
- **Performance Metrics**: Version 3.0.0+ supports AUC for classification and MAE for regression.
- **Data Types**: Ensure `y` is a factor for classification and numeric for regression to help the package automatically detect the task type.

## Reference documentation
- [EZtune README](./references/README.html.md)
- [EZtune Home Page](./references/home_page.md)