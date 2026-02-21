---
name: r-abind
description: "Combine multidimensional arrays into a single array.   This is a generalization of 'cbind' and 'rbind'.  Works with   vectors, matrices, and higher-dimensional arrays (aka tensors).   Also provides functions 'adrop', 'asub', and 'afill' for   manipulating, extracting and replacing data in arrays.</p>"
homepage: https://cloud.r-project.org/web/packages/abind/index.html
---

# r-abind

name: r-abind
description: Combine multidimensional arrays into a single array. Use when Claude needs to generalize 'cbind' and 'rbind' to higher-dimensional arrays (tensors), or perform advanced array manipulations like subsetting (asub), dropping dimensions (adrop), and filling (afill).

## Overview
The `abind` package provides a generalization of the standard R functions `cbind()` and `rbind()`. It allows for the combination of vectors, matrices, and higher-dimensional arrays along any specified dimension. It is particularly useful for stacking matrices into 3D arrays or merging multi-dimensional datasets where the number of dimensions exceeds two.

## Installation
```R
install.packages("abind")
```

## Core Functions

### abind()
The primary function for combining arrays.
- `...`: The arrays, matrices, or vectors to be combined.
- `along`: The dimension along which to bind the arrays. Default is the last dimension (e.g., for two 2D matrices, `along=3` creates a 3D array).
- `rev.along`: Alternative to `along`; specifies the dimension counting backwards from the last.
- `new.names`: A list of names for the new dimension created.
- `force.array`: If `TRUE`, the result is always an array object.
- `make.names`: If `TRUE`, ensures dimension names are syntactically valid.

### adrop()
Removes dimensions of an array that have a length of 1.
- `x`: The input array.
- `drop`: A logical or numeric vector specifying which dimensions to drop. If `NULL`, all dimensions of length 1 are dropped.

### asub()
A functional version of the `[` subsetting operator. It is highly useful for programmatic subsetting when the number of dimensions is not known in advance.
- `x`: The array to subset.
- `idx`: A list or vector of indices.
- `dims`: The dimensions to which the indices in `idx` apply.

### afill()
Replaces a portion of an array with a value or another array, matching by dimension names or indices.

## Common Workflows

### Stacking Matrices into a 3D Array
To stack multiple 2D matrices into a single 3D "brick":
```R
library(abind)
m1 <- matrix(1:4, 2, 2)
m2 <- matrix(5:8, 2, 2)
# Result is 2x2x2
combined <- abind(m1, m2, along = 3)
```

### Generalizing rbind and cbind
`abind` can perform standard binding operations by specifying the dimension:
```R
# Equivalent to rbind(m1, m2)
res_row <- abind(m1, m2, along = 1)

# Equivalent to cbind(m1, m2)
res_col <- abind(m1, m2, along = 2)
```

### Programmatic Subsetting with asub
When writing functions that handle arrays of arbitrary dimensions, `asub` avoids complex string construction for `[`:
```R
# Extract the first slice of the 3rd dimension regardless of total dimensions
slice <- asub(my_array, 1, 3)
```

## Tips
- **Dimension Alignment**: `abind` requires that all dimensions, except the one being bound `along`, must match in size across all input arrays.
- **Recycling**: Unlike some R functions, `abind` does not automatically recycle elements if dimensions do not match; it will throw an error.
- **Naming**: Use `new.names` within `abind()` to immediately label the new slices being added, which improves data provenance.

## Reference documentation
- [abind: Combine Multidimensional Arrays](./references/home_page.md)