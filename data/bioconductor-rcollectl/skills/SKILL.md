---
name: bioconductor-rcollectl
description: The Rcollectl package provides an R interface to the collectl monitoring tool for measuring and visualizing system resource consumption. Use when user asks to monitor CPU and memory usage, benchmark R tasks, or profile system resource consumption during code execution.
homepage: https://bioconductor.org/packages/release/bioc/html/Rcollectl.html
---

# bioconductor-rcollectl

## Overview
The `Rcollectl` package provides an R interface to the `collectl` monitoring tool, allowing users to measure and visualize system resource consumption. It is particularly useful for benchmarking long-running R tasks to understand their impact on CPU, memory, disk I/O, and network activity.

## Basic Workflow
To measure the resource consumption of a specific R task, follow these steps:

1.  **Start Monitoring**: Initialize the collector before running your code.
    ```r
    library(Rcollectl)
    # id is a unique identifier for the monitoring session
    id <- cl_start("my_task_prefix")
    ```

2.  **Execute R Code**: Run the computations you wish to profile.
    ```r
    # Example task
    data <- matrix(rnorm(1e7), ncol = 1000)
    res <- solve(t(data) %*% data)
    ```

3.  **Stop Monitoring**: Terminate the background collection process.
    ```r
    cl_stop(id)
    ```

4.  **Parse and Visualize**: Load the generated data and plot the results.
    ```r
    # Locate the generated .tab.gz file using the prefix
    usage_df <- cl_parse(cl_result_path(id))
    
    # Generate a multi-panel plot of resource usage
    plot_usage(usage_df)
    ```

## Annotating Workflows with Timestamps
You can mark specific phases of your R script to see exactly where they occur on the resource usage timeline.

```r
id <- cl_start("annotated_run")

# Phase 1
cl_timestamp(id, "Data Loading")
Sys.sleep(2) 

# Phase 2
cl_timestamp(id, "Computation")
Sys.sleep(2)

cl_stop(id)
path <- cl_result_path(id)

# Plot with annotations
library(ggplot2)
plot_usage(cl_parse(path)) +
  cl_timestamp_layer(path) +
  cl_timestamp_label(path) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
```

## Data Inspection
The object returned by `cl_parse()` is a data frame where each row represents a sampling interval (default is 1 second).

- **Metadata**: Access system information (Host, CPU count, Memory total) via attributes:
  ```r
  attr(usage_df, "meta")
  ```
- **Columns**: Common columns include `CPU_User%`, `CPU_Sys%`, `MemUsed` (in KB), `NetRxKBTot`, and `DiskWriteKBTot`.

## Tips
- **File Prefixes**: Use descriptive prefixes in `cl_start()` to distinguish between different experimental runs.
- **Cleanup**: Always ensure `cl_stop()` is called, even if the R code fails, to prevent background processes from persisting.
- **Platform Support**: While the package is available on all platforms, the underlying `collectl` utility is Linux-based.

## Reference documentation
- [Rcollectl Vignette (Rmd)](./references/Rcollectl.Rmd)
- [Rcollectl Documentation (md)](./references/Rcollectl.md)