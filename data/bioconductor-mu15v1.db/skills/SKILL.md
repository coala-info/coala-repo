---
name: bioconductor-mu15v1.db
description: This package provides SQLite-based annotation maps for the Mu15v1 mouse platform to link manufacturer probe IDs with various biological identifiers. Use when user asks to map Mu15v1 probe IDs to gene symbols, retrieve Gene Ontology terms for mouse probes, or convert between manufacturer IDs and standard identifiers like Entrez or Ensembl.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Mu15v1.db.html
---


# bioconductor-mu15v1.db

## Overview

The `Mu15v1.db` package is a Bioconductor annotation hub for the Mu15v1 mouse platform. It provides a SQLite-based interface to map manufacturer-specific probe IDs to standard biological identifiers. While it supports older "Bimap" interfaces, the primary and recommended method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(Mu15v1.db)
```

### Exploring Available Data
To see which types of identifiers can be retrieved or used as keys:
```r
# List available columns (e.g., SYMBOL, ENTREZID, GO, ENSEMBL)
columns(Mu15v1.db)

# List available key types (usually the same as columns)
keytypes(Mu15v1.db)

# Get a sample of manufacturer probe IDs
head(keys(Mu15v1.db))
```

### Using the select() Interface
The `select()` function is the standard way to extract data. It requires the database object, the keys you are looking up, the columns you want to retrieve, and the keytype of your input.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at") # Example probe IDs
results <- select(Mu15v1.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Ontology (GO):** Retrieve GO terms and evidence codes for specific probes.
    ```r
    select(Mu15v1.db, keys = probes, columns = "GO", keytype = "PROBEID")
    ```
*   **Chromosomal Location:** Find the start and end positions of genes.
    ```r
    select(Mu15v1.db, keys = probes, columns = c("CHR", "CHRLOC", "CHRLOCEND"), keytype = "PROBEID")
    ```
*   **External Database IDs:** Map to Ensembl, MGI (Mouse Genome Informatics), or RefSeq.
    ```r
    select(Mu15v1.db, keys = probes, columns = c("ENSEMBL", "MGI", "REFSEQ"), keytype = "PROBEID")
    ```

### Reverse Mappings (Alias to Probe)
If you have a gene symbol and want to find the corresponding manufacturer probes:
```r
select(Mu15v1.db, keys = "Tp53", columns = "PROBEID", keytype = "SYMBOL")
```

## Database Connection Utilities
For advanced users needing direct SQL access or metadata:
*   `Mu15v1_dbconn()`: Returns the DBI connection object.
*   `Mu15v1_dbschema()`: Prints the underlying SQLite schema.
*   `Mu15v1_dbInfo()`: Displays package metadata and data sources.

## Tips
*   **Bimap Interface:** Older code may use `as.list(Mu15v1SYMBOL)`. While functional, `select()` is more robust and preferred for modern Bioconductor workflows.
*   **One-to-Many Mappings:** Note that one probe ID may map to multiple GO terms or Entrez IDs. `select()` will return a long-format data frame containing all associations.
*   **Organism Info:** Use `Mu15v1ORGANISM` to programmatically confirm the species (Mus musculus).

## Reference documentation
- [Mu15v1.db Reference Manual](./references/reference_manual.md)