---
name: bioconductor-unifiedwmwqpcr
description: This package implements the unified Wilcoxon-Mann-Whitney test for differential expression analysis of RT-qPCR data without requiring pre-normalization. Use when user asks to perform uWMW tests on Cq values, incorporate normalization constants into statistical models, or visualize qPCR results using volcano and forest plots.
homepage: https://bioconductor.org/packages/release/bioc/html/unifiedWMWqPCR.html
---


# bioconductor-unifiedwmwqpcr

## Overview

The `unifiedWMWqPCR` package implements the unified Wilcoxon-Mann-Whitney (uWMW) test, specifically designed for RT-qPCR data. Unlike standard tests that require pre-normalization, uWMW incorporates the normalization constant ($\Delta$) directly into the statistical model. It models the probability $P(Y < Y' + 0.5P(Y = Y'))$, where $Y$ and $Y'$ are quantification cycles (Cq). This approach is robust to outliers and handles undetermined values by setting them to the limit of detection.

## Core Workflow

### 1. Data Preparation
The input should be a matrix of Cq values where rows are features (genes/miRNAs) and columns are samples.

```r
library(unifiedWMWqPCR)
# NBmat: matrix of Cq values
# NBgroups: factor or vector defining treatment groups
data(NBmat)
data(NBgroups)
```

### 2. Running the uWMW Test
The `uWMW` function is the primary interface. It supports two normalization strategies:

**Overall Normalization (No Housekeeping Genes)**
Uses the distribution of all features to estimate the normalization constant.
```r
uWMW.out <- uWMW(NBmat, groups = NBgroups)
```

**Housekeeping Normalization**
Uses specific features known to be stable across conditions.
```r
hk <- c("feature1", "feature2")
uWMW.out <- uWMW(NBmat, groups = NBgroups, housekeeping.names = hk)
```

### 3. Extracting and Interpreting Results
The output object can be subset like a data frame or list.

```r
# View summary
uWMW.out

# Extract specific features by name or index
results <- uWMW.out[c("geneA", "geneB")]

# Columns:
# logor: Log odds ratio (relative to the normalization constant Delta)
# se: Standard error of the logor
# or: Odds ratio (exp(logor))
# z.value: Test statistic
# p.value: Two-sided p-value
```

**Interpretation:**
- The "Fitted probabilities" in the output (e.g., `P(Group1 < Group2)`) indicate which group is the reference.
- Because lower Cq values indicate higher expression, a positive `logor` (or `or > 1`) typically indicates **upregulation** in the first group relative to the second, compared to the normalization baseline.

### 4. Multiple Testing Correction
The package does not automatically adjust p-values. Use the standard `p.adjust` function.

```r
adj.p <- p.adjust(uWMW.out@p.value, method = "BH")
names(adj.p) <- names(uWMW.out)
```

## Visualization Tools

### Volcano Plot
Visualizes effect size (log odds ratio) against statistical significance.
```r
volcanoplot(uWMW.out, 
            add.ref = "both", 
            ref.x = c(-log(2), log(2)), 
            ref.y = -log10(0.001))
```

### Forest Plot
Displays estimated probabilities and 95% confidence intervals for specific features.
```r
# selection.id: indices of features to plot
forestplot(uWMW.out, estimate = "p", order = selection.id)
```
The red diamond at the bottom represents the estimated normalization constant $\Delta$. If a feature's CI does not overlap with the $\Delta$ interval, it is significantly differentially expressed.

## Advanced Usage: Probabilistic Index Models (PIM)
The uWMW test is a specific case of a PIM. You can extract the underlying model coefficients:
```r
coef(uWMW.out) # Intercept is the normalization constant
vcov(uWMW.out) # Variance-covariance matrix
```

## Reference documentation
- [unifiedWMWqPCR](./references/unifiedWMWqPCR.md)