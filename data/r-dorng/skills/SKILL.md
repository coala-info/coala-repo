---
name: r-dorng
description: This tool provides functions to perform reproducible parallel foreach loops in R using independent random streams. Use when user asks to ensure consistent results in parallel computations, use the %dorng% operator, or generate reproducible random numbers across multiple workers.
homepage: https://cloud.r-project.org/web/packages/doRNG/index.html
---


# r-dorng

name: r-dorng
description: Provides functions to perform reproducible parallel foreach loops using independent random streams. Use this skill when you need to ensure that parallel R computations using the 'foreach' package produce identical results regardless of the number of workers, task scheduling, or the specific parallel backend (e.g., doParallel, doMPI, doSNOW) being used.

# r-dorng

## Overview
The `doRNG` package addresses the challenge of reproducibility in parallel computing. Standard `%dopar%` loops often produce different results depending on the parallel environment. `doRNG` implements L'Ecuyer's combined multiple-recursive generator to provide independent random streams for each iteration, ensuring that results are consistent and reproducible across different hardware and cluster configurations.

## Installation
```R
install.packages("r-dorng")
```

## Core Workflow
To make a parallel loop reproducible, replace the standard `%dopar%` operator with `%dorng%`.

### Basic Usage
```R
library(doRNG)
library(doParallel)

# Register a parallel backend
registerDoParallel(cores = 2)

# Use %dorng% for reproducible results
res1 <- foreach(i = 1:5) %dorng% {
  runif(3)
}

# Setting a specific seed for the loop
res2 <- foreach(i = 1:5) %dorng% 1234 {
  runif(3)
}
```

### Reproducing Results
The results of a `%dorng%` loop depend only on the initial seed and the sequence of iterations, not on how the iterations are distributed among workers.

```R
# This will produce the same result regardless of the number of cores
set.seed(123)
res_a <- foreach(i = 1:10) %dorng% { rnorm(1) }

set.seed(123)
res_b <- foreach(i = 1:10) %dorng% { rnorm(1) }

identical(res_a, res_b) # Returns TRUE
```

## Key Functions
- `%dorng%`: A reproducible alternative to `%dopar%`. It automatically handles the setup of independent random streams for each iteration.
- `registerDoRNG(seed)`: Registers `doRNG` as a foreach adapter. Once called, subsequent standard `%dopar%` loops will be executed reproducibly using the provided seed.
- `doRNGversion(v)`: Sets or gets the version of the RNG algorithm. Useful for backward compatibility with older versions of the package.

## Best Practices
- **Seeding**: Always provide a seed either via `set.seed()` before the loop or by passing the seed directly to the `%dorng%` operator (e.g., `%dorng% 123`).
- **Nested Loops**: `doRNG` supports nested `foreach` loops. Use `%dorng%` for the outer loop to ensure the entire structure is reproducible.
- **Performance**: The overhead of generating independent streams is generally negligible compared to the computation time of the loop iterations themselves.

## Reference documentation
- [Generic Reproducible Parallel Backend for foreach Loops](./references/home_page.md)