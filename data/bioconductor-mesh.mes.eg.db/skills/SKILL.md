---
name: bioconductor-mesh.mes.eg.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for the Golden Hamster (Mesocricetus auratus). Use when user asks to map hamster gene IDs to MeSH terms, perform functional annotation, or conduct gene set enrichment analysis using MeSH categories.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Mes.eg.db.html
---


# bioconductor-mesh.mes.eg.db

name: bioconductor-mesh.mes.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Mesocricetus auratus (Golden Hamster). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for hamster models.

# bioconductor-mesh.mes.eg.db

## Overview

The `MeSH.Mes.eg.db` package is a Bioconductor annotation database that provides a mapping between Medical Subject Headings (MeSH) and Entrez Gene identifiers for *Mesocricetus auratus* (Golden Hamster). It is built upon the `MeSHDbi` framework, allowing users to query biological concepts and their associated genes using a standard interface.

## Core Workflows

### Loading the Database
To use the package, load the library. The database object is named the same as the package.

```r
library(MeSH.Mes.eg.db)
# View object summary
MeSH.Mes.eg.db
```

### Exploring the Database Structure
Use the standard `AnnotationDbi` methods to understand what data is available.

```r
# List available columns (data types)
columns(MeSH.Mes.eg.db)

# List available keytypes (fields that can be used as input)
keytypes(MeSH.Mes.eg.db)

# Get the first few keys of a specific type (e.g., MESHID)
head(keys(MeSH.Mes.eg.db, keytype="MESHID"))
```

### Querying Data
Use the `select` function to retrieve mappings. This is the primary way to translate between Entrez Gene IDs and MeSH terms.

```r
# Example: Mapping specific Entrez Gene IDs to MeSH terms
my_genes <- c("101823545", "101823546") # Example Entrez IDs
res <- select(MeSH.Mes.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
To inspect the underlying database properties:

```r
species(MeSH.Mes.eg.db)  # Confirm species (Mesocricetus auratus)
dbconn(MeSH.Mes.eg.db)   # Get SQLite connection
dbfile(MeSH.Mes.eg.db)   # Get database file path
dbschema(MeSH.Mes.eg.db) # View table schema
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often categorized (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results to specific areas of interest.
- **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced enrichment analysis, consider using this database in conjunction with the `meshr` package.
- **Entrez IDs**: Ensure your input gene identifiers are character strings, as Entrez IDs are treated as keys in this database.

## Reference documentation
- [MeSH.Mes.eg.db Reference Manual](./references/reference_manual.md)