---
name: bioconductor-rat2302.db
description: This package provides annotation data for the Affymetrix Rat Expression Set 230 2.0 microarray platform. Use when user asks to map manufacturer probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways for Rattus norvegicus genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rat2302.db.html
---

# bioconductor-rat2302.db

name: bioconductor-rat2302.db
description: Annotation data for the Rat 230 2.0 platform. Use when mapping manufacturer probe IDs to biological identifiers (Entrez, Symbol, GO, KEGG, etc.) or vice versa for Rattus norvegicus genomic data.

# bioconductor-rat2302.db

## Overview

The `rat2302.db` package is a Bioconductor annotation data package for the Affymetrix Rat Expression Set 230 2.0 array. It provides comprehensive mappings between manufacturer probe identifiers and various gene-centric identifiers, allowing for the functional annotation of rat microarray data.

## Usage Instructions

### Loading the Package

```r
library(rat2302.db)
```

### The select() Interface

The preferred method for interacting with the database is the `select()` interface from the `AnnotationDbi` package.

```r
# View available columns
columns(rat2302.db)

# View available keytypes
keytypes(rat2302.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1367452_at", "1367453_at")
select(rat2302.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols**: Map probes to official gene symbols using `SYMBOL`.
- **Entrez IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **GO Terms**: Map probes to Gene Ontology terms using `GO` (includes Evidence and Ontology type).
- **KEGG Pathways**: Map probes to KEGG pathway identifiers using `PATH`.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLENGTHS` for genomic positioning.

### Legacy Bimap Interface

While `select()` is preferred, you can still use the Bimap interface for quick lookups or list conversions.

```r
# Convert a mapping to a list
sym_list <- as.list(rat2302SYMBOL)
# Get symbols for specific probes
sym_list[c("1367452_at", "1367453_at")]

# Reverse mapping (e.g., Symbols to Probes)
rev_map <- as.list(rat2302ALIAS2PROBE)
rev_map["Tp53"]
```

### Database Metadata

To inspect the underlying SQLite database connection and schema:

```r
rat2302_dbconn()   # Get DB connection
rat2302_dbschema() # View schema
rat2302_dbInfo()   # View package metadata
```

## Reference documentation

- [rat2302.db Reference Manual](./references/reference_manual.md)