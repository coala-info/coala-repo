---
name: bioconductor-cellbench
description: This tool provides a benchmarking framework for comparing single-cell analysis methods and algorithms across multiple datasets in a combinatorial fashion. Use when user asks to compare multiple R methods across datasets, benchmark single-cell analysis algorithms, time computations, or manage combinatorial benchmarking workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/CellBench.html
---


# bioconductor-cellbench

name: bioconductor-cellbench
description: Benchmarking framework for single-cell analysis methods. Use when you need to compare multiple R methods or algorithms across different datasets in a combinatorial fashion. It provides tools for managing list-columns, caching results, timing computations, and integrating with the tidyverse (dplyr, purrr).

# bioconductor-cellbench

## Overview

CellBench is a framework designed to simplify the benchmarking of bioinformatics methods, particularly for single-cell analysis. It centers around the "benchmark tibble," a data structure that stores datasets, applied methods, and results in an organized, tidy format. The core workflow involves taking a list of datasets and piping them through successive lists of functions using `apply_methods()`, which automatically handles the combinatorial expansion of all data-method pairs.

## Core Workflow

### 1. Prepare Inputs
Benchmarks require two main components: a named list of datasets and one or more named lists of functions (methods).

```r
library(CellBench)

# Datasets must be in a named list
datasets <- list(
    set1 = matrix(runif(100), 10, 10),
    set2 = matrix(runif(100), 10, 10)
)

# Methods must be in a named list of functions
# Each function should take exactly one primary argument
my_methods <- list(
    log = function(x) log(x + 1),
    sqrt = function(x) sqrt(x)
)
```

### 2. Apply Methods
Use `apply_methods()` to execute the pipeline. This function adds a column named after the method list and updates the `result` list-column.

```r
# Combinatorial application: 2 datasets x 2 methods = 4 rows
res <- datasets %>%
    apply_methods(my_methods)

# Chain multiple steps
more_methods <- list(
    scale = scale,
    identity = identity
)

res_final <- res %>%
    apply_methods(more_methods)
```

### 3. Handle Results
The `result` column is a list-column. To work with it, use `purrr::map` or `tidyr::unnest`.

```r
library(dplyr)
library(tidyr)

# Unnesting for plotting or analysis
flat_res <- res_final %>%
    unnest(cols = c(result))

# Collapsing pipeline names for easy labeling
collapsed <- res_final %>%
    pipeline_collapse()
```

## Advanced Features

### Partial Application
If a method requires multiple arguments, use `purrr::partial()` or `fn_arg_seq()` to create a single-argument function compatible with CellBench.

```r
# Create a grid of parameter variations
complex_method <- function(x, param1, param2) { ... }
method_grid <- fn_arg_seq(complex_method, param1 = c(1, 2), param2 = c(10, 20))
```

### Timing and Caching
*   **Timing**: Use `time_methods()` instead of `apply_methods()` to capture execution time. Use `unpack_timing()` to extract these values.
*   **Caching**: Use `cache_method()` to wrap expensive functions. Initialize the cache first with `cellbench_cache_init()` or `set_cellbench_cache_path()`.
*   **Parallelism**: Set global threads using `set_cellbench_threads(n)`.

### Writing Wrappers
When using external library functions, wrap them to ensure they accept a `SingleCellExperiment` (or your chosen data type) and return a consistent object type.

```r
my_wrapper <- function(sce) {
    # 1. Extract data
    # 2. Run external method
    # 3. Re-insert into SCE slots (assays, colData, etc.)
    return(sce)
}
```

## Reference documentation

- [Benchmark Data Manipulation](./references/DataManipulation.md)
- [Introduction to CellBench](./references/Introduction.md)
- [Tidyverse Patterns](./references/TidyversePatterns.md)
- [Timing methods in CellBench](./references/Timing.md)
- [Writing Wrappers](./references/WritingWrappers.md)