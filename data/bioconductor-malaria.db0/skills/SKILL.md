---
name: bioconductor-malaria.db0
description: This package provides the base SQLite annotation database for Malaria (Plasmodium falciparum) used to build organism-specific annotation resources. Use when user asks to build custom annotation packages using sqlForge, manage underlying data sources for Bioconductor infrastructure, or access raw SQLite databases for malaria research.
homepage: https://bioconductor.org/packages/release/data/annotation/html/malaria.db0.html
---


# bioconductor-malaria.db0

name: bioconductor-malaria.db0
description: Provides the base annotation database for Malaria (Plasmodium falciparum). Use this skill when you need to build custom annotation packages for malaria research using sqlForge/AnnotationDbi, or when managing the underlying SQLite data sources required for Bioconductor annotation infrastructure.

# bioconductor-malaria.db0

## Overview
`malaria.db0` is a Bioconductor annotation BASE package. Unlike standard annotation packages (e.g., `org.Pf.plasmo.db`), it is not intended for direct querying by most users. Instead, it serves as a central repository for the latest SQLite databases used by the `sqlForge` code within the `AnnotationDbi` package to construct organism-specific or chip-specific annotation packages.

## Installation
Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("malaria.db0")
```

## Usage and Workflow
The primary purpose of this package is to provide the raw data necessary for building other packages. Direct interaction with the database inside `malaria.db0` is discouraged because the schema is unstable and subject to change.

### Using with AnnotationDbi
The package is typically used as a dependency for `AnnotationDbi` functions that "forge" new annotation packages. While the documentation lists examples for other organisms (like `makeHUMANCHIP_DB`), the logic applies to creating malaria-specific resources.

### Accessing the Database (Advanced)
If you must access the underlying data for development purposes, you can locate the database file or connection:

```r
library(malaria.db0)

# Get the path to the SQLite database file
db_file <- malaria_dbfile()

# Get a DBI connection to the database
db_conn <- malaria_dbconn()

# List tables (schema is not guaranteed to be stable)
DBI::dbListTables(db_conn)
```

## Tips
- **Avoid Direct Queries**: Do not hardcode SQL queries against this package in production scripts, as the schema may change between Bioconductor releases.
- **Use Wrapper Packages**: For standard biological queries (gene ID to GO term, etc.), check if a processed package like `org.Pf.plasmo.db` is available first.
- **sqlForge**: This package is a prerequisite if you are using `AnnotationDbi::makeOrgPackage()` or similar functions to create a custom annotation object for *Plasmodium falciparum*.

## Reference documentation
- [malaria.db0 Reference Manual](./references/reference_manual.md)