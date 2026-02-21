---
name: r-future
description: "The purpose of this package is to provide a lightweight and     unified Future API for sequential and parallel processing of R     expression via futures.  The simplest way to evaluate an expression     in parallel is to use 'x %&lt;-% { expression }' with 'plan(multisession)'.     This package implements sequential, multicore, multisession, and     cluster futures.  With these, R expressions can be evaluated on the     local machine, in parallel a set of local machines, or distributed     on a mix of local and remote machines.     Extensions to this package implement additional backends for     processing futures via compute cluster schedulers, etc.     Because of its unified API, there is no need to modify any code in order     switch from sequential on the local machine to, say, distributed     processing on a remote compute cluster.     Another strength of this package is that global variables and functions     are automatically identified and exported as needed, making it     straightforward to tweak existing code to make use of futures.</p>"
homepage: https://cloud.r-project.org/web/packages/future/index.html
---

# r-future

name: r-future
description: Unified parallel and distributed processing in R using the future framework. Use this skill when you need to evaluate R expressions asynchronously, parallelize loops or map functions, or manage distributed compute resources (local multicore, multisession, or remote clusters). It provides guidance on setting up execution plans, handling global variables, and troubleshooting common parallelization issues like non-exportable objects.

# r-future

## Overview

The `future` package provides a unified API for parallel and distributed processing in R. It allows you to write code once and switch between sequential, multicore, multisession, and cluster backends without changing the core logic. A "future" is an abstraction for a value that will be available at some point.

## Installation

```r
install.packages("future")
```

## Core Workflow

### 1. Define a Plan
The `plan()` function determines how futures are resolved.

*   `plan(sequential)`: Default; synchronous evaluation in the current R session.
*   `plan(multisession)`: Background R sessions on the local machine (works on all OS).
*   `plan(multicore)`: Forked R processes (Linux/macOS only; not for RStudio).
*   `plan(cluster, workers = c("n1", "n2"))`: External R sessions on local or remote machines.

### 2. Create Futures
There are two main styles:

**Implicit Assignment (`%<-%`)**
```r
library(future)
plan(multisession)

v %<-% {
  # This block runs in the background
  Sys.sleep(2)
  sum(runif(100))
}
# The main process is NOT blocked here.
# Accessing 'v' will block until the result is ready.
print(v) 
```

**Explicit Futures (`future()` and `value()`)**
```r
f <- future({
  sum(runif(100))
})
# Check if finished without blocking
resolved(f) 
# Retrieve result (blocks if not ready)
v <- value(f) 
```

## Advanced Usage

### Nested Topologies
You can define different strategies for nested loops by passing a list to `plan()`.
```r
# Outer loop: multisession; Inner loop: sequential (default protection)
plan(list(multisession, sequential))

# Force nested parallelism (use with caution)
plan(list(tweak(multisession, workers = 2), tweak(multisession, workers = I(2))))
```

### Global Variables and Packages
The package automatically identifies globals, but sometimes needs help:
*   **Manual Globals**: `f <- future({ ... }, globals = c("my_var"))`
*   **Required Packages**: `f <- future({ ... }, packages = c("data.table"))`

### Handling Output
Standard output (`cat`, `print`) and messages are captured and "relayed" to the main session when the future's value is queried.

## Common Issues & Tips

*   **Non-Exportable Objects**: Objects like file connections, database handles (DBI), or certain C++ pointers (Rcpp/externalptr) cannot be sent to workers. Use `options(future.globals.onReference = "error")` to detect these early.
*   **List Environments**: To use futures in a loop with indices, use the `listenv` package:
    ```r
    library(listenv)
    x <- listenv()
    for (i in 1:3) x[[i]] %<-% { i^2 }
    as.list(x)
    ```
*   **Globals in Strings**: Functions like `get()` or `glue()` that reference variables via strings often fail to export globals automatically. Use the `%globals%` operator or dummy variable injection (e.g., `{ var_name; get("var_name") }`).

## Reference documentation

- [A Future for R: A Comprehensive Overview](./references/future-1-overview.md)
- [A Future for R: Text and Message Output](./references/future-2-output.md)
- [A Future for R: Available Future Backends](./references/future-2b-backend.md)
- [A Future for R: Future Topologies](./references/future-3-topologies.md)
- [A Future for R: Common Issues with Solutions](./references/future-4-issues.md)
- [A Future for R: Non-Exportable Objects](./references/future-4-non-exportable-objects.md)
- [A Future for R: Execution Startup Control](./references/future-5-startup.md)
- [A Future for R: Future API Backend Specification](./references/future-6-future-api-backend-specification.md)
- [A Future for R: For Package Developers](./references/future-7-for-package-developers.md)
- [A Future for R: How Future is Validated](./references/future-8-how-future-is-validated.md)