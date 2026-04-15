---
name: bioconductor-roberts2005annotation.db
description: This package provides a SQLite-based interface for mapping manufacturer-specific identifiers from the Roberts 2005 dataset to genomic and functional metadata. Use when user asks to map probe IDs to gene symbols, retrieve functional annotations like GO terms or KEGG pathways, or translate between different identifier systems such as Entrez, Ensembl, and UniProt.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Roberts2005Annotation.db.html
---

# bioconductor-roberts2005annotation.db

## Overview

The `Roberts2005Annotation.db` package is a Bioconductor annotation data package that provides a SQLite-based interface for mapping manufacturer-specific identifiers to genomic and functional metadata. It is primarily used in bioinformatics workflows to annotate microarray results or translate between different identifier systems (e.g., mapping a probe ID to a Gene Symbol).

## Core Workflows

### Loading the Package and Exploring Columns
To begin, load the library and inspect the available annotation types (columns).

```R
library(Roberts2005Annotation.db)

# List available annotation types
columns(Roberts2005Annotation.db)

# List available key types (usually PROBEID)
keytypes(Roberts2005Annotation.db)
```

### Using the select() Interface
The `select()` function is the recommended modern interface for retrieving data.

```R
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("100_at", "101_at") # Replace with actual probe IDs
results <- select(Roberts2005Annotation.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official symbols (`SYMBOL`) or full names (`GENENAME`).
*   **Functional Annotation**: Map to Gene Ontology (`GO`) or KEGG pathways (`PATH`).
*   **External IDs**: Map to `ENSEMBL`, `REFSEQ`, `UNIPROT`, or `ACCNUM` (GenBank accession).
*   **Chromosomal Location**: Retrieve chromosome (`CHR`) and start/end positions (`CHRLOC`, `CHRLOCEND`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, specific mappings can be accessed via "Bimap" objects for quick list-based lookups.

```R
# Map Probes to Symbols
x <- Roberts2005AnnotationSYMBOL
mapped_probes <- mappedkeys(x)
symbol_list <- as.list(x[mapped_probes])

# Reverse mapping: Map Symbols to Probes
y <- Roberts2005AnnotationALIAS2PROBE
probe_list <- as.list(y)
```

### Database Information
To check the underlying database schema or connection details:

```R
# Get database metadata
Roberts2005Annotation_dbInfo()

# Get the organism for which this package was built
Roberts2005AnnotationORGANISM
```

## Tips and Best Practices
*   **Handling Multiple Matches**: Some probes may map to multiple GO terms or Entrez IDs. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
*   **GO Evidence Codes**: When mapping to `GO`, the output includes an `EVIDENCE` column. Use this to filter for high-confidence annotations (e.g., "IDA" for direct assay).
*   **Package Dependencies**: This package depends on `AnnotationDbi`. Ensure it is installed to use the `select()`, `keys()`, and `columns()` functions.

## Reference documentation
- [Roberts2005Annotation.db Reference Manual](./references/reference_manual.md)