---
name: bioconductor-reconsi
description: This tool performs simultaneous inference and False Discovery Rate control for correlated hypotheses by estimating empirical null distributions. Use when user asks to perform large-scale hypothesis testing with dependent data, estimate empirical null distributions, or conduct differential abundance analysis on microbiome data.
homepage: https://bioconductor.org/packages/release/bioc/html/reconsi.html
---


# bioconductor-reconsi

name: bioconductor-reconsi
description: Simultaneous inference for correlated hypotheses using collapsed null distributions. Use this skill when performing large-scale hypothesis testing (e.g., genomics, microbiome data) where test statistics are dependent, and you need to estimate empirical null distributions to control the False Discovery Rate (FDR) more accurately than standard methods.

# bioconductor-reconsi

## Overview

The `reconsi` package addresses the problem of simultaneous inference when hypotheses are correlated. Standard FDR control methods often fail under dependency. `reconsi` uses an empirical Bayes framework and resampling to estimate "collapsed" null distributions that account for this correlation. It is particularly useful for microbiome data (absolute abundance) where a common factor (like total cell count) induces strong dependencies across all species tests.

## Core Workflow

### 1. Basic FDR Estimation
For a standard matrix of observations (rows = samples, columns = features) and a grouping factor:

```r
library(reconsi)

# mat: matrix of data, x: grouping factor (0/1 or factor)
fdrRes = reconsi(mat, x)

# Extract results
estFdr = fdrRes$Fdr  # Tail-area FDR estimates
p0 = fdrRes$p0       # Estimated proportion of true null hypotheses
```

### 2. Visualization
The package provides diagnostic plots to evaluate the null distribution and correlation structure:

```r
# Plot the estimated null distribution against the observed test statistics
plotNull(fdrRes)

# Visualize the approximate correlation matrix of test statistics
plotApproxCovar(fdrRes)

# Visualize the full variance-covariance matrix from resamples
plotCovar(fdrRes)
```

### 3. Custom Test Functions
You can extend `reconsi` to use any test statistic (e.g., linear models, Kruskal-Wallis).

```r
# Example using linear regression with a custom distribution function
fdrResLm = reconsi(mat, x, B = 50,
                   test = function(x, y) {
                     fit = lm(y ~ x)
                     c(summary(fit)$coef["x", "t value"], fit$df.residual)
                   },
                   distFun = function(q) { pt(q = q[1], df = q[2]) })
```

### 4. Microbiome Data (Phyloseq Integration)
The `testDAA` function is a wrapper specifically designed for `phyloseq` objects, common in microbiome research.

```r
# groupName: variable in sample_data for comparison
# FCname: variable for flow cytometry/total counts to calculate absolute abundance
testRes = testDAA(physeq_obj, groupName = "Condition", FCname = "TotalCounts", B = 100)

# Access FDR
fdrValues = testRes$Fdr
```

## Key Parameters for `reconsi()`
- `Y`: Data matrix (samples by features).
- `x`: Grouping vector. If omitted, the package performs a bootstrap (one-sample test).
- `B`: Number of resamples (default is 1000; use lower values like `5e1` for testing).
- `zValues`: If `FALSE`, calculations are done on the original test statistic scale (less stable).
- `resamZvals`: If `TRUE`, uses resampling to determine marginal null distributions.
- `argList`: A list of additional arguments passed to the `test` function (e.g., extra covariates).

## Reference documentation

- [Manual for the reconsi package](./references/reconsiVignette.md)
- [reconsi RMarkdown Source](./references/reconsiVignette.Rmd)