---
name: bioconductor-org.ecsakai.eg.db
description: This package provides organism-level genome annotations for Escherichia coli Sakai using Entrez Gene identifiers as central keys. Use when user asks to map gene identifiers, retrieve functional annotations like GO terms or KEGG pathways, or perform cross-referencing for E. coli Sakai genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.EcSakai.eg.db.html
---

# bioconductor-org.ecsakai.eg.db

## Overview

The `org.EcSakai.eg.db` package is a Bioconductor organism-level annotation database for *Escherichia coli* Sakai. It primarily uses Entrez Gene identifiers as the central keys to map to other identifiers. This package is essential for bioinformatics workflows involving E. coli Sakai, such as RNA-seq analysis, functional enrichment, or gene characterization.

## Core Workflows

### Loading the Database
```R
library(org.EcSakai.eg.db)
```

### Using the select() Interface
The recommended way to interact with the database is using the `select`, `keys`, `columns`, and `keytypes` functions from the `AnnotationDbi` package.

```R
# List available annotation types (columns)
columns(org.EcSakai.eg.db)

# List available key types (usually same as columns)
keytypes(org.EcSakai.eg.db)

# Retrieve specific annotations for a set of Entrez IDs
gene_ids <- c("912499", "912500") # Example Entrez IDs
select(org.EcSakai.eg.db, 
       keys = gene_ids, 
       columns = c("SYMBOL", "GENENAME", "GO"), 
       keytype = "ENTREZID")
```

### Common Mapping Tasks

*   **Gene Symbols to Entrez IDs:** Use `ALIAS` or `SYMBOL`. Note that `ALIAS` includes unofficial/historical symbols.
    ```R
    select(org.EcSakai.eg.db, keys = "ECs0001", columns = "ENTREZID", keytype = "SYMBOL")
    ```
*   **Functional Annotation (GO/Pathway):**
    ```R
    # Get KEGG pathways
    select(org.EcSakai.eg.db, keys = "912499", columns = "PATH", keytype = "ENTREZID")
    
    # Get GO terms with evidence codes
    select(org.EcSakai.eg.db, keys = "912499", columns = c("GO", "EVIDENCE", "ONTOLOGY"), keytype = "ENTREZID")
    ```
*   **Cross-References:** Map to `REFSEQ`, `ACCNUM` (GenBank), or `ENZYME` (EC numbers).

### Legacy Bimap Interface
While `select()` is preferred, you can use the older Bimap interface for specific list-based operations.

```R
# Convert a map to a list
accnum_list <- as.list(org.EcSakai.egACCNUM)

# Reverse mapping (e.g., Symbol to Entrez ID)
symbol_to_eg <- as.list(org.EcSakai.egSYMBOL2EG)
```

## Key Annotation Objects

*   `org.EcSakai.egSYMBOL`: Official gene symbols.
*   `org.EcSakai.egALIAS2EG`: Maps common aliases to Entrez Gene IDs.
*   `org.EcSakai.egGO`: Gene Ontology assignments (direct evidence only).
*   `org.EcSakai.egGO2ALLEGS`: All GO assignments including child nodes (useful for enrichment).
*   `org.EcSakai.egPATH`: KEGG pathway identifiers.
*   `org.EcSakai.egGENENAME`: Full descriptive gene names.

## Tips and Best Practices

1.  **Avoid Symbols as Primary Keys:** Gene symbols can change or be redundant. Always prefer Entrez Gene IDs (`ENTREZID`) or RefSeq IDs for stable data processing.
2.  **GO Evidence Codes:** When using GO annotations, pay attention to the `EVIDENCE` column. `IEA` (Inferred from Electronic Annotation) is common but less reliable than experimental codes like `IDA`.
3.  **Database Connection:** You can inspect the underlying SQLite metadata using `org.EcSakai.eg_dbInfo()`. Do not manually disconnect the connection returned by `org.EcSakai.eg_dbconn()`.

## Reference documentation

- [org.EcSakai.eg.db Reference Manual](./references/reference_manual.md)