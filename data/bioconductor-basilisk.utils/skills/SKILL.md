---
name: bioconductor-basilisk.utils
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/basilisk.utils.html
---

# bioconductor-basilisk.utils

## Overview

`basilisk.utils` provides a standardized way for Bioconductor packages to access and manage conda environments. It automates the installation of a local Miniforge instance if a suitable system conda is not found, ensuring that R packages with Python dependencies have a reliable, isolated execution environment without requiring manual user intervention.

## Core Functions

### Finding Conda
To locate the conda executable managed or recognized by the package:
```r
basilisk.utils::find()
```
This returns the path to the conda binary, either from the system `PATH` (if version requirements are met) or from the internal Bioconductor cache.

### Managing Environments
Developers define environments as lists of arguments to be passed to `createEnvironment()`.

**Defining environments (typically in `R/environments.R`):**
```r
env_args <- list(
    pkg="myPackageName",
    name="analysis_env",
    version="1.0.0",
    packages=c("pandas=2.1.0", "scipy=1.11.0")
)
```

**Creating/Accessing environments:**
```r
# This lazily creates the environment on the first call
env_path <- do.call(basilisk.utils::createEnvironment, env_args)
```

## Package Developer Workflow

1.  **Define Environments**: Create a dedicated R file (e.g., `R/environments.R`) containing the configuration lists for your required environments.
2.  **Lazy Instantiation**: Wrap the `createEnvironment` call inside your package functions so the environment is only built when needed.
3.  **Configure Scripts**: Add `configure` (and `configure.win` for Windows) to your package root to allow pre-installation of environments:
    ```bash
    #!/bin/sh
    ${R_HOME}/bin/Rscript -e "basilisk.utils::configureEnvironments('R/environments.R')"
    ```
4.  **DESCRIPTION file**: Ensure `StagedInstall: no` is set in your `DESCRIPTION` file to prevent issues with hard-coded paths in the conda installation.

## Configuration and Defaults

You can control the behavior of `basilisk.utils` using environment variables before loading the package or calling its functions:

*   **Minimum Version**: `BIOCCONDA_CONDA_MINIMUM_VERSION` (e.g., "24.11.3")
*   **System Install**: Set `BIOCCONDA_USE_SYSTEM_INSTALL=TRUE` to force environment creation during R package installation (useful for Docker/HPC admins).
*   **Cache Location**: Controlled via `basilisk.utils::defaultCacheDirectory()`, which respects standard R cache paths.

To check current defaults:
```r
basilisk.utils::defaultMinimumVersion()
basilisk.utils::defaultDownloadVersion()
basilisk.utils::defaultCacheDirectory()
```

## Reference documentation

- [Purpose and Overview](./references/purpose.md)