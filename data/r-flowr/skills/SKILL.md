---
name: r-flowr
description: The r-flowr tool designs, manages, and executes complex, reproducible workflows and pipelines within the R environment. Use when user asks to create task dependencies, define pipeline structures, or submit jobs to computing clusters like SLURM, SGE, and LSF.
homepage: https://cran.r-project.org/web/packages/flowr/index.html
---


# r-flowr

name: r-flowr
description: Designing, managing, and executing complex workflows in R. Use this skill when the user needs to create reproducible pipelines, define dependencies between tasks, and submit jobs to computing clusters (LSF, SGE, SLURM) or run them locally.

# r-flowr

## Overview
The `flowr` package provides a framework for creating and managing workflows in R. It allows users to define a series of tasks (steps), specify dependencies between them, and execute them across various computing platforms. It is particularly useful for bioinformatics pipelines and data science workflows that require high-performance computing (HPC) integration.

## Installation
```r
install.packages("flowr")
library(flowr)
```

## Core Concepts
- **Flow**: A collection of steps with defined dependencies.
- **Step**: A single unit of work (an R function or shell command).
- **Flow Definition**: A data frame or tab-separated file defining the pipeline structure.
- **Flow Mat**: A data frame containing the actual commands to be executed.

## Workflow Implementation

### 1. Create a Flow Definition
The definition table specifies the logic of the pipeline.
Required columns:
- `step_name`: Unique name for the step.
- `dep_step`: Name of the step(s) this step depends on.
- `submit_node`: Where to run (e.g., 'head' or 'compute').
- `cpu`/`mem`/`walltime`: Resource requirements.

```r
# Example definition
df_def <- data.frame(
  step_name = c("step1", "step2"),
  dep_step = c(NA, "step1"),
  submit_node = c("compute", "compute"),
  cpu = c(1, 2)
)
```

### 2. Create a Flow Mat
The flow mat contains the specific commands for each iteration/sample.
Required columns:
- `samplename`: Unique identifier for the run.
- `step_name`: Matches the definition.
- `cmd`: The actual shell command or R code to run.

```r
# Example flow mat
df_mat <- data.frame(
  samplename = "sample1",
  step_name = c("step1", "step2"),
  cmd = c("echo 'hello' > out.txt", "cat out.txt")
)
```

### 3. Assemble and Run
Use `to_flow` to combine the definition and mat, then `submit_flow` to execute.

```r
# Create flow object
f_obj <- to_flow(df_mat, df_def)

# Execute (default is 'local', or use 'slurm', 'sge', 'lsf')
submit_flow(f_obj, platform = "local")
```

## Key Functions
- `to_flow()`: Combines commands and definitions into a flow object.
- `submit_flow()`: Submits the flow to the specified cluster or local machine.
- `status()`: Checks the progress of a submitted flow.
- `kill_flow()`: Terminates a running flow.
- `rerun()`: Restarts a flow from a specific point of failure.
- `setup()`: Configures default cluster settings and paths.

## Best Practices
- **Modularize**: Keep commands in the `flow_mat` simple; wrap complex R logic into scripts that the `cmd` column calls via `Rscript`.
- **Resource Estimation**: Always provide realistic `cpu` and `mem` values in the definition to avoid cluster rejection.
- **Check Logic**: Use `plot_flow(f_obj)` to visualize the dependency graph before submission.
- **Dry Run**: Use `submit_flow(..., execute = FALSE)` to generate the scripts without actually submitting them to the queue.

## Reference documentation
None