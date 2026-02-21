---
name: r-diptest
description: "Compute Hartigan's dip test statistic for unimodality /  multimodality and provide a test with simulation based p-values,  where  the original public code has been corrected.</p>"
homepage: https://cloud.r-project.org/web/packages/diptest/index.html
---

# r-diptest

name: r-diptest
description: Compute Hartigan's dip test statistic for unimodality/multimodality. Use this skill when you need to test if a numeric dataset is unimodal or contains multiple modes (multimodality), specifically using the corrected Hartigan's dip algorithm.

# r-diptest

## Overview
The `diptest` package provides functions to compute the dip statistic $D_n$, which measures the maximum difference between the empirical distribution function and the unimodal distribution function that minimizes that maximum difference. A significant dip value indicates multimodality.

## Installation
```R
install.packages("diptest")
```

## Main Functions

### dip.test()
The primary function for performing the test. It returns a `htest` object containing the statistic and a p-value based on linear interpolation of a large-scale simulation table.

```R
library(diptest)

# Test a numeric vector
data(statfaculty)
result <- dip.test(statfaculty)

# View results
print(result)
# result$statistic (the dip D_n)
# result$p.value
```

### dip()
Computes only the dip statistic $D_n$ without the p-value. This is faster for simulations or bootstrapping.

```R
x <- runif(100)
d <- dip(x)
```

## Workflows

### Basic Multimodality Testing
1. Visualize the data first (histogram or density plot).
2. Run `dip.test()`.
3. Interpret the p-value:
   - $p < 0.05$: Reject the null hypothesis of unimodality (suggests multimodality).
   - $p \ge 0.05$: Fail to reject unimodality (data is consistent with a single mode).

```R
# Example with bimodal data
bimodal_data <- c(rnorm(100, mean = 0), rnorm(100, mean = 5))
plot(density(bimodal_data))
dip.test(bimodal_data)
```

### Manual P-value Simulation
If the built-in table is insufficient or you want to verify the p-value for a specific sample size $n$:

```R
n <- length(my_data)
obs_dip <- dip(my_data)
# Simulate dip distribution under the null (Uniform [0,1])
null_dips <- replicate(10000, dip(runif(n)))
p_val <- mean(null_dips >= obs_dip)
```

## Tips and Technical Details
- **Null Hypothesis**: The test assumes the null hypothesis is a unimodal distribution. Following Hartigan, the Uniform distribution $U[0,1]$ is used as the reference for p-value calculation.
- **Sample Size**: The dip statistic $D_n$ is sensitive to sample size. The package uses an internal table `qDiptab` (based on $10^6$ simulations) to interpolate p-values for various $n$.
- **Minimum Value**: The minimum possible value of the dip statistic is $1/(2n)$.
- **Maximum Value**: The maximum possible value is $0.25$ (achieved by a bi-point mass with equal weight).
- **Data Types**: The input must be a numeric vector. Missing values (NAs) are generally not handled by the underlying Fortran code; clean data before testing.

## Reference documentation
- [Dip Test Distributions, P-values, and other Explorations](./references/diptest-issues.md)