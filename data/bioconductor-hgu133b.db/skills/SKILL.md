---
name: bioconductor-hgu133b.db
description: This package provides annotation data for the Affymetrix Human Genome U133 Plus 2.0 Array. Use when user asks to map manufacturer probe identifiers to biological identifiers like Gene Symbols, Entrez IDs, or GO terms and retrieve chromosomal locations for the hgu133b platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu133b.db.html
---

# bioconductor-hgu133b.db

name: bioconductor-hgu133b.db
description: Provides annotation data for the Affymetrix Human Genome U133 Plus 2.0 Array (hgu133b). Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, RefSeq, Ensembl, GO, KEGG) and chromosomal locations.

# bioconductor-hgu133b.db

## Overview

The `hgu133b.db` package is a Bioconductor annotation data package for the Affymetrix hgu133b platform. It provides a stable environment for mapping probe set IDs to genomic, functional, and publication-based metadata. It primarily uses the `AnnotationDbi` interface for data retrieval.

## Installation and Loading

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hgu133b.db")

library(hgu133b.db)
```

## Core Workflows

### Using the select() Interface
The preferred method for interacting with this package is the `select()` function from `AnnotationDbi`.

```R
# View available columns (types of data)
columns(hgu133b.db)

# View available keytypes (types of input identifiers)
keytypes(hgu133b.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("200000_s_at", "200001_at")
select(hgu133b.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mappings
- **Gene Symbols**: Map probes to official gene abbreviations using `hgu133bSYMBOL`.
- **Entrez Gene IDs**: Map probes to NCBI Entrez Gene identifiers using `hgu133bENTREZID`.
- **Chromosomal Location**: Find the start position and chromosome using `hgu133bCHRLOC` and `hgu133bCHR`.
- **Gene Ontology (GO)**: Retrieve functional annotations using `hgu133bGO`.
- **Pathways**: Map probes to KEGG pathway identifiers using `hgu133bPATH`.

### Using the Bimap Interface (Legacy)
While `select()` is preferred, the "Bimap" interface allows for list-like access.

```R
# Convert a mapping to a list
sym_list <- as.list(hgu133bSYMBOL)

# Get symbols for specific probes
sym_list[c("200000_s_at", "200001_at")]

# Reverse mapping (e.g., Symbols to Probes)
alias_to_probe <- as.list(hgu133bALIAS2PROBE)
```

## Database Information
To inspect the underlying SQLite database:
- `hgu133b_dbconn()`: Returns the connection object.
- `hgu133b_dbschema()`: Displays the table schemas.
- `hgu133b_dbInfo()`: Provides metadata about the data sources and build dates.

## Tips
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with one row per mapping (potentially multiple rows per input key).
- **Evidence Codes**: When querying GO terms, pay attention to the `EVIDENCE` column to understand the quality of the annotation (e.g., IDA: Inferred from Direct Assay, IEA: Inferred from Electronic Annotation).
- **Organism**: This package is specific to *Homo sapiens*. Use `hgu133bORGANISM` to confirm.

## Reference documentation
- [hgu133b.db Reference Manual](./references/reference_manual.md)