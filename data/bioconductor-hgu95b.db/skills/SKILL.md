---
name: bioconductor-hgu95b.db
description: This package provides Bioconductor annotation data for mapping Affymetrix Human Genome U95 Set (hgu95b) probe identifiers to biological metadata. Use when user asks to map hgu95b probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95b.db.html
---

# bioconductor-hgu95b.db

name: bioconductor-hgu95b.db
description: Bioconductor annotation data for the Affymetrix Human Genome U95 Set (hgu95b). Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, KEGG pathways, and PubMed references.

## Overview

The `hgu95b.db` package is an SQLite-based annotation hub for the Affymetrix hgu95b platform. It provides a bridge between proprietary probe IDs and public database identifiers. While it supports an older "Bimap" interface, the modern and preferred method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```R
library(hgu95b.db)
```

### Using the select() Interface
The `select()` function is the primary way to query the database. It requires four arguments: the database object, the keys (input IDs), the columns (desired data), and the keytype (type of input IDs).

```R
# List available columns and keytypes
columns(hgu95b.db)
keytypes(hgu95b.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
select(hgu95b.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Use `SYMBOL` and `GENENAME`.
*   **Chromosomal Location**: Use `CHR` (chromosome), `CHRLOC` (start), and `CHRLOCEND` (end).
*   **Functional Annotation**: Use `GO` (Gene Ontology) or `PATH` (KEGG Pathways).
*   **External IDs**: Use `ENSEMBL`, `UNIPROT`, `REFSEQ`, or `ACCNUM` (GenBank Accession).
*   **Literature**: Use `PMID` to find PubMed identifiers associated with probes.

### Reverse Mappings (Alias to Probe)
To find which probes correspond to a specific gene symbol or alias:
```R
# Using select
select(hgu95b.db, keys = "GAPDH", columns = "PROBEID", keytype = "SYMBOL")

# Using the Alias map specifically
# hgu95bALIAS2PROBE maps common symbols/aliases to manufacturer IDs
as.list(hgu95bALIAS2PROBE["GAPDH"])
```

### Database Connection and Metadata
To inspect the underlying SQLite database or check version information:
```R
hgu95b_dbconn()   # Returns the DBI connection object
hgu95b_dbschema() # Prints the table schemas
hgu95b_dbInfo()   # Prints package metadata and data sources
```

## Tips and Best Practices

*   **Prefer select()**: The Bimap interface (e.g., `as.list(hgu95bSYMBOL)`) is legacy. `select()` is more robust and handles 1-to-many mappings more cleanly in a data frame format.
*   **Handling 1-to-Many**: Some probes map to multiple Entrez IDs or GO terms. `select()` will return a data frame with multiple rows for that probe; be prepared to handle these duplicates in downstream analysis.
*   **GO Evidence Codes**: When querying `GO`, the output includes `EVIDENCE` codes (e.g., IDA, IEA, TAS). Filter these if you only want experimentally verified annotations.
*   **Check Organism**: Use `hgu95bORGANISM` to programmatically confirm the species (Homo sapiens).

## Reference documentation

- [hgu95b.db Reference Manual](./references/reference_manual.md)