---
name: r-compquadform
description: This tool computes the distribution function of quadratic forms in normal variables, specifically weighted sums of chi-square distributions. Use when user asks to calculate p-values for quadratic forms, compute the cumulative distribution function of linear combinations of chi-square variables, or evaluate statistical tests like goodness-of-fit and genomic association studies.
homepage: https://cran.r-project.org/web/packages/compquadform/index.html
---

# r-compquadform

name: r-compquadform
description: Computing the distribution function of quadratic forms in normal variables. Use this skill when you need to calculate the cumulative distribution function (CDF) of a linear combination of chi-square random variables, which arises in various statistical tests (e.g., goodness-of-fit, genomic association studies).

# r-compquadform

## Overview
The `compquadform` package provides several numerical algorithms to compute the distribution function of a quadratic form $Q = \sum_{i=1}^n \lambda_i X_i + \delta$, where $X_i$ are independent non-central chi-square variables. This is essential for calculating p-values in statistics where the test statistic follows a weighted sum of chi-square distributions.

## Installation
```R
install.packages("CompQuadForm")
```

## Main Functions
The package provides four primary algorithms, each with different strengths regarding speed and precision:

- `imhof()`: Imhof's method. Numerical integration of the characteristic function. Generally stable and accurate.
- `davies()`: Davies's algorithm. Similar to Imhof but uses a different integration strategy. Handles non-centrality parameters.
- `farebrother()`: Rubinfeld-Farebrother algorithm (Ruben's method). Uses an infinite series of central chi-square distributions. Efficient for specific parameter ranges.
- `liu()`: Liu et al.'s method. A four-moment matching approximation. Very fast but less precise than the exact methods above.

## Common Workflow
To compute $P(Q > q)$ for a weighted sum of chi-square variables:

1. **Define Parameters**:
   - `q`: The value (threshold) at which to evaluate the distribution.
   - `lambda`: Vector of weights for the chi-square variables.
   - `h`: Vector of degrees of freedom for each chi-square variable (default is 1).
   - `delta`: Vector of non-centrality parameters (default is 0).

2. **Execute Calculation**:
```R
library(CompQuadForm)

# Example: P(0.5*X1^2 + 0.3*X2^2 + 0.2*X3^2 > 1.5)
lambdas <- c(0.5, 0.3, 0.2)
res <- imhof(q = 1.5, lambda = lambdas)

# Access the probability
print(res$Qq)
```

## Tips and Selection Guidance
- **Accuracy**: `imhof`, `davies`, and `farebrother` are considered "exact" methods (within numerical tolerance). `liu` is an approximation.
- **Non-centrality**: If your quadratic form involves non-central chi-square variables, ensure you provide the `delta` parameter to `davies` or `farebrother`.
- **Convergence**: If one method fails to converge or returns an error (e.g., `ifault` code), try another. `imhof` is often the most robust for general cases.
- **Output Structure**: Most functions return a list containing:
  - `Qq`: The calculated probability $P(Q > q)$.
  - `ifault`: Error code (0 indicates success).
  - `trace`: Numerical details of the integration/summation.

## Reference documentation
- [CompQuadForm Home Page](./references/home_page.md)