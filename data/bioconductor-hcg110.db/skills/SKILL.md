---
name: bioconductor-hcg110.db
description: This package provides comprehensive annotation data for mapping manufacturer probe identifiers from the hcg110 platform to biological metadata. Use when user asks to map probes to gene symbols, retrieve Entrez IDs, find GO terms, or access chromosomal locations for the hcg110 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hcg110.db.html
---

# bioconductor-hcg110.db

name: bioconductor-hcg110.db
description: Comprehensive annotation data for the hcg110 platform. Use this skill to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

# bioconductor-hcg110.db

## Overview

The `hcg110.db` package is a Bioconductor annotation data package for the hcg110 platform. It provides a SQLite-based interface to map manufacturer-specific identifiers (probes) to various biological annotations. While it supports legacy "Bimap" objects, the modern `select()` interface from the `AnnotationDbi` package is the preferred method for data retrieval.

## Core Workflows

### 1. Exploring the Database
Before querying, identify the available types of data (columns) and the types of identifiers you can use as input (keys).

```r
library(hcg110.db)

# List all available annotation types
columns(hcg110.db)

# List all possible input key types
keytypes(hcg110.db)

# Get a sample of manufacturer identifiers
head(keys(hcg110.db, keytype="PROBEID"))
```

### 2. Retrieving Annotations using select()
The `select()` function is the standard way to extract data. It requires the database object, the input keys, the columns you want to retrieve, and the keytype of the input.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("100_g_at", "101_at", "102_at")
results <- select(hcg110.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### 3. Using Legacy Bimap Objects
Specific mappings are available as individual objects. These are useful for quick lookups or when working with older scripts.

*   **hcg110SYMBOL**: Maps probes to official gene symbols.
*   **hcg110ENTREZID**: Maps probes to Entrez Gene identifiers.
*   **hcg110GO**: Maps probes to Gene Ontology (GO) identifiers (includes Evidence and Ontology codes).
*   **hcg110PATH**: Maps probes to KEGG pathway identifiers.
*   **hcg110ACCNUM**: Maps probes to GenBank accession numbers.

Example of Bimap usage:
```r
# Convert a Bimap to a list
symbol_list <- as.list(hcg110SYMBOL)

# Get symbols for specific probes
probes_of_interest <- names(symbol_list)[1:5]
symbols <- symbol_list[probes_of_interest]
```

### 4. Chromosomal Information
You can retrieve chromosome names, start/end positions, and lengths.

```r
# Get chromosome lengths
lengths <- hcg110CHRLENGTHS
chr1_len <- lengths["1"]

# Map probes to chromosomal locations
locs <- select(hcg110.db, 
               keys = probes, 
               columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
               keytype = "PROBEID")
```

## Tips and Best Practices

*   **One-to-Many Mappings**: Be aware that some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data.frame with multiple rows for these cases.
*   **Filtering GO Terms**: When querying GO terms, you can filter by ontology (BP, CC, MF) or evidence code (e.g., IDA, TAS) if you use the `select()` interface and post-process the results.
*   **Database Connection**: Use `hcg110_dbconn()` to get a DBI connection to the underlying SQLite database if you need to perform custom SQL queries. Do not call `dbDisconnect()` on this object.
*   **Reverse Mappings**: Most Bimaps have a reverse map (e.g., `hcg110SYMBOL2PROBE`). However, using `select()` with `keytype="SYMBOL"` is generally more intuitive.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)