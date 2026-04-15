---
name: bioconductor-mesh.dda.3937.eg.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for the organism Dictyostelium discoideum. Use when user asks to perform functional annotation, conduct enrichment analysis, or map gene identifiers to MeSH terms for this specific species.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dda.3937.eg.db.html
---

# bioconductor-mesh.dda.3937.eg.db

name: bioconductor-mesh.dda.3937.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for the species Dictyostelium discoideum (3937). Use this skill when performing functional annotation, enrichment analysis, or gene-to-term lookups involving MeSH terms and Entrez IDs for this specific organism.

# bioconductor-mesh.dda.3937.eg.db

## Overview

The `MeSH.Dda.3937.eg.db` package is a specialized Bioconductor annotation object. It serves as a bridge between the MeSH (Medical Subject Headings) classification system and Entrez Gene identifiers for *Dictyostelium discoideum*. It implements the standard `AnnotationDbi` interface, allowing users to query biological metadata using a consistent set of methods.

## Core Functions

The package relies on four primary methods to explore and retrieve data:

- `columns(MeSH.Dda.3937.eg.db)`: Lists the types of data that can be retrieved (e.g., MESHID, GENEID).
- `keytypes(MeSH.Dda.3937.eg.db)`: Lists the types of identifiers that can be used as query keys.
- `keys(x, keytype)`: Returns all available keys for a specific keytype.
- `select(x, keys, columns, keytype)`: Performs the actual lookup to map keys to the desired columns.

## Typical Workflow

To use the package in an R session:

```R
# 1. Load the library
library(MeSH.Dda.3937.eg.db)

# 2. Check available columns and keytypes
cols <- columns(MeSH.Dda.3937.eg.db)
kts <- keytypes(MeSH.Dda.3937.eg.db)

# 3. Retrieve specific mappings (e.g., mapping Entrez IDs to MeSH IDs)
# Get the first few Entrez IDs as example keys
eg_keys <- head(keys(MeSH.Dda.3937.eg.db, keytype="GENEID"))

# Perform the selection
mapping <- select(MeSH.Dda.3937.eg.db, 
                  keys = eg_keys, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")

# View results
print(mapping)
```

## Database Metadata

You can inspect the underlying database properties using these utility functions:

- `species(MeSH.Dda.3937.eg.db)`: Confirms the target organism (Dictyostelium discoideum).
- `dbInfo(MeSH.Dda.3937.eg.db)`: Displays metadata about the data sources and build version.
- `dbfile(MeSH.Dda.3937.eg.db)`: Returns the path to the SQLite database file.

## Usage Tips

- **MeSH Categories**: MeSH IDs are often categorized (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column in your `select` calls to filter or group results by these high-level headings.
- **Integration**: This package is designed to work seamlessly with the `MeSHDbi` framework. For advanced enrichment analysis, consider using this package in conjunction with `meshr`.
- **Entrez IDs**: Ensure your input gene identifiers are Entrez IDs (integers/strings) rather than gene symbols or Ensembl IDs before querying this specific database.

## Reference documentation

- [MeSH.Dda.3937.eg.db Reference Manual](./references/reference_manual.md)