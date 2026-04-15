---
name: bioconductor-biocroxytest
description: This tool manages Bioconductor long tests by using roxygen2 tags to automate the creation of test files that exceed standard daily build time limits. Use when user asks to set up long test infrastructure, implement the @longtests roclet, or manage extensive R package tests that require more than 40 minutes to run.
homepage: https://bioconductor.org/packages/release/bioc/html/biocroxytest.html
---

# bioconductor-biocroxytest

name: bioconductor-biocroxytest
description: Specialized workflow for managing Bioconductor "long tests" using roxygen2 tags. Use this skill when developing or maintaining Bioconductor R packages that require extensive testing (exceeding the 40-minute daily build limit). It facilitates setting up the longtests infrastructure, using the @longtests roclet, and automating the generation of test files that run on Bioconductor Long Test builds.

# bioconductor-biocroxytest

## Overview

The `biocroxytest` package streamlines the creation and management of "long tests" in Bioconductor. Traditionally, tests that take too long to run are separated from the main codebase to avoid failing the 40-minute daily build limit. `biocroxytest` allows you to document these extensive tests directly within your R function's roxygen2 comments using the `@longtests` tag. It then automatically generates the necessary infrastructure and test files to ensure these tests are run during Bioconductor's dedicated Long Test builds.

## Setup Workflow

To enable long test support in a Bioconductor package, follow these two steps:

1.  **Configure DESCRIPTION**: Add the `biocroxytest` roclet to the Roxygen field in your `DESCRIPTION` file so `roxygenise()` knows how to handle the new tag.
    ```
    Roxygen: list(roclets = c("namespace", "rd", "biocroxytest::longtests_roclet"))
    ```

2.  **Initialize Infrastructure**: Run the setup function to create the `longtests/` directory and the `.BBSoptions` file (which signals Bioconductor to run long tests).
    ```r
    biocroxytest::use_longtests()
    ```

## Implementation Workflow

### 1. Adding Long Tests
Add the `@longtests` tag to your function's roxygen block. Write the tests using standard `testthat` syntax.

```r
#' My Complex Analysis Function
#'
#' @param x A large dataset
#'
#' @longtests
#' expect_s4_class(my_function(large_data), "SummarizedExperiment")
#' expect_equal(nrow(my_function(large_data)), 10000)
#'
#' @export
my_function <- function(x) { ... }
```

### 2. Generating Test Files
Process the documentation to generate the test scripts in the `longtests/` directory.

```r
roxygen2::roxygenise()
```

This creates files like `longtests/test-biocroxytest-tests-[filename].R`. These files are automatically wrapped in `testthat::test_that()` blocks and should not be edited manually.

## Key Functions and Files

- `biocroxytest::use_longtests()`: Sets up `longtests/testthat/`, `longtests/testthat.R`, and `.BBSoptions`.
- `.BBSoptions`: A configuration file created in the package root containing `RunLongTests: TRUE`.
- `longtests/`: The directory where generated long tests reside, separate from the standard `tests/testthat/` directory used for daily builds.

## Best Practices

- **Separation of Concerns**: Use standard `@examples` or `tests/testthat/` for quick unit tests. Reserve `@longtests` for heavy computations, large data integrations, or time-consuming simulations.
- **Bioconductor Compliance**: Ensure your package is actually added to the Bioconductor Long Test builds if you expect these tests to be monitored by the build system.
- **Automation**: Always run `roxygenise()` after modifying `@longtests` content to keep the generated test files in sync with your source code.

## Reference documentation

- [Introduction to biocroxytest](./references/biocroxytest.md)