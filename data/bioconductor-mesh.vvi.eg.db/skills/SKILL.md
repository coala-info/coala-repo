---
name: bioconductor-mesh.vvi.eg.db
description: This tool provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Vitis vinifera. Use when user asks to perform functional annotation, conduct enrichment analysis, or map gene identifiers to MeSH terms for grapevine genomic data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Vvi.eg.db.html
---

# bioconductor-mesh.vvi.eg.db

name: bioconductor-mesh.vvi.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Vitis vinifera (Grapevine). Use this skill when performing functional annotation, enrichment analysis, or gene-to-MeSH term lookups for Grapevine genomic data using Bioconductor.

## Overview

The `MeSH.Vvi.eg.db` package is an annotation database for *Vitis vinifera*. It allows researchers to bridge the gap between molecular biology (Entrez Gene IDs) and clinical/biomedical concepts (MeSH terms). It follows the standard `AnnotationDbi` interface, making it compatible with common R workflows for genomic data integration.

## Core Workflows

### Loading the Database
To begin, load the library. The database object is named the same as the package.

```r
library(MeSH.Vvi.eg.db)
# View object summary
MeSH.Vvi.eg.db
```

### Exploring the Database Structure
Use the standard four accessor methods to understand what data is available:

*   `keytypes(MeSH.Vvi.eg.db)`: See which ID types can be used as input (e.g., "MESHID", "GENEID").
*   `columns(MeSH.Vvi.eg.db)`: See what data types can be retrieved.
*   `keys(MeSH.Vvi.eg.db, keytype="GENEID")`: List all available identifiers for a specific type.

### Querying Data
Use the `select` function to map between Gene IDs and MeSH terms.

```r
# Example: Mapping specific Entrez Gene IDs to MeSH terms
my_genes <- c("100232866", "100232867") # Example IDs
res <- select(MeSH.Vvi.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
To extract specific information about the database instance:

```r
species(MeSH.Vvi.eg.db)  # Confirm species (Vitis vinifera)
dbInfo(MeSH.Vvi.eg.db)   # Get database metadata
dbfile(MeSH.Vvi.eg.db)   # Locate the SQLite file path
```

## Usage Tips
*   **MeSH Categories**: MeSH IDs are often categorized (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results if you are only interested in specific types of biological descriptors.
*   **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced enrichment analysis, consider using this database in conjunction with the `meshr` package.
*   **Entrez IDs**: Ensure your input keys are character strings, as Entrez IDs are treated as keys rather than integers.

## Reference documentation
- [MeSH.Vvi.eg.db Reference Manual](./references/reference_manual.md)