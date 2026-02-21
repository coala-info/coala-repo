---
name: bioconductor-hybridmtest
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HybridMTest.html
---

# bioconductor-hybridmtest

## Overview

The `HybridMTest` package implements "Assumption Adequacy Averaging" (AAA). Instead of choosing a single test for an entire dataset, it calculates multiple test statistics for each feature (e.g., ANOVA and Kruskal-Wallis) and a diagnostic statistic (e.g., Shapiro-Wilk for normality). It then computes a weighted average of the Empirical Bayes Probabilities (EBP) or selects the "best" test based on the diagnostic, providing a more robust approach to multiple testing in large-scale genomic studies.

## Typical Workflow

### 1. Data Preparation
The package typically works with `ExpressionSet` objects. Ensure your data is formatted with expression values in the `exprs` slot and group/phenotype information in the `pData` slot.

```r
library(HybridMTest)
# Example for K-group comparison
data(GroupComp.data)
# GroupComp.data is an ExpressionSet
```

### 2. Defining Test Specifications
You must define which tests to run using a data frame. This includes the label, the internal function name, the variable in `pData` to test against, and any options.

**Common Function Names:**
- `row.oneway.anova`: Parametric K-group comparison.
- `row.kruskal.wallis`: Non-parametric K-group comparison.
- `row.kgrp.shapiro`: Shapiro-Wilk test for K-group normality.
- `row.pearson`: Parametric correlation.
- `row.spearman`: Non-parametric correlation.
- `row.slr.shapiro`: Shapiro-Wilk test for regression residuals.

```r
test.specs <- cbind.data.frame(
  label = c("anova", "kw", "shapiro"),
  func.name = c("row.oneway.anova", "row.kruskal.wallis", "row.kgrp.shapiro"),
  x = rep("grp", 3), # "grp" is the column name in pData
  opts = rep("", 3)
)
```

### 3. Defining EBP Weights
Define how the results should be combined. Usually, the diagnostic test (like Shapiro-Wilk) provides the weight for the parametric test, and (1 - weight) is used for the non-parametric test.

```r
ebp.def <- cbind.data.frame(
  wght = c("shapiro.ebp", "(1-shapiro.ebp)"),
  mthd = c("anova.ebp", "kw.ebp")
)
```

### 4. Running the Hybrid Test
The `hybrid.test` function executes the specified tests and combines them.

```r
results <- hybrid.test(GroupComp.data, test.specs, ebp.def)
```

## Interpreting Results

The output is a data frame containing:
- Individual test statistics and p-values for every test in `test.specs`.
- **ebp**: Empirical Bayes Probabilities (local FDR) for each test.
- **wgt.mean.ebp**: The weighted average of EBPs based on your `ebp.def`.
- **best.ebp**: The EBP from the test deemed most appropriate by the diagnostic.
- **best.pval**: The p-value associated with the `best.ebp`.

Features with low `wgt.mean.ebp` or `best.ebp` (typically < 0.05 or 0.1) are considered significantly differentially expressed or correlated, accounting for the adequacy of the underlying statistical assumptions.

## Tips
- **Missing Data**: For regression analysis, ensure data is pre-processed to handle missing values, as the correlation functions require complete cases.
- **Custom Weights**: While Shapiro-Wilk is the standard diagnostic, you can technically use any test to weight others as long as it is defined in `test.specs`.
- **Large Datasets**: The package is optimized for `ExpressionSet` objects, making it efficient for standard Bioconductor pipelines.

## Reference documentation
- [An Introduction to Hybrid Testing](./references/HybridMTest.md)