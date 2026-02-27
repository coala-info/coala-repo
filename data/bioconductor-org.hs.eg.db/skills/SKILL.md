---
name: bioconductor-org.hs.eg.db
description: This Bioconductor package provides comprehensive genome-wide mappings and functional annotations for human genes using Entrez Gene identifiers as primary keys. Use when user asks to map between gene symbols and database IDs, retrieve Gene Ontology terms, or find chromosomal locations for human genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Hs.eg.db.html
---


# bioconductor-org.hs.eg.db

## Overview

`org.Hs.eg.db` is a Bioconductor annotation package that provides comprehensive mappings for human genes. It uses Entrez Gene identifiers as the primary key. The package is essential for bioinformatics workflows involving human data, such as RNA-seq analysis, where converting between gene symbols and database-specific IDs is required.

## Core Workflows

### Loading the Package
```R
library(org.Hs.eg.db)
```

### The select() Interface
The modern and recommended way to interact with the database is using the `select()`, `keys()`, `columns()`, and `keytypes()` functions from the `AnnotationDbi` package.

1.  **Check available columns and keytypes:**
    ```R
    columns(org.Hs.eg.db)
    keytypes(org.Hs.eg.db)
    ```

2.  **Retrieve specific annotations:**
    ```R
    # Map Gene Symbols to Entrez IDs and Ensembl IDs
    genes <- c("TP53", "BRCA1", "APOE")
    select(org.Hs.eg.db, 
           keys = genes, 
           columns = c("ENTREZID", "ENSEMBL", "GENENAME"), 
           keytype = "SYMBOL")
    ```

### Common Mapping Tasks

*   **Gene Symbols to Entrez IDs:** Use `keytype="SYMBOL"` and `columns="ENTREZID"`.
*   **Ensembl to Symbols:** Use `keytype="ENSEMBL"` and `columns="SYMBOL"`.
*   **Functional Annotation (GO/KEGG):**
    ```R
    # Get GO terms for a set of Entrez IDs
    select(org.Hs.eg.db, 
           keys = c("7157", "672"), 
           columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
           keytype = "ENTREZID")
    ```
*   **Chromosomal Location:**
    ```R
    select(org.Hs.eg.db, 
           keys = "7157", 
           columns = c("MAP", "CHR", "CHRLOC"), 
           keytype = "ENTREZID")
    ```

### Legacy Bimap Interface
While `select()` is preferred, you can still use the older Bimap objects for quick lookups or list conversions.

```R
# Convert Symbol to Entrez ID list
sym2eg <- as.list(org.Hs.egSYMBOL2EG)
tp53_id <- sym2eg[["TP53"]]

# Get all mapped keys
all_symbols <- mappedkeys(org.Hs.egSYMBOL)
```

## Tips and Best Practices

*   **Redundancy:** Gene symbols can be redundant. The `ALIAS` map (`org.Hs.egALIAS2EG`) contains many-to-one mappings including historical symbols, whereas `SYMBOL` contains only official HGNC symbols.
*   **Data Versions:** This package is updated biannually with Bioconductor releases. Always check `org.Hs.eg_dbInfo()` to see the source data timestamps (e.g., NCBI Entrez Gene, UCSC, Ensembl).
*   **Avoid Symbols as Primary Keys:** When performing data analysis, always use stable identifiers like Entrez IDs or Ensembl IDs as your primary keys, and only map to Symbols for final visualization or reporting.
*   **Connection Management:** Use `org.Hs.eg_dbconn()` to get the underlying SQLite connection if you need to perform complex SQL queries, but never call `dbDisconnect()` on it.

## Reference documentation

- [org.Hs.eg.db Reference Manual](./references/reference_manual.md)