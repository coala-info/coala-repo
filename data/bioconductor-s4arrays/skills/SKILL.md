---
name: bioconductor-s4arrays
description: The S4Arrays package provides foundational S4 infrastructure and a standardized framework for representing and manipulating array-like objects in Bioconductor. Use when user asks to define virtual array classes, perform block-based processing on large datasets, extract array subsets, or transform multidimensional coordinates.
homepage: https://bioconductor.org/packages/release/bioc/html/S4Arrays.html
---

# bioconductor-s4arrays

## Overview

The `S4Arrays` package provides the foundational S4 infrastructure for array-like objects in the Bioconductor ecosystem. It defines the `Array` virtual class and a standardized framework for "on-disk" or "in-memory" array representation. It is primarily used by developers of other packages (like `DelayedArray` or `SparseArray`) to ensure consistent behavior for `as.matrix()`, `type()`, and block-based processing.

## Core Workflows

### 1. Working with the Array Class
The `Array` class is a virtual base. You will typically interact with its subclasses (e.g., `SparseArray`, `DelayedArray`, `ArrayGrid`).

```r
library(S4Arrays)

# Check if an object inherits from the Array framework
is(my_object, "Array")

# Determine if an array-like object uses sparse representation
is_sparse(my_object)
```

### 2. Block Processing Framework
For large datasets that do not fit in memory, `S4Arrays` provides a grid-based system to process data in chunks (blocks).

*   **Grids and Viewports**: Define how an array is partitioned.
*   **Reading/Writing**: Use `read_block()` and `write_block()`.

```r
# Create a regular grid (e.g., blocks of 100x100)
grid <- RegularArrayGrid(dim(my_array), spacings=c(100, 100))

# Read the first block
viewport <- grid[[1]]
block <- read_block(my_array, viewport)

# Map coordinates between reference array and grid
# mapToGrid(selection, grid)
```

### 3. Array Manipulation Utilities
`S4Arrays` provides generics and methods that extend base R array functionality to S4 array-like objects.

*   **`extract_array(x, index)`**: The fundamental generic for subsetting. `index` is a list of integer vectors (one per dimension).
*   **`abind(...)`**: Combine array-like objects along any dimension.
*   **`aperm2(x, perm)`**: An extended version of `aperm()` that can add or drop "ineffective" dimensions (dimensions with extent 1).
*   **`arep_times()` / `arep_each()`**: Multidimensional versions of `rep()`.

### 4. Binary Operations and Recycling
When performing arithmetic between an array and a vector, use `as_tile()` to control recycling behavior.

```r
# Ensure a vector is recycled as a "tile" against a specific dimension
my_array + as_tile(my_vector, 1)
```

## Implementation Tips
*   **For Developers**: If creating a new array-like class, you must implement a method for `extract_array()` to gain automatic support for `as.array()`, `as.matrix()`, and `type()`.
*   **Performance**: Use `is_sparse()` to write conditional code paths that optimize for sparse vs. dense data structures.
*   **Coordinate Mapping**: Use `Lindex2Mindex` (Linear index to Matrix index) and `Mindex2Lindex` for low-level coordinate transformations.

## Reference documentation
- [A quick overview of the S4Arrays package](./references/S4Arrays_quick_overview.md)