---
name: r-getoptlong
description: "This is a command-line argument parser which wraps the      powerful Perl module Getopt::Long and with some adaptations for easier use 	in R. It also provides a simple way for variable interpolation in R.</p>"
homepage: https://cloud.r-project.org/web/packages/GetoptLong/index.html
---

# r-getoptlong

name: r-getoptlong
description: Parsing command-line arguments using the Perl Getopt::Long style and performing simple variable interpolation in R. Use this skill when you need to create R scripts that accept complex command-line flags, implement sub-commands (git-style), or need a cleaner alternative to paste() for string construction using variable interpolation.

## Overview

The `GetoptLong` package provides a robust way to handle command-line arguments in R scripts by wrapping the powerful Perl `Getopt::Long` module. It also includes a variable interpolation engine (`qq()`) that allows for cleaner string construction by embedding R variables directly within strings.

## Installation

```R
install.packages("GetoptLong")
```

## Command-Line Argument Parsing

The primary function is `GetoptLong()`. It automatically creates a help message and parses arguments into R variables.

### Basic Usage

```R
library(GetoptLong)

# Define variables with default values
threshold = 0.01
name = "default"
verbose = FALSE

# Specify options
GetoptLong(
    "threshold=f", "Threshold value (float)",
    "name=s",      "User name (string)",
    "verbose",     "Print verbose messages"
)

# Variables are now updated based on command line input
# Example: Rscript script.R --threshold 0.05 --name "John" --verbose
```

### Specification Syntax
- `name=s`: String
- `name=i`: Integer
- `name=f`: Float/Double
- `name!`: Negatable boolean (provides `--name` and `--no-name`)
- `name=s@`: Array/List (can be specified multiple times)
- `name=s%`: Hash/Named list (specified as `--name key=value`)

## Sub-commands

Use `subCommands()` to create scripts with multiple actions (e.g., `script.R tool1`, `script.R tool2`).

```R
library(GetoptLong)

subCommands(
    "upload", "upload.R", "Upload data to server",
    "download", "download.R", "Download data from server"
)
```
- If no sub-command is provided, it prints a formatted help menu.
- Arguments following the sub-command are passed to the specific R script.

## Variable Interpolation

The `qq()` function (and `qqcat()`) provides a "double-quote" interpolation similar to Perl.

### Basic Interpolation
Use `@{}` to wrap R code or variables inside a string.

```R
region = c(1, 100)
name = "analysis"
# Instead of paste0("Region: ", region[1], "-", region[2], " for ", name)
qqcat("Region: @{region[1]}-@{region[2]} for @{name}\n")
```

### Vectorized Interpolation
`qq` is vectorized. If variables return vectors, the string is repeated.

```R
names = c("A", "B")
values = c(10, 20)
qqcat("Item @{names} has value @{values}\n")
# Output:
# Item A has value 10
# Item B has value 20
```

### Global Options
- `qq.options("cat_prefix")`: Set a prefix for all `qqcat` outputs (e.g., a timestamp function).
- `qq.options("code.pattern")`: Change the delimiter from `@{CODE}` to something else like `#{CODE}`.

## Tips and Best Practices
- **Help Messages**: `GetoptLong()` automatically generates a help page accessible via `--help`.
- **Variable Scope**: `GetoptLong()` looks for variables in the environment where it is called. Ensure default values are defined before calling the function.
- **Complex Strings**: Use `qq()` for SQL queries, HTML templates, or complex file paths to improve readability.

## Reference documentation
- [Parsing command-line arguments by Getopt::Long](./references/GetoptLong.Rmd)
- [Sub-commands](./references/sub_commands.Rmd)
- [Simple variable interpolation](./references/variable_interpolation.Rmd)