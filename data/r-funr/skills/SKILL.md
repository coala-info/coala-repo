---
name: r-funr
description: "A small utility which wraps Rscript and provides access to all R     functions from the shell.</p>"
homepage: https://cloud.r-project.org/web/packages/funr/index.html
---

# r-funr

name: r-funr
description: Access and execute any R function directly from the terminal/shell using the funr utility. Use this skill when you need to bridge the gap between the command line and R, allowing for the execution of R functions (base or package-specific) as CLI tools, sampling data, knitting documents, or creating R-based shell scripts.

# r-funr

## Overview
The `funr` package (Functional R) provides a small utility that wraps `Rscript`, enabling easy access to all R functions from the terminal. It automatically handles parameter type conversion (logical, integer, numeric) and provides access to R help pages directly in the shell.

## Installation
To install the package and set up the terminal utility:

```r
install.packages("funr")
library(funr)
# Copies the 'funr' script to ~/bin
setup()
```

To make `funr` accessible globally, ensure `~/bin` is in your PATH:
```bash
echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
source ~/.bashrc
```

## Core Usage

### Basic Function Execution
Run any R function by passing its name and arguments.
```bash
# Syntax: funr <function> <args>
funr rnorm n=10
funr mean x=c(1,5,10)
```

### Accessing Help
View R documentation for any function directly in the terminal.
```bash
funr -h rnorm
funr -h knitr::knit
```

### Using Specific Packages
Load a package and run a function in one command using the `pkg::func` syntax.
```bash
funr knitr::knit2html input="report.Rmd"
```

### Piping Data
`funr` supports piping between commands (version > 0.1.2). Use `-` to denote input from a pipe.
```bash
funr system.file package=knitr fl=examples/knitr-minimal.Rmd | funr knitr::knit2html input=-
```

## Creating R-based Shell Scripts
You can use `funr` to create standalone executable scripts that expose R functions to the CLI.

1. Create a file (e.g., `myscript.R`):
```r
#!/usr/bin/env Rscript
library(funr)

# Define functions you want to expose
analyze_data <- function(n, val = 1) {
  data <- rnorm(n, mean = val)
  print(summary(data))
}

# Pass command line arguments to funr
out = funr(commandArgs(trailingOnly = TRUE))
```

2. Make it executable:
```bash
chmod +x myscript.R
```

3. Run it:
```bash
./myscript.R analyze_data n=100 val=5
```

## Tips and Best Practices
- **Argument Types**: `funr` automatically detects types. `TRUE/FALSE` becomes logical, numbers become numeric/integer.
- **Verbose Mode**: Use `funr -v` to see debugging messages and how the R call is being constructed.
- **System Integration**: Use `funr` to wrap complex R workflows (like `devtools` or `testthat`) into simple shell commands for CI/CD pipelines.

## Reference documentation
- [README.md](./references/README.md)