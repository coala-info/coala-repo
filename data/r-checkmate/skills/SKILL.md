---
name: r-checkmate
description: "Tests and assertions to perform frequent argument checks. A     substantial part of the package was written in C to minimize any worries     about execution time overhead.</p>"
homepage: https://cloud.r-project.org/web/packages/checkmate/index.html
---

# r-checkmate

## Overview
`checkmate` provides a comprehensive set of functions to validate R objects. It replaces verbose `if-stop` blocks with concise, high-performance C-based checks. It is particularly useful for package development to ensure user inputs meet specific criteria while providing clear, standardized error messages.

## Installation
```R
install.packages("checkmate")
```

## Core Function Families
The package uses consistent prefixes to determine the behavior of a check:

*   **`assert*`**: Throws an error if the check fails; returns the object invisibly if it passes.
*   **`test*`**: Returns `TRUE` if the check passes, `FALSE` otherwise.
*   **`check*`**: Returns `TRUE` if the check passes, and a string containing the error message otherwise.
*   **`expect*`**: Used within `testthat` or `tinytest` for unit testing.

All functions support both `camelCase` (e.g., `assertCount`) and `snake_case` (e.g., `assert_count`).

## Common Check Functions
*   **Scalars**: `assertFlag` (logical), `assertCount` (positive integer), `assertInt` (single integer), `assertScalar` (length 1).
*   **Vectors**: `assertNumeric`, `assertCharacter`, `assertLogical`, `assertInteger`, `assertFactor`.
*   **Complex Structures**: `assertList`, `assertDataFrame`, `assertMatrix`, `assertArray`.
*   **Attributes**: `assertClass`, `assertNames`, `assertSubset`, `assertChoice`.

## Workflows

### Argument Validation in Functions
Replace multiple `if` statements with single-line assertions:
```R
my_function <- function(n, method = "stirling") {
  checkmate::assertCount(n)
  checkmate::assertChoice(method, c("stirling", "factorial"))
  
  # Function logic...
}
```

### Logical Combinations
Use `assert` to combine multiple checks (default is "OR"):
```R
# Check if x is either class 'foo' or class 'bar'
assert(
  checkClass(x, "foo"),
  checkClass(x, "bar")
)
```

### Quick Assertions (DSL)
For high-speed, concise checks, use the domain-specific language (DSL) with `qassert`:
```R
# Assert x is a numeric vector of length 10, no NAs, values between 0 and 1
qassert(x, "N10[0,1]")

# Common codes:
# B (Boolean), I (Integer), N (Numeric), S (String), D (Data.frame), L (List)
# + (length >= 1), * (length >= 0)
```

### Unit Testing Integration
`checkmate` extends `testthat` and `tinytest` with specialized expectations:

**With testthat:**
```R
test_that("data is valid", {
  x <- runif(10)
  expect_numeric(x, lower = 0, upper = 1, any.missing = FALSE)
})
```

**With tinytest:**
Include `using("checkmate")` at the top of your test file:
```R
library(tinytest)
library(checkmate)
using("checkmate")

expect_data_frame(my_df, min.rows = 1)
```

## Custom Extensions
Create your own check functions using `makeAssertionFunction`, `makeTestFunction`, or `makeExpectationFunction`:
```R
checkSquareMatrix = function(x) {
  res = checkMatrix(x)
  if (!isTRUE(res)) return(res)
  if (nrow(x) != ncol(x)) return("Must be square")
  return(TRUE)
}

assertSquareMatrix = makeAssertionFunction(checkSquareMatrix)
```

## Reference documentation
- [Checkmate](./references/checkmate.Rmd)
- [Setup tinytest](./references/tinytest.Rmd)