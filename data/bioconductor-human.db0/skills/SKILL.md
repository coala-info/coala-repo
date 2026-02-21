---
name: bioconductor-human.db0
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human.db0.html
---

# bioconductor-human.db0

name: bioconductor-human.db0
description: Use this skill when working with the Bioconductor annotation base package 'human.db0'. This package provides the underlying SQLite databases required by AnnotationDbi's sqlForge to build human-specific annotation packages (like org.Hs.eg.db or chip-specific packages). Use this skill when you need to install the base data for building custom annotation packages or when troubleshooting the data source for human genomic annotations.

# bioconductor-human.db0

## Overview

The `human.db0` package is a "base" annotation package for *Homo sapiens*. Unlike standard annotation packages (e.g., `org.Hs.eg.db`), it does not provide a stable, user-friendly schema for direct querying. Instead, its primary purpose is to serve as a centralized data repository for the `AnnotationDbi` `sqlForge` toolset. It contains the raw SQLite databases used to generate higher-level annotation packages.

## Installation and Loading

To use this package, it must be installed via `BiocManager`.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("human.db0")
library(human.db0)
```

## Typical Workflow: Building Annotation Packages

You should rarely query `human.db0` directly. Instead, use it as a dependency for `AnnotationDbi` functions that create custom ChipDb or OrgDb packages.

### Using sqlForge Wrappers

The most common use case is providing the data source for building human chip-specific annotation packages.

```r
library(AnnotationDbi)
library(human.db0)

# Example: Creating a human chip-level annotation package
# This requires a mapping file (e.g., a CSV with probe to Entrez ID mappings)
# makeHUMANCHIP_DB(schema, prefix, fileName, baseMapType, outputDir, version)
```

## Usage Tips

- **Direct Access Warning**: The database schema within `human.db0` is internal and subject to change without notice. Avoid writing `RSQLite` queries directly against the underlying files if you require long-term script stability.
- **Data Source**: This package is updated with each Bioconductor release to ensure that `sqlForge` has access to the latest NCBI/Entrez Gene mappings for humans.
- **Alternative Packages**: For standard annotation tasks (mapping IDs, GO terms, or pathways), use `org.Hs.eg.db` or specific ChipDb packages (e.g., `hgu133plus2.db`) instead of `human.db0`.

## Reference documentation

- [human.db0 Reference Manual](./references/reference_manual.md)