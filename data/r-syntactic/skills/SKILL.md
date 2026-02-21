---
name: r-syntactic
description: R package syntactic (documentation from project home).
homepage: https://cran.r-project.org/web/packages/syntactic/index.html
---

# r-syntactic

name: r-syntactic
description: Tools for creating syntactically valid names from character vectors in R. Use this skill when you need to clean column names, variable names, or any character strings to ensure they are valid R identifiers, especially when working with data frames or Acid Genomics ecosystem packages.

## Overview

The syntactic package provides utilities to transform arbitrary strings into valid R names. This is essential for data cleaning, ensuring that character vectors can be used as safe identifiers, column names, or variable names without triggering syntax errors or requiring backticks. It is designed to be more robust and flexible than the base R `make.names()` function.

## Installation

To install the package from the Acid Genomics repository:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "syntactic",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    )
)
```

## Main Functions and Workflows

### Creating Syntactic Names

The core workflow involves passing a character vector to the naming functions to strip invalid characters and handle duplicates.

```r
library(syntactic)

# Basic sanitization
original <- c("Variable 1", "Variable 2", "illegal-name!", "2nd_variable")
clean <- makeNames(original)
# Result: "variable1", "variable2", "illegalName", "x2ndVariable"
```

### Case Transformations

The package provides specific functions for common naming conventions:

- `camelCase()`: Converts strings to lowerCamelCase.
- `snakeCase()`: Converts strings to snake_case.
- `upperCamelCase()`: Converts strings to UpperCamelCase (PascalCase).

```r
# Example of specific case conversion
snakeCase("Some Variable Name") # "some_variable_name"
camelCase("Some Variable Name") # "someVariableName"
```

### Handling Data Frames

A common use case is cleaning the column names of a data frame or matrix to ensure they are easy to work with in downstream analysis.

```r
# Clean data frame column names
colnames(df) <- makeNames(colnames(df))
```

## Tips for Success

1. **Uniqueness**: The functions automatically handle name collisions by appending suffixes (e.g., `.1`, `.2`) to ensure the resulting vector contains unique identifiers.
2. **Leading Numbers**: R names cannot start with a number. `makeNames()` will typically prepend an "x" or similar character to ensure the name is syntactically valid.
3. **Consistency**: Use the same transformation (e.g., always `camelCase`) across a project to maintain code readability and predictability.

## Reference documentation

- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)