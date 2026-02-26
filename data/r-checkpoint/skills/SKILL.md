---
name: r-checkpoint
description: The r-checkpoint tool manages R package reproducibility by installing specific package versions from a CRAN snapshot date. Use when user asks to ensure R script reproducibility, install packages from a specific date, or manage project-specific package dependencies.
homepage: https://cloud.r-project.org/web/packages/checkpoint/index.html
---


# r-checkpoint

name: r-checkpoint
description: Manage R package reproducibility by installing specific package versions from a CRAN snapshot date. Use this skill when you need to ensure an R script runs with the exact package versions available on a specific date, when sharing reproducible R code, or when managing multiple projects with conflicting package version requirements.

# r-checkpoint

## Overview

The `checkpoint` package solves the problem of package reproducibility in R by allowing you to install packages from a specific snapshot date. It acts as a "CRAN time machine," ensuring that your scripts use the exact package versions that existed at a specific point in time, regardless of updates that have occurred since.

## Installation

```r
install.packages("checkpoint")
```

## Core Workflow

The primary way to use the package is the `checkpoint()` function, which automates the scanning and installation process.

### Basic Usage
Place this snippet at the very top of your R script:

```r
library(checkpoint)
checkpoint("2020-01-01") # Replace with your desired YYYY-MM-DD
```

### How it Works
1. **Scan**: It scans the current project directory for `library()`, `require()`, `::`, and `:::`.
2. **Create**: It creates a local library folder under `~/.checkpoint/` for that specific date.
3. **Install**: It downloads and installs the required packages from the MRAN snapshot for that date.
4. **Use**: It points `.libPaths()` and `options(repos)` to the checkpointed library and snapshot.

## Advanced Usage

### Restricting R Version
To ensure even stricter reproducibility, specify the R version:
```r
checkpoint("2020-01-01", r_version = "3.6.2")
```

### Managing Checkpoints
- **Reset Session**: Use `uncheckpoint()` to return to your original library paths and CRAN mirror.
- **Update Checkpoint**: Run `create_checkpoint()` to re-scan and install new dependencies added to your project.
- **Cleanup**: Use `delete_checkpoint("2020-01-01")` or `delete_all_checkpoints()` to remove unused libraries.

### Project Management Tips
- **Working Directory**: Always ensure your working directory is set to the specific project folder before running `checkpoint()`. If run in a root user directory, it may scan every R file on your computer.
- **RMarkdown**: `checkpoint` automatically detects `.Rmd` files and includes the `rmarkdown` package as a dependency.
- **Debugging**: If installation fails, check the `.json` files in the checkpoint directory (e.g., `~/.checkpoint/YYYY-MM-DD/`) for detailed logs from the `pkgdepends` engine.

## Reference documentation

- [checkpoint - Install Packages from Snapshots](./references/README.md)
- [Using checkpoint for reproducible research](./references/checkpoint.Rmd)