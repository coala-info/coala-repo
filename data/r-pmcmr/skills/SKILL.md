---
name: r-pmcmr
description: This tool performs non-parametric pairwise multiple comparisons of mean rank sums to identify specific group differences after significant omnibus tests. Use when user asks to perform post-hoc tests following Kruskal-Wallis, Friedman, or Quade tests, conduct Dunn's or Nemenyi tests, or compare multiple groups with non-normal data.
homepage: https://cran.r-project.org/web/packages/pmcmr/index.html
---

# r-pmcmr

name: r-pmcmr
description: Perform non-parametric pairwise multiple comparisons of mean rank sums. Use this skill when conducting post-hoc tests following significant results from Kruskal-Wallis, Friedman, or Quade tests. This package is ideal for data that does not meet normality assumptions.

# r-pmcmr

## Overview
The `pmcmr` package provides a suite of non-parametric multiple comparison procedures. It is used to determine which specific groups differ from one another after a global omnibus test (like `kruskal.test` or `friedman.test`) has rejected the null hypothesis. 

**Note:** This package is superseded by `PMCMRplus`. While `pmcmr` is maintained for legacy support, `PMCMRplus` is recommended for new projects requiring more advanced methods.

## Installation
To install the package from CRAN:
```R
install.packages("PMCMR")
```

## Main Functions

### Kruskal-Wallis Post-hoc Tests
Used after a significant Kruskal-Wallis test to compare independent groups.
- `posthoc.kruskal.nemenyi.test(x, g, dist = c("Tukey", "Chisq"))`: Nemenyi test for pairwise comparisons.
- `posthoc.kruskal.dunn.test(x, g, p.adjust.method)`: Dunn's test, very common for unequal sample sizes.
- `posthoc.kruskal.conover.test(x, g, p.adjust.method)`: Conover's test, often more powerful than Dunn's.

### Friedman Post-hoc Tests
Used after a significant Friedman test for unreplicated blocked designs (repeated measures).
- `posthoc.friedman.nemenyi.test(data)`: Nemenyi-test for multiple comparisons of mean rank sums.
- `posthoc.friedman.conover.test(data, p.adjust.method)`: Conover's test for Friedman-type data.

### Other Tests
- `posthoc.quade.test(data, p.adjust.method)`: Post-hoc test for Quade's test.
- `posthoc.vanWaerden.test(x, g, p.adjust.method)`: Van der Waerden's normal scores test.

## Workflows

### Standard Kruskal-Wallis Post-hoc
1. Perform the global test: `res <- kruskal.test(Ozone ~ Month, data = airquality)`
2. If significant, run post-hoc:
```R
library(PMCMR)
# Using Dunn's test with Benjamini-Hochberg adjustment
posthoc.kruskal.dunn.test(Ozone ~ Month, data = airquality, p.adjust.method = "BH")
```

### Standard Friedman Post-hoc
1. Prepare data as a matrix where rows are blocks and columns are groups.
2. Run post-hoc:
```R
# Example using Nemenyi test
posthoc.friedman.nemenyi.test(RoundingTimes)
```

## Tips
- **P-value Adjustment**: Most functions support `p.adjust.method`. Common options include "bonferroni", "holm", "BH" (Benjamini-Hochberg), and "none".
- **Data Format**: Functions typically accept either a formula (`y ~ g`) or a numeric vector `x` and a grouping factor `g`.
- **Ties**: The tests in this package generally handle ties in the rank sums.

## Reference documentation
- [PMCMR Home Page](./references/home_page.md)