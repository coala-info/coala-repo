---
name: r-runit
description: This tool implements unit testing in R using the RUnit framework to automate code verification and generate detailed reports. Use when user asks to perform unit testing in R, define test suites, use assertions to validate code logic, or generate test reports in text or HTML formats.
homepage: https://cran.r-project.org/web/packages/runit/index.html
---

# r-runit

name: r-runit
description: Use this skill to implement unit testing in R using the RUnit framework. It provides specialized workflows for defining test suites, performing assertions (checkEquals, checkTrue, checkException), and generating test reports in text or HTML formats.

## Overview
RUnit is a robust unit testing framework for R, inspired by the xUnit architecture (like JUnit). It allows developers to automate the verification of R code through formal test functions, group these tests into suites, and produce detailed inspection reports. It is particularly useful for package development and ensuring long-term code stability.

## Installation
To install the RUnit package from CRAN:
```R
install.packages("RUnit")
```

## Core Functions
RUnit relies on "check" functions to validate logic:
- `checkEquals(target, current)`: Checks if two objects are equal (within numerical tolerance).
- `checkTrue(expr)`: Checks if a logical expression evaluates to TRUE.
- `checkIdentical(target, current)`: Checks if two objects are exactly identical.
- `checkException(expr)`: Verifies that an expression correctly raises an error.

## Standard Workflow

### 1. Create Test Functions
Create an R script (e.g., `test_math.R`) and define functions starting with the prefix `test.`:
```R
test.addition <- function() {
  target <- 5
  current <- 2 + 3
  checkEquals(target, current)
}

test.failure_case <- function() {
  checkTrue(1 == 2, "This test is expected to fail")
}
```

### 2. Define and Run a Test Suite
Use `defineTestSuite` to point to the directory containing your test files:
```R
library(RUnit)

# Define the suite
my_suite <- defineTestSuite(
  name = "Project Tests",
  dirs = "path/to/tests",
  testFileRegexp = "^test_.*\\.R$"
)

# Execute the tests
test_results <- runTestSuite(my_suite)
```

### 3. Generate Reports
View the results in the console or export them to a file:
```R
# Print summary to console
printTextProtocol(test_results)

# Generate an HTML report for detailed inspection
printHTMLProtocol(test_results, fileName = "test_report.html")
```

## Tips for Effective Testing
- **Naming Convention**: Always prefix test functions with `test.` so the test runner can identify them.
- **Setup and Teardown**: If a test file contains functions named `.setUp()` or `.tearDown()`, RUnit will execute them before and after each test function in that file, respectively.
- **Numerical Tolerance**: Use `checkEquals` for floating-point comparisons as it handles small differences better than `checkIdentical`.
- **Package Integration**: When using RUnit in a package, place tests in the `inst/unitTests` directory and create a wrapper in the `tests` directory to trigger them during `R CMD check`.

## Reference documentation
- [SourceForge Articles](./references/article.md)
- [R Unit Test Framework Home](./references/home_page.md)