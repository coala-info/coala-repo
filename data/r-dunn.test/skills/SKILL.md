---
name: r-dunn.test
description: This tool performs Dunn's non-parametric test for pairwise multiple comparisons of stochastic dominance between groups. Use when user asks to perform a post hoc analysis after a Kruskal-Wallis test, compare multiple independent groups using rank-based statistics, or apply p-value adjustments for multiple testing.
homepage: https://cloud.r-project.org/web/packages/dunn.test/index.html
---


# r-dunn.test

## Overview
The `dunn.test` package implements Dunn's (1964) non-parametric test for stochastic dominance. It is the standard post hoc procedure following a significant Kruskal-Wallis test. It performs $k(k-1)/2$ pairwise comparisons using z-test statistic approximations, accounts for tied ranks, and offers various p-value adjustment methods for multiple testing.

## Installation
```R
install.packages("dunn.test")
```

## Core Functionality

### The dunn.test Function
The primary function is `dunn.test()`. It can be used with a response vector and a grouping factor, or via a formula interface.

**Basic Syntax:**
```R
library(dunn.test)

# Vector-based
dunn.test(x, g, method="bonferroni")

# Formula-based (requires rlang)
dunn.test(list(group1, group2, group3))
```

### Key Arguments
- `x`: A numeric vector of data values or a list of numeric vectors.
- `g`: A vector or factor object giving the group for the corresponding elements of `x`.
- `method`: The method for p-value adjustment. Options include:
  - `"none"`: No adjustment.
  - `"bonferroni"`: Bonferroni adjustment (conservative).
  - `"sidak"`: Sidak adjustment.
  - `"holm"`: Holm's step-down procedure.
  - `"hs"`: Holm-Sidak adjustment.
  - `"hochberg"`: Hochberg's step-up procedure.
  - `"bh"`: Benjamini-Hochberg (False Discovery Rate).
  - `"by"`: Benjamini-Yekutieli.
- `kw`: Logical. If `TRUE` (default), the Kruskal-Wallis test is performed and reported first.
- `label`: Logical. If `TRUE`, the output includes group labels.
- `wrap`: Logical. If `TRUE`, the output table is wrapped for better readability.
- `table`: Logical. If `TRUE` (default), the results table is printed.
- `list`: Logical. If `TRUE`, results are formatted as a list rather than a table.

## Common Workflow

### Post hoc Analysis after Kruskal-Wallis
1. Perform a Kruskal-Wallis test to check for global significance.
2. If $p < 0.05$, run `dunn.test` to find specific group differences.

```R
# Example with built-in airquality data
data(airquality)

# Test if Ozone levels differ by Month
# dunn.test automatically runs Kruskal-Wallis first
dunn.test(airquality$Ozone, airquality$Month, method="bh")
```

### Interpreting Output
The function returns a list (invisibly if `table=TRUE`) containing:
- `chi2`: The Kruskal-Wallis chi-squared statistic.
- `z`: A vector of Dunn's z-test statistics.
- `P`: A vector of unadjusted p-values.
- `P.adj`: A vector of adjusted p-values based on the chosen `method`.
- `comparisons`: A vector of strings identifying the pairs compared.

## Tips
- **Ties**: The package automatically adjusts for tied ranks, which is essential for accurate non-parametric testing.
- **Directionality**: The z-statistic indicates the direction of the difference. A positive $z$ for "Group A - Group B" suggests Group A has higher ranks (stochastic dominance) than Group B.
- **Missing Values**: Ensure data is cleaned or use `na.rm` logic before passing to the function, as the package expects complete cases for the pairs being compared.
- **Multiple Testing**: Always use a p-value adjustment (like `"holm"` or `"bh"`) when performing many pairwise comparisons to avoid Type I errors.

## Reference documentation
- [dunn.test: Dunn's Test of Multiple Comparisons Using Rank Sums](./references/home_page.md)