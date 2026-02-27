---
name: bioconductor-messina
description: The messina package provides algorithms for generating optimal single-gene threshold classifiers that are robust to expression outliers and suitable for clinical translation. Use when user asks to find diagnostic markers with minimum sensitivity and specificity guarantees, perform single-feature survival analysis, or visualize classifier margins and performance limits.
homepage: https://bioconductor.org/packages/release/bioc/html/messina.html
---


# bioconductor-messina

## Overview

The `messina` package provides algorithms for generating optimal single-gene threshold classifiers. Unlike conventional classifiers (SVM, kNN) that often use many features, Messina focuses on identifying individual markers that are robust enough for clinical translation (e.g., immunohistochemistry assays). It is particularly powerful for handling "expression outliers"—samples that deviate significantly from their class mean due to experimental error or hidden biological subtypes—which often cause traditional t-tests to fail.

## Core Workflows

### 1. Diagnostic Classification
Use `messina()` to find genes that separate two classes (e.g., tumor vs. normal) while meeting minimum performance guarantees.

```r
library(messina)

# x: expression matrix (features x samples)
# y: logical vector (TRUE for the 'positive' class)
# min_sens: minimum required sensitivity
# min_spec: minimum required specificity
fit = messina(x, y == "tumor", min_sens = 0.95, min_spec = 0.85)

# View summary of features passing requirements
print(fit)

# Get top results by margin (robustness)
top_results = messinaTopResults(fit)
```

### 2. Survival Analysis (Prognosis)
Use `messinaSurv()` to identify single features that separate patients into short and long survivors based on a threshold.

```r
library(messina)
library(survival)

# y_surv: a survival::Surv object
# obj_func: "tau" (stable), "reltau", or "coxcoef" (slowest)
# obj_min: minimum value of the objective function
fit_surv = messinaSurv(x, y_surv, obj_func = "tau", obj_min = 0.6)
```

### 3. Visualizing Results
Messina provides overloaded plot functions to visualize the threshold, the "margin" (robustness), and the performance limits.

```r
# Plot the best feature (index 1)
# Use plot_type = "point" for log-transformed data
plot(fit, i = 1, plot_type = "point")

# For survival results, visualize Kaplan-Meier curves at the threshold
plot(fit_surv, bootstrap_type = "ci")
```

## Key Concepts

*   **The Margin**: The distance between the performance limits of the threshold. A larger margin indicates a more robust classifier that can tolerate more measurement noise before violating sensitivity/specificity requirements.
*   **Outlier Resilience**: Messina identifies genes where a subset of samples might look like the opposite class (outliers) but the overall threshold still meets the user's strict performance criteria.
*   **Parallelization**: `messinaSurv` is computationally intensive. It is highly recommended to use `doMC` and set `parallel = TRUE` if multiple cores are available.

## Tips for Success

*   **Data Scaling**: Messina is rank-based for some operations but the margin is calculated on the provided scale. Ensure data is appropriately normalized (e.g., log2 transformed) before analysis.
*   **Class Labels**: For `messina()`, the response `y` should be a logical vector where `TRUE` represents the condition you want to detect (the "positive" class).
*   **Feature Selection**: While Messina can handle whole-genome data, pre-filtering to remove low-variance genes can significantly speed up execution time, especially for survival analysis.

## Reference documentation

- [Using Messina](./references/messina.md)