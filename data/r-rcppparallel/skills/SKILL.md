---
name: r-rcppparallel
description: "High level functions for parallel programming with 'Rcpp'.     For example, the 'parallelFor()' function can be used to convert the work of     a standard serial \"for\" loop into a parallel one and the 'parallelReduce()'     function can be used for accumulating aggregate or other values.</p>"
homepage: https://cloud.r-project.org/web/packages/RcppParallel/index.html
---

# r-rcppparallel

name: r-rcppparallel
description: High-level parallel programming in R using Rcpp and Intel TBB. Use this skill when you need to convert serial C++ loops into parallel ones using `parallelFor`, perform parallel aggregations with `parallelReduce`, or manage thread configurations for Rcpp-based packages.

# r-rcppparallel

## Overview

The `RcppParallel` package provides a complete toolkit for creating safe, portable, and high-performance parallel algorithms within Rcpp. It abstracts away low-level threading details by using Intel Threading Building Blocks (TBB) on most platforms, allowing developers to focus on data structures and logic rather than mutexes and thread management.

## Installation

```R
install.packages("RcppParallel")
```

## Core Workflows

### 1. Parallel For Loops (`parallelFor`)
Used to transform a standard serial `for` loop into a parallel one. This is ideal for element-wise operations or independent task processing.

**Pattern:**
1. Define a `Worker` struct that inherits from `RcppParallel::Worker`.
2. Implement the operator `void operator()(std::size_t begin, std::size_t end)`.
3. Call `RcppParallel::parallelFor(0, n, worker)`.

### 2. Parallel Reductions (`parallelReduce`)
Used for accumulating values (sum, product, min/max) across a dataset.

**Pattern:**
1. Define a `Worker` struct.
2. Implement a "join" constructor: `Worker(const Worker& worker, RcppParallel::Split)`.
3. Implement a `join` method: `void join(const Worker& rhs)`.
4. Call `RcppParallel::parallelReduce(0, n, worker)`.

### 3. Thread Management
Control the global resource usage of the parallel backend.

- `defaultNumThreads()`: Get the default number of threads.
- `setThreadOptions(numThreads = "auto")`: Set the number of threads to use for task scheduling.

## Package Integration

If creating a new R package that depends on `RcppParallel`:
- Use `RcppParallel.package.skeleton("packageName")` to generate the required structure.
- Ensure `LinkingTo: Rcpp, RcppParallel` is in the `DESCRIPTION` file.
- Ensure `importFrom(RcppParallel, RcppParallelLibs)` is in the `NAMESPACE` file.
- Add `$(shell "${R_HOME}/bin/Rscript" -e "RcppParallel::LdFlags()")` to `src/Makevars`.

## Best Practices
- **Thread Safety**: Ensure that the `Worker` does not modify shared R objects (like `NumericVector`) in a way that causes race conditions. Use `RcppParallel::RVector` or `RcppParallel::RMatrix` wrappers for thread-safe access to R data.
- **Granularity**: TBB handles load balancing, but ensure the work inside the operator is significant enough to overcome threading overhead.
- **Avoid R API**: Do not call R API functions (e.g., `Rf_error`, `Rcpp::print`) inside the parallel worker, as the R interpreter is single-threaded.

## Reference documentation
- [RcppParallel Reference Manual](./references/reference_manual.md)