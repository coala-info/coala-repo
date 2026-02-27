---
name: bioconductor-rgu34a.db
description: This package provides annotation data for the Affymetrix Rat Genome U34A chip. Use when user asks to map probe identifiers to gene symbols, retrieve Entrez IDs, find GO terms, or access KEGG pathway information for rat genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgu34a.db.html
---


# bioconductor-rgu34a.db

name: bioconductor-rgu34a.db
description: Provides annotation data for the Affymetrix Rat Genome U34A (rgu34a) chip. Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) and to retrieve genomic metadata for Rattus norvegicus.

## Overview

The `rgu34a.db` package is a Bioconductor annotation data package for the Affymetrix Rat Genome U34A platform. It provides a comprehensive set of mappings between manufacturer probe IDs and standard biological identifiers. While it supports older "Bimap" interfaces, the modern and preferred method for interaction is the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```R
library(rgu34a.db)
```

### Exploring Available Data
To see which types of data (columns) can be retrieved and which keys can be used for filtering:
```R
# List available columns
columns(rgu34a.db)

# List available key types (usually includes PROBEID)
keytypes(rgu34a.db)

# Get a sample of probe IDs
head(keys(rgu34a.db, keytype="PROBEID"))
```

### Using the select() Interface
The `select()` function is the primary way to retrieve data. It requires the database object, the keys (probe IDs), the columns you want to retrieve, and the keytype of the input keys.

```R
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
res <- select(rgu34a.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Ontology (GO):** Retrieve GO terms and evidence codes.
    ```R
    select(rgu34a.db, keys = "1000_at", columns = c("GO", "ONTOLOGY", "EVIDENCE"), keytype = "PROBEID")
    ```
*   **Pathways:** Map probes to KEGG pathway identifiers.
    ```R
    select(rgu34a.db, keys = "1000_at", columns = "PATH", keytype = "PROBEID")
    ```
*   **Chromosomal Location:** Find the chromosome and start/end positions.
    ```R
    select(rgu34a.db, keys = "1000_at", columns = c("CHR", "CHRLOC", "CHRLOCEND"), keytype = "PROBEID")
    ```
*   **External Accessions:** Map to RefSeq, Ensembl, or Uniprot.
    ```R
    select(rgu34a.db, keys = "1000_at", columns = c("REFSEQ", "ENSEMBL", "UNIPROT"), keytype = "PROBEID")
    ```

### Database Connection and Metadata
To inspect the underlying SQLite database or check the organism:
```R
# Get organism name
rgu34aORGANISM

# Get database schema
rgu34a_dbschema()

# Get number of rows in the probes table via SQL
library(DBI)
dbGetQuery(rgu34a_dbconn(), "SELECT COUNT(*) FROM probes")
```

## Tips and Best Practices
*   **Bimap vs. select():** While you may see older code using `as.list(rgu34aSYMBOL)`, the `select()` interface is more robust and consistent across Bioconductor.
*   **Handling 1:Many Mappings:** Some probes map to multiple genes or GO terms. `select()` will return a data frame with multiple rows for a single input key in these cases.
*   **Alias Mapping:** If you have gene symbols and need probe IDs, use `rgu34aALIAS2PROBE`. Note that aliases are not official symbols and may map to multiple probes.

## Reference documentation
- [rgu34a.db Reference Manual](./references/reference_manual.md)