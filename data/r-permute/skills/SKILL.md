---
name: r-permute
description: The permute package generates restricted and hierarchical permutations for randomization tests. Use when user asks to shuffle data with constraints, generate permutation sets for time series or spatial grids, or handle nested experimental designs like blocks and plots.
homepage: https://cloud.r-project.org/web/packages/permute/index.html
---

# r-permute

## Overview

The `permute` package provides a powerful framework for generating restricted permutations of data, which is essential for valid randomization tests when data are not freely exchangeable. It supports various structures including time series (line transects), spatial grids, and nested designs (plots within blocks). It is the engine behind the permutation schemes in the `vegan` package and is modeled after the logic used in Canoco.

## Installation

To install the package from CRAN:

```r
install.packages("permute")
library(permute)
```

## Core Workflow

The package uses a hierarchical approach to define how data should be shuffled.

### 1. Define the Design with `how()`
The `how()` function is the central configuration tool. It defines the permutation strategy.

```r
# Default: Free exchangeability (simple random shuffle)
ctrl <- how(nperm = 999)

# Time series: Preserve temporal order (cyclic shifts)
ctrl_series <- how(within = Within(type = "series"))

# Spatial Grid: 3x3 grid
ctrl_grid <- how(within = Within(type = "grid", ncol = 3, nrow = 3))
```

### 2. Generate Permutations
Use `shuffle()` for a single permutation or `shuffleSet()` for a matrix of multiple permutations (more efficient for loops).

```r
# Single vector of indices
perm_idx <- shuffle(n = 10, control = ctrl)

# Matrix of 99 permutations (rows = permutations)
perm_matrix <- shuffleSet(n = 10, nset = 99, control = ctrl)
```

## Restricted Permutation Types

The `Within()` and `Plots()` functions control the logic at different levels:

*   **`type = "free"`**: Unrestricted shuffling (default).
*   **`type = "series"`**: Cyclic shifts. If `mirror = TRUE`, the sequence can also be reversed.
*   **`type = "grid"`**: Toroidal shifts in 2D. Requires `ncol` and `nrow`.
*   **`type = "none"`**: No shuffling at that specific level.

## Handling Hierarchical Data

### Blocks
Blocks are the highest level. Samples are never swapped between blocks, and blocks themselves are never shuffled.

```r
# Permute only within blocks defined by a factor
my_blocks <- factor(rep(c("A", "B"), each = 5))
ctrl <- how(blocks = my_blocks)
```

### Plots (Split-Plots)
Plots are groups of samples that can be shuffled as units, or have their internal samples shuffled.

```r
# Permute whole plots, but keep samples within plots in original order
my_plots <- factor(rep(1:4, each = 5))
ctrl <- how(plots = Plots(strata = my_plots, type = "free"),
            within = Within(type = "none"))
```

## Integration in Functions

When writing a permutation test, use `shuffleSet` to minimize overhead and facilitate parallel processing.

```r
# Example: Permutation p-value for difference in means
perm_test <- function(x, group, nperm = 999) {
    obs_diff <- mean(x[group == "A"]) - mean(x[group == "B"])
    N <- length(x)
    
    # Generate set
    pset <- shuffleSet(N, nset = nperm)
    
    # Calculate null distribution
    null_dist <- apply(pset, 1, function(idx) {
        g_perm <- group[idx]
        mean(x[g_perm == "A"]) - mean(x[g_perm == "B"])
    })
    
    # P-value (including observed)
    (sum(null_dist >= obs_diff) + 1) / (nperm + 1)
}
```

## Tips for Package Authors
*   **Accessors**: Use `getNperm(ctrl)`, `getType(ctrl)`, etc., instead of accessing list elements directly.
*   **Setters**: Use `setNperm(ctrl) <- 199` to update design objects.
*   **Validation**: Use `check(n, control)` to verify if the requested number of permutations is possible given the design.

## Reference documentation

- [Restricted permutations; using the permute package](./references/permutations.Rmd)