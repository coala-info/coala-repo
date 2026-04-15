---
name: bioconductor-organism.dplyr
description: This tool creates and queries integrated organism-specific databases by combining genomic coordinates and functional annotations through a dplyr-compatible interface. Use when user asks to join TxDb and OrgDb data, perform SQL-like queries on genomic annotations, or extract filtered genomic ranges for specific genes and transcripts.
homepage: https://bioconductor.org/packages/release/bioc/html/Organism.dplyr.html
---

# bioconductor-organism.dplyr

name: bioconductor-organism.dplyr
description: Create and query integrated organism-specific databases using dplyr and AnnotationDbi interfaces. Use this skill when you need to join genomic coordinates (TxDb) with functional annotations (OrgDb) for organisms like Human, Mouse, or Rat, or when you need to perform complex SQL-like queries on Bioconductor annotation objects.

# bioconductor-organism.dplyr

## Overview

`Organism.dplyr` provides a `dplyr` interface to integrated genomic databases. It combines the genomic coordinates of a `TxDb` object with the gene annotations of an `OrgDb` object into a single, on-disk SQLite database. This allows for seamless joining of data (e.g., linking GO terms to genomic ranges) using standard `dplyr` verbs or traditional `AnnotationDbi` methods.

## Core Workflows

### 1. Constructing a src_organism

The `src_organism` object is the central handle for the database.

```r
library(Organism.dplyr)

# Create from a specific TxDb package (automatically finds matching OrgDb)
src <- src_organism("TxDb.Hsapiens.UCSC.hg38.knownGene")

# Create using common names (uses most recent TxDb)
src <- src_ucsc("human")

# List all supported organisms and their associated packages
supportedOrganisms()
```

### 2. The dplyr Interface

You can treat the `src_organism` object as a database source for `dplyr` operations.

```r
# List available tables
src_tbls(src)

# Query a table (e.g., 'id' table containing symbols and ensembl IDs)
tbl(src, "id") %>%
    filter(symbol == "ADA") %>%
    select(entrez, ensembl, symbol) %>%
    collect()

# Join annotation data with genomic ranges
inner_join(tbl(src, "id"), tbl(src, "ranges_gene")) %>%
    filter(symbol %in% c("ADA", "NAT2")) %>%
    collect()
```

### 3. The select Interface

Standard `AnnotationDbi` methods work directly on the `src_organism` object.

```r
# Discover available keys and columns
keytypes(src)
columns(src)

# Retrieve data
keys <- c("ADA", "NAT2")
select(src, keys = keys, columns = c("TXNAME", "ENTREZID"), keytype = "SYMBOL")

# Use mapIds for 1-to-1 or 1-to-many mapping
mapIds(src, keys = keys, column = "TXNAME", keytype = "SYMBOL", multiVals = "CharacterList")
```

### 4. Genomic Coordinates Extractors

Extract genomic features as `GRanges` or `tibbles` with built-in filtering.

```r
# Extract as tibble
transcripts_tbl(src, filter = ~ symbol == "ADA")

# Extract as GRanges
genes(src, filter = ~ symbol %in% c("ADA", "NAT2"))

# Complex filtering using AnnotationFilter syntax
# Supported filters: SymbolFilter, EntrezFilter, TxStartFilter, etc.
transcripts(src, filter = ~ symbol == "ADA" & tx_start < 44619810)
```

## Available Tables and Fields

- **id**: Basic identifiers (entrez, symbol, ensembl, genename).
- **id_go**: Gene Ontology annotations.
- **ranges_gene / ranges_tx / ranges_exon**: Genomic coordinates for genes, transcripts, and exons.
- **id_protein**: Protein-level identifiers.

## Tips

- **Persistence**: By default, `src_organism()` creates a temporary SQLite file. Provide a `path` argument to save the database for future sessions: `src_organism(txdb_pkg, path = "my_organism.sqlite")`.
- **Performance**: Use `collect()` only when you need to bring the final result into R memory. Keep operations in the database (SQL) as long as possible for large datasets.
- **Filters**: Use `supportedFilters(src)` to see all valid fields for the formula-based filtering interface.

## Reference documentation

- [Organism.dplyr](./references/Organism.dplyr.md)