---
name: bioconductor-xvector
description: The bioconductor-xvector package provides memory-efficient S4 classes and methods for storing and manipulating large sequences using external pointers to avoid data copying. Use when user asks to create or subset XVector objects, perform high-performance summarization of large numeric vectors, manage memory with compacting operations, or generate views on sequences using slicing.
homepage: https://bioconductor.org/packages/release/bioc/html/XVector.html
---


# bioconductor-xvector

name: bioconductor-xvector
description: Memory-efficient S4 classes for storing and manipulating large sequences externally (e.g., via external pointers or on disk). Use this skill when working with Bioconductor infrastructure that requires XVector, XRaw, XInteger, or XDouble objects, or when performing high-performance subsetting and summarization of large numeric/raw vectors without data copying.

## Overview

The **XVector** package provides the foundational infrastructure for memory-efficient sequence representation in Bioconductor. It uses a "pass-by-address" semantic to avoid the overhead of copying large datasets when extracting subsequences. This is particularly critical for genomic data where objects like `DNAString` (from Biostrings) inherit from XVector classes.

## Core Classes

- **XVector**: Virtual base class for external vectors.
- **XRaw / XInteger / XDouble**: Concrete subclasses for raw (bytes), integer, and numeric data.
- **XVectorList / XRawList**: List-like containers for XVector objects.
- **XIntegerViews / XDoubleViews**: Containers for multiple "views" (subsequences) on a single subject vector.

## Key Workflows and Functions

### Efficient Subsetting with subseq()
Unlike standard R subsetting, `subseq()` does not copy the underlying data. It creates a new object pointing to the same memory address.

```r
library(XVector)
x <- XInteger(1000000, val=sample(1000000))

# Instantaneous subsetting with no memory footprint increase
y <- subseq(x, start=101, end=200)
```

### Memory Management with compact()
When a small `subseq` is derived from a very large `XVector`, the large vector remains in memory. Use `compact()` to force a copy of only the necessary data and release the original large vector.

```r
# y still keeps the 1M integers of x alive in memory
y <- subseq(x, start=1, end=10)

# y0 copies only the 10 integers, allowing x to be garbage collected
y0 <- compact(y)
```

### Slicing and Views
Use `slice()` to identify regions of a vector that fall within specific numerical bounds. This returns a "Views" object.

```r
vec <- as(c(1, 10, 15, 2, 8, 12), "XInteger")
# Find regions where values are between 8 and 16
v <- slice(vec, lower=8, upper=16)

# Summarize the views efficiently
viewMeans(v)
viewMaxs(v)
```

### Sequence Manipulation
- **reverse(x)**: Reverses the order of elements. For `XVectorList`, it reverses each element individually.
- **narrow(x, start, end)**: Efficiently restricts the ranges of an `XVectorList`.
- **threebands(x, start, end)**: Splits an object into "left", "middle", and "right" components based on a narrowing operation.

### Summarization Methods
For `XIntegerViews` and `XDoubleViews`, use optimized summarization functions:
- `viewMins()`, `viewMaxs()`
- `viewSums()`, `viewMeans()`
- `viewWhichMins()`, `viewWhichMaxs()`

## Tips for Performance
1. **Avoid `[` for large extractions**: Use `subseq()` whenever you need a contiguous block, as it avoids data duplication.
2. **Check Shared Memory**: You can inspect the `@shared` slot of XVector objects to see if they point to the same memory address.
3. **Serialization**: When saving objects to disk (`save()` or `saveRDS()`), always call `compact()` on subsequences first to avoid saving the entire parent vector.

## Reference documentation
- [XVector Reference Manual](./references/reference_manual.md)