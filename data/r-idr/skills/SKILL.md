---
name: r-idr
description: The idr package implements the Irreproducible Discovery Rate framework to measure consistency and reproducibility between replicates in high-throughput experiments. Use when user asks to measure consistency between replicates, estimate parameters of a copula mixture model, compute local or global IDR for genomic features, or plot correspondence curves.
homepage: https://cloud.r-project.org/web/packages/idr/index.html
---

# r-idr

## Overview
The `idr` package implements the Irreproducible Discovery Rate (IDR) framework to measure the consistency between replicates in high-throughput experiments. It uses a copula mixture model to distinguish between a reproducible component (where signals are highly correlated) and an irreproducible component (where signals are independent). This is the standard method for determining thresholds in genomic pipelines to ensure findings are robust across replicates.

## Installation
To install the package from CRAN:
```R
install.packages("idr")
```

## Core Workflow
The typical IDR analysis follows these steps:

1. **Data Preparation**: Create a matrix where each column represents a replicate and each row represents a common feature (e.g., a peak). Values should be scores (p-values, signal intensity, etc.).
2. **Parameter Estimation**: Use `est.IDR` to fit the mixture model.
3. **IDR Calculation**: Use `get.IDR` to compute the local and global IDR for each feature.
4. **Visualization**: Use `show.idr` to plot correspondence curves.

## Main Functions

### est.IDR
Estimates the parameters of the copula mixture model.
```R
# x: matrix of observations (n by m, n features, m replicates)
# mu: starting value for the mean of the reproducible component
# sigma: starting value for the standard deviation
# rho: starting value for the correlation coefficient
# p: starting value for the proportion of reproducible component
est.IDR(x, mu, sigma, rho, p, eps=1e-6, max.ite=30)
```

### get.IDR
Computes the IDR for each observation based on the estimated parameters.
```R
# x: matrix of observations
# est.param: output object from est.IDR
get.IDR(x, est.param)
```
The output contains:
- `idr`: Local IDR (probability that a specific observation is irreproducible).
- `IDR`: Global IDR (expected fraction of irreproducible discoveries among those as or more significant than the current one).

### show.idr
Plots the correspondence curve to visualize the consistency between two replicates.
```R
# idr.out: output from get.IDR
show.idr(idr.out, ...)
```

## Usage Tips
- **Ranking**: IDR is rank-based. If your input data are p-values or scores, ensure they are transformed or handled such that smaller values represent higher significance if that is what the model expects (usually the package handles the ranking internally from the raw scores).
- **Starting Values**: The EM algorithm is sensitive to starting values. Common defaults are `mu=2`, `sigma=1`, `rho=0.9`, and `p=0.5`.
- **Multiple Replicates**: While originally designed for pairs, the model can be extended to multiple replicates by providing a matrix with more than two columns to `est.IDR`.

## Reference documentation
- [idr: Irreproducible Discovery Rate](./references/home_page.md)