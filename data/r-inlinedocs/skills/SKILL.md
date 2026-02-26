---
name: r-inlinedocs
description: This tool generates R documentation files from inline comments within R source code. Use when user asks to generate .Rd files, document R packages using inline syntax, or automate the creation of documentation from R code comments.
homepage: https://cloud.r-project.org/web/packages/inlinedocs/index.html
---


# r-inlinedocs

name: r-inlinedocs
description: Generate R documentation (.Rd files) from inline comments in R source code. Use this skill when you need to document R packages using the inlinedocs syntax, which allows defining documentation near the code, avoids repeating argument names, and keeps examples in R code rather than comments.

# r-inlinedocs

## Overview

`inlinedocs` is an R package that automates the creation of R documentation (.Rd files) by parsing specially formatted comments within your R source files. It is designed to reduce redundancy by extracting information directly from the code structure (like function arguments) and allowing documentation to live alongside the implementation.

## Installation

To install the package from CRAN:

```R
install.packages("inlinedocs")
```

## Core Workflow

The primary function is `package.skeleton.dx()`. It scans your package directory, extracts inline comments, and generates/updates the `.Rd` files in the `man/` directory.

### Basic Usage

```R
library(inlinedocs)

# Generate documentation for a package located at "path/to/your/package"
package.skeleton.dx("path/to/your/package")
```

## Comment Syntax

`inlinedocs` uses specific comment prefixes to identify documentation elements:

### 1. Description and Title
Use `###` at the beginning of a function or file.
- The first line is usually treated as the **Title**.
- Subsequent lines are treated as the **Description**.

### 2. Arguments
Use `##<<` on the same line as an argument, or `###` on the line immediately following it.

### 3. Value (Return)
Use `###` near the end of the function or `##value<<` to explicitly start a value section.

### 4. Specific Sections
Use `##sectionname<<` to define specific Rd sections (e.g., `##details<<`, `##seealso<<`, `##references<<`, `##author<<`).

### 5. Examples
Unlike standard R documentation, examples are often kept in separate R files or specific blocks to ensure they are valid R code.

## Example Function

```R
add_numbers <- function
### Add two numbers together (Title)
### This function takes two numeric inputs and returns their sum. (Description)
(x, ##<< First numeric value
 y  ##<< Second numeric value
){
  res <- x + y
  res
  ### numeric sum of x and y (Value)
}
```

## Advanced Features

### Custom Parsers
You can modify how `inlinedocs` reads your code by providing a list of parser functions to the `parsers` argument in `package.skeleton.dx()`.
- `default.parsers`: The standard set of parsers.
- `classic.parsers`: Parsers used in older versions of the package.

### S4 Classes
`inlinedocs` can scan `setClass` calls. Slots are documented similarly to function arguments using `##<<` or `###`.

### Excluding Files
Use the `excludePattern` argument in `package.skeleton.dx` to skip specific files (e.g., `excludePattern = "old_code.R"`).

## Tips for Success
- **Consistency**: Stick to either `###` or `##<<` for arguments to avoid confusion.
- **Namespace**: Set `namespace = TRUE` in `package.skeleton.dx()` to automatically generate a `NAMESPACE` file based on your functions.
- **Validation**: Always run `R CMD check` on your package after generating documentation to ensure the `.Rd` files are syntactically correct.

## Reference documentation

- [Package ‘inlinedocs’ Reference Manual](./references/reference_manual.md)