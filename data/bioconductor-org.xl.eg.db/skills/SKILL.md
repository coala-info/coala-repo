---
name: bioconductor-org.xl.eg.db
description: This package provides genome-wide annotations and identifier mappings for Xenopus laevis based on Entrez Gene IDs. Use when user asks to map between gene symbols, Entrez IDs, GO terms, or KEGG pathways for the African clawed frog.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Xl.eg.db.html
---


# bioconductor-org.xl.eg.db

name: bioconductor-org.xl.eg.db
description: Genome-wide annotation for Xenopus laevis (African clawed frog) based on Entrez Gene identifiers. Use when mapping between different gene identifiers (e.g., Symbols, RefSeq, UniProt, GO terms, KEGG pathways) or retrieving functional information for Xenopus laevis genes in R.

## Overview

The `org.Xl.eg.db` package is a Bioconductor annotation hub for *Xenopus laevis*. It provides a stable interface to map Entrez Gene identifiers to various biological annotations. While it supports an older "Bimap" interface, the modern `AnnotationDbi` `select()` interface is the recommended way to interact with the data.

## Core Workflow

### 1. Loading the Package
```R
library(org.Xl.eg.db)
```

### 2. Exploring Available Data
Use these functions to see what identifiers and data types can be queried:
- `columns(org.Xl.eg.db)`: Lists the types of data that can be retrieved (e.g., SYMBOL, GO, PATH).
- `keytypes(org.Xl.eg.db)`: Lists the types of identifiers you can use as input keys (usually Entrez Gene IDs, but others are supported).
- `keys(org.Xl.eg.db, keytype="SYMBOL")`: Returns all available keys for a specific type.

### 3. Using the select() Interface
The `select()` function is the primary tool for mapping. It requires the database object, the input keys, the columns to retrieve, and the keytype of the input.

```R
# Example: Map Gene Symbols to Entrez IDs and Chromosomes
genes <- c("hba1", "tp53", "myod1")
results <- select(org.Xl.eg.db, 
                  keys = genes, 
                  columns = c("ENTREZID", "CHR", "GENENAME"), 
                  keytype = "SYMBOL")
```

## Common Mapping Tasks

### Gene Ontology (GO)
Mapping to GO terms returns the GO ID, the Ontology (BP, CC, MF), and the Evidence code (e.g., IDA, IEA).
```R
# Get GO terms for Entrez IDs
go_mappings <- select(org.Xl.eg.db, 
                      keys = c("397830"), 
                      columns = "GO", 
                      keytype = "ENTREZID")
```

### KEGG Pathways
Map Entrez IDs to KEGG pathway identifiers.
```R
path_mappings <- select(org.Xl.eg.db, 
                        keys = "397830", 
                        columns = "PATH", 
                        keytype = "ENTREZID")
```

### Symbols and Aliases
- **SYMBOL**: Official gene symbols.
- **ALIAS**: Includes official symbols and common synonyms. Note that aliases can be redundant; one alias may map to multiple Entrez IDs.

```R
# Map an alias back to an Entrez ID
select(org.Xl.eg.db, keys="p53", columns="ENTREZID", keytype="ALIAS")
```

## Tips and Best Practices
- **Avoid Symbols as Primary Keys**: Gene symbols change over time. Always prefer Entrez Gene IDs (`ENTREZID`) or RefSeq IDs for stable analysis.
- **Handling Multi-mappings**: Functions like `select()` may return more rows than input keys if a gene maps to multiple GO terms or pathways.
- **Database Metadata**: Use `org.Xl.eg_dbInfo()` to check the data source versions and date stamps.
- **Direct SQL**: For advanced users, `org.Xl.eg_dbconn()` provides a DBI connection to the underlying SQLite database.

## Reference documentation
- [org.Xl.eg.db Reference Manual](./references/reference_manual.md)