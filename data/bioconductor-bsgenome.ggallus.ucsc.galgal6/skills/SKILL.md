---
name: bioconductor-bsgenome.ggallus.ucsc.galgal6
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ggallus.UCSC.galGal6.html
---

# bioconductor-bsgenome.ggallus.ucsc.galgal6

name: bioconductor-bsgenome.ggallus.ucsc.galgal6
description: Provides the full genome sequences for Gallus gallus (Chicken) based on the UCSC galGal6 (Mar. 2018) assembly. Use this skill when an AI agent needs to access, analyze, or manipulate chicken genomic sequences in R, including retrieving chromosome sequences, calculating sequence lengths, or performing genome-wide motif searching using Biostrings.

# bioconductor-bsgenome.ggallus.ucsc.galgal6

## Overview

The `BSgenome.Ggallus.UCSC.galGal6` package is a Bioconductor data package containing the complete genome sequence for the chicken (*Gallus gallus*). The data is stored as a `BSgenome` object, which allows for efficient access to sequences as `DNAString` objects. This package is essential for bioinformatics workflows involving the chicken genome, such as sequence alignment, SNP analysis, and regulatory element identification.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Ggallus.UCSC.galGal6")
library(BSgenome.Ggallus.UCSC.galGal6)
```

## Basic Usage

### Accessing the Genome Object

The main object is named after the package:

```r
# Assign to a shorter variable for convenience
genome <- BSgenome.Ggallus.UCSC.galGal6
genome
```

### Inspecting Sequence Information

You can check available chromosomes (sequences) and their lengths:

```r
# List all sequence names (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Retrieving Specific Sequences

Sequences are accessed using standard list or dollar-sign notation:

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Alternative access method
chr2_seq <- genome[["chr2"]]

# View a portion of the sequence
subseq(chr1_seq, start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching

Because the sequences are `Biostrings` objects, you can use `matchPattern` or `vmatchPattern` to find motifs:

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across the entire genome
# Note: This returns a GRangesList or similar depending on the function used
all_matches <- vmatchPattern(motif, genome)
```

### Calculating GC Content

```r
# Calculate GC content for chromosome 1
alphabetFrequency(genome$chr1, as.prob=TRUE)[c("C", "G")]
```

## Tips

- **Memory Management**: `BSgenome` objects use "on-disk" caching. Loading a specific chromosome (e.g., `genome$chr1`) brings that sequence into memory. If working with many large sequences, ensure your R environment has sufficient RAM.
- **Coordinate System**: UCSC genomes use 1-based indexing in R/Bioconductor, consistent with other `IRanges` and `GenomicRanges` objects.
- **Compatibility**: This package is designed to work seamlessly with `GenomicFeatures`, `GenomicRanges`, and `BSgenome` software packages.

## Reference documentation

- [BSgenome.Ggallus.UCSC.galGal6 Reference Manual](./references/reference_manual.md)