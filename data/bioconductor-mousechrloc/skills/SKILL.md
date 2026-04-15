---
name: bioconductor-mousechrloc
description: This tool provides annotation data for mouse gene locations, including transcription start and end positions, cytoband locations, and chromosome mappings for Entrez Gene IDs. Use when user asks to retrieve genomic coordinates, map Entrez IDs to chromosomes, or find cytoband locations for Mus musculus genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mouseCHRLOC.html
---

# bioconductor-mousechrloc

name: bioconductor-mousechrloc
description: Provides annotation data for mouse gene locations, including transcription start and end positions, cytoband locations, and Entrez Gene ID to chromosome mappings. Use when Claude needs to retrieve genomic coordinates or chromosomal assignments for Mus musculus genes using the mouseCHRLOC Bioconductor package.

## Overview

The `mouseCHRLOC` package is a Bioconductor annotation data package containing mappings between Entrez Gene identifiers and their physical locations on mouse chromosomes. It provides specific start and end coordinates for transcription, as well as cytoband information. The data is organized into environment objects, typically separated by chromosome and by start/end position.

## Core Workflows

### Loading the Package and Data

To use the package, load it into the R session. You should also have the `annotate` package available for standard environment interactions.

```R
library(mouseCHRLOC)
library(annotate)

# View quality control and build information
mouseCHRLOC()
```

### Mapping Entrez IDs to Chromosomes

Use `mouseCHRLOCENTREZID2CHR` to find which chromosome a specific Entrez Gene ID resides on.

```R
# Convert environment to list for easier access
chr_map <- as.list(mouseCHRLOCENTREZID2CHR)

# Get chromosome for a specific Entrez ID (e.g., "12345")
chr_map[["12345"]]
```

### Retrieving Transcription Start and End Positions

The package provides separate environments for the start and end positions of genes on each chromosome (1-19, X, Y). 

*   **Naming Convention**: `mouseCHRLOC[CHR][START/END]`
    *   Example: `mouseCHRLOC10START` for start positions on Chromosome 10.
    *   Example: `mouseCHRLOCXEND` for end positions on Chromosome X.

```R
# Get start positions for genes on Chromosome 1
start_pos_chr1 <- as.list(mouseCHRLOC1START)

# Retrieve position for a specific Entrez ID
# Positive values = Sense strand
# Negative values = Antisense strand (leading "-" sign)
pos <- start_pos_chr1[["11287"]]
```

### Working with Cytoband Locations

The `mouseCHRLOCCYTOLOC` object maps chromosome numbers to the base pair ranges of specific cytobands.

```R
bands <- as.list(mouseCHRLOCCYTOLOC)

# Get all cytobands on Chromosome 1
names(bands[[1]])

# Get start and end locations for the first band on Chromosome 1
bands[[1]][[1]]
```

## Data Interpretation Tips

1.  **Strand Orientation**: Transcription positions for genes on the antisense strand are represented as negative integers. The absolute value represents the distance from the p-arm (5' end of the sense strand).
2.  **Confidence Levels**: Values are often returned as named vectors. A name of "Confident" indicates a reliable placement, while "Unconfident" (often suffixed with `_random` in source data) indicates the gene cannot be placed with high certainty.
3.  **Environment Access**: While `as.list()` is convenient for small lookups, for high-performance mapping, use `get()` or `mget()` directly on the environment objects to avoid the memory overhead of list conversion.

## Reference documentation

- [mouseCHRLOC Reference Manual](./references/reference_manual.md)