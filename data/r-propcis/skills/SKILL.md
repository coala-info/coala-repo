---
name: r-propcis
description: This tool computes specialized confidence intervals for single, paired, and independent proportions using methods like Wilson Score, Agresti-Coull, and Newcombe. Use when user asks to calculate confidence intervals for proportions, compare differences between independent groups, or analyze paired categorical data.
homepage: https://cloud.r-project.org/web/packages/PropCIs/index.html
---

# r-propcis

name: r-propcis
description: Provides specialized methods for computing confidence intervals for single, paired, and independent proportions using the PropCIs R package. Use this skill when you need to calculate CIs beyond the standard Wald or Clopper-Pearson methods, specifically for Agresti-Coull, Wilson Score, Jeffreys, or intervals for differences in proportions (e.g., Newcombe, Score, or Wald with continuity correction).

## Overview

The `PropCIs` package implements various statistical methods for calculating confidence intervals (CIs) for proportions, as described in Alan Agresti's "Categorical Data Analysis." It is particularly useful for small sample sizes or when proportions are near 0 or 1, where standard Wald intervals perform poorly.

## Installation

```r
install.packages("PropCIs")
library(PropCIs)
```

## Core Workflows

### Single Proportion CIs
Use these functions when you have $x$ successes out of $n$ trials.

*   **Wilson Score Interval:** `scoreci(x, n, conf.level = 0.95)` - Generally recommended for good coverage properties.
*   **Agresti-Coull Interval:** `add4ci(x, n, conf.level = 0.95)` - Adds 2 successes and 2 failures; simple and reliable for 95% CIs.
*   **Jeffreys Prior Interval:** `jeffreysci(x, n, conf.level = 0.95)` - A Bayesian-derived interval.
*   **Blaker's Exact Interval:** `blakerci(x, n, conf.level = 0.95)` - An alternative to Clopper-Pearson that is typically shorter.

### Independent Proportions (Difference)
Use these to compare two independent groups ($x_1/n_1$ vs $x_2/n_2$).

*   **Newcombe Hybrid Score Interval:** `diffscoreci(x1, n1, x2, n2, conf.level = 0.95)` - Recommended for the difference between two independent proportions.
*   **Wald with Continuity Correction:** `wald2ci(x1, n1, x2, n2, conf.level = 0.95, adjust = "cc")`.

### Paired Proportions (Dependent)
Use these for matched-pair data (e.g., before/after studies).

*   **Tango's Score Interval:** `score2ci(x12, x21, n, conf.level = 0.95)` - Where $x_{12}$ and $x_{21}$ are the off-diagonal counts in a 2x2 table.
*   **Agresti-Min Interval:** `min_diffscoreci(x12, x21, n, conf.level = 0.95)`.

## Usage Tips

1.  **Input Format:** Most functions require counts of successes ($x$) and total trials ($n$), not the proportion itself.
2.  **Coverage:** For small $n$, prefer `scoreci` or `add4ci` over the standard `prop.test` (Wald) to ensure the interval actually contains the true parameter at the specified confidence level.
3.  **Odds Ratios:** For confidence intervals for odds ratios or relative risks, check `orscoreci` and `riskscoreci`.

## Reference documentation

- [PropCIs README](./references/README.md)