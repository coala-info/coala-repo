---
name: bioconductor-mesh.cja.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the species Callithrix jacchus. Use when user asks to map marmoset gene IDs to medical subject headings, perform gene set enrichment analysis using MeSH terms, or query biological metadata for Common marmoset genomic data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Cja.eg.db.html
---

# bioconductor-mesh.cja.eg.db

name: bioconductor-mesh.cja.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for the species Callithrix jacchus (Common marmoset). Use this skill when performing functional annotation, gene set enrichment analysis, or biological data integration involving marmoset genomic data and MeSH terms.

# bioconductor-mesh.cja.eg.db

## Overview

The `MeSH.Cja.eg.db` package is a Bioconductor annotation database that facilitates the mapping between Medical Subject Headings (MeSH) and Entrez Gene identifiers for *Callithrix jacchus* (Common marmoset). It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using standard AnnotationDbi methods.

## Core Workflows

### Loading the Database
To begin using the annotation data, load the library in R:

```r
library(MeSH.Cja.eg.db)
# View basic information about the database
MeSH.Cja.eg.db
```

### Exploring Available Data
Use the standard AnnotationDbi accessor functions to see what identifiers and categories are available:

```r
# List all available columns (data types)
cls <- columns(MeSH.Cja.eg.db)

# List all available keytypes (searchable fields)
kts <- keytypes(MeSH.Cja.eg.db)

# Retrieve a sample of keys for a specific keytype (e.g., Entrez Gene IDs)
ks <- head(keys(MeSH.Cja.eg.db, keytype = "GENEID"))
```

### Querying the Database
The `select` function is the primary tool for retrieving mappings. It requires the database object, the keys you are searching for, the columns you want to retrieve, and the keytype of your input keys.

```r
# Example: Mapping Entrez Gene IDs to MeSH IDs and Categories
res <- select(MeSH.Cja.eg.db, 
              keys = ks, 
              columns = c("MESHID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
You can extract specific metadata about the database connection and the target species:

```r
species(MeSH.Cja.eg.db)  # Returns "Callithrix jacchus"
dbInfo(MeSH.Cja.eg.db)   # Returns database metadata
dbfile(MeSH.Cja.eg.db)   # Returns the path to the SQLite file
```

## Usage Tips
- **MeSH Categories**: MeSH terms are organized into categories (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results to specific biological domains.
- **Integration**: This package is often used in conjunction with `MeSHSim` for semantic similarity analysis or `meshr` for enrichment analysis in marmoset datasets.
- **Keytypes**: Common keytypes include `MESHID` and `GENEID` (Entrez Gene ID).

## Reference documentation

- [MeSH.Cja.eg.db Reference Manual](./references/reference_manual.md)