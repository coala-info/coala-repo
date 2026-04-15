---
name: bioconductor-gdrstyle
description: The gDRstyle package provides a standardized development environment and style guide enforcement for the gDR platform. Use when user asks to lint package directories, run standardized package quality checks, or manage dependencies for Docker-based deployments.
homepage: https://bioconductor.org/packages/release/bioc/html/gDRstyle.html
---

# bioconductor-gdrstyle

## Overview

The `gDRstyle` package provides a standardized development environment for the gDR platform. It ensures consistency across the codebase by enforcing a specific style guide, automating package quality checks, and streamlining dependency management for Docker-based deployments.

## Core Workflows

### 1. Code Linting
To ensure your package directory follows the gDR stylistic requirements, use the `lintPkgDirs` function. This checks the code against the rules defined in the gDR style guide (e.g., indentation, naming conventions, and spacing).

```r
library(gDRstyle)
# Lint the current package directory
gDRstyle::lintPkgDirs(".")
```

### 2. Standardized Package Checking
The `checkPackage` function is the primary tool for CI/CD. It combines stylistic linting, `rcmdcheck::rcmdcheck()`, and dependency validation.

```r
# Run standard gDR checks
gDRstyle::checkPackage(".")

# Run checks including Bioconductor-specific requirements
gDRstyle::checkPackage(".", bioc_check = TRUE)
```

### 3. Dependency Management
`gDRstyle` helps keep `dependencies.yml` (used for image building) in sync with the package `DESCRIPTION` file.

*   **Validation:** `checkPackage()` automatically verifies that `dependencies.yml` is up-to-date.
*   **Installation:** Use `installAllDeps` to install all necessary dependencies for a package, often used during Docker image construction.

```r
# Install all dependencies for the current package
gDRstyle::installAllDeps(".")
```

## Style Guide Highlights

When writing code for the gDR platform, adhere to these key patterns:

*   **Indentation:** Use 2 spaces.
*   **Assignment:** Use `<-` for variable assignment; use `=` only for function arguments.
*   **Naming:** 
    *   Variables: `lower_snake_case`.
    *   Functions: `lowerCamelCase`.
    *   Internal functions: Start with a dot (e.g., `.internal_fxn`).
    *   Action functions: Start with a verb (e.g., `computeMetrics`).
*   **Functions:** 
    *   Every parameter should be on a separate line in the definition.
    *   Use implicit returns (omit the `return()` call at the end of a function).
    *   Prefer `vapply` over `sapply`.
*   **Namespacing:** Use `package.R` to handle `@import` and `@importFrom` tags for common dependencies like `checkmate` or `SummarizedExperiment`.

## Git Best Practices
*   **Commits:** Follow Conventional Commits (e.g., `feat: add new metric`, `fix: resolve subsetting bug`).
*   **Versioning:** 
    *   Bump `PATCH` for new features.
    *   Bump `MINOR` for bugfixes.
    *   *Note:* For Bioconductor-bound packages (0.99.x), always bump the `MINOR` version for any change.

## Reference documentation
- [Using gDRstyle](./references/gDRstyle.md)
- [gDR style guide](./references/style_guide.md)