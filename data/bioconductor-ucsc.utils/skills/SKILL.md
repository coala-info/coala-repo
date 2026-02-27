---
name: bioconductor-ucsc.utils
description: This tool provides low-level utilities for retrieving genomic data and metadata from the UCSC Genome Browser via REST API or MySQL. Use when user asks to list available genome assemblies, fetch chromosome sizes, discover data tracks, or download specific track data and SQL tables.
homepage: https://bioconductor.org/packages/release/bioc/html/UCSC.utils.html
---


# bioconductor-ucsc.utils

name: bioconductor-ucsc.utils
description: Low-level utilities for retrieving data from the UCSC Genome Browser via REST API or MySQL. Use this skill when you need to list available UCSC genomes, fetch chromosome sizes, discover available tracks, or download specific track data and SQL tables for genomic analysis.

## Overview

The `UCSC.utils` package provides infrastructure for interacting with the UCSC Genome Browser. It serves as a foundational tool for higher-level Bioconductor packages (like `GenomeInfoDb` and `txdbmaker`) but can be used directly to query UCSC metadata and track data.

## Core Functions

### Genome and Chromosome Discovery

*   `list_UCSC_genomes(organism)`: Lists available genome assemblies for a specific organism (e.g., "human", "mouse", "cat").
*   `get_UCSC_chrom_sizes(genome)`: Retrieves a named vector of chromosome lengths for a specific assembly (e.g., "hg38", "mm10").

### Track Exploration

*   `list_UCSC_tracks(genome, group)`: Lists available data tracks for a genome. You can filter by `group` (e.g., "varRep" for variation and repeats, "genes" for gene predictions).

### Data Retrieval

*   `fetch_UCSC_track_data(genome, track)`: Downloads data for a specific track. Returns a data frame.
*   `UCSC_dbselect(genome, table, columns, where)`: A more powerful and efficient alternative to `fetch_UCSC_track_data`. It queries the UCSC MySQL server directly, allowing for column selection and SQL-style filtering.

## Typical Workflows

### Finding a Genome Assembly
```r
library(UCSC.utils)

# Find available assemblies for Cat
cats <- list_UCSC_genomes("cat")
# Identify the latest version, e.g., "felCat9"
```

### Getting Chromosome Information
```r
# Get sizes for all chromosomes in hg38
hg38_sizes <- get_UCSC_chrom_sizes("hg38")
head(hg38_sizes)
```

### Downloading Gene Annotations
```r
# List tracks related to genes for mm10
gene_tracks <- list_UCSC_tracks("mm10", group="genes")

# Fetch the refGene table for a specific assembly
refGene_data <- fetch_UCSC_track_data("mm10", "refGene")

# OR: Use UCSC_dbselect for a more targeted query (more efficient)
# Only get specific columns for chromosome 1
cols <- c("chrom", "txStart", "txEnd", "name2")
chr1_genes <- UCSC_dbselect("mm10", "refGene", 
                            columns = cols, 
                            where = "chrom='chr1'")
```

## Usage Tips

*   **Efficiency**: Prefer `UCSC_dbselect` over `fetch_UCSC_track_data` when you only need a subset of columns or specific rows, as it reduces the amount of data transferred.
*   **MySQL Limitations**: Note that while `UCSC_dbselect` is faster, it may not work for all tracks (specifically those not stored in the standard MySQL tables).
*   **Downstream Integration**: If you are building a `TxDb` object or managing `Seqinfo`, these functions provide the raw data needed to populate those objects.

## Reference documentation

- [The UCSC.utils package](./references/UCSC.utils.md)