---
name: r-findpython
description: Package designed to find an acceptable python binary.</p>
homepage: https://cloud.r-project.org/web/packages/findpython/index.html
---

# r-findpython

## Overview

The `findpython` package provides a robust way to locate a Python binary that meets specific requirements (version range and module availability). It is particularly useful for R packages or scripts that interface with Python and need to ensure the environment is correctly configured without manual path specification.

## Installation

Install the stable version from CRAN:

```r
install.packages("findpython")
```

## Core Functions

### Finding a Python Binary
The primary function is `find_python_cmd()`. It searches the system path and common locations.

```r
library(findpython)

# Find any Python 3 binary (3.0 or higher)
py_path <- find_python_cmd(minimum_version = "3.0")

# Find a specific range (e.g., Python 2.7 only)
py_path <- find_python_cmd(minimum_version = "2.7", maximum_version = "2.7")

# Find Python with specific module requirements
# Supports OR logic with '|'
py_path <- find_python_cmd(required_modules = c("numpy", "json | simplejson"))
```

### Validating an Existing Path
If you already have a path and want to check if it meets requirements:

```r
is_python_sufficient("path/to/python", minimum_version = "3.8", required_modules = "pandas")
# Returns TRUE or FALSE
```

### Silent Checks
Use `can_find_python_cmd()` to check for existence without throwing an immediate error.

```r
result <- can_find_python_cmd(minimum_version = "3.0")
if (result) {
  py_path <- attr(result, "python_cmd")
} else {
  message("Python not found")
}
```

## Workflows and Tips

### Custom Error Messages
When using `find_python_cmd()` in a package or script intended for end-users, provide a helpful error message to guide them on how to fix the missing dependency.

```r
find_python_cmd(
  minimum_version = "3.10",
  error_message = "This analysis requires Python 3.10+. Please install it from python.org."
)
```

### Integration with Options and Env Vars
`findpython` respects the following if the search fails or to prioritize specific paths:
1. `options("python_cmd" = "/path/to/binary")`
2. Environment variables: `PYTHON`, `PYTHON2`, or `PYTHON3`.

### Module Logic
When specifying `required_modules`, you can pass a character vector. For complex dependencies, use the pipe `|` within a string to indicate that either module is acceptable for that requirement.

## Reference documentation

- [README](./references/README.md)