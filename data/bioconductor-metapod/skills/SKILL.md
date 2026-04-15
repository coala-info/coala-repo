---
name: bioconductor-metapod
description: This tool performs meta-analysis by combining p-values from multiple statistical tests into a single statistic. Use when user asks to combine parallel p-values across batches, aggregate grouped p-values for genomic regions, or summarize the direction of effect from multiple differential expression tests.
homepage: https://bioconductor.org/packages/release/bioc/html/metapod.html
---

# bioconductor-metapod

name: bioconductor-metapod
description: Meta-analysis of p-values from differential expression or other statistical tests. Use this skill to combine multiple p-values into a single statistic using methods like Simes, Fisher, Stouffer, or Wilkinson. It is particularly useful for consolidating results from parallel tests (e.g., multiple batches) or grouped tests (e.g., genomic windows within a region).

## Overview

The `metapod` package provides a robust framework for combining p-values from multiple statistical tests. It is designed to handle two primary scenarios:
1. **Parallel tests**: Combining p-values for the same features across different experiments or batches.
2. **Grouped tests**: Combining p-values for different features that belong to the same logical group (e.g., exons in a gene, windows in a ChIP-seq peak).

The package supports various combining strategies, handles dependencies between tests, and provides utilities to summarize the direction of effect (up/down/mixed) based on "influential" tests.

## Core Workflows

### 1. Combining Parallel P-values
Use this when you have multiple vectors of p-values of the same length, where each index represents the same entity (e.g., Gene A in Batch 1 and Batch 2).

```r
library(metapod)

# Example: Two batches of p-values for 10,000 genes
p1 <- rbeta(10000, 0.5, 1)
p2 <- rbeta(10000, 0.5, 1)

# Combine using Simes' method (robust to dependencies)
results <- parallelSimes(list(p1, p2))

# Access combined p-values
combined_p <- results$p.value
```

### 2. Combining Grouped P-values
Use this when you have one vector of p-values and a grouping factor (e.g., p-values for 10,000 genomic windows belonging to 100 regions).

```r
p <- rbeta(10000, 0.5, 1)
groups <- sample(100, length(p), replace=TRUE)

# Combine using Fisher's method
results <- groupedFisher(p, groups)

# Access results
combined_p <- results$p.value # Named vector by group
```

### 3. Summarizing Direction of Effect
To determine if a group is consistently up-regulated, down-regulated, or mixed, use the `influential` metadata from the combination step.

```r
logfc1 <- rnorm(10000)
logfc2 <- rnorm(10000)

# Summarize direction based on tests that actually contributed to the combined p-value
directions <- summarizeParallelDirection(list(logfc1, logfc2), 
                                         influential = results$influential)
table(directions)
```

## Choosing a Combining Strategy

| Method | Function Prefix | Best Use Case |
| :--- | :--- | :--- |
| **Simes** | `parallelSimes` | Robust to dependencies; significant if **any** test is significant. |
| **Fisher** | `parallelFisher` | Assumes independence; highly sensitive to the **smallest** p-value. |
| **Pearson** | `parallelPearson` | Assumes independence; sensitive to the **largest** p-value. |
| **Stouffer** | `parallelStouffer` | Assumes independence; supports weighting; a middle-ground approach. |
| **Wilkinson** | `parallelWilkinson` | Significant if a **minimum number** of tests are significant. |
| **Holm-min** | `parallelHolmMin` | Significant if a **minimum proportion** of tests are significant; no independence required. |
| **Berger** | `parallelBerger` | Intersection-Union test; significant only if **all** tests are significant. |

## Tips and Best Practices

- **Log-space**: For very small p-values, use `log.p = TRUE` in the combining functions to prevent underflow and return log-transformed p-values.
- **Weights**: Methods like Simes and Stouffer support a `weights` argument to prioritize specific tests (e.g., based on sample size or quality).
- **Representative Tests**: The `representative` field in the output list provides the index of the "most important" test in the group, which is useful for extracting a single log-fold change for visualization.
- **Wrapper Functions**: Use `combineParallelPValues()` or `combineGroupedPValues()` with the `method=` argument for easier programmatic switching between strategies.

## Reference documentation

- [Meta-analyses on p-values of various differential tests](./references/overview.md)