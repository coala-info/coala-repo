---
name: bioconductor-annotationdbi
description: AnnotationDbi provides a unified interface for querying and mapping biological identifiers across SQLite-based Bioconductor annotation packages. Use when user asks to map between different biological identifiers, query organism-level or transcript-centric databases, or retrieve genomic feature information using the select interface.
homepage: https://bioconductor.org/packages/release/bioc/html/AnnotationDbi.html
---

# bioconductor-annotationdbi

name: bioconductor-annotationdbi
description: Interface for SQLite-based annotation data packages in Bioconductor. Use this skill when you need to map between different biological identifiers (e.g., Entrez, Symbol, Ensembl, GO, KEGG), query organism-level (OrgDb), platform-specific (ChipDb), or transcript-centric (TxDb/EnsDb) databases, or perform direct SQL queries on Bioconductor annotation objects.

# bioconductor-annotationdbi

## Overview

AnnotationDbi provides a unified interface for interacting with SQLite-based annotation packages. It allows users to map biological identifiers across various databases using a consistent set of methods (`select`, `keys`, `columns`, and `keytypes`). It supports organism-level packages (e.g., `org.Hs.eg.db`), chip-specific packages (e.g., `hgu95av2.db`), and genomic feature packages (e.g., `TxDb` or `EnsDb`).

## Core Workflow: The Select Interface

The modern recommended interface for all `AnnotationDb` objects consists of four primary methods.

### 1. Discovery
Before querying, identify what data is available within the loaded annotation package.
```r
library(org.Hs.eg.db)
# See available data types (e.g., SYMBOL, ENSEMBL, GO)
columns(org.Hs.eg.db)

# See which types can be used as input keys
keytypes(org.Hs.eg.db)
```

### 2. Retrieving Keys
Extract valid identifiers to use for lookups.
```r
# Get the first 10 Entrez IDs
k <- head(keys(org.Hs.eg.db, keytype="ENTREZID"))
```

### 3. Mapping Data (select)
Perform the actual mapping between identifier types.
```r
# Map Entrez IDs to Symbols and Gene Names
res <- select(org.Hs.eg.db, 
              keys = k, 
              columns = c("SYMBOL", "GENENAME"), 
              keytype = "ENTREZID")
```

### 4. Simplified Mapping (mapIds)
Use `mapIds` when you need a 1:1 mapping returned as a named vector or list instead of a data.frame.
```r
# Returns a named character vector
syms <- mapIds(org.Hs.eg.db, 
               keys = k, 
               column = "SYMBOL", 
               keytype = "ENTREZID", 
               multiVals = "first")
```

## Working with Different Database Types

### Organism Packages (OrgDb)
Used for general gene-centric mappings (e.g., `org.Mm.eg.db` for Mouse).
*   **Central ID:** Usually Entrez ID (`ENTREZID`) or Ensembl ID (`ENSEMBL`).

### Chip/Platform Packages (ChipDb)
Used for mapping manufacturer-specific probe IDs to genes.
*   **Central ID:** `PROBEID`.
*   **Note:** These packages often depend on an OrgDb package for metadata.

### Transcript Packages (TxDb/EnsDb)
Used for genomic coordinates and transcript-to-gene relationships.
*   **Functions:** `transcripts()`, `exons()`, `cds()`, `transcriptsBy()`.
*   **Columns:** `TXNAME`, `TXSTART`, `TXEND`, `EXONID`.

## Advanced Usage

### Direct SQL Access
If the standard interface is insufficient, you can access the underlying SQLite database directly.
```r
# Get the database connection
conn <- org.Hs.eg_dbconn()

# Run a custom SQL query
query <- "SELECT gene_id, symbol FROM gene_info LIMIT 5"
dbGetQuery(conn, query)

# View the database schema
org.Hs.eg_dbschema()
```

### Attaching Multiple Databases
SQLite allows "attaching" multiple databases to perform cross-package joins (e.g., joining a ChipDb with an OrgDb).
```r
# Get path to the organism database
db_path <- system.file("extdata", "org.Hs.eg.sqlite", package="org.Hs.eg.db")
# Attach in SQL
dbExecute(hgu95av2_dbconn(), paste0("ATTACH '", db_path, "' AS orgDB"))
```

### Handling Multiple Probes
Some probes map to multiple genes. Use `toggleProbes` to control visibility.
```r
# Show all mappings, including those that map to multiple targets
multi_map <- toggleProbes(hgu95av2ENTREZID, "all")
```

## Tips and Best Practices
*   **Check for NAs:** Not all keys will have a mapping in every column. Use `isNA()` on Bimap objects or check for `NA` in `select()` results.
*   **GO Evidence Codes:** When querying GO terms, the `EVIDENCE` column indicates the type of supporting evidence (e.g., IDA, IEA).
*   **Reverse Mappings:** For older Bimap objects, use `revmap()` to swap the direction of the mapping (e.g., `revmap(hgu95av2SYMBOL)` to map Symbols to Probes).

## Reference documentation
- [How to use bimaps from the ".db" annotation packages](./references/AnnotationDbi.md)
- [AnnotationDbi: Introduction To Bioconductor Annotation Packages](./references/IntroToAnnotationPackages.md)