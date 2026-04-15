---
name: bioconductor-rocpai
description: This package evaluates binary classifiers by calculating standardized partial Area Under the Curve (pAUC) indexes over specific False Positive Rate intervals. Use when user asks to calculate the McClish index, compute the Tighter Partial Area Index, generate ROC curve points, or perform bootstrap resampling for classifier confidence intervals.
homepage: https://bioconductor.org/packages/release/bioc/html/ROCpAI.html
---

# bioconductor-rocpai

## Overview
The `ROCpAI` package provides tools for evaluating binary classifiers using Receiver Operating Characteristic (ROC) analysis. Its primary strength lies in calculating the Partial Area Under the Curve (pAUC) over restricted False Positive Rate (FPR) intervals. It implements two key standardized indexes: the McClish index (`mcpAUC`) for proper ROC curves and the Tighter Partial Area Index (`tpAUC`) which is robust even for improper ROC curves. It also supports bootstrap resampling for estimating standard deviations and confidence intervals.

## Core Workflow

### 1. Data Preparation
The package accepts `data.frame` or `SummarizedExperiment` objects.
- **Data Frame**: The "Gold Standard" (labels/tags) must be in the first column.
- **Summarized Experiment**: Use the `selection` parameter in functions to specify variables.

```r
library(ROCpAI)
# Example structure: First column is condition (1/2 or 0/1), others are scores
# data(fission) # Common example dataset
```

### 2. Generating ROC Points
Use `pointsCurve` to get raw sensitivity and specificity values for all possible cut-off points.

```r
# x: vector of tags, y: vector of values
points <- pointsCurve(genes[,1], genes[,2])
```

### 3. Calculating Standardized pAUC
Choose the index based on the ROC curve characteristics:
- **mcpAUC**: Use for proper ROC curves over a restricted interval.
- **tpAUC**: Use for any ROC curve shape, including improper curves.

```r
# Calculate pAUC between FPR 0 and 0.25
# low.value: lower FPR limit (default 0)
# up.value: upper FPR limit (default 1)
# plot: TRUE to visualize the curve

res_mc <- mcpAUC(genes, low.value = 0, up.value = 0.25, plot = TRUE)
res_tp <- tpAUC(genes, low.value = 0, up.value = 0.25, plot = TRUE)

# Extract results from the returned SummarizedExperiment
stats <- assay(res_tp)
print(stats$St_pAUC) # Standardized pAUC
print(stats$pAUC)    # Raw pAUC
```

### 4. Bootstrap Analysis
To calculate variability (standard deviation) and confidence intervals, use the bootstrap variants.

```r
# r: number of iterations
# type.interval: "norm", "basic", "stud", "perc", or "bca"
boot_res <- tpAUCboot(genes, low.value = 0, up.value = 0.25, r = 100)

# Access results
boot_stats <- assay(boot_res)
# Contains: Tp_AUC (or MCp_AUC), sd, lwr (lower CI), upr (upper CI)
```

## Tips and Interpretation
- **Improper Curves**: If an ROC curve crosses the diagonal (chance line) within the interval of interest, it is considered improper. In these cases, `tpAUC` is the more reliable metric.
- **Standardization**: Standardized indexes (St_pAUC) scale the partial area so that a value of 0.5 represents a non-discriminatory classifier and 1.0 represents a perfect classifier within that specific FPR range.
- **Selection**: When using `SummarizedExperiment` objects, use the `selection` argument to pass a vector of gene/feature names to analyze specific variables.

## Reference documentation
- [ROC Partial Area Indexes for evaluating classifiers](./references/vignettes.md)
- [ROCpAI Rmd Source](./references/vignettes.Rmd)