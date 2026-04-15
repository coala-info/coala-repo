---
name: bioconductor-rguatlas4k.db
description: This package provides Bioconductor annotation data for the Rat Genome Atlas 4k platform. Use when user asks to map rguatlas4k probe identifiers to biological metadata, retrieve Gene Symbols or Entrez IDs for rat genes, and perform functional annotation using GO terms or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rguatlas4k.db.html
---

# bioconductor-rguatlas4k.db

name: bioconductor-rguatlas4k.db
description: Annotation package for the Rat Genome Atlas 4k (rguatlas4k) platform. Use when mapping manufacturer probe identifiers to biological metadata like Entrez IDs, Gene Symbols, GO terms, and KEGG pathways for Rattus norvegicus data.

# bioconductor-rguatlas4k.db

## Overview

The `rguatlas4k.db` package is a Bioconductor annotation data package for the rguatlas4k platform (Rat Genome Atlas 4k). It provides a stable, SQLite-based interface to map manufacturer-specific probe identifiers to various biological identifiers and metadata for *Rattus norvegicus*.

## Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rguatlas4k.db")
library(rguatlas4k.db)
```

## Core Workflows

### Discovery
Use the `AnnotationDbi` interface to explore available metadata types.

```r
# List available columns (data types)
columns(rguatlas4k.db)

# List available keytypes (fields that can be used as input)
keytypes(rguatlas4k.db)

# Get a sample of probe IDs (keys)
head(keys(rguatlas4k.db, keytype="PROBEID"))
```

### Data Retrieval (select)
The `select()` function is the recommended method for retrieving data.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1001_at", "1002_at", "1003_at")
select(rguatlas4k.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Reverse Mapping
You can map from other identifiers (like Symbols) back to probes.

```r
# Find probes associated with specific Gene Symbols
symbols <- c("Tp53", "Brca1")
select(rguatlas4k.db, 
       keys = symbols, 
       columns = c("PROBEID"), 
       keytype = "SYMBOL")
```

## Specific Mapping Types

### Gene Ontology (GO)
GO mappings return multiple rows per probe due to the hierarchical nature of the ontology.

```r
# Get GO terms and evidence codes for probes
select(rguatlas4k.db, 
       keys = probes[1], 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")
```

### Pathway Analysis (KEGG)
Map probes to KEGG pathway identifiers for functional enrichment.

```r
select(rguatlas4k.db, 
       keys = probes, 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Chromosomal Location
Retrieve the starting and ending positions of genes.

```r
select(rguatlas4k.db, 
       keys = probes, 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "PROBEID")
```

## Legacy Bimap Interface
While `select()` is preferred, the "Bimap" interface is available for legacy code or specific list-based operations.

```r
# Convert a mapping to a list
symbol_list <- as.list(rguatlas4kSYMBOL)
# Access a specific probe
symbol_list[["1001_at"]]
```

## Database Information
To inspect the underlying SQLite database connection or schema:

```r
# Get database connection
conn <- rguatlas4k_dbconn()
# Show database schema
rguatlas4k_dbschema()
# Get summary info
rguatlas4k_dbInfo()
```

## Reference documentation

- [reference_manual.md](./references/reference_manual.md)