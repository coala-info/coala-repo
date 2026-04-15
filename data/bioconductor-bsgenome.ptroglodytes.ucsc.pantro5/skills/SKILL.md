---
name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro5
description: This package provides the full genome sequences for the chimpanzee (Pan troglodytes) based on the UCSC panTro5 assembly. Use when user asks to access chimpanzee genomic sequences, extract specific chromosome regions, or perform genome-wide motif searching and nucleotide frequency analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ptroglodytes.UCSC.panTro5.html
---

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro5

## Overview

The `BSgenome.Ptroglodytes.UCSC.panTro5` package is a data provider package containing the full genome sequences for *Pan troglodytes* (Chimpanzee) as provided by UCSC. The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and genome-wide analysis within the Bioconductor ecosystem.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Ptroglodytes.UCSC.panTro5")

# Load the package
library(BSgenome.Ptroglodytes.UCSC.panTro5)
```

## Basic Usage

### Accessing Genome Metadata
Once loaded, the genome object is available under the package name.

```r
genome <- BSgenome.Ptroglodytes.UCSC.panTro5

# View general information
genome

# List sequence names (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Check the organism and provider version
organism(genome)
providerVersion(genome)
```

### Extracting Sequences
You can extract specific chromosomes or sub-sequences using standard `BSgenome` methods.

```r
# Access a specific chromosome (returns a DNAString object)
chr1_seq <- genome$chr1 
# Alternatively: genome[["chr1"]]

# Extract a specific genomic range
library(GenomicRanges)
gr <- GRanges("chr1", IRanges(start = 1000000, end = 1000500))
sub_seq <- getSeq(genome, gr)
```

## Common Workflows

### Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the chimp genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAWAW"

# Search on a single chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across the entire genome
all_matches <- vmatchPattern(motif, genome)
```

### Calculating Nucleotide Frequency
Analyze the composition of specific regions or entire chromosomes.

```r
# GC content of chromosome 2
alphabetFrequency(genome$chr2, as.prob = TRUE)

# Letter frequency for a set of ranges
letterFrequency(sub_seq, letters = "GC", as.prob = TRUE)
```

## Tips
- **Memory Management**: BSgenome objects use "on-disk" caching via the `2bit` format, but loading many large chromosomes into memory simultaneously can be intensive. Use `getSeq` with `GRanges` to extract only the regions of interest.
- **Masks**: Check if masks are available for repeat-masked sequences using `masks(genome$chr1)`. Note that standard UCSC BSgenome packages often provide the unmasked sequences by default.
- **Compatibility**: This package is designed to work seamlessly with `GenomicFeatures`, `GenomicRanges`, and `BSgenome` infrastructure.

## Reference documentation

- [BSgenome.Ptroglodytes.UCSC.panTro5](./references/reference_manual.md)