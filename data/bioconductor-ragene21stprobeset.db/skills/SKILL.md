---
name: bioconductor-ragene21stprobeset.db
description: This Bioconductor package provides SQLite-based annotation data for mapping Affymetrix Rat Gene 2.1 ST Array probeset IDs to gene-centric information. Use when user asks to map probes to gene symbols, retrieve Entrez IDs, or associate probeset identifiers with GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene21stprobeset.db.html
---

# bioconductor-ragene21stprobeset.db

## Overview

The `ragene21stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Rat Gene 2.1 ST Array. It provides a SQLite-based interface to map manufacturer probeset IDs to gene-centric information. The primary way to interact with this package is through the `select()` interface from the `AnnotationDbi` package, though it also supports the older "Bimap" interface.

## Core Workflows

### Loading the Package
```r
library(ragene21stprobeset.db)
```

### Using the select() Interface
The `select()` function is the recommended method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```r
# 1. List available columns
columns(ragene21stprobeset.db)

# 2. List available keytypes
keytypes(ragene21stprobeset.db)

# 3. Perform a lookup
probes <- c("17212916", "17212926", "17212937")
results <- select(ragene21stprobeset.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

#### Map Probes to Gene Symbols and Entrez IDs
```r
select(ragene21stprobeset.db, keys = probes, columns = c("SYMBOL", "ENTREZID"), keytype = "PROBEID")
```

#### Map Probes to GO Terms
Note that mapping to GO terms often results in a 1-to-many relationship, returning multiple rows per probe.
```r
select(ragene21stprobeset.db, keys = probes, columns = c("GO", "ONTOLOGY", "EVIDENCE"), keytype = "PROBEID")
```

#### Map Probes to KEGG Pathways
```r
select(ragene21stprobeset.db, keys = probes, columns = "PATH", keytype = "PROBEID")
```

### Using the Bimap Interface (Legacy)
While `select()` is preferred, specific Bimap objects exist for direct access:

*   `ragene21stprobesetSYMBOL`: Probes to Gene Symbols
*   `ragene21stprobesetENTREZID`: Probes to Entrez Gene Identifiers
*   `ragene21stprobesetCHR`: Probes to Chromosomes
*   `ragene21stprobesetCHRLOC`: Probes to Chromosomal Start Positions
*   `ragene21stprobesetGO2PROBE`: GO IDs to Probes

Example of Bimap usage:
```r
# Convert a Bimap to a list
mapped_list <- as.list(ragene21stprobesetSYMBOL[1:10])
```

### Database Metadata
To check the source data versions and date stamps:
```r
ragene21stprobeset_dbInfo()
```

## Tips and Best Practices
*   **One-to-Many Mappings**: Be aware that one probe ID can map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with all possible combinations.
*   **Filtering GO Terms**: When retrieving GO annotations, use the `ONTOLOGY` column to filter for Biological Process (BP), Molecular Function (MF), or Cellular Component (CC).
*   **Organism Check**: Use `ragene21stprobesetORGANISM` to programmatically confirm the target species (Rattus norvegicus).
*   **Connection Management**: Use `ragene21stprobeset_dbconn()` to get the underlying SQLite connection if you need to perform custom SQL queries, but never call `dbDisconnect()` on it.

## Reference documentation
- [ragene21stprobeset.db Reference Manual](./references/reference_manual.md)