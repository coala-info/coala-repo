---
name: bioconductor-org.cf.eg.db
description: This package provides genome-wide annotations and identifier mappings for Canis familiaris (Dog) based on Entrez Gene identifiers. Use when user asks to map between dog gene identifiers, retrieve functional annotations like GO or KEGG terms, or find chromosomal locations for dog genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Cf.eg.db.html
---

# bioconductor-org.cf.eg.db

name: bioconductor-org.cf.eg.db
description: Genome-wide annotation for Canis familiaris (Dog), primarily based on Entrez Gene identifiers. Use this skill when you need to map between different dog gene identifiers (Entrez, Symbol, Ensembl, RefSeq, UniProt), retrieve functional annotations (GO, KEGG), or find chromosomal locations for dog genes.

# bioconductor-org.cf.eg.db

## Overview

The `org.Cf.eg.db` package is a Bioconductor organism-level annotation database for *Canis familiaris* (Dog). It provides a centralized map between Entrez Gene identifiers and various biological descriptors. While it supports "Bimap" style objects (e.g., `org.Cf.egSYMBOL`), the modern and preferred way to interact with this data is through the `select()` interface provided by the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(org.Cf.eg.db)
```

### Exploring Available Data
Before querying, check what types of identifiers (keys) and data types (columns) are available:
```r
# List available ID types to use as keys
keytypes(org.Cf.eg.db)

# List available annotation types to retrieve
columns(org.Cf.eg.db)
```

### Using the select() Interface
The `select()` function is the primary tool for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired data), and the keytype (the type of input IDs).

```r
# Example: Map Gene Symbols to Entrez IDs and Ensembl IDs
genes <- c("CANX", "APOE", "TP53")
select(org.Cf.eg.db, 
       keys = genes, 
       columns = c("ENTREZID", "ENSEMBL", "GENENAME"), 
       keytype = "SYMBOL")
```

### Functional Annotation (GO and KEGG)
Retrieve Gene Ontology (GO) terms or KEGG pathway identifiers:
```r
# Get GO terms for specific Entrez IDs
select(org.Cf.eg.db, 
       keys = c("403431", "403432"), 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "ENTREZID")

# Get KEGG pathways
select(org.Cf.eg.db, 
       keys = "403431", 
       columns = "PATH", 
       keytype = "ENTREZID")
```

### Genomic Locations
Find where genes are located on the dog genome:
```r
# Get chromosome and start position
select(org.Cf.eg.db, 
       keys = "CANX", 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "SYMBOL")
```

## Tips and Best Practices
- **Redundancy**: Gene symbols can sometimes be redundant. When mapping from symbols to other IDs, always check for one-to-many mappings.
- **Key Selection**: Use `ENTREZID` as the primary key whenever possible, as the database is structured around Entrez Gene identifiers.
- **Bimap Interface**: If you encounter older code using `as.list(org.Cf.egSYMBOL)`, it is recommended to convert it to `select()` for better performance and consistency.
- **Database Metadata**: Use `org.Cf.eg_dbconn()` to get a connection to the underlying SQLite database or `org.Cf.eg_dbInfo()` to see data source versions and timestamps.

## Reference documentation
- [org.Cf.eg.db](./references/reference_manual.md)