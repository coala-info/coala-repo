---
name: bioconductor-mus.musculus
description: This package provides a unified interface for mouse genomic annotations by integrating gene, transcript, and functional data into a single object. Use when user asks to map mouse gene identifiers, retrieve genomic coordinates for mouse features, or link genes to Gene Ontology terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Mus.musculus.html
---


# bioconductor-mus.musculus

name: bioconductor-mus.musculus
description: Annotation package for Mus musculus (mouse) that collates multiple resources (OrgDb, TxDb, GO.db) into a single OrganismDb object. Use this skill when an AI agent needs to map between mouse gene identifiers (Entrez, Ensembl, Symbol), genomic coordinates, and functional annotations (GO terms) using the standard AnnotationDbi interface.

# bioconductor-mus.musculus

## Overview
The `Mus.musculus` package is an `OrganismDb` object that simplifies mouse genomic data retrieval by acting as a unified interface for several underlying Bioconductor annotation packages. It integrates gene-centric data (from `org.Mm.eg.db`), transcript-centric data (from `TxDb.Mmusculus.UCSC.mm10.knownGene`), and functional data (from `GO.db`).

## Core Workflow
The package follows the standard `AnnotationDbi` paradigm using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Discovery
Before querying, identify what data is available and what identifiers you can use as input.

```r
library(Mus.musculus)

# See all available data types (columns)
cols <- columns(Mus.musculus)

# See all possible input identifier types
kts <- keytypes(Mus.musculus)
```

### 2. Data Retrieval
Use `select()` to map identifiers to specific information.

```r
# Example: Map Entrez IDs to Gene Symbols and Chromosomes
my_keys <- c("11430", "12345") # Example Entrez IDs
res <- select(Mus.musculus, 
              keys = my_keys, 
              columns = c("SYMBOL", "CHR", "GENENAME"), 
              keytype = "ENTREZID")
```

### 3. Genomic Coordinates
Since `Mus.musculus` contains a `TxDb` object, you can use `GenomicFeatures` methods to extract spatial information.

```r
# Get all mouse genes as a GRanges object
mouse_genes <- genes(Mus.musculus)

# Get promoters for all transcripts
mouse_promoters <- promoters(Mus.musculus, upstream = 2000, downstream = 200)
```

## Tips for Effective Use
- **Ambiguity**: When mapping between different databases (e.g., GO terms to Symbols), one key may return multiple rows. Always check for 1:many mappings in the resulting data frame.
- **Filtering**: Use the `keys` argument to limit the scope of your query; calling `select()` without specific keys on a large object can be memory-intensive.
- **OrganismDb Advantage**: Unlike using a standalone `TxDb`, `Mus.musculus` allows you to query `SYMBOL` or `GO` terms directly alongside genomic coordinates without manual merging.

## Reference documentation
- [Mus.musculus Reference Manual](./references/reference_manual.md)