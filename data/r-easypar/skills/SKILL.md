---
name: r-easypar
description: R package easypar (documentation from project home).
homepage: https://cran.r-project.org/web/packages/easypar/index.html
---

# r-easypar

name: r-easypar
description: Parallel computing in R using easypar. Use this skill to run R functions in parallel on multi-core architectures or to generate array job submission scripts for LSF and PBSpro cluster systems. It is ideal for switching between serial and parallel execution for debugging and production.

## Overview

The `easypar` package simplifies parallelizing R functions. It provides a unified interface to `doParallel` for local multi-core execution and generates shell/R script templates for High-Performance Computing (HPC) schedulers like LSF and PBSpro. Key features include runtime switching between serial/parallel modes, result caching, and error handling.

## Installation

```R
# Install from GitHub as it is the primary source
devtools::install_github("caravagnalab/easypar")
```

## Local Parallel Execution

The primary function for local execution is `easypar::run()`.

### Basic Workflow
1. **Define a function**: Create a function where arguments represent the parameters for one task.
2. **Prepare inputs**: Create a list of lists, where each sub-list contains the arguments for one call.
3. **Execute**: Use `run()` to execute across available cores.

```R
library(easypar)

# 1. Function
my_fun <- function(x, y) { x + y }

# 2. Inputs (List of lists)
params <- list(list(x=1, y=2), list(x=3, y=4), list(x=5, y=6))

# 3. Run
results <- easypar::run(FUN = my_fun, PARAMS = params, parallel = TRUE)
```

### Key Parameters for `run()`
- `FUN`: The function to execute.
- `PARAMS`: A list of lists containing function arguments.
- `parallel`: Boolean to toggle parallel execution.
- `cores`: Fraction (0 to 1) of available cores to use.
- `cache`: Path to an `.rds` file to save results incrementally.
- `outfile`: Set to `''` to see console output from threads (asynchronous).

### Global Control
You can override the `parallel` argument globally, which is useful for debugging:
```R
options(easypar.parallel = FALSE) # Forces serial execution
```

### Error Handling
`easypar` captures errors without stopping the entire loop.
- `numErrors(results)`: Returns the count of failed tasks.
- `filterErrors(results)`: Returns only the successful results.

## HPC Array Jobs

`easypar` can generate the necessary files (`.sh`, `.R`, and `.csv`) to submit array jobs to clusters.

### LSF Clusters
Use `run_lsf()` to generate submission scripts.
```R
# PARAMS must be a data.frame for cluster jobs
params_df <- data.frame(x = 1:10, y = 11:20)

# Customize BSUB settings
config <- default_BSUB_config(J = 'my_job', P = 'my_project', q = 'short')

# Generate files
run_lsf(FUN = my_fun, PARAMS = params_df, BSUB_config = config, modules = 'R/4.0.0')
```
**Submission**: Run `bsub < EASYPAR_LSF_submission.sh` in the terminal.

### PBSpro Clusters
Use `run_PBSpro()` to generate submission scripts.
```R
# Customize QSUB settings
config <- default_QSUB_config(J = 'my_job', project = 'my_project', queue = 'thin')

# Generate files
run_PBSpro(FUN = my_fun, PARAMS = params_df, QSUB_config = config)
```
**Submission**: Run `qsub < EASYPAR_PBSpro_submission.sh` in the terminal.

## Reference documentation

- [Get started](./references/easypar.html.md)
- [easypar Home](./references/home_page.md)
- [LSF array jobs with easypar](./references/lsf.html.md)
- [PBSpro array jobs with easypar](./references/pbspro.html.md)