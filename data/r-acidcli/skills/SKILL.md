---
name: r-acidcli
description: This tool provides a standardized command-line interface toolkit for managing messaging and session states in R scripts. Use when user asks to standardize console output, handle errors in R scripts, or manage interactive CLI sessions.
homepage: https://cran.r-project.org/web/packages/acidcli/index.html
---


# r-acidcli

name: r-acidcli
description: Interactive R command line interface (CLI) toolkit for Acid Genomics packages. Use this skill to standardize console output, handle errors, and manage interactive sessions within R scripts, particularly when developing or using Acid Genomics ecosystem tools.

## Overview

The `acidcli` package provides a suite of utilities designed to create a consistent command-line experience within R. It is primarily used by Acid Genomics packages to handle messaging, error reporting, and session initialization in a standardized way. It helps developers create R scripts that behave like professional CLI tools.

## Installation

To install the package from the Acid Genomics repository:

```r
install.packages(
    pkgs = "AcidCLI",
    repos = c(
        "https://r.acidgenomics.com",
        getOption("repos")
    ),
    dependencies = TRUE
)
```

## Main Functions and Workflows

### Standardized Messaging
Use these functions to provide consistent feedback during long-running R scripts.

- `initMessage()`: Initialize a CLI message, typically used at the start of a function or script to announce the process.
- `finishMessage()`: Signal the successful completion of a process.
- `handleError()`: Provide a standardized way to catch and report errors in a CLI context.

### Session Management
- `isCli()`: Check if the current R session is running in a non-interactive command-line environment.
- `isInteractive()`: Determine if the session is interactive, allowing for different behavior (e.g., prompts vs. automated defaults).

### Workflow Example
When wrapping a complex analysis into a script:

```r
library(AcidCLI)

run_analysis <- function(data) {
    initMessage("Starting data analysis")
    
    # Wrap core logic in tryCatch for standardized error handling
    tryCatch({
        # Analysis logic here
        Sys.sleep(1) 
        finishMessage("Analysis complete")
    }, error = function(e) {
        handleError(e)
    })
}
```

## Tips for Usage
- **Acid Genomics Integration**: This package is a dependency for many other Acid Genomics tools (like `acidbase` or `basejump`). Use it when you want your custom scripts to match the look and feel of those packages.
- **Environment Awareness**: Use `isCli()` to suppress certain graphical outputs or interactive prompts when running scripts via `Rscript`.

## Reference documentation
- [AcidCLI Home Page](./references/home_page.md)