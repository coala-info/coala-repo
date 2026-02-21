---
name: r-optparse
description: "A command line parser inspired by Python's 'optparse' library to     be used with Rscript to write \"#!\" shebang scripts that accept short and     long flag/options.</p>"
homepage: https://cloud.r-project.org/web/packages/optparse/index.html
---

# r-optparse

## Overview

`optparse` allows R developers to create professional command-line interfaces for their scripts. It handles the complexity of parsing `commandArgs()`, allowing for:
- Short flags (e.g., `-v`) and long flags (e.g., `--verbose`).
- Automatic generation of help/usage menus.
- Type casting (integer, logical, double, etc.).
- Positional argument handling.
- Default value management.

## Installation

```r
install.packages("optparse")
```

## Core Workflow

### 1. Define Options
Use `make_option()` to define individual flags. Store these in a list.

```r
library(optparse)

option_list <- list(
  make_option(c("-v", "--verbose"), action="store_true", default=TRUE,
              help="Print extra output [default]"),
  make_option(c("-c", "--count"), type="integer", default=5,
              help="Number of iterations [default %default]",
              metavar="number"),
  make_option("--name", type="character", default="analysis",
              help="Project name [default %default]")
)
```

### 2. Create Parser and Parse Arguments
Initialize the `OptionParser` and call `parse_args()`.

```r
# Basic parsing (returns a list of options)
parser <- OptionParser(option_list=option_list)
opt <- parse_args(parser)

# Accessing values
print(opt$count)
```

### 3. Handling Positional Arguments
If your script requires files or strings that aren't flags, use `positional_arguments`.

```r
parser <- OptionParser(usage = "%prog [options] file", option_list=option_list)

# positional_arguments can be a number (exact count) or TRUE (any number)
arguments <- parse_args(parser, positional_arguments = 1)

opt <- arguments$options # The flags
file_path <- arguments$args # The positional arguments (vector)
```

## Key Functions and Parameters

### `make_option(opt_str, action, type, dest, default, help, metavar)`
- `opt_str`: Vector containing short and long flags, e.g., `c("-s", "--size")`.
- `action`: 
    - `"store"`: Stores the argument (default).
    - `"store_true"`: Sets the option to `TRUE`.
    - `"store_false"`: Sets the option to `FALSE`.
- `type`: `"logical"`, `"integer"`, `"double"`, `"complex"`, or `"character"`.
- `dest`: The name in the resulting list (defaults to the long flag name).
- `help`: Help string. Use `%default` to print the default value in the help menu.
- `metavar`: The placeholder name for the value in the help menu (e.g., `FILE`).

### `parse_args(parser, args, positional_arguments)`
- `args`: The character vector to parse. Defaults to `commandArgs(trailingOnly = TRUE)`.
- `positional_arguments`: 
    - `FALSE`: Errors if positional arguments are found (default).
    - `TRUE`: Allows any number of positional arguments.
    - `numeric`: Specifies exact number or range, e.g., `c(1, 3)`.

## Best Practices
- **Shebang**: Start your script with `#!/usr/bin/env Rscript` for portability.
- **Suppression**: Use `suppressPackageStartupMessages(library(optparse))` to keep script output clean.
- **Help**: The `-h` and `--help` flags are created automatically.
- **Validation**: Always check if required positional arguments exist using `file.access()` or similar logic after parsing.

## Reference documentation
- [optparse Command Line Option Parsing](./references/optparse.md)