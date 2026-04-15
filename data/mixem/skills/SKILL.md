---
name: mixem
description: mixem is a Python library for fitting mixture models using the Expectation-Maximization algorithm. Use when user asks to estimate parameters of multiple probability distributions, fit mixture models to a dataset, or find maximum likelihood estimates using the EM algorithm.
homepage: https://github.com/sseemayer/mixem
metadata:
  docker_image: "quay.io/biocontainers/mixem:0.1.4--pyh5e36f6f_0"
---

# mixem

## Overview
mixem is a lightweight, pure-Python library designed to simplify the process of fitting mixture models using the Expectation-Maximization algorithm. You should use this skill to estimate the parameters of multiple probability distributions and their respective weights within a single dataset. It is particularly effective for researchers and developers who need a NumPy/SciPy-compatible tool that supports both standard and custom probability distributions without the overhead of larger machine learning frameworks.

## Usage Guidelines

### Core Workflow
To use mixem effectively, follow this procedural sequence:
1. **Data Preparation**: Ensure your data is in a NumPy array format.
2. **Distribution Selection**: Identify the component distributions (e.g., `NormalDistribution`, `LogNormalDistribution`, `GeometricDistribution`, `MultivariateNormalDistribution`, or `VMFDistribution`).
3. **Initialization**: Define the initial parameters for each distribution and the starting weights for the mixture.
4. **Execution**: Run the EM algorithm using the `mixem.em` function to find the maximum likelihood estimates.

### Implementation Patterns
* **Numerical Stability**: Always prefer using the built-in log-probability density functions (log-PDF) provided by the library. mixem is refactored to use `logsumexp` for better numerical stability when dealing with very small probabilities.
* **Custom Distributions**: If the built-in distributions do not fit your data, you can define a custom distribution by implementing:
    * A probability density function (PDF).
    * A weighted log-likelihood function.
* **Handling Multivariate Data**: For multi-dimensional datasets, use `mixem.distribution.MultivariateNormalDistribution` and ensure your input data shape matches the expected dimensionality of the covariance matrix.

### Expert Tips
* **Initial Estimates**: The EM algorithm is sensitive to initial parameters. Use simple heuristics (like the mean and variance of the whole dataset) or a quick K-Means pass to set better starting points for the distribution parameters.
* **Convergence Monitoring**: Monitor the log-likelihood values returned by the EM process to ensure the model has converged to a stable solution.
* **Visualization**: After fitting, use the estimated weights and parameters to plot the individual component densities against a histogram of the raw data to verify the fit quality.

## Reference documentation
- [mixem - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mixem_overview.md)
- [GitHub - sseemayer/mixem: Pythonic Expectation-Maximization (EM) implementation](./references/github_com_sseemayer_mixem.md)