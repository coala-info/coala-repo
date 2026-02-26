---
name: bioconductor-chicken.db
description: This package provides comprehensive SQLite-based annotation data for the chicken (Gallus gallus) genome. Use when user asks to map between gene identifiers, retrieve chromosomal locations, or look up GO terms and KEGG pathways for chicken genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/chicken.db.html
---


# bioconductor-chicken.db

name: bioconductor-chicken.db
description: Comprehensive annotation data for the chicken (Gallus gallus) genome. Use when mapping between different gene identifiers (Entrez, Ensembl, Symbol, RefSeq, Uniprot), looking up chromosomal locations, GO terms, KEGG pathways, or PubMed references for chicken genes.

# bioconductor-chicken.db

## Overview
The `chicken.db` package is a Bioconductor annotation data package that provides SQLite-based mappings for the chicken (Gallus gallus) genome. It is primarily used to translate between manufacturer-specific probe identifiers and various biological databases.

## Core Workflows

### Loading the Package
```R
library(chicken.db)
```

### Using the select() Interface
The `select()` interface from the `AnnotationDbi` package is the recommended way to interact with `chicken.db`.

1.  **List available columns:**
    ```R
    columns(chicken.db)
    ```
2.  **List available key types:**
    ```R
    keytypes(chicken.db)
    ```
3.  **Retrieve data:**
    ```R
    # Map probe IDs to Gene Symbols and Entrez IDs
    probes <- c("123_at", "456_at") # Example probe IDs
    select(chicken.db, keys = probes, columns = c("SYMBOL", "ENTREZID"), keytype = "PROBEID")
    ```

### Common Annotation Mappings
The package contains several specific objects for mapping (Bimaps). While `select()` is preferred, these are useful for quick lookups:

*   **Gene Symbols:** `chickenSYMBOL`
*   **Entrez Gene IDs:** `chickenENTREZID`
*   **Ensembl IDs:** `chickenENSEMBL`
*   **Gene Ontology (GO):** `chickenGO` (direct) or `chickenGO2ALLPROBES` (including child terms)
*   **KEGG Pathways:** `chickenPATH`
*   **Chromosomal Location:** `chickenCHR`, `chickenCHRLOC` (start), `chickenCHRLOCEND` (end)
*   **RefSeq Accessions:** `chickenREFSEQ`
*   **Uniprot Accessions:** `chickenUNIPROT`

### Example: Mapping Symbols to Probes
```R
# Using the Bimap interface to get probes for a specific alias
alias_list <- as.list(chickenALIAS2PROBE)
my_probes <- alias_list[["GAPDH"]]
```

### Genomic Metadata
To get information about the organism or the underlying database:
*   `chickenORGANISM`: Returns "Gallus gallus".
*   `chickenCHRLENGTHS`: Returns a named vector of chromosome lengths.
*   `chicken_dbschema()`: Prints the database schema.
*   `chicken_dbInfo()`: Prints package and data source metadata.

## Tips and Best Practices
*   **Consensus Mapping:** For `ENTREZID`, if a probe maps to multiple IDs, the package attempts to select a consensus or the smallest identifier.
*   **GO Evidence Codes:** When retrieving GO terms, pay attention to the `EVIDENCE` column (e.g., IDA, IEA, TAS) to understand the quality of the annotation.
*   **Reverse Mappings:** Many maps have reverse counterparts (e.g., `chickenGO2PROBE`, `chickenPATH2PROBE`) to find all probes associated with a specific biological term.
*   **Database Connection:** Use `chicken_dbconn()` if you need to perform direct SQL queries via the `DBI` package, but never call `dbDisconnect()` on this object.

## Reference documentation
- [chicken.db Reference Manual](./references/reference_manual.md)