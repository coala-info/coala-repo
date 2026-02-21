---
name: r-bbmisc
description: "Miscellaneous helper functions for and from B. Bischl and     some other guys, mainly for package development.</p>"
homepage: https://cloud.r-project.org/web/packages/BBmisc/index.html
---

# r-bbmisc

name: r-bbmisc
description: Miscellaneous helper functions for R package development and data manipulation. Use this skill when you need utility functions for argument checking, list operations, string manipulation, error handling, and functional programming enhancements in R.

# r-bbmisc

## Overview
The `BBmisc` package provides a collection of miscellaneous helper functions developed by B. Bischl and others. It is particularly useful for R package developers and data scientists who need robust utilities for common tasks that are not always elegantly handled by base R. Key features include advanced list operations, string helpers, system utilities, and enhanced functional programming tools.

## Installation
To install the stable version from CRAN:
```r
install.packages("BBmisc")
```

## Key Functions and Workflows

### Argument Checking and Validation
`BBmisc` provides several functions to streamline input validation:
- `checkArg()`: Checks if an argument matches a specific type or condition.
- `stopf()`: A wrapper for `stop(sprintf(...))` to easily throw formatted error messages.
- `warningf()` and `messagef()`: Formatted wrappers for warnings and messages.

### List Operations
- `extractSubList()`: Extracts a specific element from every member of a list.
- `insert() / update()`: Insert or update elements in a list by name.
- `listToShortString()`: Converts a list to a compact string representation for logging.
- `chunk()`: Splits a vector or list into chunks of a specific size or number.

### Functional Programming
- `map()`: A wrapper around `lapply` that can return different types (similar to `purrr`).
- `filterNA()`: Removes `NA` values from a vector or list.
- `getAttribute()`: Safely get an attribute with a default value if it doesn't exist.

### String and System Utilities
- `strCollapse()`: Collapses a vector into a single string with a separator.
- `strNormalize()`: Trims whitespace and converts to lowercase.
- `catf()`: Formatted `cat()` with a newline.
- `isWindows()`, `isLinux()`, `isDarwin()`: Simple boolean checks for the operating system.
- `pause()`: Pauses execution until the user presses Enter.

### Data Frame Helpers
- `convertDataFrameCols()`: Converts columns in a data frame to specific types (e.g., factor to character).
- `dropNamed()`: Drops columns from a data frame by name.

## Workflow Example: Safe Argument Handling
```r
library(BBmisc)

process_data <- function(data, threshold) {
  # Validate inputs
  if (!is.data.frame(data)) stopf("'data' must be a data.frame, not %s", class(data)[1])
  
  # Use string helpers for logging
  messagef("Processing %d rows with threshold %f", nrow(data), threshold)
  
  # Perform operations...
}
```

## Reference documentation
- [README](./references/README.md)