---
name: bioconductor-quantro
description: This tool performs a statistical test to determine if global normalization methods are appropriate for high-throughput data. Use when user asks to assess the assumptions of quantile normalization, test for global differences in distributions across experimental groups, or visualize data distributions using density plots and boxplots.
homepage: https://bioconductor.org/packages/release/bioc/html/quantro.html
---

# bioconductor-quantro

name: bioconductor-quantro
description: Statistical test for global differences in distributions across groups. Use when determining if global normalization methods (e.g., quantile normalization) are appropriate for high-throughput data such as microarrays, RNA-Seq, or DNA methylation. It helps identify if biological variation between groups is large enough that standard normalization might erase meaningful signals.

# bioconductor-quantro

## Overview

The `quantro` package provides a data-driven test to assess the appropriateness of global normalization methods (like quantile normalization). It evaluates whether the assumptions of these methods—namely that the statistical distribution of each sample is the same—hold true across different experimental groups.

The package performs two primary tests:
1. An ANOVA to test for differences in medians across groups (identifying technical or global biological variation).
2. A test for global differences in distributions (`quantroStat`), which compares variability within groups versus between groups.

## Installation

Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("quantro")
library(quantro)
```

## Visualizing Distributions

Before running statistical tests, visualize the raw data distributions to identify potential group-level differences.

- **matdensity()**: Plots the density for each sample, colored by group.
- **matboxplot()**: Generates boxplots for samples, ordered and colored by group.

```r
# p: matrix of values (e.g., Beta values or expression)
# groupFactor: factor indicating group membership for each column
matdensity(p, groupFactor = pd$CellType, main = "Distribution by Group")
matboxplot(p, groupFactor = pd$CellType, main = "Boxplots by Group")
```

## Testing for Global Differences

The `quantro()` function is the primary tool for testing. It accepts a matrix, data frame, or objects inheriting from `eSet` (e.g., `ExpressionSet`, `MethylSet`).

### Basic Usage

```r
# Run the test
qtest <- quantro(object = p, groupFactor = pd$CellType)

# View summary of groups and samples
summary(qtest)

# Check ANOVA results for medians
anova(qtest)

# Retrieve the quantroStat statistic
quantroStat(qtest)
```

### Permutation Testing

To assess the statistical significance of the `quantroStat`, use permutation testing by setting the `B` parameter. This requires a parallel backend.

```r
library(doParallel)
registerDoParallel(cores = 1) # Adjust cores as needed

# Run with 1000 permutations
qtestPerm <- quantro(p, groupFactor = pd$CellType, B = 1000)

# View the permutation p-value
qtestPerm
```

## Interpreting Results

- **quantroStat**: A ratio of mean squared error between groups to mean squared error within groups. A higher value suggests that global normalization may not be appropriate because group-level differences are significant.
- **anovaPval**: If significant, it indicates the medians of the distributions differ across groups.
- **quantroPvalPerm**: If this p-value is low (e.g., < 0.05), it suggests that the distributions are globally different between groups, and quantile normalization might remove biological signal.

## Visualizing Permutation Results

If permutations were performed, use `quantroPlot()` to visualize the distribution of the null test statistics relative to the observed statistic.

```r
quantroPlot(qtestPerm)
```

## Reference documentation

- [quantro](./references/quantro.md)