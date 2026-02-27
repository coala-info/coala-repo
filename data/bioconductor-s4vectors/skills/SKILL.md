---
name: bioconductor-s4vectors
description: The S4Vectors package provides foundational S4 classes for memory-efficient data representation, including virtual Vector and List classes, Rle objects, and S4-compliant DataFrames. Use when user asks to create or manipulate Rle objects, work with S4 DataFrames, manage metadata columns, or perform optimized subsetting and aggregation on Bioconductor data structures.
homepage: https://bioconductor.org/packages/release/bioc/html/S4Vectors.html
---


# bioconductor-s4vectors

name: bioconductor-s4vectors
description: Expert guidance for the S4Vectors Bioconductor package. Use this skill when working with S4-based vector-like and list-like data structures in R, specifically for Rle (Run-Length Encoding), DataFrame, and Hits objects. It covers object construction, subsetting, metadata annotation, and S4 class system fundamentals.

# bioconductor-s4vectors

## Overview
The `S4Vectors` package is a foundational Bioconductor infrastructure package that provides S4 classes for memory-efficient data representation. It defines the virtual `Vector` and `List` classes, which allow complex data types to behave like standard R atomic vectors and lists while supporting metadata and compression. Key implementations include `Rle` (Run-Length Encoding) for compressed sequences and `DataFrame` for S4-compliant tabular data.

## Core Workflows and Functions

### 1. Working with Rle (Run-Length Encoding)
Use `Rle` to store vectors with many consecutive repeated values efficiently.

```r
library(S4Vectors)

# Construction
xRle <- Rle(c(rep(1, 5), rep(2, 3), rep(1, 10)))

# Accessors
runValue(xRle)    # Returns unique values of runs
runLength(xRle)   # Returns lengths of each run
nrun(xRle)        # Number of runs

# Manipulation (Standard R operations work)
xRle > 1
sum(xRle)
rev(xRle)
```

### 2. S4 DataFrames
`S4Vectors::DataFrame` is the S4 version of `data.frame`. It supports columns that are not just atomic vectors (e.g., `Rle` objects, `IRanges`, or other `Vector` derivatives).

```r
# Construction
df <- DataFrame(col1 = Rle(1:3, 3:1), col2 = c("A", "B", "C", "D", "E", "F"))

# Metadata columns (mcols)
# Attach metadata to the elements (rows) of the DataFrame
mcols(df)$quality <- c(10, 10, 9, 8, 7, 10)

# Object-level metadata
metadata(df)$source <- "Experiment_01"
```

### 3. Subsetting and Windowing
`S4Vectors` provides optimized methods for extracting data without unnecessary copying.

*   `window(x, start, end)`: Extract a subsequence.
*   `subset(x, subset)`: Extract elements based on a logical vector.
*   `head(x, n)` / `tail(x, n)`: Standard first/last element extraction.

### 4. Looping and Aggregation
Avoid standard `for` loops; use optimized S4 methods:
*   `aggregate(x, start, width, FUN)`: Apply a function over moving windows.
*   `shiftApply(SHIFT, X, Y, FUN)`: Apply a function to two vectors with a relative positional shift.
*   `endoapply(X, FUN, ...)`: Similar to `lapply`, but returns an object of the same class as the input.

## S4 Class System Tips
*   **Inspection**: Use `showClass("ClassName")` to see slots and inheritance.
*   **Methods**: Use `showMethods("functionName")` to see available signatures.
*   **Validation**: Use `validObject(obj)` to check if an S4 object satisfies its class constraints.
*   **Coercion**: Use `as(object, "Class")` to convert between types (e.g., `as(df, "data.frame")`).

## Reference documentation
- [Rle Tips and Tricks](./references/RleTricks.md)
- [A quick overview of the S4 class system](./references/S4QuickOverview.md)
- [An Overview of the S4Vectors package](./references/S4VectorsOverview.md)