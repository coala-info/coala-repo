---
name: scipy
description: SciPy provides efficient numerical routines for scientific computing tasks including optimization, statistics, signal processing, and linear algebra. Use when user asks to perform numerical integration, solve differential equations, optimize functions, analyze signals, or manipulate sparse matrices.
homepage: https://github.com/scipy/scipy
metadata:
  docker_image: "quay.io/biocontainers/scipy:1.1.0"
---

# scipy

## Overview

SciPy is the fundamental Python library for scientific computing, built to work seamlessly with NumPy arrays. It provides efficient numerical routines for a wide array of domains including linear algebra, sparse matrices, signal and image processing, and differential equation solvers. This skill helps agents select the correct submodule for specific mathematical tasks and provides the necessary commands for developers to interact with the SciPy source code, run benchmarks, and execute tests.

## Submodule Selection Guide

SciPy is organized into submodules based on functional areas. Use the following mapping to identify the correct tool for a task:

- **Optimization**: Use `scipy.optimize` for local and global optimization, root finding, and curve fitting.
- **Statistics**: Use `scipy.stats` for continuous and discrete distributions, summary statistics, and statistical tests.
- **Integration**: Use `scipy.integrate` for numerical integration (quadrature) and solving ordinary differential equations (ODEs).
- **Linear Algebra**: Use `scipy.linalg` for standard matrix operations. It is more comprehensive than `numpy.linalg`.
- **Signal Processing**: Use `scipy.signal` for filtering, windowing, and spectral analysis.
- **Sparse Matrices**: Use `scipy.sparse` for memory-efficient storage and linear algebra on large, mostly-empty matrices.
- **Interpolation**: Use `scipy.interpolate` for splines, radial basis functions, and multidimensional interpolation.
- **Special Functions**: Use `scipy.special` for mathematical functions like Gamma, Bessel, and Error functions.

## Development and CLI Patterns

SciPy uses the `spin` developer tool to manage common tasks. When working within the SciPy repository, use these patterns:

### Building and Testing
- **Build the library**: `spin build`
- **Run the full test suite**: `spin test`
- **Run tests for a specific submodule**: `spin test -s stats`
- **Run tests with a specific version of Python**: `spin test --python 3.11`

### Documentation and Benchmarking
- **Build HTML documentation**: `spin docs`
- **Run performance benchmarks**: `spin bench`
- **Open an interactive shell with SciPy imported**: `spin shell`

## Expert Tips and Best Practices

- **NumPy Integration**: Always ensure input data is converted to NumPy arrays before passing to SciPy functions to avoid overhead and compatibility issues.
- **Linalg Preference**: Prefer `scipy.linalg` over `numpy.linalg` as the SciPy version is always compiled with BLAS/LAPACK support and contains more advanced routines (e.g., Schur decomposition, Lu factorization).
- **Vectorization**: Leverage SciPy's built-in vectorization in submodules like `stats`. Many distribution methods (PDF, CDF) accept arrays and perform computations efficiently without explicit loops.
- **Sparse Matrix Choice**: Use `CSR` (Compressed Sparse Row) for fast arithmetic and matrix-vector products; use `LIL` (List of Lists) or `DOK` (Dictionary of Keys) for incremental construction of matrices.
- **Array API Support**: When working with GPU arrays (CuPy, PyTorch), check the "Array API" support status in the SciPy wiki, as many submodules are currently being migrated to support non-NumPy backends.

## Reference documentation
- [SciPy Main Repository](./references/github_com_scipy_scipy.md)
- [SciPy Wiki and Roadmap](./references/github_com_scipy_scipy_wiki.md)
- [Issue Tracker and Known Bugs](./references/github_com_scipy_scipy_issues.md)