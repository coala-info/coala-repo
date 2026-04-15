---
name: bioconductor-biocparallel
description: BiocParallel provides a unified interface for performing parallel computing across various R backends and cluster schedulers. Use when user asks to parallelize R code, distribute tasks across multiple cores or clusters, manage parallel backends, or handle errors in distributed computations.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocParallel.html
---

# bioconductor-biocparallel

## Overview

`BiocParallel` provides a unified interface for parallel computing across different R backends. It allows developers and users to write code once and execute it on multiple cores, clusters (SGE, SLURM, LSF), or ad-hoc socket connections by simply changing a `BPPARAM` object. It is the standard for parallelization within the Bioconductor ecosystem.

## Core Workflows

### 1. Parallel Iteration
The primary functions mimic the base R `*apply` family but distribute tasks across workers.

```R
library(BiocParallel)

# Standard list apply
results <- bplapply(1:10, function(x) sqrt(x))

# Vectorized apply (subsets X into chunks)
results_vec <- bpvec(1:100, function(x) sqrt(x))

# Iterating over files or streams (e.g., BAM files)
# ITER is a function returning the next chunk or NULL
results_iter <- bpiterate(ITER, FUN)
```

### 2. Managing Backends (BPPARAM)
Backends are configured using `Param` objects.

*   **MulticoreParam**: Uses forked processes (Unix/macOS only). Efficient due to copy-on-change memory.
*   **SnowParam**: Uses separate R instances (Sockets or MPI). Works on all platforms, including Windows.
*   **BatchtoolsParam**: Interfaces with cluster schedulers (SLURM, SGE, etc.).
*   **SerialParam**: Runs code sequentially. Essential for debugging.

```R
# Define a specific backend
param <- SnowParam(workers = 4, type = "SOCK")

# Use it in a function
bplapply(1:10, sqrt, BPPARAM = param)

# Register a default backend for the session
register(SnowParam(workers = 2))
bplapply(1:10, sqrt) # Uses the registered SnowParam
```

### 3. Error Handling and Debugging
`BiocParallel` can capture errors and return partial results instead of failing the entire job.

*   **Stop on Error**: Set `stop.on.error = FALSE` to collect results from successful tasks even if some fail.
*   **bptry**: Wrap calls to catch errors gracefully.
*   **BPREDO**: Rerun only the failed tasks after fixing the input or function.

```R
# Catching errors
param <- SnowParam(workers = 2, stop.on.error = FALSE)
res <- bptry(bplapply(list(1, "a", 3), sqrt, BPPARAM = param))

# Identify failures
bpok(res) # [1] TRUE FALSE TRUE

# Rerun failed tasks
fixed_list <- list(1, 2, 3)
final_res <- bplapply(fixed_list, sqrt, BPREDO = res, BPPARAM = param)
```

### 4. Reproducible Random Numbers
To ensure reproducibility across parallel workers, use the `RNGseed` argument in the Param constructor. `BiocParallel` uses the L'Ecuyer-CMRG generator to create independent streams.

```R
# Reproducible parallel random numbers
param <- SnowParam(workers = 2, RNGseed = 123)
bplapply(1:3, runif, BPPARAM = param)
```

### 5. Logging
Enable logging to monitor worker progress or troubleshoot silent failures.

```R
param <- SnowParam(workers = 2, log = TRUE, threshold = "INFO")
# Logs will be printed to the console or written to logdir if specified
```

## Best Practices
*   **Windows Compatibility**: Always use `SnowParam` instead of `MulticoreParam` for cross-platform scripts.
*   **Memory Management**: Forked processes (`MulticoreParam`) share memory until modified, but R's garbage collector can trigger unexpected memory copying.
*   **Package Loading**: In `SnowParam`, ensure `FUN` explicitly loads required libraries or use the `packages` argument in `BatchtoolsParam`.
*   **Avoid Nested Registration**: Developers should not call `register()` inside package functions; instead, accept a `BPPARAM` argument.

## Reference documentation
- [Introduction to BatchtoolsParam](./references/BiocParallel_BatchtoolsParam.md)
- [Errors, Logs and Debugging in BiocParallel](./references/Errors_Logs_And_Debugging.md)
- [Introduction to BiocParallel](./references/Introduction_To_BiocParallel.md)
- [Random Numbers in BiocParallel](./references/Random_Numbers.md)