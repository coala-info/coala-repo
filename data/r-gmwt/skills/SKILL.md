---
name: r-gmwt
description: R package gmwt (documentation from project home).
homepage: https://cran.r-project.org/web/packages/gmwt/index.html
---

# r-gmwt

name: r-gmwt
description: Generalized Mann-Whitney type tests based on probabilistic indices and diagnostic plots. Use this skill when performing non-parametric statistical tests for comparing multiple groups, specifically using the gMWT package to calculate probabilistic indices, perform multi-group comparisons, and generate specialized diagnostic plots.

# r-gmwt

## Overview
The `gmwt` package implements generalized Mann-Whitney type tests. It is designed to compare multiple groups using probabilistic indices (PI), which represent the probability that a randomly chosen observation from one group is smaller than a randomly chosen observation from another. This approach is particularly useful for non-normal data, ordered categorical data, and when traditional ANOVA assumptions are violated.

## Installation
To install the package from CRAN:
```R
install.packages("gMWT")
```

## Main Functions and Workflows

### Core Test Function: `gmwt()`
The primary function is `gmwt()`. It calculates probabilistic indices and performs hypothesis tests.

```R
# Basic usage
# x: data matrix or data frame
# g: grouping variable (factor)
res <- gmwt(x, g, test = "mw", alternative = "two.sided")
```

**Supported Test Types (`test` argument):**
- `"mw"`: Standard Mann-Whitney / Wilcoxon test.
- `"jonckheere"`: Jonckheere-Terpstra test for ordered alternatives.
- `"u"`: U-test for comparing multiple groups.
- `"p"`: Probabilistic Index estimation.

### Diagnostic Plots
The package provides specialized plotting functions to visualize the relationships between groups:

```R
# Create a diagnostic plot of the results
plot(res)
```

### Working with Probabilistic Indices
You can specifically calculate the PI matrix which shows pairwise comparisons:

```R
# Calculate PI for all pairs
pi_results <- estPI(x, g)
```

## Workflow Example
A typical analysis involves preparing a data matrix where rows are observations and columns are variables (or vice versa depending on the object type), defining a grouping factor, and running the generalized test.

```R
library(gMWT)

# Generate dummy data: 3 groups, 10 observations each, 5 variables
set.seed(123)
data_matrix <- matrix(rnorm(150), ncol=5)
group_factor <- factor(rep(1:3, each=10))

# Run the generalized Mann-Whitney test
result <- gmwt(data_matrix, group_factor, test="jonckheere")

# View summary
summary(result)

# Visualize the probabilistic indices
plot(result)
```

## Tips
- **Data Structure**: Ensure your grouping variable is a `factor`. If the groups have a natural order (e.g., doses), use `ordered = TRUE` or the `"jonckheere"` test.
- **Multiple Testing**: When running `gmwt` on high-dimensional data (many variables), remember to apply p-value adjustments (e.g., `p.adjust`) to the resulting p-values.
- **Large Datasets**: For very large datasets, the permutation-based p-values might be computationally expensive; check the documentation for asymptotic options.

## Reference documentation
- [gMWT README](./references/README.html.md)
- [gMWT Home Page](./references/home_page.md)