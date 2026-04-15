---
name: bioconductor-delayeddataframe
description: This tool manages large-scale genomic data frames by keeping columns on-disk to minimize memory usage while providing a standard DataFrame interface. Use when user asks to handle large annotation files, perform delayed subsetting on genomic data, or manage data frames with HDF5 or GDS backends.
homepage: https://bioconductor.org/packages/release/bioc/html/DelayedDataFrame.html
---

# bioconductor-delayeddataframe

name: bioconductor-delayeddataframe
description: Specialized workflow for using the DelayedDataFrame Bioconductor package to handle large-scale genomic annotation data. Use this skill when you need to manage data frames where columns are stored on-disk (e.g., HDF5 or GDS backends) to save memory while maintaining a standard DataFrame-like interface.

# bioconductor-delayeddataframe

## Overview

`DelayedDataFrame` is a Bioconductor package designed to handle large annotation files that exceed available RAM. It extends the standard `S4Vectors::DataFrame` class by implementing a `lazyIndex` slot. This allows for "delayed" operations—such as subsetting—where the underlying data remains untouched on-disk, and only the mapping indexes are updated. It is particularly useful when working with `DelayedArray`, `HDF5Array`, or `GDSArray` objects as columns.

## Core Workflows

### 1. Installation and Loading

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DelayedDataFrame")

library(DelayedDataFrame)
```

### 2. Construction

You can construct a `DelayedDataFrame` from ordinary vectors, `DataFrame` objects, or on-disk objects like `GDSArray`.

```r
# From standard R objects
ddf <- DelayedDataFrame(col1 = 1:10, col2 = letters[1:10])

# From on-disk GDSArray objects (example)
library(GDSArray)
file <- SeqArray::seqExampleFileName("gds")
varid <- GDSArray(file, "annotation/id")
DP <- GDSArray(file, "annotation/info/DP")

# Constructing with on-disk columns
ddf_disk <- DelayedDataFrame(variant_id = varid, depth = DP)
```

### 3. Delayed Subsetting

Subsetting a `DelayedDataFrame` does not immediately realize the data. Instead, it updates the `lazyIndex`.

```r
# Subsetting rows (updates lazyIndex, does not load data into memory)
ddf_sub <- ddf_disk[1:100, ]

# Check the lazy index
lazyIndex(ddf_sub)

# The underlying listData remains identical to the original
identical(ddf_disk@listData, ddf_sub@listData) # Returns TRUE
```

### 4. Realization and Coercion

To "realize" the delayed operations and convert the object into a standard in-memory structure, use coercion.

```r
# Coerce to standard DataFrame (realizes the lazyIndex)
df_standard <- as(ddf_sub, "DataFrame")

# Coerce from other types
ddf_from_list <- as(list(a=1:5, b=6:10), "DelayedDataFrame")
```

### 5. Common Methods

`DelayedDataFrame` supports standard `DataFrame` metaphors:

*   **Accessors**: `nrow(ddf)`, `ncol(ddf)`, `colnames(ddf)`, `rownames(ddf)`.
*   **Column Extraction**: `ddf[[1]]` or `ddf[["column_name"]]` returns the original data format (e.g., a `GDSArray`).
*   **Combining**: 
    *   `rbind(...)`: Realizes the `lazyIndex` and returns a new `DelayedDataFrame`.
    *   `cbind(...)`: Preserves existing `lazyIndex` mapping.

## Key Tips

*   **Memory Efficiency**: Use `DelayedDataFrame` when your metadata/annotation columns are too large for memory. It keeps the data on-disk until explicitly accessed or coerced.
*   **Lazy Indexing**: If you perform multiple subsetting operations, `DelayedDataFrame` tracks them efficiently in the `lazyIndex` slot without copying the actual data.
*   **Row Names**: Like `DataFrame`, row names are not assigned automatically. Assign them using `rownames(ddf) <- ...` or during construction.

## Reference documentation

- [DelayedDataFrame](./references/DelayedDataFrame.md)