---
name: bioconductor-mesh.ptr.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Pan troglodytes. Use when user asks to map chimpanzee genes to medical subject headings, perform functional annotation for Pan troglodytes, or cross-reference chimpanzee genetic data with MeSH terms.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Ptr.eg.db.html
---


# bioconductor-mesh.ptr.eg.db

name: bioconductor-mesh.ptr.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Pan troglodytes (Chimpanzee). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genetic data for chimpanzees using the MeSH.Ptr.eg.db Bioconductor package.

# bioconductor-mesh.ptr.eg.db

## Overview
The `MeSH.Ptr.eg.db` package is a specialized annotation database for *Pan troglodytes* (Chimpanzee). It facilitates the conversion and mapping between Entrez Gene identifiers and MeSH terms. This is particularly useful for researchers looking to associate chimpanzee genes with specific medical subjects, diseases, or biological concepts defined in the MeSH hierarchy.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Ptr.eg.db")
library(MeSH.Ptr.eg.db)
```

## Core Workflows

### Database Exploration
The package follows the standard `AnnotationDbi` interface. Use these four methods to explore the database structure:

*   `columns(MeSH.Ptr.eg.db)`: List the types of data that can be retrieved.
*   `keytypes(MeSH.Ptr.eg.db)`: List the types of identifiers that can be used as query keys (e.g., MESHID, GENEID).
*   `keys(MeSH.Ptr.eg.db, keytype=...)`: Retrieve all available keys of a specific type.
*   `select(MeSH.Ptr.eg.db, keys=..., columns=..., keytype=...)`: Perform the actual mapping.

### Example: Mapping Entrez IDs to MeSH Terms
```r
# 1. Identify available columns
cls <- columns(MeSH.Ptr.eg.db)

# 2. Get a sample of Entrez Gene IDs (GENEID)
eg_keys <- head(keys(MeSH.Ptr.eg.db, keytype="GENEID"))

# 3. Map Gene IDs to MeSH IDs and Categories
res <- select(MeSH.Ptr.eg.db, 
              keys = eg_keys, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
To inspect the underlying database properties:
*   `species(MeSH.Ptr.eg.db)`: Confirm the target organism (Pan troglodytes).
*   `dbInfo(MeSH.Ptr.eg.db)`: View metadata about the data sources and versions.
*   `dbfile(MeSH.Ptr.eg.db)`: Get the file path to the SQLite database.

## Usage Tips
*   **MeSH Categories**: When using `select`, including the `MESHCATEGORY` column helps filter results by specific MeSH branches (e.g., Diseases, Chemicals and Drugs).
*   **MeSHDbi**: For more complex queries or to understand the underlying framework, refer to the `MeSHDbi` package documentation, which defines the class structure for this object.
*   **Entrez IDs**: Ensure your input keys are character vectors, as `AnnotationDbi` methods expect string input for keys.

## Reference documentation
- [MeSH.Ptr.eg.db Reference Manual](./references/reference_manual.md)