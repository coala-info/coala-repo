---
name: r-metap
description: This tool performs meta-analysis by combining independent p-values using various statistical methods from the R package 'metap'. Use when user asks to combine p-values from multiple studies, perform meta-analysis without effect sizes, or visualize p-value distributions using Q-Q and Albatros plots.
homepage: https://cran.r-project.org/web/packages/metap/index.html
---


# r-metap

name: r-metap
description: Meta-analysis of significance values (p-values) using the R package 'metap'. Use this skill when effect sizes are unavailable and you need to combine independent p-values using methods like Fisher's, Stouffer's, Edgington's, or Tippett's. It includes tools for p-value transformation, directionality adjustment, and graphical displays (Q-Q plots, Albatros plots).

## Overview

The `metap` package provides a comprehensive suite of methods for combining independent p-values. This is particularly useful in meta-analysis when primary studies do not report effect sizes or standard errors, but do provide significance levels.

## Installation

```R
install.packages("metap")
library(metap)
```

## Core Workflow

### 1. Prepare p-values (Directionality)
All p-values must refer to the same directional hypothesis. Use `two2one` to convert two-sided p-values to one-sided, or to invert directions.

```R
# pvals: vector of p-values
# two: logical vector indicating if study was two-sided
# invert: logical vector indicating if direction needs reversing
p_one_sided <- two2one(pvals, two = TRUE, invert = FALSE)
```

### 2. Visualize Data
Before combining, check the distribution of p-values.
- `plotp(pvals)`: Q-Q plot against a uniform distribution.
- `schweder(pvals)`: Produces a Schweder-Spjøtvoll plot to evaluate many tests simultaneously.
- `albatros(p, n)`: Albatros plot showing p-values against sample size with effect size contours.

### 3. Select and Apply a Method
Choose a method based on how you want to weight evidence or handle "cancellation" (where large p-values offset small ones).

| Function | Method Name | Best Use Case |
| :--- | :--- | :--- |
| `sumlog()` | Fisher's | Sensitive to small p-values; does NOT cancel. |
| `sumz()` | Stouffer's | Allows weighting (e.g., by sqrt of sample size); cancels. |
| `logitp()` | Logistic | A compromise between Fisher and Stouffer. |
| `sump()` | Edgington's | Sum of uniform p-values; sensitive to larger p-values. |
| `minimump()` | Tippett's | Based on the smallest p-value. |
| `invchisq()` | Lancaster's | Generalization of Fisher using varying degrees of freedom. |
| `truncated()` | Truncated Fisher | Use when signal is expected in only a few studies. |

**Example: Fisher's Method**
```R
results <- sumlog(p_vector)
print(results)
# Access p-value: results$p
```

**Example: Weighted Stouffer's Method**
```R
# weights often proportional to sqrt(n)
results <- sumz(p_vector, weights = sqrt(sample_sizes))
```

### 4. Compare Methods
Use `allmetap` to run multiple methods simultaneously and compare results.

```R
comparison <- allmetap(p_vector, method = "all")
```

## Guidelines for Method Selection

- **Cancellation**: If you want large p-values (evidence for H0) to offset small p-values (evidence for HA), use `sumz` or `logitp`. If you want to emphasize any evidence against H0 regardless of other studies, use `sumlog` or `minimump`.
- **Weights**: If you have sample sizes, `sumz` with weights is generally preferred.
- **Location of Evidence**: 
  - Evidence in a minority of studies: `sumlog` or `minimump`.
  - Evidence spread across most studies: `sumz`, `logitp`, or `sump`.

## Reference documentation

- [Comparison of methods in the metap package](./references/compare.md)
- [Introduction to the metap package](./references/metap.md)
- [Plotting in the metap package](./references/plotmetap.md)