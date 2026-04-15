---
name: bioconductor-bsgenome.gmax.ncbi.gmv40
description: This package provides the full genome sequences for Glycine max (soybean) based on the NCBI Gmv40 assembly for use in R. Use when user asks to extract soybean DNA sequences, perform motif searching, or analyze nucleotide composition using the BSgenome framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Gmax.NCBI.Gmv40.html
---

# bioconductor-bsgenome.gmax.ncbi.gmv40

name: bioconductor-bsgenome.gmax.ncbi.gmv40
description: Provides access to the full genome sequences for Glycine max (soybean) based on the NCBI Gmv40 assembly (GCF_000004515.5). Use this skill when you need to perform genomic analysis in R involving soybean DNA sequences, including sequence extraction, motif searching, and coordinate-based lookups using Biostrings and BSgenome frameworks.

# bioconductor-bsgenome.gmax.ncbi.gmv40

## Overview

The `BSgenome.Gmax.NCBI.Gmv40` package is a Bioconductor data package containing the complete genome sequences for *Glycine max* (soybean). The data is based on the NCBI assembly Gmv40 (accession GCF_000004515.5). This package allows researchers to treat the soybean genome as a structured R object, facilitating efficient sequence manipulation and integration with other Bioconductor tools like `GenomicRanges` and `Biostrings`.

## Basic Usage

### Loading the Genome
To use the genome in an R session, load the library and assign the provider object to a variable:

```r
library(BSgenome.Gmax.NCBI.Gmv40)

# Assign to a shorter variable for convenience
genome <- BSgenome.Gmax.NCBI.Gmv40
genome
```

### Exploring Genome Metadata
Check sequence names, lengths, and assembly information:

```r
# List all sequence names (chromosomes/scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View specific metadata
metadata(genome)
```

### Extracting Sequences
Extract specific regions using coordinates or `GRanges` objects:

```r
# Extract a specific chromosome
chr1 <- genome$NC_038235.1  # Use actual sequence name from seqnames()

# Extract a specific sub-sequence (e.g., first 100 bases of a scaffold)
getSeq(genome, "NC_038235.1", start=1, end=100)

# Extract multiple regions using a GRanges object
library(GenomicRanges)
gr <- GRanges(seqnames="NC_038235.1", ranges=IRanges(start=c(100, 500), end=c(200, 600)))
getSeq(genome, gr)
```

## Common Workflows

### Genome-wide Motif Searching
Search for specific DNA patterns across the entire soybean genome:

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search across all chromosomes
matches <- vmatchPattern(motif, genome)
matches
```

### Calculating Nucleotide Frequency
Analyze the composition of specific chromosomes or the whole genome:

```r
# Frequency for one chromosome
alphabetFrequency(genome$NC_038235.1)

# GC content calculation
letterFrequency(genome$NC_038235.1, letters="GC", as.prob=TRUE)
```

## Tips
- **Sequence Names**: NCBI uses Accession numbers (e.g., `NC_038235.1`) rather than simple chromosome numbers (e.g., `chr1`). Always check `seqnames(genome)` to ensure you are using the correct identifiers.
- **Memory Efficiency**: `BSgenome` objects use "on-disk" loading. Sequences are only loaded into memory when specifically accessed, making it efficient for large-scale analysis.
- **Compatibility**: This package is designed to work seamlessly with `BSgenome` functions like `forgeBSgenomeDataPkg` and `available.genomes`.

## Reference documentation
- [BSgenome.Gmax.NCBI.Gmv40 Reference Manual](./references/reference_manual.md)