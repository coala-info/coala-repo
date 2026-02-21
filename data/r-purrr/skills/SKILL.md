---
name: r-purrr
description: "A complete and consistent functional programming toolkit for     R.</p>"
homepage: https://cloud.r-project.org/web/packages/purrr/index.html
---

# r-purrr

name: r-purrr
description: Functional programming in R using the purrr package. Use this skill when you need to apply functions to vectors or lists, replace base R apply/loop patterns with type-stable alternatives, work with list-columns in data frames, or handle complex list structures.

## Overview

The `purrr` package enhances R's functional programming capabilities by providing a complete and consistent set of tools for working with functions and vectors. It replaces inconsistent base R functions (like `sapply` or `mapply`) with type-stable "map" functions, simplifies list manipulation, and provides robust tools for predicate-based filtering and error handling.

## Installation

```R
install.packages("purrr")
# Or install the whole tidyverse
install.packages("tidyverse")
```

## Core Workflows

### The Map Family (Iteration)

Map functions apply a function to each element of a vector/list and return an object of a specific type.

- `map()`: Returns a list.
- `map_lgl()`, `map_int()`, `map_dbl()`, `map_chr()`: Return atomic vectors of the specified type.
- `map_vec()`: Returns a vector of the same type as the function output (useful for Dates, factors).
- `walk()`: Returns the input invisibly; used for side effects (plotting, saving files).

**Syntax Pattern:**
`map(.x, .f, ...)` where `.x` is the data, `.f` is the function, and `...` are constant arguments.

**Anonymous Function Shorthand:**
Use the R 4.1+ syntax: `map(x, \(x) x + 1)` or the purrr formula syntax: `map(x, ~ .x + 1)`.

### Multiple Inputs

- `map2(.x, .y, .f)`: Iterates over two vectors in parallel.
- `pmap(.l, .f)`: Iterates over a list of any number of vectors. If `.l` is a data frame, it iterates over the rows.
- `imap(.x, .f)`: Iterates over a vector and its names (or indices).

### Predicate Functions

Functions that return `TRUE` or `FALSE` to filter or inspect data:

- `keep(.x, .p)` / `discard(.x, .p)`: Filter elements based on predicate `.p`.
- `every(.x, .p)` / `some(.x, .p)` / `none(.x, .p)`: Check if elements meet criteria.
- `detect(.x, .p)`: Find the first element matching criteria.
- `detect_index(.x, .p)`: Find the position of the first match.

### List Manipulation and Extraction

- `list_rbind()` / `list_cbind()`: Efficiently combine a list of data frames into one.
- `pluck(.x, ...)` / `chuck(.x, ...)`: Safely extract elements by name or index.
- `modify()`: Apply a function but preserve the input's class (e.g., modifying columns in a data frame).
- `list_flatten()`: Remove one level of hierarchy from a list.

### Advanced Features

- **Progress Bars**: Add `.progress = TRUE` to any map function to see a progress bar for long-running tasks.
- **Parallelization**: Use `in_parallel()` within a map call (requires the `mirai` package) to distribute tasks across cores.
- **Error Handling**: Use `possibly()`, `safely()`, or `quietly()` to wrap functions so they don't crash a loop when encountering an error.

## Tips for Success

1. **Type Stability**: Always prefer the specific suffix (e.g., `map_dbl`) over `map` if you know the output type. This prevents unexpected data structures.
2. **Piping**: `purrr` is designed for the pipe (`|>`). Start with your data, then pipe into map functions.
3. **Data Frames**: Remember that data frames are lists of columns. `map(df, summary)` will apply summary to every column.
4. **Extraction Shorthand**: You can use strings or integers as the function in map to extract elements: `map(list_of_lists, "name")` is equivalent to extracting `[[ "name" ]]` from each element.

## Reference documentation

- [purrr <-> base R](./references/base.Rmd)
- [Functional programming in other languages](./references/other-langs.Rmd)
- [Get started with purrr](./references/purrr.Rmd)