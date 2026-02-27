---
name: bioconductor-lumiratidmapping
description: This package provides ID mapping for Illumina Rat expression chips, including conversions between nuIDs, RefSeq accessions, and Entrez Gene IDs. Use when user asks to map Illumina Rat probe identifiers to genomic accessions, convert nuIDs to gene symbols, or access annotation data for Illumina Rat microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/lumiRatIDMapping.html
---


# bioconductor-lumiratidmapping

name: bioconductor-lumiratidmapping
description: Provides ID mapping for Illumina Rat expression chips, including nuID to RefSeq and Entrez Gene ID conversions. Use this skill when analyzing Illumina Rat microarray data in R, specifically for mapping probe identifiers (nuIDs) to genomic accessions and gene symbols using the lumiRatIDMapping annotation package.

# bioconductor-lumiratidmapping

## Overview
The `lumiRatIDMapping` package is a specialized Bioconductor annotation data package designed to work alongside the `lumi` package. It provides comprehensive mapping tables for all Illumina Rat Expression chips released prior to the package's distribution. Its primary utility is translating between Illumina-specific identifiers (Search_key, Target/ILMN_Gene, ProbeID) and nuIDs (nucleotide universal identifiers), as well as mapping nuIDs to RefSeq accessions, Entrez Gene IDs, and Gene Symbols based on the most recent Rattus norvegicus genome releases.

## Installation and Loading
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("lumiRatIDMapping")
library(lumiRatIDMapping)
```

## Core Workflows

### Exploring Available Mappings
The package stores data in an SQLite database. You can explore the available tables and fields using the database connection functions.

```r
# Get database information
lumiRatIDMapping_dbInfo()

# List all tables in the mapping database
conn <- lumiRatIDMapping_dbconn()
DBI::dbListTables(conn)

# List fields in the primary mapping table
DBI::dbListFields(conn, 'nuID_MappingInfo')
```

### Mapping nuIDs to Genomic Identifiers
The `lumiRatIDMapping_nuID()` function provides a summary of the mapping between nuIDs and RefSeq/Entrez IDs.

```r
# Get a summary of the nuID mapping
lumiRatIDMapping_nuID()
```

The `nuID_MappingInfo` table contains the following critical columns:
1. **nuID**: The universal identifier for the probe sequence.
2. **Refseq**: RefSeq IDs with perfect matches (comma-separated if multiple).
3. **EntrezID**: Corresponding Entrez Gene IDs.
4. **QualityScore**: A score indicating the mapping quality to RefSeq.
5. **Refseq_old**: The original RefSeq ID provided in the Illumina manifest.

### Accessing Chip-Specific Tables
The package includes data tables for various Illumina Rat chips. Each table typically includes:
- `Search_key` / `Search_Key`
- `Target` / `ILMN_Gene`
- `Accession`
- `Symbol`
- `ProbeId` / `Probe_Id`
- `nuID`

To see all objects (including chip-specific tables) provided by the package:
```r
ls("package:lumiRatIDMapping")
```

## Usage Tips
- **Integration with lumi**: This package is intended to be used as a backend for the `lumi` package. When processing `LumiBatch` objects, `lumi` will often call these mapping tables automatically if the correct annotation is specified.
- **Database Connections**: Use `lumiRatIDMapping_dbconn()` to get the connection object. **Do not** call `dbDisconnect()` on this object, as it is managed by the package and closing it will break other annotation objects in the session.
- **Manual Queries**: If you need to perform custom joins or filters, use standard `DBI` or `dplyr` (via `dbplyr`) commands on the connection returned by `lumiRatIDMapping_dbconn()`.

## Reference documentation
- [lumiRatIDMapping Reference Manual](./references/reference_manual.md)