---
name: bioconductor-mouse.db0
description: This package provides the base SQLite databases used to build custom mouse annotation packages. Use when user asks to build custom mouse annotation packages, create chip-specific databases, or use sqlForge to generate mouse-specific genomic resources.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse.db0.html
---

# bioconductor-mouse.db0

name: bioconductor-mouse.db0
description: Use when creating custom mouse annotation packages in R. This skill is specifically for using the mouse.db0 base annotation package as a data source for AnnotationDbi's sqlForge to build ChipDb or OrgDb packages.

# bioconductor-mouse.db0

## Overview
`mouse.db0` is a Bioconductor annotation BASE package for *Mus musculus*. Unlike standard annotation packages (e.g., `org.Mm.eg.db`), this package is not intended for direct querying of gene aliases or GO terms. Instead, it serves as a centralized repository of the latest SQLite databases used by the `AnnotationDbi` package's `sqlForge` code to generate functional annotation packages.

## Installation
To use this package as a backend for building annotations, install it via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mouse.db0")
```

## Usage and Workflows
The primary use case for `mouse.db0` is providing the raw data necessary to build a "normal" annotation package (such as a chip-specific package).

### Building a Custom Chip Package
If you are developing a custom annotation package for a specific mouse microarray or platform, you use `AnnotationDbi` wrapper functions which automatically look for `mouse.db0`.

```r
library(AnnotationDbi)
library(mouse.db0)

# Example: Creating a mouse chip-level annotation database
# This is typically used by developers or bioinformaticians creating new resources
# makeMOUSECHIP_DB(schema, prefix, outputDir, version)
```

### Important Constraints
*   **Do Not Query Directly:** Users are strongly discouraged from calling the internal databases directly via SQL. The schema is unstable and subject to change without notice between Bioconductor releases.
*   **Use High-Level Wrappers:** For standard annotation tasks (mapping IDs, finding pathways), use `org.Mm.eg.db` or specific chip packages (e.g., `mgu74av2.db`).
*   **sqlForge Integration:** This package's sole purpose is to provide the data source for `AnnotationDbi::makeMOUSECHIP_DB()` and related forge functions.

## Tips
*   If you encounter errors regarding missing base databases when trying to build a mouse annotation package, ensure `mouse.db0` is installed and up to date.
*   Always check the version of `mouse.db0` to ensure you are building your custom packages against the most recent genomic data provided by Bioconductor.

## Reference documentation
- [mouse.db0 Reference Manual](./references/reference_manual.md)