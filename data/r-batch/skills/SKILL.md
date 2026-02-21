---
name: r-batch
description: Functions to allow you to easily pass command-line arguments into R, and functions to aid in submitting your R code in parallel on a cluster and joining the results afterward (e.g. multiple parameter values for simulations running in parallel, splitting up a permutation test in parallel, etc.). See &lsquo;parseCommandArgs(...)&rsquo; for the main example of how to use this package.</p>
homepage: https://cloud.r-project.org/web/packages/batch/index.html
---

# r-batch

name: r-batch
description: Handles command-line argument parsing and parallel batch job submission in R. Use this skill when writing R scripts that need to accept external parameters via the command line or when splitting large tasks into parallel batch processes for cluster execution.

# r-batch

## Overview
The `batch` package simplifies the process of passing command-line arguments to R scripts and managing parallel batch jobs. It is particularly useful for running simulations with varying parameters or splitting large permutation tests across a cluster.

## Installation
```R
install.packages("batch")
```

## Command-Line Arguments
The core function `parseCommandArgs()` allows you to pass parameters directly from the shell into your R session.

### Basic Usage
In your R script (e.g., `analysis.R`):
```R
library(batch)
# Automatically parses arguments and assigns them to the global environment
parseCommandArgs()

# If you ran: R --vanilla --args n 100 type 'linear' < analysis.R
# You now have variables: n = 100, type = "linear"
print(n)
print(type)
```

### Advanced Parsing
To avoid cluttering the global environment, you can return arguments as a list:
```R
args <- parseCommandArgs(evaluate = FALSE)
my_n <- args$n
```

## Batch Job Management
The package provides routines to automate the submission of multiple R jobs and the subsequent merging of their results.

### Submitting Jobs
Use `rbatch()` to generate shell commands or submit jobs for a range of parameters.
```R
library(batch)
# Submits analysis.R 10 times, passing a different 'seed' each time
rbatch("analysis.R", seed = 1:10)
```

### Splitting and Merging
For tasks like permutation tests, use `msplit()` to divide the work and `mergeBatch()` to collect results.

1. **Split**: Divide a large number of iterations into smaller chunks.
2. **Run**: Execute chunks in parallel (often via a cluster scheduler).
3. **Merge**:
```R
library(batch)
# Merges all .Rdata files in the directory that share a common prefix
# Useful for joining results from parallel simulation runs
mergeBatch(prefix = "sim_results")
```

## Tips
- **Argument Types**: `parseCommandArgs` attempts to automatically detect types (numeric vs. character).
- **Default Values**: Define variables in your script before calling `parseCommandArgs()`; if the argument isn't provided in the command line, the pre-defined value remains.
- **Cluster Integration**: `rbatch` is designed to work well with traditional batch queuing systems (like Slurm or LSF) by generating the necessary system calls.

## Reference documentation
- [batch: Batching Routines in Parallel and Passing Command-Line Arguments to R](./references/home_page.md)