---
name: r-batchjobs
description: BatchJobs provides an abstraction layer for managing and submitting batch computing jobs from R to cluster queuing systems. Use when user asks to create a job registry, submit R functions to a cluster scheduler, monitor job status, or collect results from batch computations.
homepage: https://cloud.r-project.org/web/packages/BatchJobs/index.html
---

# r-batchjobs

## Overview
`BatchJobs` provides an abstraction layer for batch computing in R. It allows users to define computational jobs, submit them to a cluster's queuing system, and collect results once finished. It handles the heavy lifting of creating registry directories, managing job states, and interfacing with schedulers like SLURM or PBS.

**Note:** While `BatchJobs` is stable, the developers recommend `batchtools` for new projects. Use this skill specifically when working with legacy `BatchJobs` codebases or specific environments requiring it.

## Installation
```R
install.packages("BatchJobs")
```

## Core Workflow

### 1. Create a Registry
A registry is a directory on the file system that stores job configurations, status, and results.
```R
library(BatchJobs)
# Create a registry for Map-like operations
reg <- makeRegistry(id = "my_batch_project", seed = 123, file.dir = "my_reg_dir")
```

### 2. Define Jobs (Map/Apply)
Use `batchMap` to define jobs based on a function and a set of arguments.
```R
# Define a function to run
my_fun <- function(x, y) {
  Sys.sleep(10) # Simulate work
  return(x + y)
}

# Add jobs to the registry
batchMap(reg, my_fun, x = 1:10, more.args = list(y = 100))
```

### 3. Submit Jobs
Submit defined jobs to the batch system.
```R
# Submit all jobs
submitJobs(reg)

# Submit specific job IDs with resource requirements
submitJobs(reg, ids = 1:5, resources = list(walltime = 3600, memory = 2048))
```

### 4. Monitor and Status
Check the progress of your jobs.
```R
showStatus(reg)
getJobStatus(reg)
# Find jobs that failed
findErrors(reg)
```

### 5. Collect Results
Once jobs are "Done", fetch the results into your R session.
```R
# Load result of a specific job
res1 <- loadResult(reg, id = 1)

# Reduce all results into a single object
all_res <- reduceResults(reg, fun = function(aggr, res) c(aggr, res))
```

## Configuration
To use a cluster (e.g., SLURM), you must provide a configuration file (`.BatchJobs.R`) in your working directory or home folder.

**Example `.BatchJobs.R` for SLURM:**
```R
cluster.functions <- makeClusterFunctionsSLURM("slurm_template.brew")
mail.start <- "none"
mail.done <- "none"
mail.error <- "user@example.com"
```
You also need a template file (e.g., `slurm_template.brew`) which defines the shell script submitted to the scheduler.

## Key Functions
- `makeRegistry()`: Initialize a new job database.
- `batchMap()`: Assign functions and data to jobs.
- `submitJobs()`: Send jobs to the queue.
- `showStatus()`: Summary of pending, running, and finished jobs.
- `loadResult()` / `reduceResults()`: Retrieve data.
- `getLogFiles()`: Inspect STDOUT/STDERR of jobs for debugging.
- `sweepErrors()`: Clear out error states to allow retrying.

## Tips
- **File System:** Ensure the `file.dir` is on a shared file system accessible by all cluster nodes.
- **Resources:** Always specify `resources` in `submitJobs` to avoid being killed by the scheduler for exceeding default limits.
- **Cleanup:** Use `removeRegistry(0)` to delete the registry and all associated files from the disk.

## Reference documentation
- [README](./references/README.md)