---
name: bioconductor-orthology.eg.db
description: This package provides orthology mappings between species using NCBI Gene IDs and the Bioconductor select interface. Use when user asks to map genes between different species, translate NCBI Gene IDs to orthologs, or identify available species for orthology conversion.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Orthology.eg.db.html
---

# bioconductor-orthology.eg.db

name: bioconductor-orthology.eg.db
description: Use this skill to perform orthology mapping between species using the Bioconductor package Orthology.eg.db. This skill is essential for translating NCBI Gene IDs from one organism to their corresponding orthologs in another (e.g., Human to Mouse, or Electric eel to Human) using the standard AnnotationDbi select() interface.

# bioconductor-orthology.eg.db

## Overview

The `Orthology.eg.db` package is a specialized Bioconductor annotation data package that provides orthology mappings based on NCBI Gene IDs and NCBI orthology data. Unlike standard organism-level annotation packages (like `org.Hs.eg.db`), this package uses species names as both `keytypes` and `columns`. It is the primary resource for programmatic ortholog conversion within the Bioconductor ecosystem using the `select()` interface.

## Core Workflow

### 1. Loading the Package
```r
library(Orthology.eg.db)
library(AnnotationDbi)
```

### 2. Identifying Available Species
The "keytypes" and "columns" in this database are the scientific names of the species (Genus.species format).
```r
# List available species names
head(keytypes(Orthology.eg.db))
head(columns(Orthology.eg.db))
```

### 3. Mapping Orthologs
To map IDs, use the `select()` function. You must specify the source species as the `keytype` and the target species as the `columns`.

**Example: Human to Mouse**
```r
# Map Human Gene IDs (1, 9, 13) to Mouse orthologs
genes_to_map <- c("1", "9", "13")
select(Orthology.eg.db, 
       keys = genes_to_map, 
       columns = "Mus.musculus", 
       keytype = "Homo.sapiens")
```

**Example: Mapping all genes for a specific species**
```r
# Get all available IDs for Electric eel
ee_keys <- keys(Orthology.eg.db, keytype = "Electrophorus.electricus")

# Map them to Human
ee_to_human <- select(Orthology.eg.db, 
                      keys = ee_keys, 
                      columns = "Homo.sapiens", 
                      keytype = "Electrophorus.electricus")
```

## Database Utilities

For advanced users needing direct SQL access or schema information:

- `Orthology.eg_dbconn()`: Returns the DBI connection to the underlying SQLite database.
- `Orthology.eg_dbfile()`: Returns the file path to the SQLite database.
- `Orthology.eg_dbschema()`: Prints the database schema.
- `Orthology.eg_dbInfo()`: Displays metadata about the database version and source.

**Example: Direct SQL Query**
```r
library(DBI)
dbGetQuery(Orthology.eg_dbconn(), "SELECT COUNT(*) FROM genes")
```

## Usage Tips
- **ID Format**: All keys must be character strings representing NCBI Gene IDs (Entrez IDs).
- **Species Format**: Species names are case-sensitive and follow the `Genus.species` format (e.g., `Homo.sapiens`, not `homo_sapiens` or `Human`).
- **One-to-Many**: Be aware that orthology mappings can be one-to-many; the `select()` function will return a data.frame with all discovered mappings.

## Reference documentation
- [Orthology.eg.db Reference Manual](./references/reference_manual.md)