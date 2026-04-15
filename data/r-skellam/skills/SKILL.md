---
name: r-skellam
description: This tool provides statistical functions for the Skellam distribution to model the difference between two independent Poisson random variables. Use when user asks to calculate probability mass, cumulative distribution, quantiles, or generate random samples for Skellam-distributed data.
homepage: https://cloud.r-project.org/web/packages/skellam/index.html
---

# r-skellam

name: r-skellam
description: Statistical functions for the Skellam distribution (the distribution of the difference of two independent Poisson random variables). Use this skill when you need to calculate densities (PMF), cumulative distribution functions (CDF), quantiles, or generate random samples for Skellam-distributed data in R.

# r-skellam

## Overview
The `skellam` package provides the standard suite of probability functions (d, p, q, r) for the Skellam distribution. This distribution is defined as the difference $Z = X - Y$, where $X \sim \text{Poisson}(\lambda_1)$ and $Y \sim \text{Poisson}(\lambda_2)$. It is commonly used in modeling sports scores, count data differences, and image processing.

## Installation
```R
install.packages("skellam")
library(skellam)
```

## Core Functions
All functions take `mu1` ($\lambda_1$) and `mu2` ($\lambda_2$) as the primary parameters.

- `dskellam(x, mu1, mu2, log = FALSE)`: Probability mass function.
- `pskellam(q, mu1, mu2, lower.tail = TRUE, log.p = FALSE)`: Cumulative distribution function.
- `qskellam(p, mu1, mu2, lower.tail = TRUE, log.p = FALSE)`: Quantile function.
- `rskellam(n, mu1, mu2)`: Random variate generation.
- `skellam.ell(x, mu1, mu2, log = FALSE)`: Log-likelihood function.

## Common Workflows

### Simulating Differences
To simulate the difference between two Poisson processes (e.g., goals scored by Team A vs Team B):
```R
# Team A avg 1.5, Team B avg 0.5
samples <- rskellam(1000, mu1 = 1.5, mu2 = 0.5)
hist(samples, breaks = seq(min(samples)-0.5, max(samples)+0.5, by=1))
```

### Calculating Probabilities
To find the probability that the difference is exactly zero:
```R
dskellam(0, mu1 = 1.5, mu2 = 0.5)
```

To find the probability that the difference is greater than 2:
```R
pskellam(2, mu1 = 1.5, mu2 = 0.5, lower.tail = FALSE)
```

### Finding Quantiles
To find the 95th percentile of the distribution:
```R
qskellam(0.95, mu1 = 12, mu2 = 8)
```

## Usage Tips
- **Parameter Interpretation**: `mu1` is the mean of the first Poisson variable (positive component) and `mu2` is the mean of the second (negative component).
- **Integer Support**: The Skellam distribution is defined over all integers (..., -2, -1, 0, 1, 2, ...).
- **Large Parameters**: The package handles large values of $\lambda$ efficiently, where the distribution begins to approximate a Normal distribution $N(\mu_1 - \mu_2, \mu_1 + \mu_2)$.

## Reference documentation
- [The Skellam Distribution](./references/validate_skellam.Rmd)