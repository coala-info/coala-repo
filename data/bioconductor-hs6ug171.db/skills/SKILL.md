---
name: bioconductor-hs6ug171.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Hs6UG171.db.html
---

# bioconductor-hs6ug171.db

name: bioconductor-hs6ug171.db
description: Annotation data for the Hs6UG171 microarray platform. Use when mapping manufacturer probe identifiers to biological metadata including Gene Symbols, Entrez IDs, Ensembl IDs, GO terms, and KEGG pathways for human genomic data analysis.

## Overview

The `Hs6UG171.db` package is a Bioconductor annotation data package for the Hs6UG171 platform. It provides a comprehensive set of mappings between manufacturer-specific probe identifiers and various public identifiers, allowing researchers to functionalize microarray results.

The package primarily uses the `AnnotationDbi` interface, supporting both the modern `select()` workflow and the legacy `Bimap` interface.

## Using Hs6UG171.db

### Loading the Package

```r
library(Hs6UG171.db)
```

### The select() Interface

The preferred method for interacting with the database is the `select()` function.

1.  **Check available columns:**
    ```r
    columns(Hs6UG171.db)
    ```
2.  **Check available keytypes:**
    ```r
    keytypes(Hs6UG171.db)
    ```
3.  **Retrieve data:**
    ```r
    # Map probe IDs to Gene Symbols and Entrez IDs
    probes <- c("1000_at", "1001_at") # Example probe IDs
    select(Hs6UG171.db, keys = probes, columns = c("SYMBOL", "ENTREZID"), keytype = "PROBEID")
    ```

### Common Annotation Mappings

The package contains several specific mapping objects (Bimaps) for common tasks:

*   **Gene Symbols:** `Hs6UG171SYMBOL` maps probes to official gene symbols.
*   **Entrez IDs:** `Hs6UG171ENTREZID` maps probes to NCBI Entrez Gene identifiers.
*   **Gene Ontology (GO):** `Hs6UG171GO` provides mappings to GO terms, including evidence codes and ontologies (BP, CC, MF).
*   **KEGG Pathways:** `Hs6UG171PATH` maps probes to KEGG pathway identifiers.
*   **Chromosomal Location:** `Hs6UG171CHR` and `Hs6UG171CHRLOC` provide chromosome names and start/end coordinates.
*   **Ensembl:** `Hs6UG171ENSEMBL` maps probes to Ensembl gene accession numbers.

### Legacy Bimap Workflow

While `select()` is recommended, you can still use the Bimap interface for quick list conversions:

```r
# Convert Symbol mapping to a list
symbol_list <- as.list(Hs6UG171SYMBOL)

# Get symbols for specific probes
probes <- names(symbol_list)[1:5]
symbol_list[probes]
```

### Database Connection Information

To inspect the underlying SQLite database or schema:

```r
# Get database connection
conn <- Hs6UG171_dbconn()

# Show database schema
Hs6UG171_dbschema()

# Get path to the SQLite file
Hs6UG171_dbfile()
```

## Reference documentation

- [Hs6UG171.db Reference Manual](./references/reference_manual.md)