---
name: bioconductor-pfam.db
description: This package provides access to PFAM protein family annotation data and mappings to other biological identifiers. Use when user asks to map PFAM accessions to external databases like InterPro, PDB, or SCOP, retrieve protein domain descriptions, or query PFAM metadata using Bioconductor.
homepage: https://bioconductor.org/packages/release/data/annotation/html/PFAM.db.html
---

# bioconductor-pfam.db

name: bioconductor-pfam.db
description: Provides access to PFAM (Protein Families) annotation data. Use when you need to map PFAM accession numbers to other biological identifiers (InterPro, PDB, SCOP, CAZy, etc.) or retrieve descriptions and metadata for protein domains using the Bioconductor PFAM.db package.

# bioconductor-pfam.db

## Overview
PFAM.db is a Bioconductor annotation data package that provides detailed information about the PFAM (Protein Families) platform. It maps PFAM accession numbers to various other database identifiers and functional descriptions. While it supports older "Bimap" style interfaces, the modern and preferred method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Using the select() Interface
The `select()` function is the standard way to query the database.

```r
library(PFAM.db)

# 1. List available columns (data types)
columns(PFAM.db)

# 2. List available key types (usually "PFAMID")
keytypes(PFAM.db)

# 3. Retrieve data for specific PFAM accessions
pfam_ids <- c("PF00001", "PF00002")
select(PFAM.db, 
       keys = pfam_ids, 
       columns = c("DE", "INTERPRO", "PDB"), 
       keytype = "PFAMID")
```

### Using Bimap Objects
Bimaps are environment-like objects for direct mapping. They are useful for quick lookups or converting entire maps to lists.

```r
# Map PFAM ID to Description (DE)
x <- PFAMDE
mapped_keys <- mappedkeys(x)
# Convert to list for the first 5 mapped keys
as.list(x[mapped_keys[1:5]])

# Map PFAM ID to PDB structures
pdb_map <- as.list(PFAMPDB["PF00001"])
```

### Reverse Mappings
To map from an external ID back to a PFAM accession, use the `*2AC` objects.

```r
# Map PDB ID to PFAM Accession
as.list(PFAMPDB2AC["1AS6"])

# Map InterPro ID to PFAM Accession
as.list(PFAMINTERPRO2AC["IPR000001"])
```

## Key Mapping Types
The package supports a wide range of identifiers. Common ones include:
- **DE**: Definition/Description of the PFAM family.
- **ID**: Associated Identification (short name).
- **PDB**: 3D structure identifiers from the Protein Data Bank.
- **SCOP**: Structural Classification of Proteins identifiers.
- **INTERPRO**: Associated InterPro IDs.
- **CAZY**: Carbohydrate-Active EnZymes identifiers.
- **SMART**: Simple Modular Architecture Research Tool identifiers.
- **MEROPS**: Peptidase database identifiers.

## Database Utilities
You can access the underlying SQLite database information directly if needed.

```r
# Get database connection
conn <- PFAM_dbconn()

# Get number of rows in the description table via SQL
library(DBI)
dbGetQuery(conn, "SELECT COUNT(*) FROM de;")

# Get the path to the SQLite file
PFAM_dbfile()

# View the database schema
PFAM_dbschema()
```

## Tips
- **Map Counts**: Use `PFAMMAPCOUNTS` or `checkMAPCOUNTS("PFAM.db")` to verify the number of mapped keys in the current release.
- **Updates**: This package is updated biannually by Bioconductor; ensure you are using the version corresponding to your Bioconductor release for the most current mappings.

## Reference documentation
- [PFAM.db](./references/reference_manual.md)