---
name: bioconductor-hu35ksubc.db
description: This package provides SQLite-based annotation mappings for the Affymetrix Human Genome hu35ksubc array. Use when user asks to map Affymetrix probe identifiers to biological identifiers like Gene Symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubc.db.html
---

# bioconductor-hu35ksubc.db

name: bioconductor-hu35ksubc.db
description: Use this skill when working with the Bioconductor annotation package hu35ksubc.db. This package provides SQLite-based mappings for the Affymetrix Human Genome hu35ksubc array, allowing users to map manufacturer probe identifiers to various biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, and KEGG pathways.

# bioconductor-hu35ksubc.db

## Overview

The `hu35ksubc.db` package is a Bioconductor annotation data package for the Affymetrix hu35ksubc platform. It provides a comprehensive set of mappings between manufacturer probe IDs and standard biological identifiers. While it supports older "Bimap" interfaces, the modern and preferred way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(hu35ksubc.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```r
# Check available columns
columns(hu35ksubc.db)

# Check available keytypes
keytypes(hu35ksubc.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("100_g_at", "1000_at", "1001_at")
select(hu35ksubc.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings

- **Gene Symbols**: Map probes to official gene abbreviations using `SYMBOL`.
- **Entrez IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **GO Terms**: Map probes to Gene Ontology identifiers using `GO`. This returns GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
- **KEGG Pathways**: Map probes to KEGG pathway identifiers using `PATH`.
- **Chromosomal Location**: Map probes to chromosomes (`CHR`) or specific base pair locations (`CHRLOC` and `CHRLOCEND`).
- **RefSeq/Ensembl**: Map to RefSeq (`REFSEQ`) or Ensembl (`ENSEMBL`) accession numbers.

### Reverse Mappings (Alias to Probe)
To find which probes correspond to a specific gene symbol (including aliases):

```r
# Using select with SYMBOL as the keytype
select(hu35ksubc.db, 
       keys = "TP53", 
       columns = "PROBEID", 
       keytype = "SYMBOL")

# Using the ALIAS2PROBE map for common/historical symbols
select(hu35ksubc.db, 
       keys = "p53", 
       columns = "PROBEID", 
       keytype = "ALIAS")
```

### Database Metadata and Connection
You can inspect the underlying database schema or connection details if needed for direct SQL queries.

```r
# Get database connection
conn <- hu35ksubc_dbconn()

# Show database schema
hu35ksubc_dbschema()

# Get organism information
hu35ksubcORGANISM
```

## Tips and Best Practices
- **Vectorized Queries**: Always pass a vector of keys to `select()` rather than calling it in a loop for better performance.
- **Handling 1-to-Many**: Note that some mappings (like GO or PATH) may return multiple rows for a single probe ID.
- **Bimap Interface**: While `as.list(hu35ksubcSYMBOL)` still works, it is considered "old style." Use `select()` for new code to ensure compatibility with modern Bioconductor workflows.
- **Map Counts**: The `hu35ksubcMAPCOUNTS` object is deprecated; use `count.mappedkeys()` or standard R functions on the results of `keys()` to determine mapping coverage.

## Reference documentation
- [hu35ksubc.db Reference Manual](./references/reference_manual.md)