---
name: rmath4
description: The rmath4 library provides R-compatible statistical distributions and mathematical routines optimized for use within Numba-compiled Python code. Use when user asks to perform statistical calculations in Numba, generate random samples using R's algorithms, or compute probability densities and quantiles with high numerical precision.
homepage: https://github.com/alex-wave/Rmath-python
---


# rmath4

## Overview

The `rmath4` library is a Python port of the standalone R math library (version 4). It provides a collection of C-based routines for statistical distributions and mathematical calculations that are identical to those found in the R programming language. Its primary advantage is its compatibility with Numba's `nopython` mode, allowing developers to use robust R statistical functions within compiled Python code without the overhead of the Python interpreter or the need to bridge to a full R session.

## Usage and Best Practices

### Installation
The library can be installed via pip or conda:
- **Pip**: `pip install Rmath4`
- **Conda**: `conda install bioconda::rmath4`

### Numba Integration
The most common use case for `rmath4` is within Numba-decorated functions. Because the library wraps the underlying C code of R's `nmath.h`, it can be called directly inside `@njit` (or `@jit(nopython=True)`) blocks.

```python
import Rmath4
from numba import njit

@njit
def calculate_density(x):
    # Example: Normal distribution density (dnorm)
    # Parameters: x, mean, sd, give_log (0 or 1)
    return Rmath4.dnorm(x, 0.0, 1.0, 0)
```

### Function Naming Convention
The library follows the standard R naming convention for probability distributions:
- **d[name]**: Density function (e.g., `dnorm`, `dgamma`)
- **p[name]**: Cumulative distribution function (e.g., `pnorm`, `pbeta`)
- **q[name]**: Quantile function (e.g., `qnorm`, `qchisq`)
- **r[name]**: Random number generation (e.g., `rnorm`, `rpois`)

### Key Parameters
- **Log Probabilities**: Most density and distribution functions include a final integer argument (usually `give_log` or `lower_tail`) to specify if the result should be returned on the log scale or if the lower/upper tail should be calculated.
- **Random Seed**: When using `r[name]` functions for random sampling, ensure you manage the random state appropriately if reproducibility is required, as these call the underlying C-level RNG.

### Performance Tips
- Use `rmath4` when you need the exact numerical precision and behavior of R's math library.
- Prefer `rmath4` over standard Python `math` or `scipy.stats` when working inside Numba loops, as it avoids the "object mode" fallback that occurs with many other libraries.

## Reference documentation
- [Rmath4-python GitHub](./references/github_com_DessimozLab_Rmath4-python.md)
- [Bioconda rmath4 Overview](./references/anaconda_org_channels_bioconda_packages_rmath4_overview.md)