---
name: bioconductor-hsagilentdesign026652.db
description: This Bioconductor package provides SQLite-based annotation data for the Agilent Design 026652 microarray platform. Use when user asks to map manufacturer probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, RefSeq, or GO terms for human genomic data analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/HsAgilentDesign026652.db.html
---


# bioconductor-hsagilentdesign026652.db

name: bioconductor-hsagilentdesign026652.db
description: Annotation data for the Agilent Design 026652 platform. Use when mapping manufacturer probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, RefSeq, or GO terms for human genomic data analysis.

## Overview

The `HsAgilentDesign026652.db` package is a Bioconductor annotation data package for the Agilent Design 026652 microarray platform. It provides a SQLite-based interface to map manufacturer probe IDs to various genomic and functional annotations.

## Core Workflows

### Loading the Package

```r
library(HsAgilentDesign026652.db)
```

### Using the select() Interface

The preferred method for interacting with the database is through the `select`, `columns`, and `keys` functions from the `AnnotationDbi` package.

1.  **List available columns**: See what types of data can be retrieved.
    ```r
    columns(HsAgilentDesign026652.db)
    ```
2.  **List available keys**: See the manufacturer probe IDs.
    ```r
    k <- head(keys(HsAgilentDesign026652.db))
    ```
3.  **Retrieve annotations**: Map probe IDs to specific data types.
    ```r
    res <- select(HsAgilentDesign026652.db, 
                  keys = k, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
    ```

### Common Mappings

The package contains several specific mapping objects (Bimaps), though `select()` is generally preferred:

*   **Gene Symbols**: `HsAgilentDesign026652SYMBOL`
*   **Entrez Gene IDs**: `HsAgilentDesign026652ENTREZID`
*   **Gene Ontology (GO)**: `HsAgilentDesign026652GO` (includes Evidence codes and Ontologies: BP, CC, MF)
*   **KEGG Pathways**: `HsAgilentDesign026652PATH`
*   **RefSeq Accessions**: `HsAgilentDesign026652REFSEQ`
*   **Ensembl IDs**: `HsAgilentDesign026652ENSEMBL`
*   **Chromosomal Location**: `HsAgilentDesign026652CHR` and `HsAgilentDesign026652CHRLOC`

### Reverse Mappings

To map from a biological identifier back to probe IDs, use the `select` interface by changing the `keytype`:

```r
# Map from Gene Symbol to Probe IDs
select(HsAgilentDesign026652.db, 
       keys = c("TP53", "BRCA1"), 
       columns = c("PROBEID"), 
       keytype = "SYMBOL")
```

### Database Connection Information

To inspect the underlying SQLite database:

```r
# Get database connection
conn <- HsAgilentDesign026652_dbconn()
# Show database schema
HsAgilentDesign026652_dbschema()
# Get row count for probes table
DBI::dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips

*   **Handling Multiple Matches**: Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with one row per mapping, potentially resulting in more rows than input keys.
*   **Alias Mapping**: Use `HsAgilentDesign026652ALIAS2PROBE` to map common gene aliases to manufacturer identifiers.
*   **GO Evidence**: When using GO mappings, pay attention to the "Evidence" column (e.g., IDA, IEA, TAS) to understand the quality of the annotation.

## Reference documentation

- [HsAgilentDesign026652.db Reference Manual](./references/reference_manual.md)