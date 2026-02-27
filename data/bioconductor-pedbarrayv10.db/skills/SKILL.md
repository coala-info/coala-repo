---
name: bioconductor-pedbarrayv10.db
description: This package provides comprehensive mappings between manufacturer-specific identifiers for the pedbarrayv10 platform and various biological identifiers. Use when user asks to map probe identifiers to gene symbols, retrieve Entrez Gene or Ensembl IDs, or perform functional annotation using GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pedbarrayv10.db.html
---


# bioconductor-pedbarrayv10.db

name: bioconductor-pedbarrayv10.db
description: A specialized skill for using the Bioconductor annotation package pedbarrayv10.db. Use this skill when you need to map manufacturer probe identifiers for the pedbarrayv10 platform to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) or perform genomic annotation tasks in R.

# bioconductor-pedbarrayv10.db

## Overview

The `pedbarrayv10.db` package is a Bioconductor annotation data package that provides comprehensive mappings between manufacturer-specific identifiers for the pedbarrayv10 platform and various biological databases. It is built using the SQLite database technology and is primarily accessed through the `AnnotationDbi` interface.

## Core Workflows

### Loading the Package
```R
library(pedbarrayv10.db)
```

### Using the select() Interface
The preferred method for interacting with this package is the `select()` function from `AnnotationDbi`.

```R
# List available columns (types of data)
columns(pedbarrayv10.db)

# List available keytypes (types of input identifiers)
keytypes(pedbarrayv10.db)

# Retrieve specific annotations
probes <- head(keys(pedbarrayv10.db))
res <- select(pedbarrayv10.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official gene symbols (`SYMBOL`) or full gene names (`GENENAME`).
*   **External IDs**: Map to Entrez Gene IDs (`ENTREZID`), Ensembl IDs (`ENSEMBL`), or RefSeq accessions (`REFSEQ`).
*   **Functional Annotation**: Map to Gene Ontology (`GO`) terms or KEGG pathways (`PATH`).
*   **Chromosomal Location**: Retrieve chromosome numbers (`CHR`), start positions (`CHRLOC`), or end positions (`CHRLOCEND`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, the package supports the older Bimap interface for specific tasks like list conversions.

```R
# Convert a map to a list
symbol_list <- as.list(pedbarrayv10SYMBOL)

# Get mapped keys
mapped_probes <- mappedkeys(pedbarrayv10ACCNUM)

# Reverse mapping (e.g., Symbol to Probe)
alias_to_probe <- as.list(pedbarrayv10ALIAS2PROBE)
```

### Database Connection and Metadata
To inspect the underlying database or schema:

```R
# Get database connection
conn <- pedbarrayv10_dbconn()

# View database schema
pedbarrayv10_dbschema()

# Get organism information
pedbarrayv10ORGANISM
```

## Tips and Best Practices
*   **One-to-Many Mappings**: Be aware that some probes may map to multiple identifiers (e.g., multiple GO terms). The `select()` function will return a data frame with multiple rows for these cases.
*   **Filtering GO Terms**: When retrieving GO annotations, the results include the Evidence code and Ontology (BP, CC, MF). Use these to filter for high-confidence or specific biological categories.
*   **Package Updates**: This package is updated biannually; ensure you are using the version corresponding to your Bioconductor release for the most current mappings.

## Reference documentation

- [pedbarrayv10.db Reference Manual](./references/reference_manual.md)