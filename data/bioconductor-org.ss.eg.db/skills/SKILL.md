---
name: bioconductor-org.ss.eg.db
description: This package provides genome-wide annotation and identifier mappings for the pig (Sus scrofa) organism. Use when user asks to map between pig gene identifiers like Entrez IDs and symbols, retrieve Gene Ontology terms, or find KEGG pathway information.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Ss.eg.db.html
---


# bioconductor-org.ss.eg.db

name: bioconductor-org.ss.eg.db
description: Genome-wide annotation for Pig (Sus scrofa), primarily based on Entrez Gene identifiers. Use this skill when mapping between different pig gene identifiers (e.g., Entrez ID to Symbol, GO terms, or KEGG pathways) or retrieving metadata for pig genes in R.

# bioconductor-org.ss.eg.db

## Overview

The `org.Ss.eg.db` package is a Bioconductor annotation hub for *Sus scrofa* (Pig). It provides comprehensive mappings between Entrez Gene identifiers and various other biological descriptors such as Gene Symbols, RefSeq, UniProt, Gene Ontology (GO), and KEGG pathways.

The package is built around the `AnnotationDb` class and is primarily accessed using the standard `AnnotationDbi` interface (`select`, `keys`, `columns`, and `mapIds`).

## Core Workflows

### Loading the Package
```r
library(org.Ss.eg.db)
```

### Exploring Available Data
To see what types of data (columns) can be retrieved:
```r
columns(org.Ss.eg.db)
```

To see what types of identifiers can be used as input (keys):
```r
keytypes(org.Ss.eg.db)
```

### Basic Mapping with select()
The `select()` function returns a data frame. It is useful for one-to-many mappings.
```r
# Map Entrez IDs to Symbols and Chromosomes
gene_ids <- c("397219", "397220")
res <- select(org.Ss.eg.db, 
              keys = gene_ids, 
              columns = c("SYMBOL", "GENENAME", "CHR"), 
              keytype = "ENTREZID")
```

### Simple Mapping with mapIds()
The `mapIds()` function is preferred when you need a named vector and want to control how multi-mappings are handled.
```r
# Map Entrez IDs to Symbols, keeping only the first match for each
symbols <- mapIds(org.Ss.eg.db, 
                  keys = gene_ids, 
                  column = "SYMBOL", 
                  keytype = "ENTREZID", 
                  multiVals = "first")
```

### Mapping from Symbols to Entrez IDs
Since symbols can be ambiguous, use the `ALIAS` map if the official `SYMBOL` map fails to find a match.
```r
# Using official symbols
ids <- mapIds(org.Ss.eg.db, 
              keys = c("SLA-1", "TP53"), 
              column = "ENTREZID", 
              keytype = "SYMBOL", 
              multiVals = "first")
```

## Common Annotation Tasks

### Gene Ontology (GO) Retrieval
Retrieving GO terms provides the ID, Evidence code, and Ontology category (BP, CC, MF).
```r
go_annots <- select(org.Ss.eg.db, 
                    keys = "397219", 
                    columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                    keytype = "ENTREZID")
```

### KEGG Pathway Mapping
Map genes to KEGG pathway identifiers:
```r
pathways <- select(org.Ss.eg.db, 
                   keys = "397219", 
                   columns = "PATH", 
                   keytype = "ENTREZID")
```

### Accessing Database Metadata
To check the organism name or data source versions:
```r
org.Ss.egORGANISM
org.Ss.eg_dbInfo()
```

## Tips and Best Practices
- **Primary Keys:** Entrez Gene IDs are the primary keys for this database. Using them as the `keytype` is generally the most reliable method.
- **Multi-mappings:** Many genes map to multiple GO terms or pathways. When using `select()`, this will result in multiple rows for a single input key. Use `mapIds()` with `multiVals = "list"` if you want to preserve all mappings in a structured format.
- **Bimap Interface:** While "old style" Bimaps (e.g., `org.Ss.egSYMBOL2EG`) still exist, the `select()` and `mapIds()` interface is recommended for consistency and ease of use.
- **Avoid Symbols as Primary IDs:** Gene symbols change over time. Always prefer Entrez IDs or Ensembl IDs for data storage and primary analysis.

## Reference documentation
- [org.Ss.eg.db Reference Manual](./references/reference_manual.md)