---
name: bioconductor-lumimouseidmapping
description: This tool provides ID mapping information for Illumina Mouse expression chips, including mappings between Illumina identifiers, nuIDs, RefSeq accessions, and Entrez Gene IDs. Use when user asks to map mouse microarray probe identifiers, convert nuIDs to gene symbols or accessions, or access the underlying SQLite database for Illumina mouse chip annotation.
homepage: https://bioconductor.org/packages/release/data/annotation/html/lumiMouseIDMapping.html
---

# bioconductor-lumimouseidmapping

name: bioconductor-lumimouseidmapping
description: Provides ID mapping information for Illumina Mouse expression chips. Use this skill to map between Illumina identifiers (Search_key, Target, ProbeId), nuIDs, RefSeq accessions, and Entrez Gene IDs for mouse microarray data. It is designed to be used in conjunction with the 'lumi' Bioconductor package for transcriptomic analysis.

## Overview

The `lumiMouseIDMapping` package is an annotation data package providing comprehensive mapping for Illumina Mouse Expression chips. It centers around the **nuID** (nucleotide universal identifier), a unique identifier derived from the probe sequence itself, ensuring consistency across different chip versions and platforms.

The package contains mapping tables for all Illumina Mouse chips released prior to the package version, including metadata such as Search_Key, ILMN_Gene (Target), Accession, Symbol, and Probe_Id.

## Core Workflows

### Accessing Mapping Data
The package primarily functions as an SQLite database interface. You can interact with the underlying data using convenience functions or standard DBI queries.

```r
library(lumiMouseIDMapping)

# List all available objects/tables in the package
ls("package:lumiMouseIDMapping")

# Get a summary of the nuID mapping quality and statistics
lumiMouseIDMapping_nuID()
```

### Database Connectivity
To perform custom queries or inspect table structures, use the database connection functions.

```r
# Get the connection object
conn <- lumiMouseIDMapping_dbconn()

# List all tables (e.g., nuID_MappingInfo, and chip-specific tables)
DBI::dbListTables(conn)

# List fields in the primary mapping table
DBI::dbListFields(conn, 'nuID_MappingInfo')

# Get the physical path to the SQLite database file
db_path <- lumiMouseIDMapping_dbfile()
```

### Mapping nuIDs to Gene Identifiers
The `nuID_MappingInfo` table is the most critical resource for functional annotation. It contains:
- **nuID**: The unique probe identifier.
- **Refseq**: Matching RefSeq IDs.
- **EntrezID**: Corresponding Entrez Gene IDs.
- **QualityScore**: A score indicating the reliability of the probe-to-sequence match.

```r
# Example: Fetching mapping info for specific nuIDs via SQL
library(DBI)
conn <- lumiMouseIDMapping_dbconn()
query <- "SELECT * FROM nuID_MappingInfo LIMIT 10"
mapping_sample <- dbGetQuery(conn, query)
```

## Usage Tips
- **Integration with lumi**: This package is intended to be called internally by functions in the `lumi` package (e.g., `addAnnotationInfo`). You rarely need to manually parse the tables if using the standard `lumi` workflow.
- **Do Not Disconnect**: Never call `dbDisconnect()` on the object returned by `lumiMouseIDMapping_dbconn()`, as this will break other annotation objects in the current R session.
- **Version Consistency**: For versions > 1.8.0, mappings are based on Illumina manifest files. Newer manifest data replaces older data for the same Probe ID to ensure the most accurate current annotation.

## Reference documentation
- [lumiMouseIDMapping Reference Manual](./references/reference_manual.md)