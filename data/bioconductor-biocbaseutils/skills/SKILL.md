---
name: bioconductor-biocbaseutils
description: The package provides utility functions related to package development. These include functions that replace slots, and selectors for show methods. It aims to coalesce the various helper functions often re-used throughout the Bioconductor ecosystem.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocBaseUtils.html
---

# bioconductor-biocbaseutils

## Overview

`BiocBaseUtils` is a collection of low-level utility functions designed to standardize common tasks in Bioconductor package development. It focuses on three primary areas: robust input assertions, consistent S4 object slot replacement, and user-friendly object display (`show` methods). By using these utilities, developers can reduce code duplication and ensure their packages follow Bioconductor's best practices for object-oriented programming.

## Installation and Loading

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BiocBaseUtils")

library(BiocBaseUtils)
```

## Assertions

Use these functions to validate inputs within your functions. They are more specific than base R equivalents and handle `NA` values explicitly.

### Logical Assertions
- `isTRUEorFALSE(x, na.ok = FALSE)`: Checks if an input is a single logical value.

### Character Assertions
- `isScalarCharacter(x, na.ok = FALSE)`: Checks if `x` is a character vector of length 1.
- `isCharacter(x, na.ok = FALSE)`: Checks if `x` is a character vector.
- `isZeroOneCharacter(x, zchar = FALSE)`: Checks if `x` is a character vector of length 0 or 1. Set `zchar = TRUE` to allow empty strings (`""`).

### Numeric Assertions
- `isScalarInteger(x, na.ok = FALSE)`: Checks if `x` is an integer of length 1 (requires `L` suffix or integer class).
- `isScalarNumber(x, na.ok = FALSE)`: Checks if `x` is a numeric/double of length 1.

## S4 Slot Replacement

When implementing "setter" functions for S4 classes, use `setSlots` to update object components. This is the preferred Bioconductor alternative to `BiocGenerics:::replaceSlots`.

```r
# Example S4 Class
setClass("MyClass", representation = representation(data = "numeric"))
obj <- new("MyClass", data = 1:5)

# Update the slot
obj <- setSlots(obj, data = 6:10)
```

## Formatting Show Methods

The `selectSome` function is used within `show` methods to provide a concise summary of long vectors or slots, preventing the console from being flooded with data.

```r
setMethod("show", "MyClass", function(object) {
    val <- getElement(object, "data")
    cat("MyClass object with data:", selectSome(val), "\n")
})

# Output will look like: 6 7 ... 9 10
```

## Best Practices
- **Accessors**: Always use `getElement()` or defined accessor functions inside `show` methods rather than `@` to maintain encapsulation.
- **Minimal Dependencies**: `BiocBaseUtils` is designed to be lightweight; use it to replace custom "is-type" helper functions in your package to reduce maintenance overhead.
- **Type Strictness**: Note the difference between `isScalarInteger(1L)` (TRUE) and `isScalarInteger(1)` (FALSE). Use `isScalarNumber` if you do not require the integer class specifically.

## Reference documentation
- [BiocBaseUtils](./references/BiocBaseUtils.md)