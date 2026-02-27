---
name: bioconductor-org.at.tair.db
description: This package provides genome-wide annotations and functional metadata for Arabidopsis thaliana using TAIR identifiers. Use when user asks to map TAIR accessions to gene symbols, retrieve Gene Ontology terms, find KEGG or AraCyc pathways, or identify chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.At.tair.db.html
---


# bioconductor-org.at.tair.db

name: bioconductor-org.at.tair.db
description: Genome-wide annotation for Arabidopsis thaliana based on TAIR identifiers. Use this skill to map TAIR accessions to Gene Symbols, Entrez IDs, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `org.At.tair.db` package is a Bioconductor annotation hub for *Arabidopsis thaliana*. It primarily uses TAIR (The Arabidopsis Information Resource) identifiers as keys to provide functional and positional metadata. While it supports legacy "Bimap" objects, the modern `AnnotationDbi` interface (`select`, `mapIds`, `keys`, `columns`) is the preferred method for data retrieval.

## Core Workflows

### 1. Discovery
Before querying, identify what data types are available and what keys can be used.

```r
library(org.At.tair.db)

# List available annotation types (columns)
columns(org.At.tair.db)

# List valid key types for searching
keytypes(org.At.tair.db)

# Get a sample of TAIR identifiers
head(keys(org.At.tair.db, keytype="TAIR"))
```

### 2. Mapping Identifiers
Use `select()` for multi-column results or `mapIds()` for a simple vector mapping.

```r
# Map TAIR IDs to Symbols and Entrez IDs
genes <- c("AT1G01010", "AT1G01020")
select(org.At.tair.db, 
       keys = genes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "TAIR")

# Map IDs to a single output (returns a named vector)
mapIds(org.At.tair.db, 
       keys = genes, 
       column = "SYMBOL", 
       keytype = "TAIR", 
       multiVals = "first")
```

### 3. Functional Annotation (GO and Pathways)
Retrieve Gene Ontology (GO) terms or pathway information from AraCyc or KEGG.

```r
# Get GO terms with evidence codes
select(org.At.tair.db, 
       keys = "AT1G01010", 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "TAIR")

# Get KEGG pathway IDs
select(org.At.tair.db, 
       keys = "AT1G01010", 
       columns = "PATH", 
       keytype = "TAIR")
```

### 4. Genomic Location
Retrieve chromosome names and base pair positions.

```r
# Get chromosome and start position
select(org.At.tair.db, 
       keys = genes, 
       columns = c("CHR", "CHRLOC"), 
       keytype = "TAIR")
```

## Tips and Best Practices
- **TAIR Keys**: Ensure identifiers are in the standard TAIR format (e.g., "AT1G01010").
- **multiVals**: When using `mapIds`, the `multiVals` argument is crucial. Use "first" for a 1:1 mapping, or "list" if you need to capture all associated terms (common for GO or PATH).
- **AraCyc vs KEGG**: The package provides `ARACYC` for plant-specific metabolic pathways and `PATH` for standard KEGG pathways.
- **Database Connection**: Use `org.At.tair_dbconn()` if you need to perform direct SQL queries via the `DBI` package, but `select()` is safer for most tasks.

## Reference documentation
- [org.At.tair.db Reference Manual](./references/reference_manual.md)