---
name: bioconductor-zebrafish.db0
description: This package provides base annotation databases for Zebrafish (Danio rerio) to be used as data sources for the AnnotationDbi sqlForge toolset. Use when user asks to build custom zebrafish annotation packages, create organism-specific annotation objects, or access raw SQLite data for zebrafish genomic mappings.
homepage: https://bioconductor.org/packages/release/data/annotation/html/zebrafish.db0.html
---


# bioconductor-zebrafish.db0

name: bioconductor-zebrafish.db0
description: Guidance for using the zebrafish.db0 Bioconductor package. Use this skill when you need to access base annotation databases for Zebrafish (Danio rerio) to build custom annotation packages using AnnotationDbi's sqlForge.

# bioconductor-zebrafish.db0

## Overview
The `zebrafish.db0` package is a Bioconductor annotation BASE package. Unlike standard annotation packages (like `org.Dr.eg.db`), this package is specifically designed as a data source for the `sqlForge` toolset within the `AnnotationDbi` framework. It contains the raw SQLite databases required to construct higher-level annotation packages.

Directly querying the databases within this package is discouraged because the schema is unstable and subject to change. Instead, it should be used as an input for functions that generate consistent, schema-compliant annotation objects.

## Typical Workflow

### 1. Installation
The package should be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("zebrafish.db0")
```

### 2. Using with sqlForge
The primary use case for `zebrafish.db0` is providing the underlying data for creating organism-specific or chip-specific annotation packages. While the package itself does not provide high-level mapping functions (like `select()` or `mapIds()`), it enables the creation of packages that do.

To create a zebrafish organism package from the base data:

```r
library(AnnotationDbi)
library(zebrafish.db0)

# Example: Using sqlForge to create a standard organism package
# Note: This is typically handled by Bioconductor maintainers, 
# but useful for custom annotation pipeline development.
makeZEBRAFISH_DB(
  version = "1.0.0",
  maintainer = "Your Name <your.email@example.com>",
  author = "Your Name",
  outputDir = ".",
  tax_id = "7955",
  genus = "Danio",
  species = "rerio"
)
```

### 3. Accessing the Database Location
If you must find the path to the raw SQLite database for low-level tools:

```r
system.file("extdata", package="zebrafish.db0")
```

## Usage Tips
- **Do Not Query Directly:** Avoid writing SQL queries against the internal tables of `zebrafish.db0` for production scripts. Use the generated `org.Dr.eg.db` package for standard gene-to-symbol or gene-to-GO mappings.
- **Purpose:** This package is a dependency for `AnnotationDbi`. If you are trying to annotate a Zebrafish RNA-seq dataset, you likely want `org.Dr.eg.db` instead of `zebrafish.db0`.
- **Updates:** Always ensure this package is up to date when building new annotation packages to ensure you are using the latest NCBI/Entrez mappings.

## Reference documentation
- [zebrafish.db0 Reference Manual](./references/reference_manual.md)