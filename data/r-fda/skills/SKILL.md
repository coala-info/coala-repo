---
name: r-fda
description: This tool provides expert assistance for Functional Data Analysis in R using the fda package to represent and analyze data as continuous functions. Use when user asks to create basis systems, convert raw data into functional objects, smooth noisy data, perform functional registration, or implement monotone smoothing.
homepage: https://cloud.r-project.org/web/packages/fda/index.html
---


# r-fda

name: r-fda
description: Expert assistance for Functional Data Analysis (FDA) using the 'fda' R package. Use this skill when you need to represent, smooth, and analyze data that varies over a continuum (time, space, etc.). It provides guidance on creating basis systems (B-splines, Fourier), converting raw data into functional data objects (fd), performing functional registration, and implementing specialized techniques like monotone smoothing.

## Overview

The `fda` package implements the methods described by Ramsay and Silverman for Functional Data Analysis. Instead of treating data as a sequence of discrete points, FDA treats data as continuous functions. This skill helps you navigate the workflow of defining basis functions, fitting functional objects, and performing functional calculus or registration.

## Installation

To install the package from CRAN:

```r
install.packages("fda")
library(fda)
```

## Core Workflow

### 1. Define a Basis System
Choose a basis based on the nature of your data (e.g., Fourier for periodic data, B-splines for non-periodic data).

```r
# B-spline basis: range, number of basis functions, and order (default is 4)
basis_obj <- create.bspline.basis(rangeval = c(0, 10), nbasis = 10, norder = 4)

# Fourier basis: range, number of basis functions, and period
fourier_obj <- create.fourier.basis(rangeval = c(0, 1), nbasis = 7, period = 1)
```

### 2. Create Functional Data Objects (fd)
Convert coefficients or raw data into an `fd` object.

```r
# From coefficients
coefs <- matrix(rnorm(10), 10, 1)
fd_obj <- fd(coefs, basis_obj)

# Plotting functional data
plot(fd_obj)
```

### 3. Smoothing Raw Data
Use `smooth.basis` to convert noisy discrete observations into smooth functions.

```r
argvals <- seq(0, 10, length.out = 50)
y_data <- sin(argvals) + rnorm(50, 0, 0.1)

# Smooth the data
smooth_list <- smooth.basis(argvals, y_data, basis_obj)
fd_smooth <- smooth_list$fd
```

## Advanced Techniques

### Monotone Smoothing
For data that must strictly increase (e.g., growth curves), use `smooth.monotone`. This transforms an unconstrained function $W(x)$ into a monotone function $h(x) = \int \exp(W(u)) du$.

```r
# Example: smooth.monotone(argvals, y_data, basis_obj)
# Use smooth.morph() if the function must end at a specific value (like a CDF).
```

### Functional Registration
If features (like peaks) occur at different times across samples, use `register.fd` to align them.

## Tips for Success
- **Order vs. Degree**: In `fda`, `norder` is the number of coefficients (degree + 1). A cubic spline has `norder = 4`.
- **Knots**: By default, `create.bspline.basis` places knots equally spaced. You can provide custom breakpoints using the `breaks` argument.
- **Derivatives**: Use `eval.fd(evalarg, fdobj, Lfdobj = 1)` to evaluate the first derivative of a functional object.

## Reference documentation

- [The Basics of Basis Functions](./references/BasisBasics.Rmd)
- [Monotone Functions](./references/monotoneFunctions.Rmd)
- [Spline Functions](./references/splineFunctions.Rmd)