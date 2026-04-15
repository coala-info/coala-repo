---
name: bioconductor-lumihumanidmapping
description: This package provides mapping tables for Illumina Human Expression chips to translate proprietary Illumina identifiers and nuIDs into RefSeq and Entrez Gene IDs. Use when user asks to map Illumina probe identifiers to nuIDs, translate nuIDs to NCBI RefSeq or Entrez Gene IDs, or access the underlying SQLite database for human expression chip annotation.
homepage: https://bioconductor.org/packages/release/data/annotation/html/lumiHumanIDMapping.html
---

# bioconductor-lumihumanidmapping

## Overview

The `lumiHumanIDMapping` package is a specialized Bioconductor annotation data package designed to work with the `lumi` package. It provides mapping tables for all Illumina Human Expression chips released prior to the package version. Its primary purpose is to provide a bridge between proprietary Illumina identifiers and **nuIDs** (nucleotide universal identifiers), as well as mappings from nuIDs to NCBI RefSeq and Entrez Gene IDs.

## Key Functions and Workflows

### Initializing and Exploring the Package
To use the mapping data, you must first load the library and can explore the available mapping objects.

```r
library(lumiHumanIDMapping)

# List all objects/tables provided by the package
ls("package:lumiHumanIDMapping")
```

### Accessing the Mapping Database
The package stores mapping information in an SQLite database. You can interact with it using standard `DBI` methods.

```r
# Get database connection
conn <- lumiHumanIDMapping_dbconn()

# List all available mapping tables (e.g., chip-specific tables and nuID_MappingInfo)
library(DBI)
dbListTables(conn)

# Check fields in the central mapping table
dbListFields(conn, 'nuID_MappingInfo')

# Get database metadata
lumiHumanIDMapping_dbInfo()
```

### Mapping nuIDs to Gene Identifiers
The `nuID_MappingInfo` table is the core resource for translating nuIDs to biological identifiers.

- **nuID**: The universal identifier for the probe sequence.
- **Refseq**: Perfect matching RefSeq IDs (comma-separated).
- **EntrezID**: Corresponding Entrez Gene IDs.
- **QualityScore**: A score indicating the mapping quality to RefSeq.

You can get a summary of the mapping status using:
```r
lumiHumanIDMapping_nuID()
```

### Typical Workflow: ID Translation
While this package is often called internally by `lumi` functions (like `addAnnotation`), you can manually query the database for specific mappings:

```r
library(DBI)
conn <- lumiHumanIDMapping_dbconn()

# Example: Fetching Entrez IDs for a set of nuIDs
query <- "SELECT nuID, EntrezID, QualityScore FROM nuID_MappingInfo WHERE nuID IN ('nuID_1', 'nuID_2')"
results <- dbGetQuery(conn, query)
```

## Usage Tips
- **Integration with lumi**: This package is intended to be used alongside the `lumi` package. When processing Illumina data in `lumi`, ensure this package is installed so that `lumi` can automatically resolve probe identifiers.
- **Database Connection**: Never call `dbDisconnect()` on the object returned by `lumiHumanIDMapping_dbconn()`, as it will break other annotation objects in the current R session.
- **Identifier Types**: The package supports multiple Illumina ID types including `Search_key`, `Target` (ILMN_Gene), `Accession`, `Symbol`, and `ProbeId`.

## Reference documentation
- [lumiHumanIDMapping Reference Manual](./references/reference_manual.md)