---
name: bioconductor-bsgenome.tguttata.ucsc.taegut2
description: This package provides the full genome sequences for the Zebra finch (Taeniopygia guttata) based on the UCSC taeGut2 assembly. Use when user asks to retrieve Zebra finch DNA sequences, search for genomic motifs, or access chromosome lengths and metadata for the taeGut2 coordinate system.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Tguttata.UCSC.taeGut2.html
---


# bioconductor-bsgenome.tguttata.ucsc.taegut2

name: bioconductor-bsgenome.tguttata.ucsc.taegut2
description: Access and analyze the full genome sequences for Taeniopygia guttata (Zebra finch) using the UCSC taeGut2 (Feb. 2013) assembly. Use this skill when performing genomic analysis in R that requires Zebra finch sequence data, chromosome lengths, or motif searching within the taeGut2 coordinate system.

# bioconductor-bsgenome.tguttata.ucsc.taegut2

## Overview

The `BSgenome.Tguttata.UCSC.taeGut2` package is a data provider for the Zebra finch (*Taeniopygia guttata*) genome. It stores the UCSC `taeGut2` assembly as a `BSgenome` object, allowing for efficient sequence retrieval, coordinate-based lookups, and integration with other Bioconductor tools like `Biostrings` and `GenomicRanges`.

## Basic Usage

### Loading the Genome
To use the genome, load the library and assign the object to a variable for easier access.

```r
library(BSgenome.Tguttata.UCSC.taeGut2)
genome <- BSgenome.Tguttata.UCSC.taeGut2
```

### Exploring Genome Metadata
Check available chromosomes, sequence lengths, and assembly information.

```r
# List all sequences (chromosomes/scaffolds)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# View specific chromosome metadata
genome[["chr1"]]
```

### Retrieving Sequences
Extract specific DNA sequences using standard R indexing or `getSeq`.

```r
# Access a whole chromosome (returns a DNAString)
chr1_seq <- genome$chr1 

# Extract a specific sub-sequence (e.g., first 100bp of chr2)
library(Biostrings)
sub_seq <- getSeq(genome, "chr2", start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the Zebra finch genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAWAW"

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across the entire genome
all_matches <- vmatchPattern(motif, genome)
```

### Working with Genomic Ranges
You can use `GRanges` objects to extract multiple regions of interest simultaneously.

```r
library(GenomicRanges)

# Define regions
regions <- GRanges(seqnames = c("chr1", "chr2"), 
                   ranges = IRanges(start = c(1000, 5000), end = c(1200, 5200)))

# Extract sequences for these regions
region_seqs <- getSeq(genome, regions)
```

## Tips
- **Memory Management**: `BSgenome` objects use "on-disk" loading for sequences. Accessing a chromosome (e.g., `genome$chr1`) loads it into memory. If working with many large chromosomes, consider clearing your workspace periodically.
- **Coordinate System**: This package uses the UCSC `taeGut2` assembly. Ensure your annotation data (GTF/GFF) or SNP coordinates match this specific version to avoid offset errors.
- **Masks**: Check if the genome contains built-in masks (e.g., for assembly gaps or repeats) using `masks(genome$chr1)`.

## Reference documentation

- [BSgenome.Tguttata.UCSC.taeGut2](./references/reference_manual.md)