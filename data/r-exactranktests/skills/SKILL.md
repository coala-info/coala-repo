---
name: r-exactranktests
description: This package computes exact conditional p-values and quantiles for non-parametric tests using the Shift-Algorithm. Use when user asks to perform exact Wilcoxon Rank Sum tests, Wilcoxon Signed Rank tests, Ansari-Bradley tests, or permutation tests for small sample sizes or data with ties.
homepage: https://cran.r-project.org/web/packages/exactranktests/index.html
---

# r-exactranktests

## Overview
The `exactranktests` package provides an implementation of the Shift-Algorithm by Streitberg and Roehmel for computing exact conditional p-values and quantiles for non-parametric tests. It is primarily used for Wilcoxon Rank Sum, Wilcoxon Signed Rank, and Ansari-Bradley tests when the user requires exact distributions rather than asymptotic approximations.

## Installation
To install the package from CRAN:
```R
install.packages("exactranktests")
```

## Main Functions

### wilcox.exact
This is the exact version of the Wilcoxon Rank Sum (Mann-Whitney U) and Signed Rank tests. It handles ties and small sample sizes correctly.

```R
library(exactranktests)

# Two-sample Wilcoxon Rank Sum Test (Independent)
wilcox.exact(x, y, alternative = "two.sided", mu = 0, paired = FALSE, conf.int = TRUE)

# One-sample or Paired Wilcoxon Signed Rank Test
wilcox.exact(x, y, paired = TRUE, conf.int = TRUE)
```

### ansari.exact
Performs the exact Ansari-Bradley test to compare the dispersion (scale) of two distributions.

```R
ansari.exact(x, y, alternative = "two.sided")
```

### perm.test
A general-purpose exact permutation test for the difference in means between two samples.

```R
# Exact permutation test
perm.test(x, y, paired = FALSE, alternative = "two.sided")
```

## Workflows and Tips

### Handling Ties
Unlike the standard `wilcox.test` in the `stats` package, which often reverts to asymptotic approximations or issues warnings when ties are present, `wilcox.exact` computes the exact distribution even in the presence of ties.

### Small Sample Sizes
Always prefer `wilcox.exact` over `wilcox.test` when sample sizes (n) are very small (e.g., n < 10 per group), as the normal approximation used in asymptotic tests is often invalid in these cases.

### Comparison with stats::wilcox.test
The syntax for `wilcox.exact` is designed to be highly compatible with `stats::wilcox.test`. You can usually replace the function name in existing scripts to upgrade to an exact test.

```R
# Standard R (Asymptotic or simple exact)
stats::wilcox.test(1:10, 7:16)

# exactranktests (Shift-Algorithm exact)
exactranktests::wilcox.exact(1:10, 7:16)
```

## Reference documentation
- [exactRankTests: Exact Distributions for Rank and Permutation Tests](./references/home_page.md)