---
name: bioconductor-mesh.cal.sc5314.eg.db
description: This package provides mapping between Entrez Gene IDs and Medical Subject Headings (MeSH) for the yeast strain Candida albicans SC5314. Use when user asks to map yeast genetic data to MeSH terms, perform functional enrichment analysis, or query gene-to-MeSH relationships for Candida albicans.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Cal.SC5314.eg.db.html
---

# bioconductor-mesh.cal.sc5314.eg.db

name: bioconductor-mesh.cal.sc5314.eg.db
description: Annotation package for Candida albicans SC5314 providing correspondence between MeSH IDs and Entrez Gene IDs. Use this skill when you need to map yeast genetic data to Medical Subject Headings (MeSH) for functional analysis or enrichment studies.

## Overview
The `MeSH.Cal.SC5314.eg.db` package is a Bioconductor annotation resource for the organism *Candida albicans* SC5314. It utilizes the `AnnotationDbi` interface, allowing users to query relationships between Entrez Gene identifiers and MeSH terms.

## Basic Usage

To use the package, load the library and interact with the primary object `MeSH.Cal.SC5314.eg.db`.

```r
library(MeSH.Cal.SC5314.eg.db)

# Display object information
MeSH.Cal.SC5314.eg.db
```

### Standard Accessor Methods
The package follows the standard four accessor methods for `AnnotationDbi` objects:

1.  **`columns(x)`**: List the types of data that can be retrieved.
2.  **`keytypes(x)`**: List the types of keys that can be used for querying.
3.  **`keys(x, keytype)`**: Return all keys of a specific type.
4.  **`select(x, keys, columns, keytype)`**: Retrieve the data based on provided keys.

### Example Workflow

```r
# 1. Check available columns and keytypes
cls <- columns(MeSH.Cal.SC5314.eg.db)
kts <- keytypes(MeSH.Cal.SC5314.eg.db)

# 2. Retrieve a sample of keys (e.g., Entrez Gene IDs)
# Assuming kts[2] is 'GENEID' or similar
kt <- kts[2]
ks <- head(keys(MeSH.Cal.SC5314.eg.db, keytype=kt))

# 3. Perform a query
res <- select(MeSH.Cal.SC5314.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)
```

## Database Metadata
You can extract metadata and connection details using the following functions:

*   `species(MeSH.Cal.SC5314.eg.db)`: Returns the organism name.
*   `dbInfo(MeSH.Cal.SC5314.eg.db)`: Provides database information.
*   `dbconn(MeSH.Cal.SC5314.eg.db)`: Returns the underlying SQLite connection.
*   `dbfile(MeSH.Cal.SC5314.eg.db)`: Returns the path to the database file.
*   `dbschema(MeSH.Cal.SC5314.eg.db)`: Displays the database schema.

## Tips
*   This package is specifically for the **SC5314** strain of *Candida albicans*.
*   For more complex queries involving MeSH hierarchies, consider using this package in conjunction with the `MeSHDbi` and `meshr` packages.

## Reference documentation
- [MeSH.Cal.SC5314.eg.db Manual](./references/reference_manual.md)