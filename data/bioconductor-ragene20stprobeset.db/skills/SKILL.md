---
name: bioconductor-ragene20stprobeset.db
description: This package provides SQLite-based annotation data for mapping Affymetrix Rat Gene 2.0 ST array probeset IDs to various biological identifiers. Use when user asks to map probeset IDs to gene symbols, retrieve Entrez or Ensembl identifiers, or find functional annotations like GO terms and KEGG pathways for rat genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene20stprobeset.db.html
---


# bioconductor-ragene20stprobeset.db

## Overview

The `ragene20stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Rat Gene 2.0 ST array. It provides a SQLite-based interface to map manufacturer probeset IDs to various biological identifiers. While it supports the older "Bimap" interface, the modern `select()` interface from the `AnnotationDbi` package is the recommended way to interact with this data.

## Core Workflows

### Loading the Package
```r
library(ragene20stprobeset.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probeset IDs), the columns you want to retrieve, and the keytype.

```r
# Check available columns
columns(ragene20stprobeset.db)

# Check available keytypes
keytypes(ragene20stprobeset.db)

# Example: Map probeset IDs to Gene Symbols and Entrez IDs
probes <- c("17000001", "17000002", "17000003")
select(ragene20stprobeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mappings
- **Gene Symbols**: Use `SYMBOL` to get official gene abbreviations.
- **Entrez IDs**: Use `ENTREZID` for NCBI Gene identifiers.
- **Ensembl**: Use `ENSEMBL` for Ensembl gene accession numbers.
- **Gene Ontology**: Use `GO` for functional annotations (includes Evidence and Ontology category).
- **Pathways**: Use `PATH` for KEGG pathway identifiers.
- **Chromosomal Location**: Use `CHR` (chromosome), `CHRLOC` (start position), and `CHRLOCEND` (end position).

### Reverse Mappings (Bimap Interface)
If you need to find probes associated with a specific gene or term, you can use the Bimap interface or `select()` with a different `keytype`.

```r
# Find probes for a specific Gene Symbol using select
select(ragene20stprobeset.db, 
       keys = "Tp53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")

# Using the ALIAS map for common names not in the official SYMBOL map
as.list(ragene20stprobesetALIAS2PROBE["Tp53"])
```

### Database Connection and Metadata
To inspect the underlying database or get organism information:
```r
# Get organism name
ragene20stprobesetORGANISM

# Get the underlying SQLite connection
conn <- ragene20stprobeset_dbconn()
dbGetQuery(conn, "SELECT * FROM probes LIMIT 5")
```

## Tips
- **Multiple Matches**: Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data.frame with one row per mapping, which may result in more rows than input keys.
- **NA Values**: If a probe cannot be mapped to a specific resource (e.g., no KEGG pathway), `NA` is returned.
- **Performance**: When mapping thousands of identifiers, `select()` is significantly more efficient than looping through a list or using `mget()`.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)