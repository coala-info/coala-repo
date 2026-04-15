---
name: bioconductor-sitadela
description: bioconductor-sitadela provides a unified interface for building and managing genomic interval annotations from multiple sources in a local SQLite database. Use when user asks to build genomic annotation databases, retrieve gene or transcript coordinates, manage custom GTF files, or fetch summarized exon data for RNA-Seq analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/sitadela.html
---

# bioconductor-sitadela

name: bioconductor-sitadela
description: Comprehensive genomic annotation management for Bioconductor. Use when needing to build, manage, or retrieve genomic interval annotations (genes, transcripts, exons, UTRs) for multiple organisms and sources (Ensembl, UCSC, RefSeq, NCBI). Supports local SQLite database creation for reproducibility and on-the-fly annotation fetching.

# bioconductor-sitadela

## Overview

The `sitadela` package (Simple Tab-Delimited Annotations) provides a unified interface for managing genomic interval data. It centralizes annotations for multiple organisms and versions into a single SQLite database, offering consistent access to gene, transcript, exon, and UTR coordinates along with metadata like GC content and biotypes.

## Typical Workflows

### 1. Database Setup and Building

By default, `sitadela` uses a database within the package directory. Use `setDbPath` to specify a custom location for persistence across sessions.

```r
library(sitadela)

# Set a custom database path
my_db <- "path/to/my_annotations.sqlite"
setDbPath(my_db)

# Define organisms and versions (e.g., Ensembl versions)
orgs <- list(hg38 = 110, mm10 = 102)
srcs <- c("ensembl", "refseq")

# Build the database (requires internet connection)
# Note: RefSeq/UCSC builds require Linux for Kent utilities
addAnnotation(organisms = orgs, sources = srcs, rc = 0.5)
```

### 2. Loading Annotations

Retrieve annotations as `GRanges` objects (default) or data frames.

```r
# Load gene annotations for Human hg38 from Ensembl
genes <- loadAnnotation(genome = "hg38", refdb = "ensembl", type = "gene")

# Load summarized exons for RNA-Seq analysis
exons <- loadAnnotation(genome = "mm10", refdb = "ensembl", type = "exon", summarized = TRUE)

# Load as a data frame instead of GRanges
genes_df <- loadAnnotation(genome = "hg38", refdb = "ensembl", type = "gene", asdf = TRUE)

# Fetch on-the-fly (if not in local DB)
# This happens automatically if the requested genome/source is missing from the DB
```

### 3. Adding Custom Annotations

Import non-supported organisms or custom versions using GTF/GFF files.

```r
# Prepare metadata
metadata <- list(
    organism = "my_custom_genome",
    source = "custom_lab",
    chromInfo = data.frame(length = c(1000000), row.names = c("chr1"))
)

# Add to database
addCustomAnnotation(gtfFile = "path/to/file.gtf", metadata = metadata)

# Retrieve custom data
custom_genes <- loadAnnotation(genome = "my_custom_genome", refdb = "custom_lab", type = "gene")
```

## Key Functions and Parameters

- `loadAnnotation()`: Main retrieval function.
    - `type`: "gene", "transcript", "utr", or "exon".
    - `summarized`: If `TRUE`, returns merged features (useful for read counting).
    - `asdf`: If `TRUE`, returns a `data.frame` instead of `GRanges`.
- `addAnnotation()`: Downloads and processes remote annotations into the local SQLite DB.
- `addCustomAnnotation()`: Processes a local GTF into the database.
- `removeAnnotation()`: Deletes specific entries from the local database.

## Tips for Effective Usage

- **GC Content**: To include GC content in annotations, ensure the corresponding `BSgenome` package (e.g., `BSgenome.Hsapiens.UCSC.hg38`) is installed before building the database.
- **OS Limitations**: Building RefSeq, UCSC, or NCBI annotations from scratch requires `genePredToGtf` (part of UCSC Kent utilities), which is generally unavailable on Windows. Use pre-built databases or Ensembl sources on Windows.
- **Versioning**: When using Ensembl, you can specify multiple versions in the `organisms` list (e.g., `hg38 = 100:102`) to maintain multiple annotation snapshots.

## Reference documentation

- [Building a simple annotation database](./references/sitadela.Rmd)
- [Building a simple annotation database](./references/sitadela.md)