---
name: bioconductor-bioccheck
description: This tool validates R packages against Bioconductor-specific guidelines and best practices to ensure they meet repository standards. Use when user asks to check a package for Bioconductor submission, perform quality control on R package source code, or troubleshoot BiocCheck errors, warnings, and notes.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocCheck.html
---

# bioconductor-bioccheck

name: bioconductor-bioccheck
description: Use this skill to validate R packages against Bioconductor guidelines using the BiocCheck package. It should be used when preparing a package for Bioconductor submission, performing quality control on existing Bioconductor packages, or troubleshooting ERROR, WARNING, and NOTE messages related to Bioconductor-specific standards.

# bioconductor-bioccheck

## Overview

The `BiocCheck` package is a critical quality control tool that complements `R CMD check` by enforcing Bioconductor-specific best practices and requirements. It analyzes package source directories or tarballs to identify issues categorized as ERROR (must fix for acceptance), WARNING (should fix), or NOTE (optional improvements). It covers a wide range of checks including versioning, documentation, coding practices, and build system compatibility.

## Installation

To install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BiocCheck")
```

## Core Workflows

### Running Standard Checks
`BiocCheck` is typically run on a package source directory or a built `.tar.gz` file. It should always be run *after* a successful `R CMD check`.

```r
library(BiocCheck)

# Run checks on a package directory
BiocCheck("path/to/PackageName")

# Run checks on a source tarball
BiocCheck("PackageName_1.0.0.tar.gz")
```

### New Package Submissions
When preparing a package for initial submission to Bioconductor, use the `new-package` argument to enable stricter versioning and naming checks.

```r
BiocCheck("path/to/PackageName", `new-package` = TRUE)
```

### Git-Specific Checks
For packages maintained in a Git repository, use `BiocCheckGitClone` to check for forbidden files (e.g., `.Rproj`, `.DS_Store`) and raw `DESCRIPTION` file formatting that might be obscured after a build.

```r
BiocCheckGitClone("path/to/cloned/repo")
```

## Interpreting Results

The output is divided into three levels of severity:
1.  **ERROR**: Critical violations. The package will not be accepted into Bioconductor until these are resolved.
2.  **WARNING**: Significant issues that usually require addressing before release.
3.  **NOTE**: Suggestions for better alignment with Bioconductor style and best practices.

## Common Check Categories

- **Versioning**: Ensures `x.y.z` format is correct. New submissions should typically be `0.99.z`.
- **biocViews**: Validates that the `biocViews` field in `DESCRIPTION` contains specific, valid terms from the Bioconductor hierarchy.
- **Coding Practices**: Checks for `vapply` vs `sapply`, `seq_len` vs `1:n`, and avoids `T`/`F` or `<<-`.
- **Documentation**: Ensures 80% of exported objects have runnable examples and that `man` pages have `\value` sections.
- **Vignettes**: Checks for the existence of the `vignettes/` directory, proper engines, and that code chunks are evaluated (not just `eval=FALSE`).
- **Dependencies**: Discourages the use of `Remotes:` and checks for deprecated packages like `multicore`.

## Useful Options

You can disable specific checks if they are not applicable to your current environment:

```r
# Example: Skip vignette and biocViews checks
BiocCheck("path/to/pkg", `no-check-vignettes` = TRUE, `no-check-bioc-views` = TRUE)
```

## Reference documentation

- [BiocCheck: Ensuring Bioconductor package guidelines](./references/BiocCheck.md)