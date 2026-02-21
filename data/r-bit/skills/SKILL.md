---
name: r-bit
description: "Provided are classes for boolean and skewed boolean vectors,     fast boolean methods, fast unique and non-unique integer sorting,     fast set operations on sorted and unsorted sets of integers, and     foundations for ff (range index, compression, chunked processing).</p>"
homepage: https://cloud.r-project.org/web/packages/bit/index.html
---

# r-bit

## Overview
The `bit` package provides specialized S3 classes for boolean data that are significantly more memory-efficient than R's standard `logical` type. While R's `logical` uses 32 bits per element (to support `TRUE`, `FALSE`, and `NA`), `bit` uses only 1 bit. The package also offers `bitwhich` for skewed data and highly optimized C-based functions for integer set operations and sorting.

## Installation
```R
install.packages("bit")
library(bit)
```

## Core Boolean Classes

### bit
Use for dense boolean data where `NA` values are not required.
- **Memory**: 1 bit per element (32x savings over logical).
- **Creation**: `b <- bit(n)` (initialized to `FALSE`).
- **Coercion**: `as.bit(logical_vector)`.

### bitwhich
Use for very skewed boolean data (mostly `TRUE` or mostly `FALSE`).
- **Mechanism**: Stores only the indices of the minority value.
- **Creation**: `w <- bitwhich(n, TRUE)` (all TRUE) or `bitwhich(n, c(1, 10))` (TRUE at 1 and 10).
- **Coercion**: `as.bitwhich(x)`.

## Fast Integer Operations

### Synthetic Sorting
The package provides $O(N)$ sorting for integers within a known range, which is often much faster than R's default $O(N \log N)$ sort.
- `bit_sort(x)`: Sorts integers, keeping duplicates.
- `bit_sort_unique(x)`: Sorts and removes duplicates.

### Set Operations
Optimized versions of standard R set functions using bit vectors or merging (for pre-sorted data).

| Task | Bit Vector Method | Merge Method (Sorted Input) |
| :--- | :--- | :--- |
| Membership | `bit_in(x, table)` | `merge_in(x, table)` |
| Unique | `bit_unique(x)` | `merge_unique(x)` |
| Duplicates | `bit_duplicated(x)` | `merge_anyDuplicated(x)` |
| Union | `bit_union(x, y)` | `merge_union(x, y)` |
| Intersection | `bit_intersect(x, y)` | `merge_intersect(x, y)` |
| Difference | `bit_setdiff(x, y)` | `merge_setdiff(x, y)` |

## Workflows and Tips

### Chunked Processing
Use `chunk()` to create index ranges for processing large datasets (like `ff` objects) in memory-efficient pieces.
```R
# Create chunks of size 300,000
chunks <- chunk(from=1, to=1e6, by=3e5)
lapply(chunks, function(i) {
  # Perform operation on range i
  summary(my_bit_vector, range=i)
})
```

### Fast Range Subscripting
Instead of `(1:n)[-i]`, use `bit_rangediff` for faster negative subscripting from a range:
```R
# Get all indices from 1 to 1e7 except for a specific sample
i <- sample(1e7, 1000)
remaining <- bit_rangediff(c(1L, 1e7L), i)
```

### Boolean Aggregation
`bit` objects support optimized aggregation functions that can be restricted to a range:
- `sum(b)`: Count of `TRUE` values.
- `min(b)`: Index of the first `TRUE`.
- `max(b)`: Index of the last `TRUE`.
- `summary(b)`: Counts of `TRUE`/`FALSE` and range.

## Reference documentation
- [Demo of the bit package](./references/bit-demo.Rmd)
- [Performance of the bit package](./references/bit-performance.Rmd)
- [Usage of the bit package](./references/bit-usage.Rmd)