---
name: bioconductor-org.ag.eg.db
description: This package provides organism-level annotation data and identifier mapping for *Anopheles gambiae*. Use when user asks to map Entrez IDs to gene symbols, retrieve Gene Ontology terms, or access genomic metadata for the malaria mosquito.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Ag.eg.db.html
---


# bioconductor-org.ag.eg.db

## Overview

The `org.Ag.eg.db` package is a Bioconductor organism-level annotation database for *Anopheles gambiae*. It provides a stable mapping between Entrez Gene identifiers and various biological metadata. While it supports older "Bimap" interfaces, the primary and recommended way to interact with the data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### 1. Initialization and Discovery
To use the package, load it into your R session and explore the available keys and columns.

```r
library(org.Ag.eg.db)

# See available columns (types of data you can retrieve)
columns(org.Ag.eg.db)

# See available keytypes (types of identifiers you can use as input)
keytypes(org.Ag.eg.db)

# Get a sample of Entrez IDs (the primary keys)
head(keys(org.Ag.eg.db, keytype="ENTREZID"))
```

### 2. Mapping Identifiers (The select Interface)
The `select()` function is the standard way to translate between identifiers.

```r
# Map Entrez IDs to Gene Symbols and Ensembl IDs
genes <- c("1272272", "1272273")
select(org.Ag.eg.db, 
       keys = genes, 
       columns = c("SYMBOL", "ENSEMBL", "GENENAME"), 
       keytype = "ENTREZID")
```

### 3. Functional Annotation (GO and KEGG)
Retrieve Gene Ontology terms or KEGG pathway identifiers for specific genes.

```r
# Get GO terms for a set of symbols
select(org.Ag.eg.db, 
       keys = "Vg", 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "SYMBOL")

# Get KEGG pathways
select(org.Ag.eg.db, 
       keys = "1272272", 
       columns = "PATH", 
       keytype = "ENTREZID")
```

### 4. Genomic Location
Retrieve chromosome information and lengths.

```r
# Map genes to chromosomes
select(org.Ag.eg.db, 
       keys = "1272272", 
       columns = "CHR", 
       keytype = "ENTREZID")

# Get all chromosome lengths
org.Ag.egCHRLENGTHS
```

## Tips and Best Practices

- **Avoid Symbols as Primary Keys**: Gene symbols can be redundant or change over time. Always prefer Entrez IDs (`ENTREZID`) or Ensembl IDs (`ENSEMBL`) for stable analysis.
- **Alias Mapping**: If you have non-official symbols, use the `ALIAS` column to find the corresponding Entrez ID.
- **One-to-Many Mappings**: Functions like `select()` may return more rows than input keys if a gene maps to multiple GO terms or transcripts. Always check the dimensions of your output.
- **Bimap Interface**: While `as.list(org.Ag.egSYMBOL)` still works, it is considered "old style." Stick to `select()`, `keys()`, and `columns()` for better compatibility with modern Bioconductor workflows.
- **Database Connection**: You can access the underlying SQLite database directly using `org.Ag.eg_dbconn()` for complex SQL queries, though this is rarely necessary for standard annotation tasks.

## Reference documentation

- [org.Ag.eg.db](./references/reference_manual.md)