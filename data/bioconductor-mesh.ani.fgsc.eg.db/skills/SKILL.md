---
name: bioconductor-mesh.ani.fgsc.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Aspergillus nidulans FGSC. Use when user asks to map gene identifiers to medical subject headings, perform functional annotation, or conduct gene set enrichment analysis for this specific organism.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Ani.FGSC.eg.db.html
---

# bioconductor-mesh.ani.fgsc.eg.db

name: bioconductor-mesh.ani.fgsc.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Aspergillus nidulans FGSC. Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological concepts with genomic data for this specific organism using Bioconductor.

# bioconductor-mesh.ani.fgsc.eg.db

## Overview
The `MeSH.Ani.FGSC.eg.db` package is a specialized annotation database for *Aspergillus nidulans* FGSC. It facilitates the translation between MeSH terms (used for indexing biological literature and concepts) and Entrez Gene identifiers. It is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, providing a standardized interface for querying biological metadata.

## Installation and Loading
To use this package in an R session:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Ani.FGSC.eg.db")
library(MeSH.Ani.FGSC.eg.db)
```

## Core Workflows

### Exploring the Database
The package follows the standard `AnnotationDbi` interface. Use these four methods to explore the data:

*   `columns(MeSH.Ani.FGSC.eg.db)`: List the types of data that can be retrieved (e.g., MESHID, GENEID).
*   `keytypes(MeSH.Ani.FGSC.eg.db)`: List the types of identifiers that can be used as query keys.
*   `keys(MeSH.Ani.FGSC.eg.db, keytype=...)`: Retrieve all available keys of a specific type.
*   `select(MeSH.Ani.FGSC.eg.db, keys=..., columns=..., keytype=...)`: Perform the actual mapping.

### Example: Mapping Entrez Gene IDs to MeSH Terms
```r
# 1. Identify available columns
cls <- columns(MeSH.Ani.FGSC.eg.db)

# 2. Get a sample of Entrez Gene IDs (keys)
eg_keys <- head(keys(MeSH.Ani.FGSC.eg.db, keytype="GENEID"))

# 3. Retrieve corresponding MeSH IDs
mapping <- select(MeSH.Ani.FGSC.eg.db, 
                  keys = eg_keys, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")
print(mapping)
```

### Database Metadata
To inspect the underlying database structure and species information:
```r
species(MeSH.Ani.FGSC.eg.db)
dbInfo(MeSH.Ani.FGSC.eg.db)
dbfile(MeSH.Ani.FGSC.eg.db)
```

## Usage Tips
*   **MeSHDbi Dependency**: This package is designed to work in tandem with `MeSHDbi`. For advanced queries involving MeSH term descriptions or tree structures, ensure `MeSHDbi` is also utilized.
*   **Specific Organism**: This database is strictly for *Aspergillus nidulans* FGSC. For other organisms, look for the corresponding `.db` package (e.g., `MeSH.Hsa.eg.db` for humans).
*   **Data Versioning**: Use `dbInfo()` to check the source versions of the MeSH and Entrez Gene mappings to ensure reproducibility.

## Reference documentation
- [MeSH.Ani.FGSC.eg.db Reference Manual](./references/reference_manual.md)