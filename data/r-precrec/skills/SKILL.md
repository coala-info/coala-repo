---
name: r-precrec
description: The r-precrec package calculates and visualizes Receiver Operator Characteristics and Precision-Recall curves for evaluating machine learning models. Use when user asks to calculate ROC and PRC curves, compute AUC values with confidence intervals, or visualize model performance across multiple cross-validation folds.
homepage: https://cloud.r-project.org/web/packages/precrec/index.html
---

# r-precrec

## Overview
The `precrec` package provides accurate and efficient computations for Receiver Operator Characteristics (ROC) and Precision-Recall (PRC) curves. It is specifically designed to handle large datasets and provides robust support for multiple models and cross-validation folds, including confidence interval calculations.

## Installation
To install the package from CRAN:
```R
install.packages("precrec")
```

## Core Workflow

### 1. Data Preparation
Use `mmdata` to format scores and labels. It supports multiple models and multiple datasets (e.g., test sets or folds).

```R
library(precrec)

# Basic: Single model, single dataset
dat <- mmdata(scores = c(0.1, 0.4, 0.7, 0.8), labels = c(0, 0, 1, 1))

# Advanced: Multiple models and datasets
# join_scores and join_labels help combine vectors/matrices
s1 <- c(0.1, 0.2, 0.3); s2 <- c(0.4, 0.5, 0.6)
l1 <- c(0, 0, 1); l2 <- c(0, 1, 1)

dat_multi <- mmdata(join_scores(s1, s2), join_labels(l1, l2), 
                    modnames = c("m1", "m2"), dsids = c(1, 2))
```

### 2. Curve Calculation
The `evalmod` function is the primary engine for calculations.

```R
# Calculate ROC and PRC
sscurves <- evalmod(dat)

# Calculate only ROC AUC (fast mode using U-statistic)
aucroc_only <- evalmod(dat, mode = "aucroc")

# Calculate basic measures (accuracy, error, mcc, fscore, etc.)
basic_measures <- evalmod(dat, mode = "basic")
```

### 3. Visualization
Use `autoplot` (requires `ggplot2`) or the standard `plot` function.

```R
library(ggplot2)
# Plot both ROC and PRC
autoplot(sscurves)

# Plot specific curve type
autoplot(sscurves, curvetype = "PRC")

# Show confidence intervals (requires multiple datasets/folds)
autoplot(smcurves, show_cb = TRUE)
```

### 4. Extracting Results
Convert results to data frames or extract AUC values.

```R
# Get AUC values
aucs <- auc(sscurves)

# Get partial AUC (e.g., for FPR range 0.0 to 0.25)
p_curves <- part(sscurves, xlim = c(0.0, 0.25))
paucs <- pauc(p_curves)

# Convert full curve coordinates to data frame
df_curves <- as.data.frame(sscurves)
```

## Advanced Features

### Cross-Validation
Use `format_nfold` to prepare data from a data frame containing a fold column.

```R
# Assuming df has columns: score1, score2, label, fold
nfold_list <- format_nfold(df, score_cols = c("score1", "score2"), 
                           lab_col = "label", fold_col = "fold")
cv_curves <- evalmod(scores = nfold_list$scores, labels = nfold_list$labels)
```

### Confidence Intervals
Calculate CIs for AUC scores using `auc_ci`.

```R
# Calculate 95% CI (default)
ci_res <- auc_ci(cv_curves)

# Calculate 99% CI using t-distribution
ci_res_t <- auc_ci(cv_curves, alpha = 0.01, dtype = "t")
```

## Tips for Large Datasets
- **Point Reduction**: `autoplot` uses `reduce_points = TRUE` by default to speed up rendering of large datasets without losing curve shape.
- **Fast AUC**: Use `mode = "aucroc"` if you only need the AUC score and not the full curve coordinates.

## Reference documentation
- [Introduction to precrec](./references/introduction.Rmd)