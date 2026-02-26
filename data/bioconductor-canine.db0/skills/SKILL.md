---
name: bioconductor-canine.db0
description: This package provides a base annotation database for the canine genome used primarily as a data source for building custom annotation packages. Use when user asks to install the underlying database for sqlForge, create custom canine chip packages, or build organism-specific annotation packages for dogs.
homepage: https://bioconductor.org/packages/release/data/annotation/html/canine.db0.html
---


# bioconductor-canine.db0

name: bioconductor-canine.db0
description: Use this skill when working with canine (dog) genome annotation in R. This package is a "BASE" annotation package used primarily as a data source for sqlForge to create stable annotation packages. Use it when you need to install the underlying database required to build custom canine chip or organism annotation packages.

# bioconductor-canine.db0

## Overview

The `canine.db0` package is a Bioconductor annotation BASE package for *Canis familiaris* (Dog). Unlike standard annotation packages (e.g., `canine.db`), a `.db0` package is designed to be a central repository for the latest raw annotation databases. It is primarily used by the `sqlForge` toolset within the `AnnotationDbi` framework to generate more stable, user-friendly annotation packages.

Directly querying the database within `canine.db0` is discouraged because its schema is unstable and subject to change without notice.

## Installation

To use this package as a backend for annotation building, install it via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("canine.db0")
```

## Typical Workflow

The primary purpose of `canine.db0` is to provide the necessary data for `AnnotationDbi` wrapper functions. You do not typically load this package with `library(canine.db0)` for direct analysis. Instead, it serves as a dependency for building other packages.

### Using with sqlForge

If you are creating a custom chip package for canine data, `AnnotationDbi` will look for `canine.db0` in your R library.

```r
library(AnnotationDbi)

# Example of the type of wrapper function that utilizes .db0 packages
# Note: Specific wrapper names depend on the current AnnotationDbi version
# and the specific chip type being forged.
# Typical usage involves functions like:
# makeCANINECHIP_DB(...) 
```

## Usage Tips

1. **Avoid Direct Calls**: Do not attempt to connect directly to the SQLite database inside this package using `dbConnect` unless you are developing Bioconductor core annotation tools.
2. **Use Wrapper Packages**: For standard gene-to-symbol or gene-to-GO mappings, use the standard `canine.db` package or specific chip packages (e.g., `canine2.db`) instead of this base package.
3. **Keep Updated**: Since this package is a data source for building other annotations, ensure it is updated to the latest version to provide the most current biological metadata to `sqlForge`.

## Reference documentation

- [canine.db0](./references/reference_manual.md)