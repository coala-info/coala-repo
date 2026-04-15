---
name: r-prroc
description: The r-prroc tool computes and visualizes Precision-Recall and ROC curves for evaluating binary classification models in R. Use when user asks to calculate area under the curve, generate PR or ROC plots, handle weighted data or soft labels, and perform non-linear interpolation for precision-recall analysis.
homepage: https://cran.r-project.org/web/packages/prroc/index.html
---

# r-prroc

name: r-prroc
description: Use this skill when working with the R package 'PRROC' to compute and visualize Precision-Recall (PR) and Receiver Operating Characteristic (ROC) curves. This skill is essential for evaluating binary classification models, especially when dealing with weighted data, soft labels, or when accurate non-linear interpolation for PR curves is required.

## Overview
The `PRROC` package computes the area under the curve (AUC) for both Precision-Recall and ROC curves. Unlike many other packages, it uses a non-linear piecewise function for PR curve interpolation, which is more theoretically sound. It natively supports weighted data and soft labels (where observations belong to a class with a certain probability).

## Installation
To install the package from CRAN:
```R
install.packages("PRROC")
```

## Main Functions

### 1. ROC Curve
Computes the ROC curve and AUC.
```R
# Using separate score vectors for positive and negative classes
roc <- roc.curve(scores.class0 = fg_scores, scores.class1 = bg_scores, curve = TRUE)

# Using a single score vector and labels (0/1)
roc <- roc.curve(scores.class0 = scores, weights.class0 = labels, curve = TRUE)

print(roc) # Shows AUC
```

### 2. Precision-Recall Curve
Computes the PR curve and AUC using non-linear interpolation.
```R
# Using separate score vectors
pr <- pr.curve(scores.class0 = fg_scores, scores.class1 = bg_scores, curve = TRUE)

# Using a single score vector and labels
pr <- pr.curve(scores.class0 = scores, weights.class0 = labels, curve = TRUE)

print(pr) # Shows AUC
```

### 3. Plotting
The package provides an S3 method for plotting the generated curve objects.
```R
# Basic plot
plot(roc)

# Enhanced plot with AUC in title and color-coded thresholds
plot(pr, color = TRUE, auc.main = TRUE, main = "PR Curve")
```

## Workflows

### Handling Weighted Data
If your data has weights (e.g., for soft labels or cost-sensitive learning), pass them to the `weights` arguments:
```R
# weights.class0 represents the degree of belonging to the positive class
pr_weighted <- pr.curve(scores.class0 = my_scores, weights.class0 = my_weights, curve = TRUE)
```

### Comparing Models
To compare multiple models, compute the curves separately and plot them or compare their AUC values:
```R
pr_model1 <- pr.curve(scores_m1, labels, curve = TRUE)
pr_model2 <- pr.curve(scores_m2, labels, curve = TRUE)

# Access AUC value directly
auc1 <- pr_model1$auc.integral
auc2 <- pr_model2$auc.integral
```

## Tips
- **Curve Argument**: Always set `curve = TRUE` if you intend to plot the results; otherwise, only the AUC is calculated.
- **Class Definition**: `scores.class0` refers to the scores of the positive class (foreground), and `scores.class1` refers to the scores of the negative class (background).
- **Interpolation**: `PRROC` is preferred over `ROCR` or `pROC` when PR curve precision is critical, as linear interpolation between points in PR space can be misleading.

## Reference documentation
- [PRROC: Precision-Recall and ROC Curves](./references/home_page.md)