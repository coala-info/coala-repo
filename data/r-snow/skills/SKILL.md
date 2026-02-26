---
name: r-snow
description: The r-snow package provides a high-level interface for executing parallel computing tasks across a cluster of worker processes in R. Use when user asks to initialize a socket or MPI cluster, export variables to worker nodes, or execute functions in parallel using clusterApply or parLapply.
homepage: https://cloud.r-project.org/web/packages/snow/index.html
---


# r-snow

## Overview

The `snow` (Simple Network of Workstations) package provides a high-level interface for parallel computing in R. It allows a master R process to control a cluster of worker processes, distributing tasks and collecting results. It supports socket-based clusters (easiest for local multi-core use) and MPI-based clusters (for high-performance computing environments).

## Installation

Install the package from CRAN:

```R
install.packages("snow")
```

For MPI support, the `Rmpi` package and a system MPI implementation (like Open MPI) are required. For parallel random number generation, `rlecuyer` is recommended.

## Core Workflow

### 1. Initialize a Cluster
Create a cluster object specifying the number of nodes or specific hostnames.

```R
library(snow)

# Create a local socket cluster with 4 workers
cl <- makeSOCKcluster(4)

# Or create an MPI cluster (requires Rmpi)
# cl <- makeMPIcluster(4)
```

### 2. Prepare the Workers
Workers start with a clean environment. You must export variables or load libraries needed for the computation.

```R
# Export a variable to all workers
x <- 10
clusterExport(cl, "x")

# Load a library on all workers
clusterEvalQ(cl, library(MASS))
```

### 3. Execute Parallel Tasks
Use the `clusterApply` family of functions, which mirror R's base `apply` functions.

```R
# Parallel version of lapply
results <- clusterApplyLB(cl, 1:10, function(i) {
  # Perform computation
  sqrt(i + x)
})

# clusterApply: Basic parallel apply
# clusterApplyLB: Load-balanced version (recommended for varying task lengths)
# clusterMap: Parallel version of mapply
# clusterCall: Calls a function on each node with the same arguments
```

### 4. Stop the Cluster
**Critical:** Always shut down the cluster to prevent stray R processes from consuming system resources.

```R
stopCluster(cl)
```

## Key Functions

| Function | Description |
| :--- | :--- |
| `makeCluster(spec, type)` | General constructor for clusters (type "SOCK" or "MPI"). |
| `clusterExport(cl, list)` | Assigns values of global variables to workers. |
| `clusterEvalQ(cl, expr)` | Evaluates an arbitrary expression on each worker. |
| `clusterApply(cl, x, fun, ...)` | Distributes elements of `x` to workers. |
| `clusterApplyLB(cl, x, fun, ...)` | Load-balanced version of `clusterApply`. |
| `parLapply(cl, x, fun, ...)` | Parallel `lapply`. |
| `parSapply(cl, x, fun, ...)` | Parallel `sapply`. |

## Best Practices

- **Load Balancing:** Use `clusterApplyLB` or `parLapply` when tasks have different execution times or workers have different processing speeds.
- **Memory Management:** Large objects exported via `clusterExport` consume memory on every worker node.
- **Random Numbers:** For reproducible parallel results, use `clusterSetupRNG(cl)` which requires the `rlecuyer` package.
- **Debugging:** If a cluster fails to start, use `makeSOCKcluster(..., manual = TRUE)` to see the manual startup command or use the `outfile` option to capture worker logs.

## Reference documentation

- [SNOW: Simple Network of Workstations](./references/README.md)
- [snow: Simple Network of Workstations Home Page](./references/home_page.md)