---
name: qglmm
description: The qglmm package provides a high-performance implementation of Penalized Quasi-Likelihood for fitting generalized linear mixed models to binomial genomic data. Use when user asks to fit GLMMs for allele counts, account for population structure or kinship in genomic studies, and estimate heritability or fixed-effect coefficients using PQL.
homepage: https://github.com/mokar2001/qglmm
---


# qglmm

## Overview
The `qglmm` package (also referred to as `PQLseqPy`) provides a high-performance Python implementation of Penalized Quasi-Likelihood (PQL) for binomial data. It is optimized for genomic studies where observations consist of allele counts—either from individuals or pooled samples—and requires accounting for complex relatedness or population structure through a random-effects covariance matrix. It offers significant speed and numerical stability improvements over traditional PQL implementations.

## Core Workflow
To use `qglmm`, you must prepare three primary inputs as NumPy arrays:
1.  **X (Covariates)**: An $(n, k)$ matrix where the first column is typically ones for the intercept.
2.  **Y (Allele Counts)**: An $(n, 2)$ matrix where column 0 is the alternative allele count and column 1 is the reference allele count.
3.  **K (Structure Matrix)**: An $(n, n)$ matrix representing the random-effect covariance (e.g., a Kinship or Relatedness matrix).

### Basic Implementation
```python
import numpy as np
from PQLseqPy import GLMM

# Initialize the model
# X: covariates, Y: [alt, ref] counts, K: relatedness matrix
model = GLMM(X, Y, K)

# Fit the model
res = model.fit()

# Retrieve results
# param: convergence status and variance components (tau1, tau2)
# coef: fixed-effect estimates (beta), SE, and p-values
param, coef = res.summary()
```

## Expert Tips and Best Practices
- **Handling Numerical Instability**: If the model fails to converge or produces matrix inversion errors, increase the `regularization_factor` (e.g., `1e-6`) to add a small value to the diagonal of the covariance matrix.
- **Constraining Variance**: To test a model without an independent error term (identity matrix), set `tau2_set_to_zero=True`. This forces the model to only estimate the variance component associated with the structure matrix `K`.
- **Fixed Variance Components**: If you already know the variance components (tau1, tau2) from a null model, pass them to `fixed_tau=(tau1, tau2)` to update only the fixed-effect coefficients ($\beta$) without re-estimating the variance.
- **Convergence Tuning**: For difficult datasets, adjust `starting_step_size` (default 1) or increase `max_iter` (default 200).
- **Interpreting Results**:
    - `h2` (Heritability): Calculated as $\tau_1 / (\tau_1 + \tau_2)$.
    - `p_beta`: Two-sided p-values derived from Wald statistics ($z^2 \sim \chi^2_1$).
    - `variance_model`: Check this attribute to see if the model converged to a specific boundary (e.g., `tau1>0, tau2=0`).

## Reference documentation
- [PQLseqPy GitHub Documentation](./references/github_com_mokar2001_PQLseqPy.md)