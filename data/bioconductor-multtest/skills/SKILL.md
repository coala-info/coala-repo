---
name: bioconductor-multtest
description: This tool performs resampling-based multiple hypothesis testing to provide adjusted p-values for high-dimensional data. Use when user asks to perform permutation or bootstrap tests, control error rates like FWER and FDR, or calculate adjusted p-values for genomic datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/multtest.html
---


# bioconductor-multtest

name: bioconductor-multtest
description: Resampling-based multiple hypothesis testing for high-dimensional data. Use this skill to perform non-parametric bootstrap and permutation-based multiple testing procedures to control FWER, gFWER, TPPFP, and FDR. It is particularly useful for identifying differentially expressed genes in microarray experiments or any scenario requiring adjusted p-values for thousands of simultaneous tests.

# bioconductor-multtest

## Overview
The `multtest` package provides a suite of resampling-based multiple testing procedures. Unlike traditional methods that assume specific distributions, `multtest` uses the data itself (via permutations or bootstrap) to estimate the null distribution of test statistics. This accounts for the joint dependence structure between variables, leading to more accurate and powerful inference in high-dimensional settings like genomics.

## Main Functions and Workflows

### 1. Calculating Test Statistics
Before adjusting p-values, you can compute various test statistics (t-stats, F-stats, Wilcoxon) using `mt.teststat`.
```r
library(multtest)
data(golub)
# Compute Welch t-statistics for two groups (0 and 1)
teststat <- mt.teststat(golub, golub.cl, test="t")
```

### 2. Step-down maxT and minP Procedures
These are the primary functions for strong control of the Family-Wise Error Rate (FWER).
- `mt.maxT`: Based on the distribution of the maximum test statistic. Faster for large numbers of hypotheses.
- `mt.minP`: Based on the distribution of the minimum p-value. More powerful if test statistics have different distributions.

```r
# Perform maxT procedure with 1000 permutations
res.maxT <- mt.maxT(golub, golub.cl, B=1000)
# Results are sorted by significance
head(res.maxT)
```

### 3. Simple p-value Adjustments
If you already have raw p-values, use `mt.rawp2adjp` to apply standard corrections (Bonferroni, Holm, BH, BY, etc.).
```r
rawp <- res.maxT$rawp[order(res.maxT$index)]
procs <- c("Bonferroni", "Holm", "BH", "BY")
res.adjp <- mt.rawp2adjp(rawp, procs)
```

### 4. Empirical Bayes Multiple Testing (EBMTP)
For more advanced control of FDR or TPPFP using a common-cutoff method and local q-values.
```r
# Control FDR at 0.05 using EBMTP
eb.res <- EBMTP(X=golub, Y=golub.cl, typeone="fdr", alpha=0.05, B=100)
summary(eb.res)
```

### 5. Visualization
The package provides `mt.plot` to visualize the relationship between test statistics, raw p-values, and adjusted p-values.
```r
# Plot adjusted p-values vs. test statistics (Volcano-like plot)
mt.plot(res.adjp$adjp, teststat, plottype="pvst", proc=procs)
```

## Key Parameters
- `B`: Number of iterations. Higher values (e.g., 10,000) increase precision but take longer.
- `test`: Type of test ("t", "t.equalvar", "wilcoxon", "f", "pairt", "blockf").
- `side`: Rejection region ("abs" for two-sided, "upper", or "lower").
- `nulldist`: For `MTP` or `EBMTP`, defines the null distribution (e.g., "boot.cs" for centered/scaled bootstrap).

## Tips for Success
- **Data Orientation**: Most functions expect a matrix `X` where rows are variables (genes) and columns are observations (samples).
- **Class Labels**: Labels for groups must be integers starting from 0 (e.g., 0, 1, 2).
- **Reproducibility**: Use `set.seed()` before calling resampling functions to ensure results are consistent across runs.
- **Memory Management**: For very large datasets, `mt.maxT` is generally more memory-efficient than `mt.minP`.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)