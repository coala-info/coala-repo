---
name: bioconductor-rat.db0
description: bioconductor-rat.db0 provides raw SQLite databases used as a base for building custom rat annotation packages. Use when user asks to build custom organism-level annotation packages, create platform-specific chip databases for Rattus norvegicus, or provide source data for the sqlForge toolset.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rat.db0.html
---

# bioconductor-rat.db0

## Overview
The `rat.db0` package is a Bioconductor "base" annotation package. Unlike standard annotation packages (like `org.Rn.eg.db`), it does not provide a stable schema for direct querying. Instead, it serves as a centralized data repository for the `AnnotationDbi` `sqlForge` toolset. Its primary purpose is to provide the raw SQLite databases required to build up-to-date, platform-specific, or custom organism-level annotation packages for the rat.

## Usage Guidance

### Primary Workflow: Building Custom Annotation Packages
The most common use case for `rat.db0` is as a dependency for `makeRATCHIP_DB` or similar functions in `AnnotationDbi`. You do not typically call functions from `rat.db0` directly; rather, you install it so that `AnnotationDbi` can find the source data.

```r
# 1. Install the base package
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rat.db0")

# 2. Use AnnotationDbi to build a custom package
library(AnnotationDbi)
# Example: Creating a custom chip-level DB using the data in rat.db0
# (Requires a mapping file between probes and Entrez Gene IDs)
# makeRATCHIP_DB(affy_mapping_file, output_directory)
```

### Important Constraints
- **Schema Instability**: The internal database schema of `rat.db0` is subject to change without notice. Avoid writing SQL queries directly against the underlying database files.
- **Indirect Access**: Always prefer using the high-level wrappers provided by `AnnotationDbi` (e.g., `select()`, `keys()`, `columns()`) on the *generated* packages rather than trying to extract data from `rat.db0` itself.
- **Target Organism**: This package is strictly for *Rattus norvegicus*.

## Troubleshooting
If you encounter errors stating that a rat annotation database cannot be found during a build process, ensure `rat.db0` is installed and updated to the latest version:
```r
BiocManager::install("rat.db0", update = TRUE)
```

## Reference documentation
- [rat.db0 Reference Manual](./references/reference_manual.md)