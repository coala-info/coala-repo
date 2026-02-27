---
name: bioconductor-mouse4302.db
description: This package provides annotation data for the Affymetrix Mouse Genome 430 2.0 Array. Use when user asks to map probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouse4302.db.html
---


# bioconductor-mouse4302.db

name: bioconductor-mouse4302.db
description: Provides annotation data for the Affymetrix Mouse Genome 430 2.0 Array. Use this skill to map manufacturer probe identifiers to various biological metadata including Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `mouse4302.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Genome 430 2.0 Array. It provides a comprehensive set of mappings between manufacturer probe IDs and standard biological identifiers. While it supports the legacy "Bimap" interface, the modern and recommended way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(mouse4302.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (data to retrieve), and the keytype (type of input IDs).

```r
# 1. List available columns
columns(mouse4302.db)

# 2. List available keytypes
keytypes(mouse4302.db)

# 3. Perform a lookup (e.g., map probe IDs to Gene Symbols and Entrez IDs)
probes <- c("1415670_at", "1415671_at")
select(mouse4302.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols and Names**: Map probes to official symbols using `SYMBOL` or descriptive names using `GENENAME`.
*   **Gene Ontology (GO)**: Retrieve GO identifiers and evidence codes using the `GO` column.
*   **Pathways**: Map probes to KEGG pathway identifiers using the `PATH` column.
*   **External IDs**: Map to Ensembl (`ENSEMBL`), RefSeq (`REFSEQ`), or Uniprot (`UNIPROT`) identifiers.
*   **Chromosomal Location**: Find chromosome numbers (`CHR`) and start/end positions (`CHRLOC`, `CHRLOCEND`).

### Legacy Bimap Interface
For quick lookups or specific vector-based operations, you can use the older Bimap objects.

```r
# Convert a mapping to a list
sym_list <- as.list(mouse4302SYMBOL)
# Access a specific probe
sym_list[["1415670_at"]]

# Get all mapped keys
mapped_probes <- mappedkeys(mouse4302SYMBOL)
```

### Database Connection and Metadata
To inspect the underlying SQLite database or package metadata:
```r
# Get database metadata
mouse4302_dbInfo()

# Get the organism name
mouse4302ORGANISM

# Get chromosome lengths
mouse4302CHRLENGTHS
```

## Tips
*   **One-to-Many Mappings**: Note that a single probe ID can sometimes map to multiple Entrez IDs or GO terms. The `select()` function will return a data.frame with all possible combinations.
*   **Alias vs Symbol**: Use `mouse4302ALIAS2PROBE` if you are searching for common gene names that might not be the official symbol.
*   **Package Updates**: This package is updated biannually by Bioconductor; ensure you are using the version corresponding to your Bioconductor release for the most accurate annotations.

## Reference documentation
- [mouse4302.db Reference Manual](./references/reference_manual.md)