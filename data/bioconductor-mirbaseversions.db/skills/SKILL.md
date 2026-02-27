---
name: bioconductor-mirbaseversions.db
description: This tool provides access to mature miRNA names, sequences, and accessions across 22 different miRBase release versions using the AnnotationDbi interface. Use when user asks to retrieve miRNA metadata, map miRNA names between different miRBase versions, or query historical miRBase database records.
homepage: https://bioconductor.org/packages/release/data/annotation/html/miRBaseVersions.db.html
---


# bioconductor-mirbaseversions.db

name: bioconductor-mirbaseversions.db
description: Access and map mature miRNA names across 22 different miRBase release versions (v6.0 to v22.0). Use this skill when you need to: (1) Retrieve miRNA accessions (MIMAT), names, sequences, or organism info, (2) Map miRNA names between different miRBase versions, (3) Check if a miRNA was present in a specific historical release, or (4) Query the miRBase database using the standard AnnotationDbi interface.

# bioconductor-mirbaseversions.db

## Overview

The `miRBaseVersions.db` package is a Bioconductor annotation resource containing mature miRNA data from 22 miRBase releases (from version 6.0 to 22.0). It implements the standard `AnnotationDbi` interface, allowing users to query miRNA accessions (MIMAT IDs), names, sequences, and organism information across different database versions. This is particularly useful for reconciling miRNA nomenclature changes over time.

## Core Functions

The package uses the four standard `AnnotationDbi` methods:

- `keytypes(miRBaseVersions.db)`: Lists available tables and version-specific views.
- `columns(miRBaseVersions.db)`: Lists the types of data that can be retrieved.
- `keys(miRBaseVersions.db, keytype)`: Returns all valid keys for a given keytype.
- `select(miRBaseVersions.db, keys, columns, keytype)`: Performs the data retrieval.

## Usage Workflow

### 1. Initialization
```r
library(miRBaseVersions.db)
```

### 2. Exploring the Database Structure
Check available columns and keytypes:
```r
# Available data fields: ACCESSION, NAME, ORGANISM, SEQUENCE, VERSION
columns(miRBaseVersions.db)

# Available tables: "MIMAT" (all records) or "VW-MIMAT-[VERSION]" (version-specific views)
keytypes(miRBaseVersions.db)
```

### 3. Querying miRNA Information
To track a specific miRNA accession across all versions:
```r
# Querying by MIMAT accession
result <- select(miRBaseVersions.db, 
                 keys = "MIMAT0000092", 
                 keytype = "MIMAT", 
                 columns = c("NAME", "VERSION", "SEQUENCE"))
```

To get all miRNAs present in a specific miRBase version (e.g., version 22.0):
```r
# Get keys for a specific version view
v22_keys <- head(keys(miRBaseVersions.db, keytype = "VW-MIMAT-22.0"))

# Select data from that specific view
v22_data <- select(miRBaseVersions.db, 
                   keys = v22_keys, 
                   keytype = "VW-MIMAT-22.0", 
                   columns = "*")
```

## Tips and Best Practices

- **MIMAT IDs**: Use the `ACCESSION` column (MIMAT IDs) as the most stable identifier, as miRNA `NAME` strings often change between versions.
- **SQL Views**: Keytypes starting with `VW-MIMAT-` are SQL views. Querying these is more efficient than querying the main `MIMAT` table and filtering by version manually.
- **Wildcards**: You can use `columns = "*"` in the `select` function to retrieve all available fields (ACCESSION, NAME, ORGANISM, SEQUENCE, VERSION).
- **Organisms**: The database covers 271 organisms. Use the `ORGANISM` column (e.g., "hsa" for human) to filter results.

## Reference documentation

- [miRBaseVersions.db-vignette](./references/miRBaseVersions.db-vignette.md)
- [vignette_2](./references/vignette_2.md)