---
name: bioconductor-mu19ksubb.db
description: This package provides SQLite-based annotation mappings for the mu19ksubb microarray platform. Use when user asks to map mu19ksubb probe identifiers to gene symbols, Entrez IDs, or other public database identifiers.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu19ksubb.db.html
---


# bioconductor-mu19ksubb.db

## Overview

The `mu19ksubb.db` package is a Bioconductor annotation hub for the mu19ksubb microarray platform. It provides SQLite-based mappings between manufacturer-specific probe identifiers and various public identifiers. While it supports legacy Bimap objects, the recommended way to interact with the data is through the `select()` interface from the `AnnotationDbi` package.

## Installation

To use this package in R:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("mu19ksubb.db")
library(mu19ksubb.db)
```

## Core Workflows

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```R
# View available columns
columns(mu19ksubb.db)

# View available keytypes
keytypes(mu19ksubb.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
res <- select(mu19ksubb.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### Using mapIds() for 1-to-1 Mappings
If you need a simple named vector and want to handle multi-mapping probes (e.g., one probe mapping to multiple GO terms) by picking the first one:

```R
symbols <- mapIds(mu19ksubb.db, 
                  keys = probes, 
                  column = "SYMBOL", 
                  keytype = "PROBEID", 
                  multiVals = "first")
```

### Accessing Organism Information
To programmatically check the species or the underlying organism-level package:

```R
mu19ksubbORGANISM
mu19ksubbORGPKG
```

## Available Mappings

The package includes mappings for:
- **ACCNUM**: GenBank Accession numbers.
- **ALIAS**: Common gene symbols/aliases.
- **ENSEMBL**: Ensembl gene identifiers.
- **ENTREZID**: Entrez Gene identifiers.
- **ENZYME**: Enzyme Commission (EC) numbers.
- **GENENAME**: Full gene names.
- **GO**: Gene Ontology identifiers (includes Evidence and Ontology type).
- **MGI**: Mouse Genome Informatics identifiers.
- **PATH**: KEGG pathway identifiers.
- **PMID**: PubMed identifiers.
- **REFSEQ**: RefSeq identifiers.
- **SYMBOL**: Official Gene Symbols.
- **UNIPROT**: Uniprot accession numbers.
- **CHR/CHRLOC**: Chromosome and start/end positions.

## Tips and Best Practices
- **Legacy Bimaps**: Objects like `mu19ksubbSYMBOL` can be converted to lists using `as.list()`, but `select()` is more efficient for large-scale queries.
- **Defunct Interfaces**: The Bimap interface for PFAM and PROSITE is defunct; always use `select()` for these specific identifiers.
- **Database Connection**: Use `mu19ksubb_dbconn()` to get a DBI connection to the underlying SQLite database for custom SQL queries, but do not call `dbDisconnect()` on it.

## Reference documentation
- [mu19ksubb.db Reference Manual](./references/reference_manual.md)