---
name: r-gbm
description: This tool provides expert guidance for implementing Generalized Boosted Regression Models using the gbm package in R. Use when user asks to fit gradient boosting models for regression, classification, ranking, or survival analysis, tune hyperparameters like shrinkage and tree depth, or evaluate model performance using cross-validation and variable importance.
homepage: https://cloud.r-project.org/web/packages/gbm/index.html
---

# r-gbm

name: r-gbm
description: Expert guidance for using the 'gbm' R package to fit Generalized Boosted Regression Models. Use this skill when you need to implement gradient boosting for regression, classification (Bernoulli, AdaBoost), ranking (LambdaMart), or survival analysis (Cox PH) in R. It covers model fitting, hyperparameter tuning (shrinkage, tree depth), and performance evaluation using cross-validation or OOB estimates.

## Overview
The `gbm` package implements Friedman's Gradient Boosting Machine. It builds an ensemble of shallow decision trees in a forward-greedy fashion to minimize a loss function. Key features include support for various distributions (Gaussian, Bernoulli, Poisson, Cox PH, etc.), stochastic gradient boosting via subsampling, and tools for model interpretation like variable importance and partial dependence plots.

## Installation
```R
install.packages("gbm")
library(gbm)
```

## Core Workflow

### 1. Fitting a Model
The primary function is `gbm()`.
```R
model <- gbm(
  formula = y ~ .,
  data = train_data,
  distribution = "bernoulli", # "gaussian", "laplace", "poisson", "coxph", "adaboost"
  n.trees = 5000,             # Total number of trees
  interaction.depth = 3,      # Maximum nodes per tree (1 = additive model)
  shrinkage = 0.01,           # Learning rate
  bag.fraction = 0.5,         # Subsampling fraction for stochastic boosting
  train.fraction = 0.8,       # Fraction used for training (rest for "test" error)
  cv.folds = 5,               # Number of cross-validation folds
  keep.data = TRUE,
  verbose = FALSE
)
```

### 2. Determining Optimal Iterations
Boosting can overfit if `n.trees` is too high. Use `gbm.perf()` to find the best iteration.
```R
# Returns the best iteration based on the method
best_iter <- gbm.perf(model, method = "cv")   # Options: "cv", "OOB", "test"
```

### 3. Prediction
Always specify the number of trees to use for prediction.
```R
preds <- predict(model, newdata = test_data, n.trees = best_iter, type = "response")
```

### 4. Interpretation
*   **Relative Influence:** View variable importance.
    ```R
    summary(model, n.trees = best_iter)
    ```
*   **Partial Dependence Plots:** Visualize the effect of a variable on the response.
    ```R
    plot(model, i.var = 1, n.trees = best_iter)
    ```

## Key Parameters & Tuning
*   **shrinkage (λ):** Smaller values (0.01 to 0.001) generally improve performance but require more `n.trees`.
*   **interaction.depth:** Controls the complexity of interactions. `depth=1` creates an additive model (stumps). Usually 2–8 is sufficient.
*   **n.trees:** Set this high enough so that the error curve reaches a minimum. If `best_iter` is equal to `n.trees`, increase `n.trees` and re-run.
*   **bag.fraction:** Values around 0.5 introduce randomness that often improves generalization and allows for OOB error estimation.

## Common Distributions
*   `"gaussian"`: Squared error (Regression).
*   `"laplace"`: Absolute loss (Robust regression).
*   `"bernoulli"`: Logistic regression (Binary classification).
*   `"adaboost"`: Exponential loss (Binary classification).
*   `"poisson"`: Count data.
*   `"coxph"`: Right-censored survival data.
*   `"quantile"`: Quantile regression (requires `distribution = list(name="quantile", alpha=0.5)`).
*   `"pairwise"`: Ranking (LambdaMart).

## Reference documentation
- [Generalized Boosted Models: A guide to the gbm package](./references/gbm.md)