---
name: bioconductor-bsgenome.hsapiens.ncbi.t2t.chm13v2.0
description: This package provides the complete T2T-CHM13v2.0 human genome assembly as a BSgenome object for use in R. Use when user asks to access the full human genome sequence, perform genome-wide motif searching, or extract specific chromosomal sequences from the CHM13v2.0 reference.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0.html
---


# bioconductor-bsgenome.hsapiens.ncbi.t2t.chm13v2.0

name: bioconductor-bsgenome.hsapiens.ncbi.t2t.chm13v2.0
description: Provides the T2T-CHM13v2.0 (Telomere-to-Telomere) human genome assembly as a BSgenome object. Use this skill when a user needs to access the complete human genome sequence (accession GCA_009914755.4), perform genome-wide motif searching, or extract specific chromosomal sequences from the CHM13v2.0 reference in R.

# bioconductor-bsgenome.hsapiens.ncbi.t2t.chm13v2.0

## Overview

This package provides a full genomic sequence for the Homo sapiens T2T-CHM13v2.0 assembly, wrapped in a `BSgenome` object. This assembly represents a significant improvement over GRCh38, providing the first truly complete sequence of a human genome, including centromeric regions and difficult-to-map telomeric repeats.

## Loading and Basic Usage

To use the genome in an R session, load the library and assign the genome object to a variable for easier access.

```r
library(BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0)

# Assign to a shorter variable name
genome <- BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0

# View genome metadata
genome

# List available sequences (chromosomes)
seqnames(genome)

# Check sequence lengths
seqlengths(genome)
```

## Accessing Sequences

You can extract specific chromosomes or sub-sequences using standard `BSgenome` and `Biostrings` methods.

```r
# Access a specific chromosome (e.g., Chromosome 1)
chr1 <- genome[["1"]]

# Extract a specific range (e.g., first 1000 bp of Chromosome X)
library(GenomicRanges)
getSeq(genome, GRanges("X:1-1000"))
```

## Genome-Wide Motif Searching

The package is designed to work with `Biostrings` for pattern matching across the entire assembly.

```r
library(Biostrings)

# Example: Search for a specific DNA pattern on Chromosome 22
matchPattern("TTAGGG", genome[["22"]])

# For genome-wide searching across all chromosomes, use vmatchPattern
# Note: This can be memory intensive
motifs <- vmatchPattern("TTAGGG", genome)
```

## Workflow Tips

- **Sequence Naming**: This package uses NCBI naming conventions (e.g., "1", "2", "X", "Y", "MT") rather than UCSC "chr" prefixes. Use `seqlevelsStyle(genome) <- "UCSC"` if you need to convert styles for compatibility with other datasets.
- **Memory Management**: The T2T assembly is large. When performing operations across the whole genome, consider using `lapply` over `seqnames(genome)` or using the `BSgenome` views to avoid loading the entire sequence into RAM simultaneously.
- **Coordinate Systems**: Ensure your genomic coordinates (BED files, VCFs) are specifically mapped to T2T-CHM13v2.0 (GCA_009914755.4), as coordinates differ significantly from GRCh38/hg38.

## Reference documentation

- [BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0 Reference Manual](./references/reference_manual.md)