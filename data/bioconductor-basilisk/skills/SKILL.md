---
name: bioconductor-basilisk
description: The basilisk package provides a framework for Bioconductor packages to provision and manage dedicated, isolated Python environments to ensure version stability and reproducibility. Use when user asks to create a BasiliskEnvironment, execute Python code via basiliskRun, manage local Python instances for R scripts, or configure environment storage settings.
homepage: https://bioconductor.org/packages/release/bioc/html/basilisk.html
---


# bioconductor-basilisk

## Overview

The `basilisk` package provides a framework for Bioconductor packages to provision and use their own dedicated Python instances and virtual environments. It solves the "DLL hell" of Python versioning by isolating the Python environment used by a specific R package from the system Python and from other R packages. It uses `reticulate` under the hood but wraps it in a process-safe, version-stable execution model.

## Core Workflow for Package Developers

### 1. Define the Environment
Create a `BasiliskEnvironment` object (typically in `R/basilisk.R`). Always specify explicit version numbers for Python and all packages to ensure reproducibility.

```r
library(basilisk)
my_env <- BasiliskEnvironment(
    envname="my_analysis_env",
    pkgname="MyPackageName",
    packages=c("pandas==2.2.3", "scikit-learn==1.6.1"),
    channels=c("conda-forge") # Optional: specify conda channels
)
```

### 2. Execute Python Code
Use `basiliskStart()` and `basiliskRun()` to execute code within the environment. This ensures the correct Python version is loaded and prevents conflicts.

```r
my_r_function <- function(data) {
    # Start the environment
    proc <- basiliskStart(my_env)
    on.exit(basiliskStop(proc))

    # Run code inside the environment
    result <- basiliskRun(proc, function(df) {
        pd <- reticulate::import("pandas")
        # Perform calculations...
        return(processed_df) 
    }, df = data)

    return(result)
}
```

### 3. Critical Constraints for `basiliskRun`
*   **Input/Output:** Arguments passed to the function and the return value must be **pure R objects**. You cannot return `reticulate` Python objects or pointers.
*   **Self-Containment:** The function passed to `basiliskRun` should not rely on the global environment. Pass all required variables as explicit arguments.
*   **Namespacing:** Use `::` for any non-base R functions used inside the `basiliskRun` closure (e.g., `stats::median(x)`).

## Direct Analysis for End Users

Users can create local environments for specific scripts without building a full R package:

```r
# Create a local environment in a temporary directory
tmp_env <- createLocalBasiliskEnv(
    "my_local_python",
    packages=c("numpy==2.2.2", "scipy==1.15.1")
)

# Use it
res <- basiliskRun(env=tmp_env, fun=function() {
    np <- reticulate::import("numpy")
    np$array(c(1, 2, 3)) * 2
})
```

## Troubleshooting and Configuration

### Environment Variables
*   `BASILISK_EXTERNAL_DIR`: Set this to change where environments are stored (useful if the default path is too long for Windows or lacks space).
*   `BASILISK_USE_SYSTEM_DIR=1`: Forces installation into the R library directory (requires installation from source).
*   `BASILISK_CUSTOM_PYTHON_3_12`: Path to a specific Python binary to override `basilisk`'s automatic installation.

### Cleaning Up
If environments become corrupted or take up too much space:
```r
# Clear obsolete environments for a specific package
basilisk::clearExternalDir(package = "MyPackage", obsolete.only = TRUE)

# Clear everything managed by basilisk
basilisk.utils::clearExternalDir()
```

### Windows Path Limits
Windows has a 260-character path limit. If installation fails silently, set `BASILISK_EXTERNAL_DIR` to a short path like `C:\bioc-py`.

## Reference documentation

- [Freezing Python versions inside Bioconductor packages](./references/motivation.md)
- [Motivation for Basilisk](./references/motivation.Rmd)