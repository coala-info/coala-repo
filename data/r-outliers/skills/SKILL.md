---
name: r-outliers
description: The r-outliers package provides a collection of statistical tests and functions for identifying, testing, and handling outliers in data. Use when user asks to find extreme values, perform Grubbs or Dixon tests, calculate outlier scores, or remove and replace outliers in a dataset.
homepage: https://cloud.r-project.org/web/packages/outliers/index.html
---

# r-outliers

## Overview

The `outliers` package provides a collection of statistical tests for identifying and handling outliers in data. It includes classic tests for single or multiple outliers (Grubbs, Dixon, Chi-squared) and tests for outlying variances (Cochran).

## Installation

```R
install.packages("outliers")
library(outliers)
```

## Core Functions

### 1. Identifying Outliers
*   `outlier(x, opposite = FALSE, logical = FALSE)`: Finds the value with the largest difference from the mean.
    *   `opposite = TRUE`: Finds the value at the other extreme.
    *   `logical = TRUE`: Returns a logical vector where `TRUE` marks the outlier position.

### 2. Statistical Tests
*   `grubbs.test(x, type = 10, opposite = FALSE, two.sided = FALSE)`:
    *   `type = 10`: Test for one outlier.
    *   `type = 11`: Test for two outliers on opposite tails.
    *   `type = 20`: Test for two outliers on the same tail.
*   `dixon.test(x, type = 0, opposite = FALSE, two.sided = TRUE)`: Best for small samples (n < 30).
*   `chisq.out.test(x, variance, opposite = FALSE)`: Chi-squared test for one outlier (requires known variance for best results).
*   `cochran.test(object, data, inlying = FALSE)`: Tests if the largest (or smallest) variance in a group is an outlier.

### 3. Scoring and Transformation
*   `scores(x, type = c("z", "t", "chisq", "iqr", "mad"), prob = NA)`: Calculates various outlier scores.
    *   If `prob` is set (e.g., 0.95), it returns a logical vector indicating which values exceed that probability threshold.
*   `rm.outlier(x, fill = FALSE, median = FALSE, opposite = FALSE)`: Removes the outlier or replaces it with the mean/median.

## Common Workflows

### Testing and Removing a Single Outlier
```R
# 1. Detect the most suspicious value
val <- outlier(my_data)

# 2. Perform Grubbs test
test_result <- grubbs.test(my_data)

# 3. If p-value < 0.05, remove or replace the outlier
if(test_result$p.value < 0.05) {
  clean_data <- rm.outlier(my_data, fill = TRUE) # Replaces with mean
}
```

### Checking for Outlying Variances in Groups
```R
# Using a formula for grouped data
cochran.test(yield ~ treatment, data = my_df)
```

### Calculating Z-Scores or MAD-Scores
```R
# Get Z-scores
z_scores <- scores(my_data, type = "z")

# Identify values exceeding 99% probability threshold
is_outlier <- scores(my_data, type = "mad", prob = 0.99)
```

## Tips
*   **Sample Size**: Use `dixon.test` for very small datasets and `grubbs.test` for larger ones.
*   **Opposite Tail**: If your data is skewed and you suspect the "lower" value is the outlier even if the "higher" value is further from the mean, use `opposite = TRUE`.
*   **Replacement**: `rm.outlier(fill = TRUE)` is useful for maintaining vector length in time-series or structured data by replacing the outlier with the sample mean.

## Reference documentation
- [Package Manual](./references/reference_manual.md)