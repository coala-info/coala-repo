---
name: r-ada
description: This tool performs discrete, real, and gentle stochastic boosting for binary classification tasks using exponential or logistic loss. Use when user asks to fit boosting models, predict classes or probabilities, perform stochastic boosting, or visualize variable importance and model performance in R.
homepage: https://cloud.r-project.org/web/packages/ada/index.html
---


# r-ada

name: r-ada
description: Performs discrete, real, and gentle boosting under both exponential and logistic loss for classification tasks. Use this skill when you need to implement stochastic boosting algorithms in R, particularly for small to moderate-sized datasets where high-performance classification is required.

## Overview

The `ada` package provides a robust implementation of boosting routines for binary classification. It supports three main types of boosting: Discrete AdaBoost, Real AdaBoost, and Gentle AdaBoost. It allows for both exponential loss (traditional AdaBoost) and logistic loss (LogitBoost), and incorporates stochastic boosting by allowing sub-sampling of the training data.

## Installation

```R
install.packages("ada")
```

## Main Functions

- `ada()`: The primary function to fit a boosting model. It uses `rpart` as the default base learner.
- `predict.ada()`: Predicts classes or probabilities for new data using a fitted `ada` object.
- `plot.ada()`: Generates diagnostic plots including error rates, kappa statistics, and variable importance.
- `update.ada()`: Allows for adding more iterations to an existing boosting model without retraining from scratch.
- `addtest()`: Adds a test set to an `ada` object to monitor test error during the boosting process.
- `varplot()`: Specifically plots the variable importance for the boosted model.

## Workflows

### Basic Classification
```R
library(ada)
data(iris)
# Prepare binary classification (e.g., setosa vs others)
iris$Species <- as.factor(ifelse(iris$Species == "setosa", "setosa", "other"))

# Fit model (Discrete AdaBoost by default)
model <- ada(Species ~ ., data = iris, iter = 50, type = "discrete")

# Predict
preds <- predict(model, newdata = iris)
```

### Stochastic Boosting and Loss Functions
To use stochastic boosting (sub-sampling) and different boosting variations:
```R
# Real AdaBoost with logistic loss and 50% sub-sampling
model_logit <- ada(Species ~ ., data = iris, 
                   iter = 100, 
                   type = "real", 
                   loss = "logistic", 
                   bag.frac = 0.5)

# Summary and Plots
summary(model_logit)
plot(model_logit)
```

### Model Refinement
If the model has not converged, you can add iterations:
```R
# Add 50 more iterations to the existing model
model_extended <- update(model, x = iris[,-5], y = iris[,5], n.iter = 50)
```

## Tips

- **Base Learner**: `ada` uses `rpart` trees. You can control the complexity of these trees using the `control` argument (passing `rpart.control` objects).
- **Type Selection**: 
  - `type = "discrete"`: Standard AdaBoost.
  - `type = "real"`: Uses class probability estimates.
  - `type = "gentle"`: Often more robust to outliers and stable.
- **Variable Importance**: Use `varplot(model)` to identify which features are contributing most to the classification.
- **Overfitting**: Monitor the training vs. test error using `addtest` to determine the optimal number of iterations (`iter`).

## Reference documentation

- [ada: The R Package Ada for Stochastic Boosting](./references/home_page.md)