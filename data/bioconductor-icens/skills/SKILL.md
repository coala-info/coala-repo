---
name: bioconductor-icens
description: This tool computes the Nonparametric Maximum Likelihood Estimator for censored and truncated data using various optimization algorithms and intersection graph analysis. Use when user asks to estimate distribution functions for interval-censored data, perform bivariate censored data analysis, or visualize survival data using NPMLE.
homepage: https://bioconductor.org/packages/release/bioc/html/Icens.html
---


# bioconductor-icens

name: bioconductor-icens
description: Nonparametric Maximum Likelihood Estimation (NPMLE) for censored and truncated data. Use this skill when analyzing survival data that is interval-censored, doubly-censored, or bivariate-censored. It provides multiple optimization algorithms (EM, ICM, PGM, VEM, ISDM) to estimate the distribution function and tools for intersection graph analysis of censored intervals.

## Overview
The `Icens` package provides a suite of algorithms to compute the Nonparametric Maximum Likelihood Estimator (NPMLE) for various types of censored data. It is particularly strong in handling interval-censored data by representing the problem using intersection graphs and maximal cliques. The package supports both univariate and bivariate censored data, offering specialized plotting functions for each.

## Core Workflow

### 1. Data Preparation
Data should typically be in a matrix or data frame format where rows represent observations and columns represent the left (L) and right (R) endpoints of the censoring interval.
- For univariate data: An $n \times 2$ matrix.
- For bivariate data: An $n \times 4$ matrix (e.g., `cmvL`, `cmvR`, `macL`, `macR`).

### 2. Computing the NPMLE
Choose an algorithm based on the data complexity and convergence requirements. Most functions accept either the raw interval matrix or a pre-computed clique matrix.

- **EMICM**: Generally recommended as a fast hybrid of the Expectation-Maximization and Iterative Convex Minorant algorithms.
  ```r
  library(Icens)
  data(cosmesis)
  # Subset for radiotherapy group
  csub <- subset(cosmesis, subset = Trt == 0, select = c(L, R))
  fit <- EMICM(csub)
  ```
- **EM**: The standard Expectation-Maximization algorithm. Reliable but can be slow to converge.
- **VEM**: Vertex Exchange Method, often used in optimal design theory.
- **PGM**: Projected Gradient Method.
- **ISDM**: Iterative Smoothing-Differentiation Method.

### 3. Bivariate Analysis
For bivariate censored data (like the `cmv` or `hiv` datasets), use the `BV` family of functions to find maximal cliques and support.
```r
data(cmv)
# Find bivariate cliques
cliques <- BVcliques(cmv[,1:2], cmv[,3:4])
# Compute support regions for those cliques
support <- BVsupport(cmv[,1:2], cmv[,3:4], cliques)
```

### 4. Visualization
- **Univariate**: Use the S3 `plot` method for `icsurv` objects.
  ```r
  plot(fit, main = "NPMLE for Cosmesis Data", xlab = "Months", ylab = "Survival")
  ```
- **Bivariate**: Use `Plotboxes` to visualize the intersection of event regions.
  ```r
  Plotboxes(cmv[,1:2], cmv[,3:4], showmac = TRUE)
  ```

## Key Functions and Classes
- **icsurv**: The class returned by estimation routines. Contains `pf` (probability vector), `converge` (boolean), and `intmap` (real representation of support).
- **Maclist / Macmat**: Functions to compute maximal cliques and the incidence (clique) matrix from interval data.
- **MLEintvl**: Computes the real-line intervals corresponding to the maximal cliques where the NPMLE places mass.

## Tips and Best Practices
- **Convergence**: If an algorithm fails to converge, try increasing `maxiter` or switching to `EMICM` or `ISDM`.
- **Interval Types**: Ensure you know if your intervals are open or closed. Functions like `Maclist` and `BVcliques` allow you to specify `Lopen` and `Ropen` arguments.
- **Internal Data**: The package includes several classic datasets for practice: `cosmesis` (univariate), `cmv` (bivariate), `hiv` (doubly-censored), and `pruitt` (artificial bivariate).

## Reference documentation
- [Icens Reference Manual](./references/reference_manual.md)