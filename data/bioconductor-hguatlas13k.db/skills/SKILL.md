---
name: bioconductor-hguatlas13k.db
description: This package provides SQLite-based annotation mappings for the hguatlas13k microarray platform. Use when user asks to map hguatlas13k probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hguatlas13k.db.html
---

# bioconductor-hguatlas13k.db

name: bioconductor-hguatlas13k.db
description: An annotation data package for the hguatlas13k platform. Use this skill when you need to map manufacturer identifiers (probes) to various biological annotations such as Gene Symbols, Entrez IDs, GO terms, KEGG pathways, and chromosomal locations for the hguatlas13k chip.

## Overview

The `hguatlas13k.db` package is a Bioconductor annotation hub for the hguatlas13k microarray platform. It provides SQLite-based mappings between manufacturer probe IDs and standard biological identifiers. While it supports the older "Bimap" interface, the recommended way to interact with this data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```R
library(hguatlas13k.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (your IDs), the columns (data you want), and the keytype (the type of IDs you are providing).

```R
# List available columns
columns(hguatlas13k.db)

# List available keytypes
keytypes(hguatlas13k.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("100_g_at", "1000_at")
select(hguatlas13k.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols**: Use `SYMBOL` to get official gene abbreviations.
*   **Entrez IDs**: Use `ENTREZID` to map to NCBI Entrez Gene identifiers.
*   **Gene Ontology (GO)**: Use `GO` to get GO IDs, evidence codes, and ontologies (BP, CC, MF).
*   **Pathways**: Use `PATH` to retrieve KEGG pathway identifiers.
*   **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` for genomic positioning.
*   **RefSeq/Ensembl**: Use `REFSEQ` or `ENSEMBL` for transcript and protein accessions.

### Using the Bimap Interface (Legacy)
For specific reverse mappings or quick list conversions, the Bimap objects can be used:

```R
# Convert a map to a list
sym_list <- as.list(hguatlas13kSYMBOL)
# Get symbols for specific probes
sym_list[c("100_g_at", "1000_at")]

# Reverse mapping: Find probes for a specific Gene Symbol
alias_map <- as.list(hguatlas13kALIAS2PROBE)
alias_map[["GAPDH"]]
```

### Database Metadata
To inspect the underlying database schema or connection:
```R
hguatlas13k_dbschema()
hguatlas13k_dbInfo()
```

## Tips
*   **NAs**: If a probe cannot be mapped to a specific identifier, `NA` is returned.
*   **One-to-Many**: Some probes may map to multiple identifiers (e.g., multiple GO terms). `select()` will return a data frame with one row per mapping, which may result in more rows than input keys.
*   **Package Dependencies**: Ensure `AnnotationDbi` is loaded to use `select()`, `keys()`, and `columns()`.

## Reference documentation
- [hguatlas13k.db Reference Manual](./references/reference_manual.md)