---
name: bioconductor-genefilter
description: This tool filters genes from high-throughput expression data based on statistical or biological criteria. Use when user asks to reduce data dimensionality, perform independent filtering to increase statistical power, find genes with similar expression profiles, or apply custom filtering functions to ExpressionSet objects.
homepage: https://bioconductor.org/packages/release/bioc/html/genefilter.html
---


# bioconductor-genefilter

name: bioconductor-genefilter
description: Filtering genes from high-throughput experiments (microarray, RNA-seq) using non-specific and specific criteria. Use when you need to reduce the dimensionality of expression data, perform independent filtering to increase statistical power, find genes with similar expression profiles, or apply custom filtering functions to ExpressionSet objects.

## Overview
The `genefilter` package provides tools for selecting a subset of genes from a large dataset based on specific statistical or biological criteria. It supports "non-specific" filtering (e.g., variance, minimum expression levels) and "specific" filtering (e.g., differential expression between groups). A key feature is the ability to chain multiple filters together and perform "independent filtering" to improve the power of multiple testing corrections.

## Core Workflow

### 1. Non-specific Filtering
Non-specific filtering removes genes that are unlikely to be informative regardless of the experimental groups (e.g., genes with very low expression or low variation).

```r
library(genefilter)
library(Biobase)

# Example: Select genes with expression > 200 in at least 5 samples
f1 <- kOverA(5, 200)
ffun <- filterfun(f1)
selected <- genefilter(exprs(myExpressionSet), ffun)
filtered_data <- myExpressionSet[selected, ]
```

### 2. Specific Filtering
Specific filtering selects genes based on sample metadata, such as group labels.

```r
# Example: Select genes based on a t-test p-value < 0.1 between groups
f2 <- ttest(myExpressionSet$group_var, p = 0.1)
ffun <- filterfun(f2)
selected <- genefilter(exprs(myExpressionSet), ffun)
```

### 3. Combining Filters
You can combine multiple criteria into a single filtering function. A gene must pass ALL criteria to be selected.

```r
ffun_combined <- filterfun(kOverA(5, 200), ttest(myExpressionSet$type, p = 0.05))
selected <- genefilter(exprs(myExpressionSet), ffun_combined)
```

### 4. Finding Similar Genes
Use `genefinder` to find genes with expression profiles similar to a set of "seed" genes.

```r
# Find 10 closest genes to indices 300 and 333 using Euclidean distance
close_genes <- genefinder(myExpressionSet, c(300, 333), 10, method = "euclidean")

# Access indices and distances for the first seed gene
close_genes[[1]]$indices
close_genes[[1]]$dists
```

## Independent Filtering Diagnostics
Independent filtering (e.g., filtering by row variance before a t-test) can increase the number of rejections at a fixed FDR.

- **`rowttests`**: Fast row-wise t-tests for every gene.
- **`filtered_p`**: Computes adjusted p-values across a range of filtering thresholds ($\theta$).
- **`rejection_plot`**: Visualizes how the number of rejections changes with different filtering stringencies.

```r
# Compute filter statistic (variance) and test statistic (p-value)
s_vars <- rowVars(exprs(myExpressionSet))
p_vals <- rowttests(myExpressionSet, "group_var")$p.value

# Calculate BH adjusted p-values for filtering thresholds 0% to 50%
theta <- seq(0, 0.5, 0.1)
p_bh <- filtered_p(s_vars, p_vals, theta, method = "BH")

# Plot rejections
rejection_plot(p_bh, at = "sample")
```

## Key Functions
- `genefilter(expr, flist)`: Primary filtering engine.
- `filterfun(...)`: Combines multiple filter functions.
- `kOverA(k, A)`: Filter for at least `k` samples with expression `> A`.
- `ttest(cov, p)`: Filter based on t-test p-value.
- `rowVars()`, `rowSds()`: Efficient row-wise variance/standard deviation.
- `genefinder(X, ilist, n)`: Find `n` nearest neighbors for genes in `ilist`.

## Reference documentation
- [Using the genefilter function to filter genes from a microarray dataset](./references/howtogenefilter.md)
- [Finding similar genes with genefinder](./references/howtogenefinder.md)
- [Independent filtering plots and diagnostics](./references/independent_filtering_plots.md)