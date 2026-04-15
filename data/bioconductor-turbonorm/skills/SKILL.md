---
name: bioconductor-turbonorm
description: TurboNorm performs fast microarray normalization and scatterplot smoothing using piecewise constant P-splines. Use when user asks to normalize single-colour or two-colour microarray data, perform weighted smoothing on DNA methylation data, or fit fast P-splines to large datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/TurboNorm.html
---

# bioconductor-turbonorm

name: bioconductor-turbonorm
description: Fast scatterplot smoothing and microarray normalization using piecewise constant P-splines. Use this skill to normalize single-colour (Affymetrix) or two-colour (limma/marray) microarray data, as well as array-based DNA methylation data, especially when computational speed or weighted smoothing is required.

# bioconductor-turbonorm

## Overview
TurboNorm provides an efficient implementation of P-splines (penalized B-splines) for normalizing microarray data. It is significantly faster than traditional loess-based normalization because it uses piecewise constant basis functions, which simplifies the underlying linear systems to diagonal matrices. It is particularly effective for large datasets and experiments where specific probes (e.g., invariant sets in methylation studies) require differential weighting.

## Core Functions

### turbotrend()
The primary engine for fitting a smooth curve to scatterplot data.
- `turbotrend(x, y, n = 15, method = "original")`: Fits a P-spline to the data.
- `n`: Number of bins (basis functions).
- `method`: "original" for standard P-splines or "weighted" for weighted fits.
- Returns an object with effective degrees of freedom, optimized penalty ($\lambda$), and GCV error.

### pspline()
Normalization for two-colour microarray data.
- Supports `RGList` (from `limma`) and `MarrayRaw` (from `marray`) objects.
- `pspline(object, showArrays = NULL)`: Automatically detects the object type and returns a normalized `MAList` or `MarrayNorm` object.
- Use `showArrays = index` to visualize the fit on a specific array.

### Single-Colour Normalization
Wrappers for Affymetrix data that mirror `affy` package functionality:
- `normalize.pspline(data)`: Normalizes a data matrix.
- `normalize.AffyBatch.pspline(abatch)`: Normalizes an `AffyBatch` object.

### panel.pspline()
A lattice-compatible panel function for adding P-spline curves to multipanel plots.
- `panel.pspline(x, y, weights = NULL, ...)`

## Typical Workflows

### Two-Colour Normalization
```R
library(TurboNorm)
library(limma)

# Assuming 'rg' is an RGList object
# Perform P-spline normalization
ma_norm <- pspline(rg)

# Visualize the fit for the first array
pspline(rg, showArrays = 1)
```

### Weighted Normalization (e.g., Methylation Data)
Useful when a subset of probes (invariant set) should guide the normalization.
```R
# Create weights: 1 for regular probes, higher for invariant probes
weights <- rep(1, nrow(methylation))
weights[invariant_indices] <- 250 

# Use in a lattice plot
library(lattice)
xyplot(M ~ A | Array, data = df,
       panel = function(x, y, ...) {
           panel.xyplot(x, y, col="grey")
           panel.pspline(x, y, weights = weights, col="red")
       })
```

## Tips for Usage
- **Speed**: Use TurboNorm as a drop-in replacement for `loess` when dealing with very large arrays where `limma::normalizeWithinArrays(method="loess")` is too slow.
- **Binning**: The `n` parameter in `turbotrend` controls the number of bins. While 15-30 is often sufficient for microarray data, you can increase it for more complex underlying genomic architectures.
- **Robustness**: The package handles outliers well, but for extremely noisy data, check the GCV (Generalized Cross-Validation) value in the `turbotrend` output to ensure the penalty parameter was optimized correctly.

## Reference documentation
- [TurboNorm: A fast scatterplot smoother with applications for microarray normalization](./references/turbonorm.md)