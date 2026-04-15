---
name: bioconductor-pocrcannotation.db
description: This package provides SQLite-based annotation data for mapping POCRC platform probe identifiers to biological metadata. Use when user asks to map probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/POCRCannotation.db.html
---

# bioconductor-pocrcannotation.db

name: bioconductor-pocrcannotation.db
description: Provides annotation data for the POCRC (Pacific Northwest Prostate Cancer Research Consortium) platform. Use this skill to map manufacturer probe identifiers to various biological annotations including Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `POCRCannotation.db` package is a Bioconductor annotation data package that provides SQLite-based mappings for the POCRC platform. It allows researchers to translate probe-level data into biological context. The package primarily uses the `AnnotationDbi` interface, supporting both the modern `select()` workflow and the legacy `Bimap` (list-like) interface.

## Core Workflows

### Loading the Package
```R
library(POCRCannotation.db)
```

### Using the select() Interface
The recommended way to interact with this package is via `keys()`, `columns()`, and `select()`.

```R
# List available columns for mapping
columns(POCRCannotation.db)

# List available key types (usually PROBEID)
keytypes(POCRCannotation.db)

# Retrieve specific annotations for a set of probes
probes <- c("1001_at", "1002_at") # Example probe IDs
select(POCRCannotation.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official gene symbols (`SYMBOL`) or full names (`GENENAME`).
*   **External IDs**: Map to `ENTREZID`, `ENSEMBL`, `REFSEQ`, or `UNIPROT`.
*   **Functional Annotation**: Map to Gene Ontology (`GO`) or KEGG pathways (`PATH`).
*   **Chromosomal Location**: Map to chromosomes (`CHR`) or specific base-pair locations (`CHRLOC`).

### Legacy Bimap Interface
While `select()` is preferred, you can access specific maps directly as objects.

```R
# Convert a map to a list
sym_list <- as.list(POCRCannotationSYMBOL)

# Get symbols for the first 5 probes
sym_list[1:5]

# Reverse mapping (e.g., Symbols to Probes)
alias_to_probe <- as.list(POCRCannotationALIAS2PROBE)
```

### Database Metadata
To inspect the underlying database or schema:
```R
# Get database connection info
POCRCannotation_dbInfo()

# Get the organism for which this package was built
POCRCannotationORGANISM
```

## Tips and Best Practices
*   **Handling Multiple Matches**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data.frame with one row per mapping, which may result in more rows than input keys.
*   **GO Evidence Codes**: When mapping to `GO`, use the `EVIDENCE` column to filter by the type of supporting data (e.g., "IDA" for direct assay).
*   **Package Updates**: These annotation packages are typically updated biannually by Bioconductor. Ensure you are using the version that matches your data's original processing date if reproducibility is a concern.

## Reference documentation
- [POCRCannotation.db Reference Manual](./references/reference_manual.md)