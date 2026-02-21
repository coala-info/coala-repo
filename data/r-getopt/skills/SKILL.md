---
name: r-getopt
description: "Package designed to be used with Rscript to write     '#!' shebang scripts that accept short and long flags/options.     Many users will prefer using instead the packages optparse or argparse     which add extra features like automatically generated help option and usage,     support for default values, positional argument support, etc.</p>"
homepage: https://cloud.r-project.org/web/packages/getopt/index.html
---

# r-getopt

name: r-getopt
description: Expert guidance for the 'getopt' R package to handle C-like command-line options in R scripts. Use this skill when creating R shebang scripts (#!), parsing short (-v) and long (--verbose) flags, or defining command-line interfaces for Rscript-based tools.

# r-getopt

## Overview

The `getopt` package is designed for R scripts invoked via `Rscript` to provide a C-like command-line option parsing experience. It allows scripts to accept short flags, long flags, and arguments with specific data types. While simpler than `optparse` or `argparse`, it is highly efficient for scripts requiring optional arguments and strict type casting.

## Installation

```R
install.packages("getopt")
```

## Core Workflow

### 1. Define the Specification (Spec)
The spec is a matrix (or a vector coercible to a matrix) that defines valid flags. It has 4 or 5 columns:
1.  **Long Name**: Multi-character string (e.g., "verbose").
2.  **Short Name**: Single-character alias (e.g., "v").
3.  **Argument Mask**: 0 = no argument, 1 = required argument, 2 = optional argument.
4.  **Data Type**: logical, integer, double, complex, or character.
5.  **Description** (Optional): Brief help text.

### 2. Parse Arguments
Use `getopt(spec)` to parse `commandArgs(TRUE)`.

```R
library(getopt)

spec <- matrix(c(
  'help',    'h', 0, "logical",   "Print help message",
  'count',   'c', 1, "integer",   "Number of iterations (required)",
  'output',  'o', 2, "character", "Output file (optional)",
  'verbose', 'v', 0, "logical",   "Verbose output"
), byrow=TRUE, ncol=5)

opt <- getopt(spec)
```

### 3. Handle Results
The function returns a list where names correspond to the long flags.

```R
if (!is.null(opt$help)) {
  cat(getopt(spec, usage = TRUE))
  q(status = 1)
}

# Set defaults for optional flags
if (is.null(opt$output)) opt$output <- "default.txt"
```

## Key Functions

### getopt()
The primary parsing function.
- `spec`: The specification matrix.
- `opt`: Character vector to parse (defaults to `commandArgs(TRUE)`).
- `usage`: If `TRUE`, returns a generated usage string instead of parsing.

### get_Rscript_filename()
Returns the name of the script currently being executed by `Rscript`. Useful for dynamic help messages.

## Best Practices

- **Shebang Scripts**: Always start your R script with `#!/usr/bin/env Rscript` for portability.
- **Type Safety**: Use the 4th column of the spec to ensure inputs are automatically cast to `integer` or `double`, reducing manual validation code.
- **Help Logic**: Always include a `help` flag and check for its existence immediately after parsing to provide a user-friendly interface.
- **Positional Arguments**: `getopt` does not natively support mixing positional arguments with flags. If you need to handle trailing positional arguments, they remain in `commandArgs(TRUE)` but are not easily separated by `getopt`.

## Reference documentation

- [getopt: C-Like 'getopt' Behavior](./references/reference_manual.md)