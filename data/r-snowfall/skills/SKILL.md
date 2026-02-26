---
name: r-snowfall
description: The snowfall package provides a simplified wrapper for parallel computing in R across multiple cores or clusters. Use when user asks to parallelize R code, run apply functions in parallel, or manage socket and MPI clusters for distributed computing.
homepage: https://cloud.r-project.org/web/packages/snowfall/index.html
---


# r-snowfall

name: r-snowfall
description: Parallel computing in R using the snowfall package. Use this skill when the user needs to parallelize R code (lapply, apply, etc.) across multiple cores or cluster nodes using a simplified wrapper for the 'snow' package. It supports Socket, MPI, PVM, and NetWorkSpaces clusters and provides extended error handling and sequential fallback.

## Overview

`snowfall` is an "usability wrapper" for the `snow` package. It simplifies the transition from sequential to parallel R code by providing parallel versions of standard R functions (like `sfLapply` for `lapply`). A key feature is its ability to run the same code sequentially if no cluster is initialized, making code more portable.

## Installation

```R
install.packages("snowfall")
# Optional: install.packages("snow") if not automatically pulled
# For MPI support: install.packages("Rmpi")
```

## Core Workflow

The standard `snowfall` workflow follows four steps:

1.  **Initialize**: `sfInit(parallel = TRUE, cpus = 4, type = "SOCK")`
2.  **Export**: `sfExport("my_variable")` or `sfLibrary(my_package)` to prepare workers.
3.  **Execute**: Use `sfLapply`, `sfSapply`, or `sfApply` for parallel calculations.
4.  **Stop**: `sfStop()` to release resources.

## Key Functions

### Initialization and Configuration
- `sfInit(parallel, cpus, type, ...)`: Starts the cluster. `type` can be "SOCK" (default, easiest for local multi-core), "MPI", "PVM", or "NWS".
- `sfStop()`: Shuts down the cluster.
- `sfParallel()`: Returns `TRUE` if running in parallel mode.
- `sfSetMaxCPUs(n)`: Call before `sfInit` if you need more than the default limit (40).

### Data and Environment Management
- `sfExport(list)`: Exports variables from the master to all slaves.
- `sfExportAll()`: Exports all variables from the global environment.
- `sfLibrary(package)`: Loads an R package on all slaves.
- `sfSource(file)`: Sources an R file on all slaves.

### Parallel Execution
- `sfLapply(x, fun, ...)`: Parallel version of `lapply`.
- `sfSapply(x, fun, ...)`: Parallel version of `sapply`.
- `sfApply(x, margin, fun, ...)`: Parallel version of `apply`.
- `sfClusterApplyLB(x, fun, ...)`: Load-balanced version of `lapply`. Use this when tasks have varying execution times or nodes have different speeds.

## Advanced Features

### Intermediate Results (Restore)
`sfClusterApplySR(x, fun, ..., name="default")` saves intermediate results to disk. If the process is interrupted, it can be restarted from the last completed block of results.

### Error Handling
By default, `snowfall` functions call `stop()` on failure. You can modify this behavior using the `stopOnError` argument in many functions (e.g., `sfLapply(..., stopOnError = FALSE)`).

## Best Practices
- **Sequential Development**: Develop and debug your code using `sfInit(parallel = FALSE)` first.
- **Wrapper Functions**: Wrap complex logic into a single function that takes one index/element as an argument, then pass that function to `sfLapply`.
- **Global Variables**: Remember that workers start with a clean environment. Always use `sfExport` for any variable defined outside the function passed to `sfLapply`.
- **Socket Clusters**: For local machines (Windows/Mac/Linux), `type = "SOCK"` is the most reliable and requires no extra system configuration.

## Reference documentation
- [Developing parallel programs using snowfall](./references/snowfall.md)