---
name: numpy
description: NumPy provides a powerful N-dimensional array object and high-performance functions for vectorized numerical operations and scientific computing in Python. Use when user asks to perform complex mathematical operations, design memory-efficient data pipelines, manipulate multidimensional arrays, or integrate Fortran code using f2py.
homepage: https://github.com/numpy/numpy
---


# numpy

## Overview
NumPy is the fundamental package for scientific computing in Python. It introduces a powerful N-dimensional array object (`ndarray`) and sophisticated functions for performing "vectorized" operations, which eliminate the need for slow Python-level loops. This skill should be used to design memory-efficient data pipelines, perform complex mathematical operations, and integrate high-performance C/C++ or Fortran code into Python workflows.

## Core Usage and Best Practices

### Array Creation and Memory Efficiency
*   **Prefer Pre-allocation**: Use `np.zeros()`, `np.ones()`, or `np.empty()` to allocate memory before filling it, rather than using `np.append()` or `np.concatenate()` inside loops, which causes expensive re-allocations.
*   **Dtype Specification**: Always specify the `dtype` (e.g., `float32`, `int16`) to minimize memory footprint, especially when working with large datasets.
*   **Views vs. Copies**: Understand that slicing (e.g., `arr[:5]`) returns a **view**, not a copy. Modifying a view changes the original array. Use `.copy()` explicitly if you need to decouple the data.

### Vectorization and Broadcasting
*   **Avoid Loops**: Replace `for` loops with NumPy universal functions (ufuncs) like `np.add()`, `np.sin()`, or arithmetic operators.
*   **Broadcasting Rules**: Use broadcasting to perform operations on arrays of different shapes without replicating data. Ensure trailing dimensions match or one of them is 1.
*   **Indexing**: Use boolean indexing (e.g., `arr[arr > 0]`) and fancy indexing for efficient data filtering and selection.

### Linear Algebra and Random Numbers
*   **Linalg Module**: Use `np.linalg` for matrix inversions, eigenvalues, and solving linear systems.
*   **Random Generators**: Use the modern `numpy.random.Generator` (e.g., `np.random.default_rng()`) instead of the legacy `np.random.seed()` for better statistical properties and thread safety.

## Command Line and Maintenance
While NumPy is primarily a library, it provides several CLI-accessible utilities for environment validation and integration.

### Testing the Installation
To verify that NumPy is correctly installed and all submodules (including BLAS/LAPACK integrations) are functional:
```bash
python -c "import numpy; numpy.test()"
```
*Note: Requires `pytest` and `hypothesis` to be installed.*

### Fortran Integration (f2py)
NumPy includes `f2py`, a tool to wrap Fortran code for use in Python.
*   **Check f2py version**: `python -m numpy.f2py -v`
*   **Compile a module**: `python -m numpy.f2py -c source.f90 -m module_name`

### Environment Inspection
To check the version and configuration (including linked acceleration libraries like OpenBLAS or MKL):
```bash
python -c "import numpy; numpy.show_config()"
```

## Expert Tips
*   **Memory Mapping**: For datasets larger than RAM, use `np.memmap` to map a file on disk into an array-like object.
*   **Axis Manipulation**: Use `np.newaxis` or `np.expand_dims` to align dimensions for broadcasting instead of `reshape` when adding singleton dimensions.
*   **In-place Operations**: Use operators like `+=` or `*=` to perform operations in-place and reduce memory overhead, provided you do not need to preserve the original array.

## Reference documentation
- [NumPy README](./references/github_com_numpy_numpy.md)
- [NumPy Wiki](./references/github_com_numpy_numpy_wiki.md)