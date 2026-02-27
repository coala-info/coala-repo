---
name: bioconductor-mu19ksuba.db
description: This package provides SQLite-based annotation mappings for the mu19ksuba mouse microarray platform. Use when user asks to map mu19ksuba probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu19ksuba.db.html
---


# bioconductor-mu19ksuba.db

name: bioconductor-mu19ksuba.db
description: An annotation data package for the mu19ksuba platform (Mus musculus). Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) and genomic locations.

# bioconductor-mu19ksuba.db

## Overview

The `mu19ksuba.db` package is a Bioconductor annotation data package for the mu19ksuba mouse microarray platform. It provides SQLite-based mappings between manufacturer probe identifiers and various biological databases. While it supports older "Bimap" interfaces, the modern and recommended way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package

```R
library(mu19ksuba.db)
```

### Using the select() Interface

The `select()` function is the primary method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```R
# List available columns
columns(mu19ksuba.db)

# List available keytypes
keytypes(mu19ksuba.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
select(mu19ksuba.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols**: Use the `SYMBOL` column for official symbols or `ALIAS` for common aliases.
- **Gene Ontology (GO)**: Use the `GO` column to get GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
- **Pathways**: Use the `PATH` column for KEGG pathway identifiers.
- **Genomic Location**: Use `CHR` (Chromosome), `CHRLOC` (Start position), and `CHRLOCEND` (End position).
- **External IDs**: Map to `ENSEMBL`, `REFSEQ`, `UNIPROT`, or `MGI` (Mouse Genome Informatics).

### Using the Bimap Interface (Legacy)

For specific reverse mappings or quick lookups, the Bimap objects can be used:

```R
# Map Symbols to Probes
x <- mu19ksubaALIAS2PROBE
mapped_probes <- mappedkeys(x)
as.list(x[mapped_probes][1:5])

# Get Chromosome lengths
mu19ksubaCHRLENGTHS["1"]
```

### Database Connection and Metadata

To inspect the underlying SQLite database:

```R
# Get database metadata
mu19ksuba_dbInfo()

# Get the database schema
mu19ksuba_dbschema()

# Get the organism for which this package was built
mu19ksubaORGANISM
```

## Tips and Best Practices

- **Consensus Mapping**: For `ENTREZID` mappings, if a probe maps to multiple identifiers, the package attempts to select a consensus or the smallest identifier.
- **GO Evidence**: When retrieving GO terms, pay attention to the `EVIDENCE` column to understand the quality of the annotation (e.g., IDA: Inferred from Direct Assay vs. IEA: Inferred from Electronic Annotation).
- **Vectorized Operations**: Always prefer passing a vector of keys to `select()` rather than looping over individual IDs for significantly better performance.

## Reference documentation

- [mu19ksuba.db Reference Manual](./references/reference_manual.md)