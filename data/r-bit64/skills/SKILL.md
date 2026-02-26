---
name: r-bit64
description: The r-bit64 tool provides support for 64-bit signed integers in R using the bit64 package. Use when user asks to handle large database keys, perform arithmetic on integers exceeding 32-bit limits, or manage high-precision integer vectors and data frames.
homepage: https://cloud.r-project.org/web/packages/bit64/index.html
---


# r-bit64

name: r-bit64
description: Support for 64-bit signed integers in R using the 'bit64' package. Use this skill when handling large database keys, exact counts exceeding 2^31-1 (up to ±2^63), or when high-precision integer arithmetic is required in vectors, matrices, and data.frames.

# r-bit64

## Overview
The `bit64` package introduces the `integer64` S3 class to R, allowing the representation and manipulation of 64-bit signed integers. Since R's native `integer` type is limited to 32-bit, `bit64` is essential for working with Big Data identifiers, financial transactions, and large-scale counting.

## Installation
```R
install.packages("bit64")
library(bit64)
```

## Core Usage

### Creation and Coercion
Always use the `as.integer64()` constructor. Avoid using `integer64()` directly for initialization from values.
```R
# From character (safest for very large numbers)
x <- as.integer64("9223372036854775807")

# From numeric/double (precision loss may occur if > 2^53)
y <- as.integer64(1e15)

# From integer
z <- as.integer64(123L)

# Create a vector of length n
vec <- integer64(10) 
```

### Arithmetic and Comparison
`integer64` supports standard operators: `+`, `-`, `*`, `/`, `^`, `%%`, `%/%`.
**Warning on Mixed Types:**
- `integer64` + `double` => `integer64` (The double is coerced to integer64 before addition).
- `integer64` + `integer` => `integer64`.

### Data Structures
`integer64` objects work seamlessly in:
- **Vectors**: `c(as.integer64(1), as.integer64(2))`
- **Data Frames**: `data.frame(id = as.integer64(1:10))`
- **Matrices/Arrays**: `matrix(as.integer64(1:9), 3, 3)`

## Important Constraints
1. **Subscripting**: R-core does not support `integer64` for indexing. You must coerce to `integer` or `double` for use as an index: `my_list[[as.integer(x)]]`.
2. **NA Handling**: `bit64` uses a specific bit pattern for `NA_integer64_`.
3. **Printing**: Large integers are printed with an `LL` suffix or as plain text depending on options.

## Fast Algorithmic Operations
The package provides optimized versions of standard R functions for `integer64`:
- **Matching**: `match()`, `%in%`
- **Uniqueness**: `unique()`, `duplicated()`, `anyDuplicated()`
- **Ordering**: `order()`, `sort()`, `rank()`
- **Summary**: `sum()`, `mean()`, `min()`, `max()`, `range()`, `median()`

## Workflows

### Reading Large IDs from CSV
When reading data with `read.csv`, large IDs are often mangled into doubles.
```R
# Read as character first to preserve precision
df <- read.csv("data.csv", colClasses = c(id = "character"))
df$id <- as.integer64(df$id)
```

### Database Integration
Many DBI-compliant drivers (like `RPostgres` or `odbc`) automatically map BIGINT to `integer64` if `bit64` is loaded.

## Reference documentation
- [bit64 README](./references/README.md)