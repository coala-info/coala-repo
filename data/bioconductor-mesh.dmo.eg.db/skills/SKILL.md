---
name: bioconductor-mesh.dmo.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Drosophila melanogaster. Use when user asks to map MeSH terms to fruit fly gene identifiers, perform functional annotation, or conduct gene set enrichment analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Dmo.eg.db.html
---


# bioconductor-mesh.dmo.eg.db

name: bioconductor-mesh.dmo.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Drosophila melanogaster (fruit fly). Use this skill when performing functional annotation, gene set enrichment analysis, or translating between medical terminology and genomic data for Drosophila.

# bioconductor-mesh.dmo.eg.db

## Overview
The `MeSH.Dmo.eg.db` package is a Bioconductor annotation database that facilitates the mapping between MeSH terms and Entrez Gene identifiers specifically for *Drosophila melanogaster*. It is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, allowing users to query biological metadata using a standardized interface.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Dmo.eg.db")
library(MeSH.Dmo.eg.db)
```

## Core Workflows

### Exploring the Database
Use the standard `AnnotationDbi` methods to understand the available data types:

```r
# View available columns (data types)
columns(MeSH.Dmo.eg.db)

# View available keytypes (searchable fields)
keytypes(MeSH.Dmo.eg.db)

# Get the first few keys for a specific keytype (e.g., MESHID)
head(keys(MeSH.Dmo.eg.db, keytype="MESHID"))
```

### Mapping Identifiers
The `select` function is the primary tool for retrieving mappings.

```r
# Example: Map specific MeSH IDs to Entrez Gene IDs
my_keys <- c("D000107", "D000108") # Example MeSH IDs
res <- select(MeSH.Dmo.eg.db, 
              keys = my_keys, 
              columns = c("GENEID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "MESHID")
head(res)
```

### Database Metadata
To inspect the underlying database structure and species information:

```r
# Get species name
species(MeSH.Dmo.eg.db)

# Get database metadata
dbInfo(MeSH.Dmo.eg.db)

# Get the path to the underlying SQLite file
dbfile(MeSH.Dmo.eg.db)
```

## Usage Tips
- **MeSHDbi Dependency**: This package is designed to work with `MeSHDbi`. For advanced analysis like enrichment testing, consider using the `meshr` package.
- **Key Selection**: Always verify the `keytype` matches the format of your input `keys` to avoid empty results.
- **Data Source**: This package provides correspondence between MeSH and Entrez Gene IDs; it does not contain the full MeSH hierarchy descriptions (use `MeSH.db` for general MeSH term descriptions).

## Reference documentation
- [MeSH.Dmo.eg.db Reference Manual](./references/reference_manual.md)