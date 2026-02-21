---
name: r-testthat
description: "Software testing is important, but, in part because it is     frustrating and boring, many of us avoid it. 'testthat' is a testing     framework for R that is easy to learn and use, and integrates with     your existing 'workflow'.</p>"
homepage: https://cloud.r-project.org/web/packages/testthat/index.html
---

# r-testthat

## Overview
`testthat` is the most popular unit testing framework for R. It provides a structured way to verify that your code works as expected, making testing "frustrating and boring" no longer. It integrates deeply with the RStudio IDE and the `devtools` workflow.

## Installation
To install the package from CRAN:
```r
install.packages("testthat")
```

## Core Workflow
1.  **Setup**: Use `usethis::use_testthat()` to initialize testing infrastructure in a package.
2.  **Create a test**: Use `usethis::use_test("function_name")` to create a test file (e.g., `tests/testthat/test-function_name.R`).
3.  **Write tests**: Use `test_that()` to group related expectations.
    ```r
    test_that("multiplication works", {
      expect_equal(2 * 2, 4)
    })
    ```
4.  **Run tests**: Execute `devtools::test()` to run all tests in a package.

## Key Functions and Concepts

### Expectations
Expectations are the building blocks of testthat. They all start with `expect_`.
- `expect_equal(object, expected)`: Checks for equality within numerical tolerance.
- `expect_identical(object, expected)`: Checks for exact identity.
- `expect_error(code, regexp)`: Verifies that code throws an error.
- `expect_warning(code, regexp)`: Verifies that code throws a warning.
- `expect_message(code, regexp)`: Verifies that code produces a message.
- `expect_true(logical)` / `expect_false(logical)`: Checks logical conditions.
- `expect_s3_class(object, class)`: Checks the S3 class of an object.

### Snapshot Testing
Use snapshots when output is large, complex (like HTML/JSON), or graphical.
- `expect_snapshot(x)`: Records the output/messages/errors of `x` in a `_snaps/` markdown file.
- `expect_snapshot_value(x)`: Snapshots the return value specifically.
- `snapshot_accept()`: Run this to accept changes if a snapshot failure is intentional.

### Test Fixtures and State
Tests should leave the world as they found it. Use `withr` style "local" functions for temporary changes:
- `withr::local_options()`: Change options for the duration of the test.
- `withr::local_tempfile()`: Create a temporary file that is automatically deleted.
- `withr::local_envvar()`: Set environment variables temporarily.

### Mocking
Mocking allows you to replace functions with fake versions to test hard-to-reach logic or avoid side effects (like API calls).
- `local_mocked_bindings(fn_name = function(...) { ... })`: Replaces a function within the scope of the test.

### Skipping Tests
Skip tests that cannot run in certain environments:
- `skip_on_cran()`: Skip on CRAN servers.
- `skip_on_os("windows")`: Skip on specific operating systems.
- `skip_if_not_installed("pkg")`: Skip if a dependency is missing.

## Best Practices
- **File Organization**: Match `R/` files to `tests/testthat/test-` files (e.g., `R/string-logic.R` -> `tests/testthat/test-string-logic.R`).
- **3rd Edition**: Always use the 3rd edition for new projects by adding `Config/testthat/edition: 3` to your `DESCRIPTION` file.
- **Helper Files**: Put reusable setup code or custom expectations in `tests/testthat/helper.R`.
- **Parallel Testing**: Enable parallel tests in `DESCRIPTION` with `Config/testthat/parallel: true` to speed up large suites.

## Reference documentation
- [Testing challenging functions](./references/challenging-tests.Rmd)
- [Custom expectations](./references/custom-expectation.Rmd)
- [Mocking](./references/mocking.Rmd)
- [Running tests in parallel](./references/parallel.Rmd)
- [Skipping tests](./references/skipping.Rmd)
- [Snapshot tests](./references/snapshotting.Rmd)
- [Special files](./references/special-files.Rmd)
- [Test fixtures](./references/test-fixtures.Rmd)
- [testthat 3e](./references/third-edition.Rmd)