---
name: pqlseqpy
description: pqlseqpy is a high-performance Python implementation of the Penalized Quasi-Likelihood method for modeling binomial count data in population genetics. Use when user asks to estimate fixed-effect coefficients, model allele frequencies with latent random effects, or account for population structure using relatedness matrices.
homepage: https://github.com/mokar2001/PQLseqPy
metadata:
  docker_image: "quay.io/biocontainers/pqlseqpy:0.1.2--pyh7e72e81_0"
---

# pqlseqpy

## Overview

pqlseqpy is a high-performance Python implementation of the Penalized Quasi-Likelihood method designed for binomial count data. It is specifically optimized for population genetics, where it models allele frequencies through a logit link function while integrating out latent random effects. Use this skill to estimate fixed-effect coefficients and variance components in datasets where observations may be correlated due to shared ancestry or population structure. It provides significant improvements in numerical stability and speed over traditional implementations.

## Core Usage Pattern

The primary interface is the `GLMM` class. The workflow involves preparing NumPy arrays for covariates, counts, and structure, then fitting the model.

```python
import numpy as np
from PQLseqPy import GLMM

# 1. Prepare Data
# X: (n_samples, n_covariates) - First column must be ones for intercept
# Y: (n_samples, 2) - [alternative_counts, reference_counts]
# K: (n_samples, n_samples) - Relatedness/Structure matrix

# 2. Initialize and Fit
model = GLMM(X, Y, K)
res = model.fit()

# 3. Extract Results
# param: Series containing convergence status and variance components
# coef: DataFrame containing beta, SE, z-score, and p-values
param, coef = res.summary()
```

## Parameter Tuning and Best Practices

### Numerical Stability
If the model fails to converge or encounters singular matrices, use the `regularization_factor`. This adds a small value to the diagonal during matrix inversions.
```python
res = GLMM(X, Y, K, regularization_factor=1e-6).fit()
```

### Variance Component Constraints
By default, the model estimates two variance components: `tau1` (associated with matrix `K`) and `tau2` (associated with the identity matrix `I`).
- **Enforce tau2 = 0**: Use `tau2_set_to_zero=True` to assume no independent residual variance beyond the structure provided by `K`.
- **Fixed Variance**: Pass a tuple `(tau1, tau2)` to `fixed_tau` to estimate only the fixed effects (`beta`) while holding the variance structure constant.

### Convergence Control
For complex datasets, adjust the iteration parameters:
- `error_tolerance`: Default is `1e-5`. Tighten for higher precision or loosen if convergence is difficult.
- `max_iter`: Default is `200`. Increase for models with many covariates or weak signals.
- `starting_step_size`: Adjust the initial step for Average Information (AI) updates.

## Data Requirements
- **Intercept**: The covariate matrix `X` does not automatically add an intercept. You must manually prepend a column of ones: `X = np.hstack([np.ones((n, 1)), covariates])`.
- **Counts**: `Y` must be a 2D array of integers. The total "library size" or total allele count per row is calculated internally as the sum of the two columns.
- **Structure Matrix**: `K` should be a symmetric positive semi-definite matrix representing the covariance structure (e.g., a Genetic Relatedness Matrix).

## Reference documentation
- [PQLseqPy GitHub Repository](./references/github_com_mokar2001_PQLseqPy.md)
- [PQLseqPy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pqlseqpy_overview.md)