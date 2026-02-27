---
name: bioconductor-zebrafish.db
description: This package provides comprehensive annotation data for zebrafish genes, enabling translation between various biological identifiers and retrieval of functional or positional information. Use when user asks to map zebrafish identifiers, retrieve gene symbols, find chromosomal locations, or obtain Gene Ontology and KEGG pathway annotations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/zebrafish.db.html
---


# bioconductor-zebrafish.db

## Overview

The `zebrafish.db` package is a comprehensive annotation database for Zebrafish. It is primarily used to translate between different biological identifiers and to retrieve functional or positional information about zebrafish genes. It utilizes the `AnnotationDbi` interface, allowing for efficient querying via the `select()` function.

## Core Workflows

### 1. Initialization and Discovery
To use the package, load it into your R session and explore the available keys and columns.

```r
library(zebrafish.db)

# View available columns (types of data you can retrieve)
columns(zebrafish.db)

# View available keytypes (types of identifiers you can use as input)
keytypes(zebrafish.db)

# Get a sample of keys (e.g., Entrez IDs)
head(keys(zebrafish.db, keytype="ENTREZID"))
```

### 2. Mapping Identifiers with select()
The `select()` function is the recommended way to perform mappings. It requires the database object, the keys to look up, the columns to return, and the keytype of the input.

```r
# Map Entrez IDs to Gene Symbols and Chromosomes
ids <- c("30037", "30038", "30039")
select(zebrafish.db, 
       keys = ids, 
       columns = c("SYMBOL", "CHR", "GENENAME"), 
       keytype = "ENTREZID")
```

### 3. Functional Annotation (GO and PATH)
Retrieve Gene Ontology (GO) terms or KEGG pathway identifiers for specific genes.

```r
# Get GO terms for a specific gene symbol
select(zebrafish.db, 
       keys = "shha", 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "SYMBOL")

# Map genes to KEGG pathways
select(zebrafish.db, 
       keys = "shha", 
       columns = "PATH", 
       keytype = "SYMBOL")
```

### 4. Chromosomal Locations
Retrieve the start and end positions of genes on the zebrafish genome.

```r
# Get chromosomal start (CHRLOC) and end (CHRLOCEND)
select(zebrafish.db, 
       keys = "30037", 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "ENTREZID")
```

### 5. Legacy Bimap Interface
While `select()` is preferred, you can still use the older Bimap interface for specific mappings (e.g., `zebrafishSYMBOL`).

```r
# Convert a mapping to a list
sym_list <- as.list(zebrafishSYMBOL)
# Access by identifier
sym_list[["30037"]]
```

## Tips and Best Practices
- **ZFIN IDs**: For zebrafish research, ZFIN identifiers are often the primary key. Use `keytype="ZFIN"` when starting with ZFIN accessions.
- **One-to-Many Mappings**: Be aware that `select()` may return more rows than input keys if a gene maps to multiple GO terms or pathways.
- **Database Connection**: Use `zebrafish_dbconn()` to get a direct connection to the underlying SQLite database if you need to perform custom SQL queries.
- **Alias Mapping**: If a gene symbol is not found in the `SYMBOL` column, try searching the `ALIAS` column using `zebrafishALIAS2PROBE`.

## Reference documentation
- [zebrafish.db Reference Manual](./references/reference_manual.md)