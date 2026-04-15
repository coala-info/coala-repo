---
name: bioconductor-ath1121501.db
description: This package provides annotation data for mapping Affymetrix Arabidopsis ATH1 Genome Array probe identifiers to biological metadata. Use when user asks to map probe IDs to gene symbols, AGI locus IDs, chromosomal locations, GO terms, or KEGG and AraCyc pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ath1121501.db.html
---

# bioconductor-ath1121501.db

name: bioconductor-ath1121501.db
description: Annotation data for the Affymetrix Arabidopsis ATH1 Genome Array. Use this skill to map manufacturer probe identifiers to biological metadata including AGI locus IDs, gene symbols, chromosomal locations, GO terms, KEGG/AraCyc pathways, and PubMed references for Arabidopsis thaliana.

# bioconductor-ath1121501.db

## Overview

The `ath1121501.db` package is a Bioconductor annotation hub for the Affymetrix Arabidopsis ATH1 Genome Array. It provides a SQLite-based infrastructure to map probe set IDs to various genomic, functional, and publication-related identifiers. This is essential for downstream analysis of microarray data, such as converting probe-level results into gene symbols or metabolic pathways.

## Core Workflows

### Loading the Library and Exploring Columns
To begin, load the package and inspect the available annotation types (columns).

```r
library(ath1121501.db)

# List available annotation types
columns(ath1121501.db)

# List available key types (usually PROBEID)
keytypes(ath1121501.db)
```

### Using the select() Interface
The `select()` function is the recommended method for retrieving data. It maps a vector of keys (probe IDs) to specific columns.

```r
# Example: Map probe IDs to Gene Symbols and AGI Locus IDs
probes <- c("244901_at", "244902_at", "244903_at")
results <- select(ath1121501.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ACCNUM", "GENENAME"), 
                  keytype = "PROBEID")
```

### Mapping to Pathways (AraCyc and KEGG)
Arabidopsis researchers often require AraCyc or KEGG pathway information.

```r
# Map probes to AraCyc pathways
aracyc_map <- select(ath1121501.db, 
                     keys = probes, 
                     columns = "ARACYC", 
                     keytype = "PROBEID")

# Map probes to KEGG pathway IDs
kegg_map <- select(ath1121501.db, 
                   keys = probes, 
                   columns = "PATH", 
                   keytype = "PROBEID")
```

### Chromosomal Locations
Retrieve the physical location of genes represented by the probes.

```r
# Get chromosome and start position
loc_data <- select(ath1121501.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")
```

### Legacy Bimap Interface
While `select()` is preferred, you can use the older Bimap interface for specific list-based operations.

```r
# Convert the SYMBOL map to a list
symbol_list <- as.list(ath1121501SYMBOL)

# Access a specific probe
symbol_list[["244901_at"]]

# Get only mapped keys
mapped_probes <- mappedkeys(ath1121501ACCNUM)
```

## Key Mapping Table

| Column Name | Description |
| :--- | :--- |
| ACCNUM | AGI Locus ID (e.g., AT1G01010) |
| SYMBOL | Gene Symbol |
| GENENAME | Full Gene Name |
| GO | Gene Ontology Identifiers |
| PATH | KEGG Pathway Identifiers |
| ARACYC | AraCyc Pathway Names |
| PMID | PubMed Identifiers |
| ENZYME | Enzyme Commission (EC) Numbers |

## Tips and Best Practices
- **One-to-Many Mappings**: Be aware that one probe ID may map to multiple GO terms or pathways. The `select()` function will return a data frame with multiple rows for that probe in such cases.
- **Package Dependencies**: This package depends on `AnnotationDbi`. Ensure it is installed to use the `select()`, `keys()`, and `columns()` functions.
- **Database Connection**: You can access the underlying SQLite connection using `ath1121501_dbconn()` for custom SQL queries, but do not call `dbDisconnect()` on it.

## Reference documentation
- [ath1121501.db Reference Manual](./references/reference_manual.md)