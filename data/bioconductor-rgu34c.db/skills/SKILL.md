---
name: bioconductor-rgu34c.db
description: This package provides annotation data for the Affymetrix Rat Genome U34C array by mapping manufacturer probe identifiers to various biological databases. Use when user asks to map probe IDs to gene symbols, retrieve Entrez Gene IDs, perform functional annotation with GO terms or KEGG pathways, and query genomic metadata for Rattus norvegicus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34c.db.html
---

# bioconductor-rgu34c.db

name: bioconductor-rgu34c.db
description: Annotation data package for the Rat Genome U34C array (rgu34c). Use this skill to map manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and Ensembl identifiers for Rattus norvegicus.

# bioconductor-rgu34c.db

## Overview

The `rgu34c.db` package is a Bioconductor annotation data package for the Affymetrix Rat Genome U34C array. It provides a comprehensive set of mappings between manufacturer probe identifiers and various genomic databases. While it supports an older "Bimap" interface, the modern and preferred way to interact with this data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### 1. Using the select() Interface

The `select()` function is the primary method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (the type of input IDs).

```r
library(rgu34c.db)

# 1. List available columns
columns(rgu34c.db)

# 2. List available keytypes
keytypes(rgu34c.db)

# 3. Perform a lookup
probes <- c("1367452_at", "1367453_at")
results <- select(rgu34c.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### 2. Mapping Gene Symbols to Probes

To find which manufacturer probes correspond to specific gene symbols, use the `ALIAS` or `SYMBOL` columns.

```r
# Find probes for specific gene symbols
gene_symbols <- c("Tp53", "Brca1")
mapping <- select(rgu34c.db, 
                  keys = gene_symbols, 
                  columns = c("PROBEID"), 
                  keytype = "SYMBOL")
```

### 3. Functional Annotation (GO and KEGG)

You can retrieve Gene Ontology (GO) terms or KEGG pathway identifiers for a set of probes.

```r
# Get GO terms for probes
go_info <- select(rgu34c.db, 
                  keys = probes, 
                  columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                  keytype = "PROBEID")

# Get KEGG pathways
pathway_info <- select(rgu34c.db, 
                       keys = probes, 
                       columns = "PATH", 
                       keytype = "PROBEID")
```

### 4. Accessing Database Metadata

To inspect the underlying SQLite database or check versioning information:

```r
# Get database connection
conn <- rgu34c_dbconn()

# View database schema
rgu34c_dbschema()

# Get general package info
rgu34c_dbInfo()
```

## Tips and Best Practices

- **Prefer select()**: Use the `select()` interface over the older Bimap objects (e.g., `rgu34cSYMBOL`) for better consistency and integration with other Bioconductor tools.
- **Handle 1:Many Mappings**: Be aware that a single probe ID might map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Check Organism**: Use `rgu34cORGANISM` to programmatically confirm the species (Rattus norvegicus).
- **Keytypes**: When using `select()`, the default `keytype` is "PROBEID" (the manufacturer's identifiers).

## Reference documentation

- [rgu34c.db Reference Manual](./references/reference_manual.md)