---
name: bioconductor-hgubeta7.db
description: This package provides SQLite-based annotation mappings for the Affymetrix hgubeta7 platform to link probe identifiers with biological metadata. Use when user asks to map hgubeta7 probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgubeta7.db.html
---

# bioconductor-hgubeta7.db

name: bioconductor-hgubeta7.db
description: Use this skill when working with the Bioconductor annotation package hgubeta7.db. This package provides SQLite-based mappings for the Affymetrix hgubeta7 platform (Human Genome U95 Beta chip), allowing users to map manufacturer probe identifiers to various biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, and KEGG pathways.

## Overview

The `hgubeta7.db` package is a standard Bioconductor annotation data package. It provides a comprehensive set of mappings for the hgubeta7 microarray platform. While it supports the older "Bimap" interface, the modern and recommended way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(hgubeta7.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```r
# 1. Check available columns
columns(hgubeta7.db)

# 2. Check available keytypes
keytypes(hgubeta7.db)

# 3. Perform a lookup (e.g., map probe IDs to Gene Symbols and Entrez IDs)
probes <- c("1000_at", "1001_at", "1002_f_at")
select(hgubeta7.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

#### Map Probes to Gene Symbols
```r
select(hgubeta7.db, keys = probes, columns = "SYMBOL", keytype = "PROBEID")
```

#### Map Probes to Gene Ontology (GO)
This returns GO IDs, evidence codes, and ontologies (BP, CC, MF).
```r
select(hgubeta7.db, keys = probes, columns = "GO", keytype = "PROBEID")
```

#### Map Gene Symbols to Probes
```r
syms <- c("TP53", "BRCA1")
select(hgubeta7.db, keys = syms, columns = "PROBEID", keytype = "SYMBOL")
```

### Using the Bimap Interface (Legacy)
While `select()` is preferred, you can still use the Bimap objects for quick lookups or list conversions.

```r
# Convert a map to a list
mapped_list <- as.list(hgubeta7SYMBOL)

# Get probes mapped to a specific symbol
mapped_list[["TP53"]]

# Get all mapped keys
probes_with_symbols <- mappedkeys(hgubeta7SYMBOL)
```

### Database Metadata and Connection
You can inspect the underlying SQLite database metadata using convenience functions.

```r
# Get database schema
hgubeta7_dbschema()

# Get number of rows in specific tables via SQL
dbGetQuery(hgubeta7_dbconn(), "SELECT COUNT(*) FROM probes")

# Get organism information
hgubeta7ORGANISM
```

## Tips and Best Practices
- **Keytypes**: Always use `PROBEID` as the keytype when providing manufacturer-specific identifiers.
- **Duplicates**: The `select()` function may return a 1:many mapping (e.g., one probe mapping to multiple GO terms), resulting in more rows in the output than input keys.
- **Defunct Maps**: Note that `hgubeta7PFAM` and `hgubeta7PROSITE` Bimap interfaces are defunct; use the `select()` interface to access these identifiers.
- **Official Symbols**: Use the `SYMBOL` map for official gene symbols and `ALIAS2PROBE` if you are searching using common aliases or historical symbols.

## Reference documentation
- [hgubeta7.db Reference Manual](./references/reference_manual.md)