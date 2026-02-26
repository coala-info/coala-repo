---
name: r-xnomial
description: This tool performs exact goodness-of-fit tests for multinomial data to determine if observed counts deviate from expected ratios. Use when user asks to perform exact multinomial tests, run Monte Carlo simulations for categorical data, or test genetic ratios like 9:3:3:1.
homepage: https://cran.r-project.org/web/packages/xnomial/index.html
---


# r-xnomial

name: r-xnomial
description: Perform exact goodness-of-fit tests for multinomial data with fixed probabilities. Use this skill when analyzing whether observed categorical counts deviate significantly from expected ratios (e.g., Mendelian genetic ratios like 9:3:3:1) using exact multinomial tests or Monte Carlo simulations instead of relying solely on asymptotic chi-square approximations.

## Overview

The `XNomial` package provides tools to test whether a set of observed counts fits a given expected ratio. It is particularly useful for small sample sizes where the standard chi-square test's asymptotic assumptions may not hold. It offers two primary methods:
1. **Exact Test (`xmulti`)**: Examines all possible outcomes to find the exact probability of an observation deviating from the expectation.
2. **Monte Carlo Test (`xmonte`)**: Uses a random sample of possible outcomes when the total number of combinations is too large to compute exactly.

Users can evaluate deviations using three statistics: the log-likelihood ratio (LLR), the multinomial probability, or the classic chi-square statistic.

## Installation

To install the package from CRAN:

```r
install.packages("XNomial")
```

## Usage

### Basic Workflow

1. **Define Data**: Create a vector of observed counts and a vector of expected ratios.
2. **Choose Method**: Use `xmulti()` for small total counts or `xmonte()` for large datasets.
3. **Interpret Results**: Review the p-values for the three test statistics (LLR, Prob, and Chisq).

### Exact Multinomial Test

Use `xmulti` when the number of possible outcomes is manageable.

```r
library(XNomial)

# Example: Testing a genetic cross expected to be 9:3:3:1
observed <- c(30, 12, 10, 2)
expected <- c(9, 3, 3, 1)

# Run the exact test
# detail = 1 prints a summary; outplot = 1 shows a histogram
result <- xmulti(observed, expected, detail = 1)
```

### Monte Carlo Simulation

Use `xmonte` when the total number of observations or categories makes the exact calculation computationally prohibitive.

```r
# Example: Large sample size where exact calculation is slow
obs_large <- c(100, 150, 50)
exp_large <- c(1, 1, 1)

# Run with 100,000 trials
result_mc <- xmonte(obs_large, exp_large, ntrials = 100000)
```

### Parameters and Options

- **`detail`**: 
  - `0`: No printed output.
  - `1`: (Default) Prints p-values for LLR, Probability, and Chi-square.
  - `2`: Prints all possible outcomes and their probabilities.
  - `3`: Includes the observed outcome in the detailed list.
- **`outplot`**:
  - `0`: No plot.
  - `1`: Histogram of the chosen statistic (default is LLR).
  - `2`: Comparison of the test statistic's distribution against the asymptotic chi-square curve.
- **`statName`**: Choose which statistic to use for the p-value calculation and plotting (`"llr"`, `"prob"`, or `"chisq"`).

### Tips

- **LLR vs Chi-square**: The log-likelihood ratio (LLR) is generally recommended over the chi-square statistic for multinomial data, though `XNomial` provides both.
- **Visualizing Fit**: Use `outplot = 2` to see how well the asymptotic chi-square distribution matches the exact distribution of your specific case. If they differ significantly, the exact test (or Monte Carlo) is necessary.

## Reference documentation

- [XNomial Home Page](./references/home_page.md)