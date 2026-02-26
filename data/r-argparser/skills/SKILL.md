---
name: r-argparser
description: This tool creates and manages command-line interfaces for R scripts using the argparser package. Use when user asks to turn an R script into an executable command-line tool, define positional arguments or optional flags, and handle parameter parsing with automatic help message generation.
homepage: https://cloud.r-project.org/web/packages/argparser/index.html
---


# r-argparser

name: r-argparser
description: A skill for creating and managing command-line interfaces in R using the 'argparser' package. Use this skill when you need to turn an R script into an executable command-line tool, define positional arguments, optional flags, or handle complex parameter parsing with automatic help message generation.

## Overview

The `argparser` package provides a clean, cross-platform way to parse command-line arguments in R. It is written in pure R with no external dependencies, making it ideal for portable scripts. It automatically generates help messages and supports type inference, default values, and flag handling.

## Installation

```r
install.packages("argparser")
library(argparser)
```

## Core Workflow

### 1. Initialize the Parser
Create a parser object with a description of your program.
```r
p <- arg_parser("Description of my R script")
```

### 2. Add Arguments
Add positional arguments, optional arguments, or flags.
- **Positional**: No prefix. Required by default.
- **Optional**: Prefix with `--` or `-`.
- **Flags**: Optional arguments that don't take a value (boolean).

```r
# Positional argument
p <- add_argument(p, "input", help = "Path to input file")

# Optional argument with default and type
p <- add_argument(p, "--iterations", help = "Number of loops", default = 5, type = "numeric")

# Flag (TRUE if present, FALSE if absent)
p <- add_argument(p, "--verbose", help = "Print detailed output", flag = TRUE)
```

### 3. Parse Arguments
Retrieve the values into a list. By default, it reads from `commandArgs()`.
```r
argv <- parse_args(p)

# Access values using the argument names
# Note: dashes in argument names (e.g., --input-file) become underscores (input_file)
input_path <- argv$input
if (argv$verbose) {
  message("Processing...")
}
```

## Advanced Features

### Multiple Arguments at Once
You can pass vectors to `add_argument` to define multiple parameters efficiently.
```r
p <- add_argument(p, 
    arg = c("--mode", "--ratio"),
    help = c("Execution mode", "Scaling ratio"),
    default = list("fast", 0.5)
)
```

### Variable Number of Arguments (nargs)
Use `nargs` to accept multiple values for a single argument.
```r
p <- add_argument(p, "--files", help = "Input files", nargs = Inf)
# Usage: Rscript script.R --files a.txt b.txt c.txt
```

### Custom Types
Define custom validation logic by creating an S4 method for `coerce`.
```r
setClass("existingFile")
setMethod("coerce", c(from = "ANY", to = "existingFile"), function(from, to) {
  if (!file.exists(from)) stop("File does not exist: ", from)
  from
})
p <- add_argument(p, "--config", type = "existingFile")
```

### Saving and Loading Arguments
The parser automatically adds an `--opts` argument. You can save a parsed `argv` list to an RDS file and reload it later via the command line to skip manual entry.
```bash
Rscript script.R --opts saved_args.rds
```

## Tips for Success
- **Naming**: Dashes in command-line flags (e.g., `--output-dir`) are automatically converted to underscores in the resulting list (`argv$output_dir`).
- **Short Forms**: Short forms (e.g., `-v` for `--verbose`) are assigned automatically based on the first character. To ensure specific short forms, add those arguments first.
- **Help**: Users can trigger the auto-generated help menu using `--help` or `-h`.

## Reference documentation
- [argparser Reference Manual](./references/reference_manual.md)