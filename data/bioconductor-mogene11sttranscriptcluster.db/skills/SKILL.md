---
name: bioconductor-mogene11sttranscriptcluster.db
description: This package provides annotation data for the Affymetrix Mouse Gene 1.1 ST Transcript Cluster array. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve gene symbols or Entrez IDs for mouse transcriptomic data, and perform functional annotation using GO terms or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene11sttranscriptcluster.db.html
---

# bioconductor-mogene11sttranscriptcluster.db

name: bioconductor-mogene11sttranscriptcluster.db
description: Provides annotation data for the Affymetrix Mouse Gene 1.1 ST Transcript Cluster array. Use when mapping manufacturer probe identifiers to biological metadata (Entrez IDs, Gene Symbols, GO terms, etc.) or vice versa for mouse transcriptomic data.

# bioconductor-mogene11sttranscriptcluster.db

## Overview

The `mogene11sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Gene 1.1 ST Transcript Cluster array. It provides mappings between manufacturer probe identifiers and various gene-centric identifiers for *Mus musculus*. The primary interface for querying this data is the `select()` function from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package

```r
library(mogene11sttranscriptcluster.db)
```

### Querying with the select() Interface

The `select()` interface is the recommended method for retrieving data.

1.  **List available columns**:
    ```r
    columns(mogene11sttranscriptcluster.db)
    ```
2.  **List available keytypes**:
    ```r
    keytypes(mogene11sttranscriptcluster.db)
    ```
3.  **Retrieve specific annotations**:
    ```r
    probes <- c("10341561", "10341565", "10341574")
    select(mogene11sttranscriptcluster.db, 
           keys = probes, 
           columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
           keytype = "PROBEID")
    ```

### Using Legacy Bimap Objects

While `select()` is preferred, bimap objects allow for list-style access and reverse mapping.

*   **Convert a map to a list**:
    ```r
    # Map Probes to Symbols
    symbol_list <- as.list(mogene11sttranscriptclusterSYMBOL)
    # Access a specific probe
    symbol_list[["10341561"]]
    ```
*   **Get mapped keys**:
    ```r
    mapped_probes <- mappedkeys(mogene11sttranscriptclusterENTREZID)
    ```
*   **Reverse mapping**:
    ```r
    # Map Symbols back to Probes
    alias_to_probe <- as.list(mogene11sttranscriptclusterALIAS2PROBE)
    ```

### Common Annotation Mappings

*   **Gene Identification**: `SYMBOL` (Official Symbol), `GENENAME` (Full Name), `ENTREZID` (Entrez Gene ID), `ENSEMBL` (Ensembl ID).
*   **Functional Annotation**: `GO` (Gene Ontology), `PATH` (KEGG Pathways), `ENZYME` (EC Numbers).
*   **Positional Data**: `CHR` (Chromosome), `CHRLOC` (Start position), `CHRLOCEND` (End position).
*   **External References**: `REFSEQ` (RefSeq IDs), `UNIPROT` (UniProt accessions), `MGI` (Mouse Genome Informatics IDs).

### Database Connection Information

To inspect the underlying SQLite database:
```r
# Get database connection
conn <- mogene11sttranscriptcluster_dbconn()
# Get database file path
dbfile <- mogene11sttranscriptcluster_dbfile()
# Show database schema
mogene11sttranscriptcluster_dbschema()
```

## Tips and Best Practices

*   **Handle Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. `select()` returns a data.frame with all possible combinations; be prepared to handle duplicate keys in the output.
*   **GO Evidence Codes**: When querying `GO`, the output includes evidence codes (e.g., IDA, IEA, TAS). Filter these if only high-confidence experimental evidence is required.
*   **Check Organism**: Confirm the organism is *Mus musculus* using `mogene11sttranscriptclusterORGANISM`.
*   **Avoid Deprecated Functions**: Do not use `mogene11sttranscriptclusterMAPCOUNTS` as it is deprecated and may be out of sync. Use `length(mappedkeys(x))` instead.

## Reference documentation

- [mogene11sttranscriptcluster.db Reference Manual](./references/reference_manual.md)