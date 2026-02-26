---
name: bioconductor-htmg430a.db
description: This package provides comprehensive annotation data for the Affymetrix HT Mouse Genome 430A array. Use when user asks to map manufacturer probe identifiers to biological metadata, translate microarray results into gene symbols, or identify associated GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htmg430a.db.html
---


# bioconductor-htmg430a.db

name: bioconductor-htmg430a.db
description: Comprehensive annotation data for the Affymetrix HT Mouse Genome 430A array. Use when mapping manufacturer probe identifiers to biological metadata (Entrez, Symbol, GO, KEGG, Ensembl, etc.) or vice versa for mouse genomic studies.

# bioconductor-htmg430a.db

## Overview

The `htmg430a.db` package is a Bioconductor annotation data package for the Affymetrix HT Mouse Genome 430A array. It provides a stable, SQLite-based environment for mapping manufacturer probe identifiers to various biological database identifiers and metadata. This package is essential for downstream analysis of microarray data, allowing researchers to translate probe-level results into gene symbols, pathways, and functional categories.

## Core Workflows

### Loading the Package and Exploring Columns

To begin, load the package and use the `AnnotationDbi` interface to see available data types.

```r
library(htmg430a.db)

# List all available annotation types (columns)
columns(htmg430a.db)

# List the types of keys that can be used as input
keytypes(htmg430a.db)

# Get a sample of probe IDs (keys)
head(keys(htmg430a.db))
```

### Using the select() Interface

The `select()` function is the modern, recommended way to retrieve data. It allows you to map a vector of keys to specific columns.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1415670_at", "1415671_at", "1415672_at")
results <- select(htmg430a.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
print(results)
```

### Mapping to Gene Ontology (GO)

Mapping probes to GO terms provides functional context (Biological Process, Cellular Component, Molecular Function).

```r
# Get GO terms and evidence codes for specific probes
go_mappings <- select(htmg430a.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")
```

### Mapping to KEGG Pathways

To identify biological pathways associated with specific probes:

```r
pathway_mappings <- select(htmg430a.db, 
                           keys = probes, 
                           columns = "PATH", 
                           keytype = "PROBEID")
```

### Legacy Bimap Interface

While `select()` is preferred, you can still use the "Bimap" interface for specific mappings or reverse lookups.

```r
# Convert a mapping to a list (e.g., Probes to Symbols)
symbol_list <- as.list(htmg430aSYMBOL)
# Access a specific probe
symbol_list[["1415670_at"]]

# Reverse mapping: Find probes associated with a specific Gene Symbol
alias_to_probe <- as.list(htmg430aALIAS2PROBE)
alias_to_probe[["Gnf1"]]
```

## Database Connection and Metadata

You can access the underlying SQLite connection or view package metadata directly.

```r
# Get database schema information
htmg430a_dbschema()

# Get package metadata (source dates, versions)
htmg430a_dbInfo()

# Get the organism name
htmg430aORGANISM
```

## Tips and Best Practices

- **Consensus Mapping**: For `ENTREZID`, if a probe maps to multiple identifiers, the package attempts to select a consensus or the smallest identifier.
- **Evidence Codes**: When working with GO terms, pay attention to the `EVIDENCE` column (e.g., TAS, IDA, IEA) to understand the reliability of the annotation.
- **Filtering**: Use `mappedkeys()` with Bimaps to identify only those probes that have a valid mapping for a specific attribute.
- **Memory Efficiency**: For large-scale lookups, `select()` is generally more memory-efficient than converting entire Bimaps to lists.

## Reference documentation

- [htmg430a.db Reference Manual](./references/reference_manual.md)