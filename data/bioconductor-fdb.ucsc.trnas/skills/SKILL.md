---
name: bioconductor-fdb.ucsc.trnas
description: This package provides prefabricated FeatureDb objects for tRNA annotations from the UCSC Genome Browser for human, mouse, and rat genomes. Use when user asks to retrieve tRNA genomic coordinates, query tRNA metadata, or extract tRNA features for use with Bioconductor genomic interval tools.
homepage: https://bioconductor.org/packages/release/data/annotation/html/FDb.UCSC.tRNAs.html
---


# bioconductor-fdb.ucsc.trnas

name: bioconductor-fdb.ucsc.trnas
description: Access and use prefabricated FeatureDb objects for tRNA annotations from UCSC. Use this skill when you need to retrieve tRNA genomic coordinates, sequences, or metadata for human (hg18, hg19), mouse (mm9), or rat (rn4) genomes within the Bioconductor ecosystem.

# bioconductor-fdb.ucsc.trnas

## Overview

The `FDb.UCSC.tRNAs` package provides a collection of `FeatureDb` objects containing tRNA annotations sourced from the UCSC Genome Browser. These objects serve as specialized annotation databases that allow users to query tRNA locations and structures using standard Bioconductor genomic interval tools.

## Loading and Inspecting Data

To use the package, load the library and identify the specific database object corresponding to your organism and genome build.

```r
library(FDb.UCSC.tRNAs)

# List all available FeatureDb objects in the package
ls('package:FDb.UCSC.tRNAs')

# Available objects typically include:
# FDb.Hsapiens.UCSC.hg19.tRNAs (Human hg19)
# FDb.Hsapiens.UCSC.hg18.tRNAs (Human hg18)
# FDb.Mmusculus.UCSC.mm9.tRNAs (Mouse mm9)
# FDb.Rnorvegicus.UCSC.rn4.tRNAs (Rat rn4)

# Inspect a specific object
FDb.Hsapiens.UCSC.hg19.tRNAs
```

## Common Workflows

### Extracting tRNA Features

Since these are `FeatureDb` objects, you interact with them using functions from the `GenomicFeatures` and `AnnotationDbi` packages.

```r
library(GenomicFeatures)

# Get all tRNAs as a GRanges object
tRNAs <- features(FDb.Hsapiens.UCSC.hg19.tRNAs)

# Get tRNAs grouped by a specific attribute (if applicable)
# Note: FeatureDb is simpler than TxDb; use 'features' for general extraction
```

### Filtering and Querying

You can use the `select`, `keys`, and `columns` methods to retrieve specific metadata associated with the tRNA entries.

```r
# View available metadata columns
columns(FDb.Hsapiens.UCSC.hg19.tRNAs)

# View available keys (usually internal IDs)
k <- head(keys(FDb.Hsapiens.UCSC.hg19.tRNAs))

# Retrieve specific information
select(FDb.Hsapiens.UCSC.hg19.tRNAs, keys = k, columns = c("chrom", "start", "end", "strand"))
```

### Integration with Genomic Ranges

The output of these queries is typically a `GRanges` object, which can be used for:
- Overlapping with sequencing data (e.g., RNA-seq or ChIP-seq).
- Extracting sequences using `BSgenome` packages and `getSeq()`.
- Visualizing tRNA positions in tracks.

## Tips

- **Genome Builds**: Ensure the `FDb` object matches the genome build of your other data (e.g., do not use `hg19` annotations with `hg38` alignments).
- **FeatureDb vs TxDb**: `FeatureDb` is a lightweight version of `TxDb`. It is designed for simple genomic features like tRNAs that do not necessarily follow the complex exon/intron/transcript structure of protein-coding genes.
- **Standard Methods**: Use `transcripts()` or `transcriptsBy()` if you need to treat tRNAs as transcript units for downstream Bioconductor compatibility.

## Reference documentation

- [FDb.UCSC.tRNAs Reference Manual](./references/reference_manual.md)