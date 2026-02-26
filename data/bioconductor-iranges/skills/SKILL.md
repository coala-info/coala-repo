---
name: bioconductor-iranges
description: The IRanges package provides memory-efficient containers and optimized algorithms for manipulating integer intervals and sequences in R. Use when user asks to perform interval arithmetic, find overlaps between ranges, calculate coverage, or manage lists of atomic vectors like Rle and IntegerList.
homepage: https://bioconductor.org/packages/release/bioc/html/IRanges.html
---


# bioconductor-iranges

name: bioconductor-iranges
description: Efficient manipulation of integer ranges and sequences in R. Use this skill when you need to perform interval arithmetic, find overlaps between ranges, calculate coverage, or manage lists of atomic vectors (Rle, IntegerList) using the Bioconductor IRanges package.

# bioconductor-iranges

## Overview

The `IRanges` package is a fundamental Bioconductor infrastructure for representing and manipulating intervals of integers. It provides memory-efficient containers for range data and optimized algorithms for interval algebra (union, intersection, gaps), overlap detection, and sequence summaries. It is the foundation for higher-level genomic packages like `GenomicRanges`.

## Core Workflows

### 1. Creating and Accessing IRanges
Construct ranges using any two of `start`, `end`, and `width`.

```R
library(IRanges)

# Construction
ir <- IRanges(start = c(1, 8, 14, 15), width = c(12, 6, 6, 15))

# Accessors
start(ir)
end(ir)
width(ir)

# Subsetting
ir[width(ir) > 10]
```

### 2. Range Transformations
Modify the geometry of the intervals.

*   **Intra-range**: `shift()` (move), `narrow()` (subset relative to start/end), `resize()` (fix one end, change width), `flank()` (get adjacent regions).
*   **Inter-range**: `reduce()` (merge overlapping/adjacent ranges into "normal" form), `disjoin()` (break into non-overlapping atomic intervals).

```R
# Merge overlapping ranges
reduced_ir <- reduce(ir)

# Get gaps between ranges
gaps_ir <- gaps(ir, start = 1, end = 50)

# Shift ranges
shifted_ir <- shift(ir, 10)
```

### 3. Overlaps and Neighbor Finding
Identify relationships between two sets of ranges (query and subject).

*   `findOverlaps(query, subject)`: Returns a Hits object mapping indices.
*   `countOverlaps(query, subject)`: Returns an integer vector of counts.
*   `subsetByOverlaps(query, subject)`: Returns the subset of query that hits the subject.
*   `nearest()`, `precede()`, `follow()`: Find neighboring ranges.

```R
query <- IRanges(c(1, 20), width = 5)
subject <- IRanges(c(3, 15), width = 10)

olaps <- findOverlaps(query, subject)
as.matrix(olaps)
```

### 4. Coverage and Rle Objects
Calculate how many ranges cover each integer position. The result is typically an `Rle` (Run-Length Encoding) object for memory efficiency.

```R
cov <- coverage(ir)
# Access Rle values
runValue(cov)
runLength(cov)
```

### 5. Vector Views
Apply window-based summaries to a sequence (subject) based on ranges.

```R
# Create views on an Rle sequence
x_rle <- Rle(c(1, 1, 1, 0, 0, 2, 2))
views <- Views(x_rle, start = c(1, 5), width = 3)

viewSums(views)
viewMaxs(views)
```

### 6. Lists of Atomic Vectors
Use `IntegerList`, `NumericList`, or `RleList` to handle collections of vectors of varying lengths. "Compressed" versions are highly efficient for large numbers of elements.

```R
# Create a compressed list
int_list <- IntegerList(a = 1:5, b = 10:20, compress = TRUE)

# Element-wise operations (fast)
sum(int_list > 10)
```

## Tips for Efficiency
*   **Normality**: Use `reduce()` when you need a minimal representation of a set of integers (no overlaps, no adjacency).
*   **Compression**: Prefer `CompressedIRangesList` or `CompressedRleList` over "Simple" versions when dealing with thousands of elements.
*   **Vectorization**: Most `IRanges` functions are vectorized. Avoid `lapply` over ranges; use the package's native functions (e.g., `shift`, `narrow`) directly on the object.

## Reference documentation
- [An Overview of the IRanges package](./references/IRangesOverview.md)