---
name: bioconductor-biocgenerics
description: BiocGenerics provides S4 generic functions and promotes base R functions to enable consistent method dispatch across the Bioconductor ecosystem. Use when user asks to define S4 methods for base functions, combine Bioconductor objects, access genomic metadata, or handle out-of-memory data structures.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocGenerics.html
---


# bioconductor-biocgenerics

name: bioconductor-biocgenerics
description: Expert guidance for using the BiocGenerics R package. Use this skill when you need to work with S4 generic functions in Bioconductor, including promoted base R functions (like append, cbind, lapply) and Bioconductor-specific generics (like annotation, combine, updateObject). Use it to ensure correct method dispatch and to handle data structures like eSets, DataFrames, and array-like objects.

# bioconductor-biocgenerics

## Overview
The `BiocGenerics` package is a core infrastructure component of the Bioconductor project. It provides S4 generic functions that allow different Bioconductor packages to implement consistent methods for common operations. It serves two primary purposes:
1. **Promoting base R functions to S4 generics**: This allows packages to define methods for base functions (e.g., `nrow()`, `mean()`, `subset()`) on complex S4 objects.
2. **Defining Bioconductor-specific generics**: It establishes standard verbs for the ecosystem (e.g., `annotation()`, `combine()`, `strand()`).

## Core Workflows

### 1. Method Discovery and Inspection
Since `BiocGenerics` defines the interface but not usually the implementation for specific data types, use these functions to find available methods:
```r
library(BiocGenerics)
# List all symbols in the package
ls('package:BiocGenerics')

# Check which methods exist for a generic
showMethods("combine")

# Get the specific implementation for a class
selectMethod("annotation", "eSet")
```

### 2. Combining Data Structures
The `combine()` function is used to merge Bioconductor objects. It typically follows either an intersection or union strategy.
```r
# Combining data frames or matrices with shared metadata
combined_df <- combine(df1, df2)

# Note: For factors, levels must be compatible or converted to character
df1$y <- I(as.character(df1$y))
df2$y <- I(as.character(df2$y))
combine(df1, df2)
```

### 3. Accessing Metadata and Coordinates
Standardized accessors for genomic and annotation data:
- **Annotation**: `annotation(obj)`, `annotation(obj) <- value`
- **Genomic Coordinates**: `start(obj)`, `end(obj)`, `width(obj)`, `strand(obj)`
- **Organism Info**: `organism(obj)` (preferred over `species()`)
- **Database Connections**: `dbconn(obj)`, `dbfile(obj)`

### 4. Vectorized Dimensions
Use `dims()`, `nrows()`, and `ncols()` for list-like objects where you need the dimensions of every element:
```r
# Returns a matrix of dimensions for each element in the list-like object
all_dims <- dims(myDataFrameList)
```

### 5. Handling Out-of-Memory Data
Bioconductor often works with on-disk data (HDF5, SQLite).
```r
# Check if an object resides in memory or on disk
containsOutOfMemoryData(myObject)

# Safe serialization (warns if data is out-of-memory)
saveRDS(myObject, "data.rds")
```

## Common Pitfalls and Tips
- **Masking**: `BiocGenerics` masks several base R functions. Always ensure `BiocGenerics` is loaded if you expect S4 dispatch on objects like `Rle`, `DataFrame`, or `GenomicRanges`.
- **Dispatch**: Most generics dispatch on the first argument (`x` or `object`), but some like `cbind`/`rbind` dispatch on `...`, and `combine` dispatches on `x` and `y`.
- **Stability**: When implementing or using `order()`, `sort()`, or `rank()`, `BiocGenerics` expects "stable" behavior (ties broken by original position).
- **Path Setters**: The `basename(obj) <- value` and `dirname(obj) <- value` setters work automatically if a `path()` method is defined for the class.

## Reference documentation
- [BiocGenerics Reference Manual](./references/reference_manual.md)