---
name: bioconductor-mesh.eco.umn026.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Escherichia coli UMN026. Use when user asks to map identifiers, perform functional annotation, or conduct enrichment analysis for this specific bacterial strain.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Eco.UMN026.eg.db.html
---


# bioconductor-mesh.eco.umn026.eg.db

name: bioconductor-mesh.eco.umn026.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Escherichia coli UMN026. Use this skill when performing functional annotation, enrichment analysis, or cross-referencing genetic data with medical subject hierarchies for this specific bacterial strain.

# bioconductor-mesh.eco.umn026.eg.db

## Overview
The `MeSH.Eco.UMN026.eg.db` package is a specialized annotation database for *Escherichia coli* UMN026. It facilitates the translation between Entrez Gene identifiers and MeSH terms, allowing researchers to link genomic data with a standardized vocabulary of biological and medical concepts. This package follows the standard `AnnotationDbi` interface.

## Basic Usage

To use this package, first load the library in R:

```r
library(MeSH.Eco.UMN026.eg.db)
```

### Exploring the Database
Use the standard four accessor methods to explore the available data:

*   `columns(MeSH.Eco.UMN026.eg.db)`: List the types of data that can be retrieved.
*   `keytypes(MeSH.Eco.UMN026.eg.db)`: List the types of identifiers that can be used as query keys (e.g., MESHID, GENEID).
*   `keys(MeSH.Eco.UMN026.eg.db, keytype=...)`: Retrieve all keys of a specific type.
*   `select(MeSH.Eco.UMN026.eg.db, keys=..., columns=..., keytype=...)`: Perform a lookup to map identifiers.

### Example Workflow
Mapping Entrez Gene IDs to MeSH terms:

```r
# 1. Identify available columns
cls <- columns(MeSH.Eco.UMN026.eg.db)

# 2. Get a sample of Gene IDs (keys)
gene_keys <- head(keys(MeSH.Eco.UMN026.eg.db, keytype="GENEID"))

# 3. Retrieve corresponding MeSH information
results <- select(MeSH.Eco.UMN026.eg.db, 
                  keys = gene_keys, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")

# View results
head(results)
```

## Database Metadata
You can retrieve information about the database instance using these utility functions:

*   `species(MeSH.Eco.UMN026.eg.db)`: Confirm the target organism (Escherichia coli UMN026).
*   `dbInfo(MeSH.Eco.UMN026.eg.db)`: View metadata about the data sources and creation date.
*   `dbfile(MeSH.Eco.UMN026.eg.db)`: Get the file path to the underlying SQLite database.

## Tips
*   The package is designed to work seamlessly with the `MeSHDbi` framework. For complex queries or enrichment analysis, refer to `MeSHHyperGParams` in related Bioconductor packages.
*   Ensure your input keys match the `keytype` exactly (e.g., Entrez IDs should be characters or integers as specified by the keys method).

## Reference documentation
- [MeSH.Eco.UMN026.eg.db Reference Manual](./references/reference_manual.md)