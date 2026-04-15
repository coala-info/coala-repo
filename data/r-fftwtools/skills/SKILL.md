---
name: r-fftwtools
description: The r-fftwtools package provides a fast R wrapper for the FFTW3 library to perform efficient one-dimensional and multi-dimensional Fourier transforms. Use when user asks to compute fast Fourier transforms, perform multivariate or multidimensional transforms, or optimize real-valued data processing in R.
homepage: https://cloud.r-project.org/web/packages/fftwtools/index.html
---

# r-fftwtools

## Overview
The `fftwtools` package provides a fast R wrapper for the FFTW3 (Fastest Fourier Transform in the West) library. It is designed to be a drop-in replacement for R's native `fft()` and `mvfft()` functions while offering superior speed for large data sizes and specialized options for real-valued data.

## Installation
To install the package from CRAN:
```R
install.packages("fftwtools")
library(fftwtools)
```

## Core Functions
The package provides functions that mimic standard R behavior but utilize the FFTW backend:

- `fftw(data, inverse = FALSE, HermConj = TRUE)`: 1D Fourier Transform.
- `mvfftw(data, inverse = FALSE, HermConj = TRUE)`: Multivariate Fourier Transform (for matrices).
- `fftw2d(data, inverse = FALSE, HermConj = TRUE)`: 2D Fourier Transform.
- `fftw3d(data, inverse = FALSE, HermConj = TRUE)`: 3D Fourier Transform.

## Key Workflows

### 1. Basic Replacement of R's fft
For large datasets (typically $2^{18}$ points or more), `fftw` significantly outperforms `fft`.
```R
# Standard usage
res <- fftw(my_vector)

# Inverse transform
res_inv <- fftw(res, inverse = TRUE)
```

### 2. Optimizing Real Data Transforms
When input data is real (not complex), the Fourier transform is Hermitian symmetric. You can save memory and computation time by setting `HermConj = FALSE`.
```R
# Returns only the non-redundant part of the complex result
res_compact <- fftw(real_vector, HermConj = FALSE)
```
*Note: If you discard the complex conjugate, you must track the original data length to perform an accurate inverse transform later.*

### 3. Global Override (Session-wide)
To use `fftwtools` in existing code without rewriting function calls, you can mask the default R functions:
```R
fft <- function(z, inverse = FALSE) fftwtools::fftw(z, inverse = inverse)
mvfft <- function(z, inverse = FALSE) fftwtools::mvfftw(z, inverse = inverse)

# To revert back to base R:
rm(fft, mvfft)
```

## Performance Tips
- **Data Size**: The speed advantage of `fftwtools` is most apparent with large vectors (e.g., $2^{20}$ points). For very small vectors, base R may be faster due to lower overhead.
- **Memory**: Setting `HermConj = FALSE` reduces memory allocation, which is often the primary bottleneck in large-scale signal processing.
- **Multivariate Data**: Use `mvfftw` for matrices where each column represents a separate signal to be transformed.

## Reference documentation
- [FFTWTOOLS Timing and Simple Use](./references/testTimeAndSimpleUse.md)