---
name: bioconductor-mguatlas5k.db
description: This package provides Bioconductor annotation data for the mguatlas5k platform to map manufacturer probe identifiers to biological metadata. Use when user asks to map probe IDs to Entrez Gene IDs, GO terms, KEGG pathways, or gene symbols for Mus musculus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mguatlas5k.db.html
---

# bioconductor-mguatlas5k.db

name: bioconductor-mguatlas5k.db
description: Annotation data for the mguatlas5k platform. Use when mapping manufacturer identifiers (probes) to biological annotations like Entrez Gene IDs, GO terms, KEGG pathways, and gene symbols for Mus musculus.

# bioconductor-mguatlas5k.db

## Overview
The `mguatlas5k.db` package is a Bioconductor annotation hub for the mguatlas5k platform. It provides SQLite-based mappings between manufacturer probe identifiers and various biological databases. This skill guides the use of both the modern `select()` interface and the legacy `Bimap` interface for data retrieval.

## Core Workflows

### Loading the Package
```r
library(mguatlas5k.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `AnnotationDbi` interface.

1.  **List available columns:**
    ```r
    columns(mguatlas5k.db)
    ```
2.  **List available key types:**
    ```r
    keytypes(mguatlas5k.db)
    ```
3.  **Retrieve data:**
    ```r
    # Example: Map probe IDs to Gene Symbols and Entrez IDs
    probes <- c("1001_at", "1002_at") # Replace with actual probe IDs
    select(mguatlas5k.db, keys = probes, columns = c("SYMBOL", "ENTREZID"), keytype = "PROBEID")
    ```

### Using the Bimap Interface
While `select()` is preferred, specific mappings can be accessed directly as Bimap objects.

*   **Gene Symbols:** `mguatlas5kSYMBOL`
*   **Entrez Gene IDs:** `mguatlas5kENTREZID`
*   **Gene Ontology (GO):** `mguatlas5kGO`
*   **KEGG Pathways:** `mguatlas5kPATH`
*   **Ensembl IDs:** `mguatlas5kENSEMBL`
*   **RefSeq IDs:** `mguatlas5kREFSEQ`

**Example Bimap usage:**
```r
# Convert a mapping to a list
mapped_list <- as.list(mguatlas5kSYMBOL)
# Access specific probe
mapped_list[["1001_at"]]
```

### Chromosomal Information
*   **Location:** `mguatlas5kCHRLOC` (start) and `mguatlas5kCHRLOCEND` (end).
*   **Chromosome:** `mguatlas5kCHR`.
*   **Lengths:** `mguatlas5kCHRLENGTHS`.

### Database Metadata
To inspect the underlying database connection and schema:
```r
mguatlas5k_dbconn()   # Get connection object
mguatlas5k_dbschema() # View table structures
mguatlas5k_dbInfo()   # View package metadata
```

## Tips
*   **Alias Mapping:** Use `mguatlas5kALIAS2PROBE` to map common gene symbols (aliases) back to manufacturer identifiers.
*   **GO Evidence:** When using `mguatlas5kGO`, results include evidence codes (e.g., IDA, IEA, TAS) and ontology categories (BP, CC, MF).
*   **Reverse Maps:** Many objects have reverse mappings (e.g., `mguatlas5kGO2PROBE` or `mguatlas5kPATH2PROBE`) to find probes associated with specific biological terms.

## Reference documentation
- [mguatlas5k.db Reference Manual](./references/reference_manual.md)