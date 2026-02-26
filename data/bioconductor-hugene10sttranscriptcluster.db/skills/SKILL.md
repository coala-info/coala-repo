---
name: bioconductor-hugene10sttranscriptcluster.db
description: This package provides comprehensive annotation data for the Affymetrix Human Gene 1.0 ST Transcript Cluster platform. Use when user asks to map probe identifiers to gene symbols, Entrez IDs, GO terms, or KEGG pathways for this specific microarray.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene10sttranscriptcluster.db.html
---


# bioconductor-hugene10sttranscriptcluster.db

name: bioconductor-hugene10sttranscriptcluster.db
description: Comprehensive annotation data for the Affymetrix Human Gene 1.0 ST Transcript Cluster platform. Use when Claude needs to map manufacturer probe identifiers to genomic metadata (Entrez Gene IDs, Symbols, GO terms, KEGG pathways, etc.) or perform identifier conversions for this specific microarray platform.

# bioconductor-hugene10sttranscriptcluster.db

## Overview

The `hugene10sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Human Gene 1.0 ST Transcript Cluster array. It provides a SQLite-based interface to map manufacturer identifiers (probe set IDs) to various biological annotations.

## Core Workflows

### Loading the Package

```r
library(hugene10sttranscriptcluster.db)
```

### Using the select() Interface

The preferred method for accessing data is the `select()` interface from the `AnnotationDbi` package.

```r
# List available columns
columns(hugene10sttranscriptcluster.db)

# List available key types
keytypes(hugene10sttranscriptcluster.db)

# Retrieve specific annotations for a set of probe IDs
probes <- c("7896736", "7896744", "7896752")
res <- select(hugene10sttranscriptcluster.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### Common Mappings

- **Gene Symbols**: Map probe IDs to official gene symbols using `SYMBOL`.
- **Entrez IDs**: Map probe IDs to NCBI Entrez Gene identifiers using `ENTREZID`.
- **Gene Ontology (GO)**: Map probe IDs to GO terms and evidence codes using `GO`.
- **KEGG Pathways**: Map probe IDs to KEGG pathway identifiers using `PATH`.
- **Chromosomal Location**: Map probe IDs to chromosomes (`CHR`) or specific base pair locations (`CHRLOC`, `CHRLOCEND`).

### Reverse Mappings (Bimap Interface)

While `select()` is preferred, the "Bimap" interface is useful for quick list-based conversions or reverse mappings (e.g., finding probes for a specific gene symbol).

```r
# Map Symbols to Probe IDs
alias_map <- as.list(hugene10sttranscriptclusterALIAS2PROBE)
probes_for_gene <- alias_map[["TP53"]]

# Map GO IDs to Probe IDs
go_map <- as.list(hugene10sttranscriptclusterGO2PROBE)
probes_in_go <- go_map[["GO:0008150"]]
```

## Database Information

To inspect the underlying database connection and schema:

```r
# Get database connection
conn <- hugene10sttranscriptcluster_dbconn()

# View database schema
hugene10sttranscriptcluster_dbschema()

# Get summary info
hugene10sttranscriptcluster_dbInfo()
```

## Tips for Success

- **Probe IDs**: Ensure probe identifiers are treated as character strings, even if they appear numeric.
- **One-to-Many**: Be aware that a single probe ID may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with multiple rows in these cases.
- **Defunct Interfaces**: The Bimap interface for `PFAM` and `PROSITE` is defunct; always use the `select()` interface for these specific identifiers.
- **Organism Info**: Use `hugene10sttranscriptclusterORGANISM` to programmatically confirm the target species (Homo sapiens).

## Reference documentation

- [hugene10sttranscriptcluster.db Reference Manual](./references/reference_manual.md)