---
name: bioconductor-a4base
description: bioconductor-a4base provides utility functions for the automated analysis and visualization of Affymetrix microarray data. Use when user asks to perform differential expression analysis, filter ExpressionSet objects, create volcano plots, or generate spectral maps.
homepage: https://bioconductor.org/packages/release/bioc/html/a4Base.html
---

# bioconductor-a4base

name: bioconductor-a4base
description: Automated Affymetrix Array Analysis (a4) base utility functions. Use this skill to perform differential expression analysis, create specialized plots (volcano, spectral maps, log-ratio plots), and manage ExpressionSet objects within the a4 framework.

# bioconductor-a4base

## Overview

The `a4Base` package provides the core functionality for the Automated Affymetrix Array Analysis suite. It simplifies common microarray data analysis tasks such as filtering, statistical testing (t-tests, limma), and high-quality visualization. It is designed to work seamlessly with `ExpressionSet` objects.

## Core Workflows

### Data Preparation and Filtering
Before analysis, use `a4Base` utilities to clean and filter your `ExpressionSet`.

```r
library(a4Base)

# Filter features based on intensity and variance
# Default: intensity > log2(100) in 25% of samples, IQR > 0.5
filtered_eset <- filterVarInt(object = eset, IntCutOff = log2(100), VarCutOff = 0.5)

# Combine two ExpressionSets
combined_eset <- combineTwoExpressionSet(eset1, eset2)
```

### Differential Expression Analysis
The package provides wrappers for standard tests that return objects compatible with `a4Base` plotting functions.

```r
# Simple t-test between two groups
# 'groups' is a column name in pData(eset)
t_results <- tTest(object = eset, groups = "condition", probe2gene = TRUE)

# Limma wrapper for two levels
limma_results <- limmaTwoLevels(object = eset, group = "condition")

# Extract top genes
top_genes <- topTable(t_results, n = 20)
```

### Visualization

#### Volcano Plots
Assess statistical vs. biological significance.
```r
volcanoPlot(t_results, topPValues = 10, topLogRatios = 10)
```

#### Gene-specific Plots
Visualize expression levels for a single gene across groups.
```r
# Boxplot with jittered raw data
boxPlot(geneSymbol = "MYC", object = eset, groups = "condition")

# Profile plot (expression vs samples)
plot1gene(geneSymbol = "MYC", object = eset, groups = "condition")
```

#### Multivariate and Summary Plots
```r
# Spectral Map (Multivariate analysis)
spectralMap(object = eset, groups = "condition", probe2gene = TRUE)

# Heatmap with subgroup support
heatmap.expressionSet(eset, col.groups = eset$condition)

# Log-Ratio Plot (Summary of top genes vs reference)
# Requires computing log ratios first
log_ratio_eset <- computeLogRatio(eset, reference = list(var = "condition", level = "Control"))
plotLogRatio(e = log_ratio_eset[1:20,], colorsColumnsBy = "condition")
```

### Predictive Modeling
```r
# Lasso regression to find gene predictors for a continuous covariate
lasso_mod <- lassoReg(object = eset, covariate = "age")

# Logistic regression for binary classification probabilities
log_reg_res <- logReg(object = eset, groups = "status", geneSymbol = "HLA-DPB1")
probabilitiesPlot(proportions = log_reg_res$fit, classVar = log_reg_res$y)
```

## Tips and Best Practices
- **Gene Symbols**: Many functions have a `probe2gene` argument. Ensure your `ExpressionSet` is properly annotated (e.g., via `a4Preproc::addGeneInfo`) for this to work.
- **P-value Distribution**: Use `histPvalue(t_results)` to check the distribution of p-values and estimate the proportion of differentially expressed genes using `propDEgenes`.
- **Color Palettes**: Use `a4palette(n)` or `oaPalette(n)` for consistent, publication-quality color schemes.
- **Interactive SVG**: `plotLogRatio` can generate SVG files with tooltips if `device = 'svg'` and `tooltipvalues = TRUE` are set.

## Reference documentation
- [a4Base Reference Manual](./references/reference_manual.md)