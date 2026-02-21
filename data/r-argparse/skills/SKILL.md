---
name: r-argparse
description: "A command line parser to     be used with 'Rscript' to write \"#!\" shebang scripts that gracefully     accept positional and optional arguments and automatically generate usage.</p>"
homepage: https://cloud.r-project.org/web/packages/argparse/index.html
---

# r-argparse

## Overview

The `argparse` package is a command-line argument parser for R, heavily inspired by Python's `argparse` library. It is primarily used with `Rscript` to create professional command-line tools that support short/long flags, positional arguments, default values, and automatically generated help messages.

## Installation

Install the package from CRAN:

```r
install.packages("argparse")
```

Note: This package requires a Python installation on the system as it wraps the Python `argparse` module via `find_python_cmd()` or `reticulate`.

## Core Workflow

### 1. Initialize the Parser
Create a parser object to hold all argument definitions.

```r
library(argparse)
parser <- ArgumentParser(description = 'Description of your script')
```

### 2. Add Arguments
Define the expected inputs. Use `add_argument` for both flags (optional) and positional (required) arguments.

```r
# Optional argument (flag)
parser$add_argument("-n", "--count", type = "integer", default = 5,
                    help = "Number of iterations [default %(default)s]")

# Flag with action (boolean switch)
parser$add_argument("-v", "--verbose", action = "store_true",
                    help = "Print extra output")

# Positional argument (required)
parser$add_argument("input", nargs = 1, help = "Path to input file")
```

### 3. Parse and Use
Convert the command-line strings into an R list.

```r
args <- parser$parse_args()

# Access values using list notation
if (args$verbose) {
    print(paste("Processing file:", args$input))
}
print(args$count)
```

## Argument Configuration Tips

- **Actions**: 
    - `store` (default): Stores the argument value.
    - `store_true` / `store_false`: Useful for boolean flags.
    - `append`: Allows the argument to be specified multiple times, resulting in a list.
- **Types**: Supports `integer`, `double`, `character`.
- **Defaults**: Use `%(default)s` in the `help` string to automatically display the default value in the help message.
- **Nargs**: 
    - `1`: Exactly one value.
    - `?`: One optional value.
    - `*`: Zero or more values (collected into a list).
    - `+`: One or more values.

## Example Script Structure

Save this as `myscript.R`:

```r
#!/usr/bin/env Rscript
library(argparse)

parser <- ArgumentParser()
parser$add_argument("--mean", type="double", default=0, help="Mean value")
parser$add_argument("out", help="Output filename")

args <- parser$parse_args()

# Logic
res <- rnorm(100, mean = args$mean)
write.csv(res, file = args$out)
```

Run from terminal:
```bash
Rscript myscript.R --mean 10 output.csv
```

## Reference documentation

- [argparse Command Line Argument Parsing](./references/argparse.Rmd)