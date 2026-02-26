---
name: r-goalie
description: "r-goalie provides assertive check functions for defensive R programming and S4 class validation. Use when user asks to implement robust input validation, perform S4 class validity checks, or handle custom errors in R scripts and packages."
homepage: https://cran.r-project.org/web/packages/goalie/index.html
---


# r-goalie

name: r-goalie
description: Assertive check functions for defensive R programming. Use this skill when you need to implement robust input validation, S4 class validity checks, or custom error handling in R scripts and packages using the goalie framework.

## Overview

The `goalie` package provides a unified interface for assertive programming in R, combining the best features of packages like `assertive`, `assertthat`, and `checkmate`. It is designed to be lightweight with minimal dependencies, making it ideal for both general R scripts and Bioconductor-style S4 development.

Key features:
- `assert()`: A drop-in replacement for `stopifnot()` with better error messages.
- `validate()`: Specialized for S4 class validity checks.
- `cause()`: Retrieves the specific reason for a check failure.
- Extensive library of `is*` check functions returning a "goalie" S4 class.

## Installation

```R
install.packages(
    pkgs = "goalie",
    repos = c(
        "https://r.acidgenomics.com",
        getOption("repos")
    )
)
```

## Core Workflows

### Defensive Programming with assert()
Use `assert()` at the beginning of functions to validate inputs. Unlike `stopifnot()`, it provides descriptive feedback.

```R
library(goalie)

my_function <- function(x, n) {
  assert(
    isString(x),
    isPositive(n)
  )
  # Function logic...
}
```

### S4 Class Validation
Use `validate()` within `setValidity` definitions. It returns `TRUE` on success or a character string describing the failure on error, which is the format required by R's S4 system.

```R
setValidity("MyClass", function(object) {
  validate(
    isADirectory(object@path),
    isScalarCharacter(object@name)
  )
})
```

### Inspecting Failures with cause()
Goalie check functions return a logical value with a "goalie" class. If a check returns `FALSE`, you can inspect why using `cause()`.

```R
res <- isString(123)
if (!res) {
  print(cause(res)) # Outputs the specific reason for failure
}
```

## Common Check Functions

| Category | Functions |
| :--- | :--- |
| **Types** | `isString()`, `isCharacter()`, `isFlag()`, `isScalarLogical()` |
| **Numbers** | `isInt()`, `isPositive()`, `isNonNegative()`, `isPercentage()` |
| **Filesystem** | `isAFile()`, `isADirectory()`, `isExistingFile()` |
| **Bioinformatics** | `isGeneSymbol()`, `isEnsemblId()` |

## Tips for Effective Use
- **Conciseness**: Use `isScalar*` variants (e.g., `isScalarInteger`) instead of checking `is.integer(x) && length(x) == 1`.
- **Custom Messages**: While `goalie` generates smart defaults, you can often wrap checks to provide domain-specific context.
- **Bioconductor Integration**: Use `validate()` to ensure your S4 objects remain "tidy" and valid throughout complex workflows.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)