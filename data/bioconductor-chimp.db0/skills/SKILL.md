---
name: bioconductor-chimp.db0
description: This package provides base annotation data and database schemas for Chimpanzee (*Pan troglodytes*) to support the construction of specialized annotation packages. Use when user asks to build chimpanzee-specific organism packages, create platform-specific chip packages, or use sqlForge to generate annotation databases.
homepage: https://bioconductor.org/packages/release/data/annotation/html/chimp.db0.html
---

# bioconductor-chimp.db0

name: bioconductor-chimp.db0
description: Guidance for using the chimp.db0 Bioconductor package. Use when needing to understand the role of this base annotation package in the Bioconductor ecosystem, specifically for building chimpanzee-specific annotation packages using sqlForge and AnnotationDbi.

# bioconductor-chimp.db0

## Overview

The `chimp.db0` package is a Bioconductor annotation BASE package for Chimpanzee (*Pan troglodytes*). Unlike standard annotation packages (e.g., `org.Pt.eg.db`), `.db0` packages are not intended for direct end-user querying. Instead, they serve as central repositories of raw data used by the `AnnotationDbi` package's `sqlForge` functionality to construct more stable, user-friendly annotation packages.

## Installation

To install the package, use the BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("chimp.db0")
```

## Usage and Workflow

The primary purpose of `chimp.db0` is to provide the underlying database schema and data for building other packages. 

### Integration with sqlForge
Users typically do not call functions from `chimp.db0` directly. Instead, this package must be installed on the system so that `AnnotationDbi` can locate the data when running package-building functions.

Common workflows involving `.db0` packages include:
1. **Building Organism Packages**: Using `sqlForge` to create a standard `org.db` package.
2. **Building Chip Packages**: Creating platform-specific annotation packages for microarrays.

### Direct Access Warning
Directly querying the SQLite database inside `chimp.db0` is strongly discouraged because:
- The internal schema is unstable and subject to change without notice.
- No official schema documentation is provided for the `.db0` level.
- Standard `select()`, `keys()`, and `columns()` methods from `AnnotationDbi` are intended for the resulting generated packages, not this base package.

## Typical Workflow Example

If you are tasked with creating a new annotation package for chimpanzee data, you would ensure `chimp.db0` is installed and then use `AnnotationDbi`:

```r
library(AnnotationDbi)
# Example of the type of wrapper that utilizes .db0 packages
# (Specific function calls depend on the target package type)
# makeOrgPackageFromNCBI(...) or similar sqlForge utilities
```

## Reference documentation

- [chimp.db0 Reference Manual](./references/reference_manual.md)