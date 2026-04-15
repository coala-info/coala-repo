---
name: bioconductor-flowtrans
description: This package optimizes parameters for flow cytometry transformations using profile maximum likelihood to improve data normality. Use when user asks to transform flow cytometry data, optimize transformation parameters, or apply multivariate Box-Cox, ArcSinh, or biexponential transformations to flowFrame objects.
homepage: https://bioconductor.org/packages/release/bioc/html/flowTrans.html
---

# bioconductor-flowtrans

## Overview

The `flowTrans` package provides methods for optimizing parameters of common flow cytometry transformations. Unlike static transformations, `flowTrans` uses profile maximum likelihood to estimate parameters that make the data appear more normally distributed. This is particularly useful for high-throughput experiments where manual tuning of transformation parameters (like the 'w' in biexponential or 'a/b' in arcsinh) is impractical.

## Core Workflow

### 1. Loading Data and Package
The package operates on `flowFrame` objects from the `flowCore` ecosystem.

```r
library(flowTrans)
library(flowCore)
data(GvHD)
# Select a specific sample
fr <- GvHD[[1]]
```

### 2. Performing Optimization
The primary function is `flowTrans()`. It handles multiple dimensions simultaneously to tend toward a multivariate normal distribution.

**Available Transformation Functions (`fun` argument):**
- `mclMultivBoxCox`: Box-Cox transformation.
- `mclMultivArcSinh`: Inverse Hyperbolic Sine transformation.
- `mclMultivBiexp`: Biexponential transformation.
- `mclMultivLinLog`: Linear-Logarithmic transformation.

**Basic Usage:**
```r
# Transform FSC-H and SSC-H using ArcSinh
result <- flowTrans(dat = fr, 
                    fun = "mclMultivArcSinh", 
                    dims = c("FSC-H", "SSC-H"), 
                    n2f = FALSE, 
                    parameters.only = FALSE)

# Access the transformed flowFrame
transformed_fr <- result$result
```

### 3. Extracting Parameters
If you need to inspect the optimized parameters or apply them elsewhere:

```r
# Extract parameters for specific dimensions
params <- extractParams(result, dims = c("FSC-H", "SSC-H"))
print(params)
```

### 4. Integration with flowCore Workflows
If you only want the optimized parameters to use within a standard `flowCore` transformation workflow, set `parameters.only = TRUE`.

```r
opt_params <- flowTrans(dat = fr, 
                        fun = "mclMultivArcSinh", 
                        dims = c("FSC-H", "SSC-H"), 
                        parameters.only = TRUE)
```

## Tips and Best Practices

- **Dimensionality**: `flowTrans` is designed for multivariate optimization. It is most effective when transforming two or more dimensions that define specific cell populations.
- **n2f Parameter**: The `n2f` (norm2Filter) argument, if set to `TRUE`, can be used to pre-filter data, though typically `FALSE` is used for standard transformation tasks.
- **Visualization**: Always compare untransformed vs. transformed data using `plot()` and `contour()` to ensure the optimization has correctly resolved populations and reduced skewness.
- **List Processing**: When working with a `flowSet`, use `lapply` to transform individual frames, as the optimal parameters are data-dependent and will vary between samples.

## Reference documentation

- [flowTrans](./references/flowTrans.md)