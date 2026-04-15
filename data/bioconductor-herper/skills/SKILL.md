---
name: bioconductor-herper
description: Herper provides an interface to install and manage Conda-based software and system requirements directly within the R environment. Use when user asks to install Conda tools from R, manage external dependencies for R packages, or automate Miniconda setup for bioinformatics workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/Herper.html
---

# bioconductor-herper

## Overview

Herper is a Bioconductor package designed to bridge the gap between R and the Conda package management system. It provides a user-friendly interface to install, manage, and utilize Conda-based software without leaving the R environment. This is particularly useful for bioinformatics workflows that rely on command-line tools which are difficult to install manually. Herper also features automated system requirement discovery for R packages, ensuring that necessary external libraries are present.

## Core Functions and Workflows

### Installing Conda Tools

The primary function for installing software is `install_CondaTools()`. It handles Miniconda installation automatically if it is not already present.

```r
library(Herper)

# Define a path for Miniconda (optional, defaults to reticulate's default)
my_conda_path <- file.path(tempdir(), "my_mini")

# Install specific tools into a named environment
# Format: "package" or "package==version"
install_CondaTools(
  tools = c("salmon==1.3.0", "samtools"), 
  env = "rnaseq_env", 
  pathToMiniConda = my_conda_path
)
```

### Managing R Package System Requirements

Herper can scan an R package's `SystemRequirements` field and attempt to install those dependencies via Conda using `install_CondaSysReqs()`.

```r
# Install system requirements for a specific package
conda_paths <- install_CondaSysReqs(
  pkg = "Herper", 
  pathToMiniConda = my_conda_path
)

# The returned object contains paths to the environment and binaries
# conda_paths$pathToEnvBin
```

### Using Installed Tools

Once tools are installed via Herper, they can be called from R using `system2()` by referencing the path provided by Herper or by using `reticulate` to manage the environment.

```r
# Example of calling an installed tool
bin_path <- file.path(my_conda_path, "envs", "rnaseq_env", "bin", "salmon")
system2(bin_path, args = "--version")
```

## Tips for Success

- **Environment Isolation**: Always use descriptive names for the `env` parameter to keep different project dependencies separate.
- **Version Locking**: Specify versions (e.g., `"tool==1.2.3"`) to ensure reproducibility of your analysis.
- **Miniconda Path**: If working on a shared cluster, check if Miniconda is already installed and provide that path to `pathToMiniConda` to avoid redundant installations.
- **Permissions**: Ensure you have write permissions to the directory specified in `pathToMiniConda`.

## Reference documentation

- [Herper Quick Start Guide (Rmd)](./references/QuickStart.Rmd)
- [Herper Quick Start Guide (Markdown)](./references/QuickStart.md)