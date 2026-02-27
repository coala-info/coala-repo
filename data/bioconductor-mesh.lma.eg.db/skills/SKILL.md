---
name: bioconductor-mesh.lma.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the species Lutzomyia mazamae. Use when user asks to perform functional annotation, conduct gene set enrichment analysis, or map medical subject headings to genomic data for Lutzomyia mazamae.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Lma.eg.db.html
---


# bioconductor-mesh.lma.eg.db

name: bioconductor-mesh.lma.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Lutzomyia mazamae (Lma). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for this specific species using Bioconductor.

## Overview

The `MeSH.Lma.eg.db` package is a specialized annotation database for *Lutzomyia mazamae*. It allows researchers to bridge the gap between standardized medical/biological terminology (MeSH) and NCBI Entrez Gene identifiers. It follows the standard `AnnotationDbi` interface, making it compatible with common R/Bioconductor workflows for data retrieval and mapping.

## Core Workflow

To use this package, you must have it installed and loaded in your R environment.

```r
# Load the library
library(MeSH.Lma.eg.db)

# View object summary
MeSH.Lma.eg.db
```

### Data Exploration

Use the standard four accessor methods to explore the database structure:

1.  **`keytypes(MeSH.Lma.eg.db)`**: List the types of identifiers that can be used as keys (e.g., "MESHID", "ENTREZID").
2.  **`columns(MeSH.Lma.eg.db)`**: List the types of data that can be retrieved.
3.  **`keys(MeSH.Lma.eg.db, keytype=...)`**: List all available keys for a specific keytype.
4.  **`select(MeSH.Lma.eg.db, keys, columns, keytype)`**: Perform the actual mapping/lookup.

### Example: Mapping MeSH IDs to Entrez IDs

```r
# 1. Identify available keytypes
kts <- keytypes(MeSH.Lma.eg.db)

# 2. Get a sample of keys (e.g., the first few MeSH IDs)
sample_keys <- head(keys(MeSH.Lma.eg.db, keytype="MESHID"))

# 3. Retrieve corresponding Entrez Gene IDs
mapping <- select(MeSH.Lma.eg.db, 
                  keys = sample_keys, 
                  columns = c("MESHID", "ENTREZID"), 
                  keytype = "MESHID")

# View results
head(mapping)
```

## Database Metadata

You can retrieve technical information about the underlying database using these utility functions:

*   `species(MeSH.Lma.eg.db)`: Confirm the target organism (*Lutzomyia mazamae*).
*   `dbInfo(MeSH.Lma.eg.db)`: View metadata about the data sources and build version.
*   `dbfile(MeSH.Lma.eg.db)`: Get the file path to the SQLite database.
*   `dbschema(MeSH.Lma.eg.db)`: View the internal database schema.

## Tips for Success

*   **Vectorized Queries**: The `select` function is highly efficient with vectors. Pass all your genes of interest at once rather than looping.
*   **MeSH Hierarchy**: Remember that MeSH is hierarchical. This package provides the direct mappings; for tree-structure navigation, use the `MeSHDbi` or `MeSH.db` packages in conjunction with this one.
*   **Entrez Focus**: This specific package is centered on Entrez Gene IDs. If you have Uniprot or Ensembl IDs, you may need to map them to Entrez IDs first using an `org.Lma.eg.db` package (if available) before using this MeSH mapping.

## Reference documentation

- [MeSH.Lma.eg.db Reference Manual](./references/reference_manual.md)