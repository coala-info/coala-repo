---
name: bioconductor-org.dr.eg.db
description: This package provides genome-wide annotation data for Zebrafish using Entrez Gene identifiers. Use when user asks to map between Zebrafish gene identifiers, retrieve functional annotations like GO or KEGG terms, or find chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Dr.eg.db.html
---


# bioconductor-org.dr.eg.db

name: bioconductor-org.dr.eg.db
description: Provides annotation data for Zebrafish (Danio rerio) using Entrez Gene identifiers. Use this skill when you need to map between different gene identifiers (Entrez, Symbol, Ensembl, RefSeq, Uniprot), find chromosomal locations, or retrieve functional annotations (GO, KEGG/PATH) for Zebrafish data in R.

# bioconductor-org.dr.eg.db

## Overview
The `org.Dr.eg.db` package is a genome-wide annotation database for Zebrafish (*Danio rerio*), primarily based on Entrez Gene identifiers. It serves as a central hub for mapping various biological identifiers and retrieving metadata associated with Zebrafish genes.

## Core Workflows

### 1. Loading the Database
To use the package, load it into your R session. The object `org.Dr.eg.db` is automatically created.
```r
library(org.Dr.eg.db)
# View available columns for mapping
columns(org.Dr.eg.db)
# View available key types
keytypes(org.Dr.eg.db)
```

### 2. Using the select() Interface
The recommended way to interact with the database is using `select()`, `keys()`, and `mapIds()`.

**Basic Mapping:**
```r
# Map Entrez IDs to Gene Symbols and Ensembl IDs
genes <- c("30037", "30038", "30039")
select(org.Dr.eg.db, 
       keys = genes, 
       columns = c("SYMBOL", "ENSEMBL", "GENENAME"), 
       keytype = "ENTREZID")
```

**Using mapIds for 1-to-1 mapping:**
```r
# Returns a named vector (useful for adding columns to data frames)
symbols <- mapIds(org.Dr.eg.db, 
                  keys = genes, 
                  column = "SYMBOL", 
                  keytype = "ENTREZID", 
                  multiVals = "first")
```

### 3. Common Identifier Mappings
*   **Symbols to Entrez:** Use `keytype="SYMBOL"` and `columns="ENTREZID"`.
*   **Ensembl to Symbol:** Use `keytype="ENSEMBL"` and `columns="SYMBOL"`.
*   **RefSeq:** Map using the `REFSEQ` column.
*   **Uniprot:** Map using the `UNIPROT` column.
*   **Zfin:** Map using the `ZFIN` column (specific to Zebrafish).

### 4. Functional and Location Annotation
*   **Gene Ontology (GO):** Retrieve GO IDs and evidence codes.
    ```r
    select(org.Dr.eg.db, keys = "30037", columns = c("GO", "ONTOLOGY", "EVIDENCE"), keytype = "ENTREZID")
    ```
*   **KEGG Pathways:** Map genes to KEGG pathway identifiers using the `PATH` column.
*   **Chromosomal Location:** Use `CHR`, `CHRLOC` (start), and `CHRLOCEND` (end).
    ```r
    select(org.Dr.eg.db, keys = "30037", columns = c("CHR", "CHRLOC"), keytype = "ENTREZID")
    ```

### 5. Legacy Bimap Interface
While `select()` is preferred, you can access specific maps directly for complex list-based operations.
```r
# Get all Entrez IDs mapped to Symbols
x <- org.Dr.egSYMBOL
mapped_genes <- mappedkeys(x)
xx <- as.list(x[mapped_genes])
```

## Tips and Best Practices
*   **Redundant Symbols:** Gene symbols (ALIAS) can be redundant. Use `SYMBOL` for official nomenclature and `ENTREZID` or `ENSEMBL` as primary keys for data analysis.
*   **multiVals Argument:** When using `mapIds`, decide how to handle 1-to-many mappings using `multiVals` (e.g., "first", "list", "CharacterList", or "filter").
*   **Database Metadata:** Use `org.Dr.eg_dbInfo()` to check data source versions and timestamps.
*   **Species Confirmation:** Use `org.Dr.egORGANISM` to programmatically verify the species is *Danio rerio*.

## Reference documentation
- [org.Dr.eg.db](./references/reference_manual.md)