---
name: bioconductor-hgu133a.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133a.db.html
---

# bioconductor-hgu133a.db

name: bioconductor-hgu133a.db
description: Annotation data for the Affymetrix Human Genome U133A array. Use when mapping Affymetrix probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, RefSeq, Ensembl, Gene Ontology (GO), and KEGG pathways.

# bioconductor-hgu133a.db

## Overview

The `hgu133a.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome U133A platform. It provides a comprehensive set of mappings between manufacturer probe IDs and various biological identifiers. The package uses an SQLite database backend and is primarily accessed via the `AnnotationDbi` interface.

## Core Workflows

### Loading the Package
```r
library(hgu133a.db)
```

### Using the select() Interface (Recommended)
The `select()` function is the modern, unified way to query annotation packages.

1.  **Check available columns:**
    ```r
    columns(hgu133a.db)
    ```
2.  **Check available keytypes:**
    ```r
    keytypes(hgu133a.db)
    ```
3.  **Perform a query:**
    ```r
    # Map probe IDs to Gene Symbols and Entrez IDs
    probes <- c("1000_at", "1001_at", "1002_f_at")
    select(hgu133a.db, keys = probes, columns = c("SYMBOL", "ENTREZID"), keytype = "PROBEID")
    ```

### Using the Bimap Interface (Legacy)
While `select()` is preferred, the Bimap interface is useful for quick list conversions or reverse mappings.

*   **Convert a map to a list:**
    ```r
    # Map Probes to Symbols
    symbol_list <- as.list(hgu133aSYMBOL)
    # Access specific probe
    symbol_list[["1000_at"]]
    ```
*   **Get mapped keys:**
    ```r
    mapped_probes <- mappedkeys(hgu133aSYMBOL)
    ```
*   **Reverse mappings:**
    ```r
    # Map Symbols back to Probes
    symbol_to_probe <- as.list(hgu133aALIAS2PROBE)
    ```

### Common Annotation Mappings

*   **Gene Identifiers:** `hgu133aSYMBOL` (Official Symbol), `hgu133aENTREZID` (Entrez Gene), `hgu133aGENENAME` (Full Name).
*   **External Databases:** `hgu133aENSEMBL` (Ensembl IDs), `hgu133aUNIPROT` (UniProt), `hgu133aREFSEQ` (RefSeq).
*   **Functional Annotation:** `hgu133aGO` (Gene Ontology), `hgu133aPATH` (KEGG Pathways).
*   **Location:** `hgu133aCHR` (Chromosome), `hgu133aMAP` (Cytoband), `hgu133aCHRLOC` (Chromosomal start position).

### Database Information
To inspect the underlying database schema or connection:
```r
hgu133a_dbschema()
hgu133a_dbInfo()
```

## Tips for AI Agents
*   **Probe ID Format:** Affymetrix HGU133A probe IDs typically look like `12345_at` or `12345_s_at`.
*   **One-to-Many Mappings:** Be aware that one probe ID can sometimes map to multiple Entrez IDs or GO terms. `select()` returns a data.frame that will expand to accommodate these many-to-many relationships.
*   **GO Evidence Codes:** When querying GO terms, the results include evidence codes (e.g., IDA, TAS, IEA). Filter these if specific levels of evidence are required.
*   **Package Dependencies:** Ensure `AnnotationDbi` is loaded to use `select()`, `keys()`, and `columns()`.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)