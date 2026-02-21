---
name: xtensor
description: xtensor is a powerful C++ library designed for numerical analysis using multi-dimensional array expressions.
homepage: https://github.com/xtensor-stack/xtensor
---

# xtensor

## Overview
xtensor is a powerful C++ library designed for numerical analysis using multi-dimensional array expressions. It provides a NumPy-style API within a statically typed environment, enabling features like lazy broadcasting, universal functions (xfunctions), and seamless integration with other languages like Python, Julia, and R. Use this skill to write efficient C++ code for tensor algebra, data reshaping, and complex mathematical expressions without the overhead of immediate evaluation.

## Core Usage Patterns

### Container Selection
*   **xt::xarray<T>**: Use for arrays where the number of dimensions is determined at runtime.
*   **xt::xtensor<T, N>**: Use when the number of dimensions (N) is known at compile time for better performance.
*   **xt::xfixed<T, shape... >**: Use for small, fixed-size tensors to enable maximum compiler optimization.

### Basic Initialization and Manipulation
```cpp
#include "xtensor/xarray.hpp"
#include "xtensor/xio.hpp"
#include "xtensor/xview.hpp"

// Initialize a 2D array
xt::xarray<double> a = {{1.0, 2.0}, {3.0, 4.0}};

// Reshape (inplace)
a.reshape({4, 1});

// Indexing
double val = a(0, 1); // Access element at row 0, col 1
```

### Lazy Evaluation and Broadcasting
xtensor expressions are lazy by default. Operations like `a + b` do not compute the result immediately but return an `xexpression`.
*   **Triggering Computation**: Assign the expression to a container (e.g., `xt::xarray<double> res = a + b;`) or access an element.
*   **Broadcasting**: Smaller arrays are automatically broadcast to match larger ones following NumPy rules.

### Views and Slicing
Use `xt::view` to create a window into existing data without copying.
```cpp
#include "xtensor/xview.hpp"

auto v = xt::view(a, xt::range(0, 2), xt::all()); // First two rows
v(0, 0) = 10.0; // Modifies the original array 'a'
```

## Expert Tips and Best Practices

### Performance Optimization
*   **SIMD Acceleration**: Define `XTENSOR_USE_XSIMD` before including xtensor headers to enable vectorized operations via the xsimd library.
*   **Layout Awareness**: Be mindful of `layout_type`. Use `xt::layout_type::row_major` (default) or `xt::layout_type::column_major` to match your data access patterns and avoid cache misses.
*   **Avoid Unnecessary Copies**: Always prefer `xt::view` or `xt::strided_view` over creating new containers unless you specifically need a detached copy of the data.

### Functional Mapping
*   **Vectorization**: Use `xt::vectorize(func)` to transform a scalar function into one that accepts and returns xtensor expressions.
*   **Reductions**: Use `xt::sum`, `xt::prod`, `xt::mean`, etc., and specify the axis (e.g., `xt::sum(a, {1})`) to perform operations across specific dimensions.

### Integration
*   **NumPy Cheat Sheet**: If you are familiar with NumPy, map `np.array` to `xt::xarray`, `np.reshape` to `arr.reshape()`, and `np.linspace` to `xt::linspace`.

## Reference documentation
- [xtensor GitHub Repository](./references/github_com_xtensor-stack_xtensor.md)
- [xtensor Commits and Version History](./references/github_com_xtensor-stack_xtensor_commits_master.md)