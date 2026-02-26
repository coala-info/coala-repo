---
name: r-base
description: The r-base package provides the fundamental functions, data structures, and control flow mechanisms essential for the R statistical computing environment. Use when user asks to create data structures, perform basic arithmetic, manipulate data frames, apply statistical functions, or manage files and system utilities.
homepage: https://cran.r-project.org/web/packages/base/index.html
---


# r-base

## Overview
The `base` package is the heart of the R statistical computing environment. It contains the fundamental functions that allow R to function as a language, including basic arithmetic, control flow (loops and conditionals), data structure creation, and core system utilities. It is automatically loaded in every R session.

## Installation
The `base` package is a core component of the R distribution and does not need to be installed separately. It is always available.
```r
# No installation required. To check version:
packageVersion("base")
```

## Core Functions and Workflows

### Data Structure Creation
*   **Vectors**: Created using `c()`. Use `seq()` for sequences and `rep()` for repetitions.
*   **Matrices**: Created using `matrix(data, nrow, ncol)`.
*   **Data Frames**: Created using `data.frame(...)`. This is the standard for tabular data.
*   **Lists**: Created using `list(...)` to hold heterogeneous objects.
*   **Factors**: Created using `factor()` for categorical data.

### Data Manipulation
*   **Subsetting**: Use `[` for vectors/matrices, `[[` or `$` for lists and data frames.
*   **Binding**: `rbind()` and `cbind()` for combining objects by rows or columns.
*   **Merging**: `merge()` for joining data frames based on common keys.
*   **Applying Functions**: Use the `apply` family (`apply`, `lapply`, `sapply`, `tapply`) for vectorized operations over structures.

### Control Flow
*   **Conditionals**: `if (cond) { ... } else { ... }` and the vectorized `ifelse(test, yes, no)`.
*   **Loops**: `for (i in values) { ... }`, `while (cond) { ... }`, and `repeat { ... }`.

### Mathematical and Statistical Utilities
*   **Math**: `sum()`, `mean()`, `median()`, `sd()`, `var()`, `round()`, `abs()`, `log()`, `exp()`.
*   **Distributions**: Base R provides density (`d`), distribution (`p`), quantile (`q`), and random (`r`) functions for various distributions (e.g., `rnorm`, `pbinom`).
*   **Linear Algebra**: `solve()` for inverses/systems, `t()` for transpose, `%*%` for matrix multiplication.

### Input and Output
*   **Reading**: `read.table()`, `read.csv()`.
*   **Writing**: `write.table()`, `write.csv()`.
*   **System**: `list.files()`, `getwd()`, `setwd()`.

## Tips for Efficient Usage
*   **Vectorization**: Always prefer vectorized functions (e.g., `x + y`) over explicit `for` loops for performance.
*   **Missing Values**: Use `is.na()` to detect `NA` values and the `na.rm = TRUE` argument in statistical functions.
*   **Help**: Use `?function_name` or `help("function_name")` to access internal documentation.
*   **Attributes**: Use `str()` to inspect the structure of any object and `summary()` for a quick statistical overview.

## Reference documentation
- [Books related to R](./references/R-books.html.md)
- [R Project Home Page](./references/home_page.md)
- [Other R Publications](./references/other-docs.html.md)