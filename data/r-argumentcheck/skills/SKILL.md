---
name: r-argumentcheck
description: Skill for using the CRAN R package r-argumentcheck.
homepage: https://cloud.r-project.org/web/packages/ArgumentCheck/index.html
---

# r-argumentcheck

name: r-argumentcheck
description: Facilitates robust argument validation in R functions by collecting multiple errors and warnings to report them simultaneously rather than failing on the first error. Use this skill when writing R functions that require complex parameter checking, input validation, or when you want to provide user-friendly, comprehensive error reporting.

# r-argumentcheck

## Overview

The `ArgumentCheck` package allows R developers to follow a "Fail All At Once" philosophy. Instead of using `stop()` or `warning()` immediately—which terminates execution at the first issue—this package provides a mechanism to collect all validation failures and report them in a single, unified message. This improves the user experience by allowing users to fix all input errors at once.

**Note:** The author has noted that `checkmate` (version 1.6.3+) now provides similar "assert collection" features, but `ArgumentCheck` remains a dedicated, lightweight tool for this specific workflow.

## Installation

```R
install.packages("ArgumentCheck")
```

## Core Workflow

The standard implementation involves three steps:
1. **Initialize**: Create a new check object using `newArgCheck()`.
2. **Collect**: Perform logical tests and add messages using `addError()` or `addWarning()`.
3. **Report**: Finalize the process with `finishArgCheck()`, which triggers the actual `stop()` or `warning()` calls if any issues were collected.

### Basic Example

```R
library(ArgumentCheck)

calculate_volume <- function(height, radius) {
  # 1. Initialize the check object
  Check <- ArgumentCheck::newArgCheck()
  
  # 2. Perform checks and add errors
  if (height < 0) {
    ArgumentCheck::addError(
      msg = "'height' must be >= 0",
      argcheck = Check
    )
  }
  
  if (radius < 0) {
    ArgumentCheck::addError(
      msg = "'radius' must be >= 0",
      argcheck = Check
    )
  }
  
  # 3. Report all collected errors/warnings
  # This will stop the function here if errors exist
  ArgumentCheck::finishArgCheck(Check)
  
  pi * radius^2 * height 
}
```

## Handling Vectorized Inputs

When dealing with vectors, use `any()` to detect if any element violates the constraints. You can choose to either throw an error or issue a warning and sanitize the data.

### Warning and Sanitize Pattern

```R
process_data <- function(x) {
  Check <- ArgumentCheck::newArgCheck()
  
  if (any(x < 0)) {
    ArgumentCheck::addWarning(
      msg = "Negative values detected and set to NA",
      argcheck = Check
    )
    x[x < 0] <- NA
  }
  
  ArgumentCheck::finishArgCheck(Check)
  return(x)
}
```

## Key Functions

- `newArgCheck()`: Creates a new environment to store error and warning messages.
- `addError(msg, argcheck)`: Adds an error message to the collection.
- `addWarning(msg, argcheck)`: Adds a warning message to the collection.
- `finishArgCheck(argcheck)`: Inspects the collection. If errors are present, it calls `stop()` with all messages. If only warnings are present, it calls `warning()` with all messages.

## Tips for Effective Checks

- **Be Specific**: Include the name of the argument and the expected condition in the `msg`.
- **Check Early**: Place the `finishArgCheck()` call immediately after the validation logic and before any heavy computation.
- **Vector Awareness**: Always consider if your function might receive vectors. Use `any(is.na(x))` or `any(x < 0)` to ensure the logic doesn't break or return "friendly" warnings for vectorized inputs.

## Reference documentation

- [Checking Arguments in R Functions](./references/ArgumentChecking.Rmd)
- [ArgumentCheck README](./references/README.md)