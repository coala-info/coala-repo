---
name: r-r.utils
description: The R.utils package provides a collection of utility functions that extend the base R environment for programming, package development, and system interactions. Use when user asks to validate function arguments, perform advanced file system operations, compress files, use string interpolation, or manage command-line arguments.
homepage: https://cloud.r-project.org/web/packages/R.utils/index.html
---


# r-r.utils

name: r-r.utils
description: Utility functions for R programming and package development. Use this skill when you need to perform common R programming tasks such as argument validation, file system manipulations (absolute/relative paths, directory copying, file compression), advanced string substitution (GStrings), progress bars, or session management.

# r-r.utils

## Overview
The `R.utils` package provides a vast collection of utility functions that extend the base R programming environment. It is particularly useful for package developers and for writing robust scripts that require advanced file handling, system interactions, and object-oriented programming support (via `R.oo`).

## Installation
To install the package from CRAN:
```R
install.packages("R.utils")
```

## Core Workflows and Functions

### Argument Validation and Assertions
The `Arguments` and `Assert` classes provide a standardized way to validate function inputs.
```R
library(R.utils)

foo <- function(n, path) {
  # Validate n is a single integer >= 1
  n <- Arguments$getInteger(n, range=c(1, Inf))
  # Validate path is a readable directory
  path <- Arguments$getReadablePath(path)
  
  # Generic assertion
  Assert$isVector(n)
}
```

### File and Directory Operations
`R.utils` simplifies complex file system tasks that are often cumbersome in base R.
- **Path Management**: `getAbsolutePath()`, `getRelativePath()`, and `getParent()`.
- **Directory Handling**: `copyDirectory(from, to)`, `mkdirs(path)`.
- **File Information**: `countLines(file)`, `lastModified(pathname)`.
- **Atomic Writing**: `createFileAtomically()` ensures a file is only created if the write process completes successfully.
- **Links**: `createLink()` creates symbolic links or Windows shortcuts across platforms.

### Compression
Easy-to-use wrappers for gzip and bzip2:
```R
gzip("data.csv")       # Creates data.csv.gz and removes original
gunzip("data.csv.gz")  # Restores original
```

### Advanced String Substitution (GString)
`GString` allows for variable interpolation and inline R code execution within strings, similar to interpreted languages.
```R
who <- "world"
gcat("Hello ${who}, the time is ${`Sys.time()`}.\n")

# Built-in variables
gcat("Running on ${os} with R v${rversion}.")
```

### Progress Bars
Provides text-based and file-based progress bars for long-running loops.
```R
pb <- ProgressBar(max = 100)
for (i in 1:100) {
  update(pb, i)
  Sys.sleep(0.01)
}
```

### Command-Line Arguments
Simplifies the retrieval of arguments passed to R scripts via the command line.
```R
# If script is run as: Rscript script.R --n=100 --name=test
n <- cmdArg(n = 10) # Default is 10
name <- cmdArg(name = "default")
```

### Session and Hook Management
- `onSessionExit(fcn)`: Registers a function to run when the R session terminates.
- `callHooks(hookName)`: Implements a custom hook system for your own functions.

## Tips and Best Practices
- **Performance**: Use `captureOutput()` instead of base `capture.output()` for large outputs, as it is significantly faster.
- **Local Attachment**: Use `attachLocally(list)` to bring list elements into the local function environment (similar to `with()`, but persists in the local scope).
- **Safe Loading**: Use `loadObject(file)` to load an `.RData` or `.rds` file directly into a variable without polluting the global environment with the original object name.

## Reference documentation
- [R.utils: Various Programming Utilities](./references/reference_manual.md)