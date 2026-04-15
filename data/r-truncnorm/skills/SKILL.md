---
name: r-truncnorm
description: This tool provides functions for calculating the density, probability, quantiles, and random generation for the truncated normal distribution. Use when user asks to generate random samples within a specific range, calculate probabilities for bounded normal variables, or determine moments of a truncated normal distribution.
homepage: https://cloud.r-project.org/web/packages/truncnorm/index.html
---

# r-truncnorm

name: r-truncnorm
description: Provides functions for the truncated normal distribution, including density (dtruncnorm), probability (ptruncnorm), quantiles (qtruncnorm), and random generation (rtruncnorm). Use this skill when a user needs to model variables that follow a normal distribution but are restricted within a specific range [a, b], or when performing truncated regression and Bayesian inference involving truncated priors.

# r-truncnorm

## Overview
The `truncnorm` package provides efficient tools for working with the truncated normal distribution $N(\mu, \sigma^2)$ restricted to the interval $[a, b]$. It is particularly useful because standard normal distribution functions in R do not account for the renormalization required when bounds are applied.

## Installation
To install the package from CRAN:
```R
install.packages("truncnorm")
```

## Core Functions
All functions follow the standard R distribution naming convention: `[dpqr]truncnorm`.

- `dtruncnorm(x, a=-Inf, b=Inf, mean=0, sd=1)`: Density function.
- `ptruncnorm(q, a=-Inf, b=Inf, mean=0, sd=1)`: Distribution function.
- `qtruncnorm(p, a=-Inf, b=Inf, mean=0, sd=1)`: Quantile function.
- `rtruncnorm(n, a=-Inf, b=Inf, mean=0, sd=1)`: Random generation.
- `etruncnorm(a=-Inf, b=Inf, mean=0, sd=1)`: Expected value (mean) of the truncated distribution.
- `vtruncnorm(a=-Inf, b=Inf, mean=0, sd=1)`: Variance of the truncated distribution.

## Usage Workflows

### Random Sampling
Generate 1000 samples from a normal distribution with mean 50 and SD 10, truncated between 45 and 55:
```R
library(truncnorm)
samples <- rtruncnorm(n = 1000, a = 45, b = 55, mean = 50, sd = 10)
hist(samples)
```

### Calculating Probabilities
Find the probability that a value is less than 60 given a distribution truncated at [50, 100]:
```R
# Probability P(X <= 60 | 50 <= X <= 100)
prob <- ptruncnorm(60, a = 50, b = 100, mean = 70, sd = 15)
```

### Moments
Calculate the theoretical mean and variance of a truncated normal distribution:
```R
m <- etruncnorm(a = 0, b = 10, mean = 2, sd = 5)
v <- vtruncnorm(a = 0, b = 10, mean = 2, sd = 5)
```

## Tips and Best Practices
- **Infinite Bounds**: Use `-Inf` or `Inf` for one-sided truncation (e.g., `a = 0, b = Inf` for a distribution truncated only at the bottom).
- **Vectorization**: All functions are vectorized over their arguments, allowing for different means, SDs, or bounds for each observation.
- **Efficiency**: `rtruncnorm` uses a specialized rejection sampling algorithm that is significantly faster and more stable than naive inverse transform sampling, especially in the tails.

## Reference documentation
- [truncnorm README](./references/README.md)