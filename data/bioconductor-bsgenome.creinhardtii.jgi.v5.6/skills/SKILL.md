---
name: bioconductor-bsgenome.creinhardtii.jgi.v5.6
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Creinhardtii.JGI.v5.6.html
---

# bioconductor-bsgenome.creinhardtii.jgi.v5.6

name: bioconductor-bsgenome.creinhardtii.jgi.v5.6
description: Provides full genome sequences for Chlamydomonas reinhardtii (v5.6) as provided by JGI. Use this skill when you need to access, analyze, or perform sequence operations on the Chlamydomonas reinhardtii genome within R, including motif searching, sequence extraction, and genomic coordinate mapping.

# bioconductor-bsgenome.creinhardtii.jgi.v5.6

## Overview

The `BSgenome.Creinhardtii.JGI.v5.6` package is a data provider package containing the complete genome sequence for the green alga *Chlamydomonas reinhardtii* (v5.6). It stores the genomic data as `Biostrings` objects, allowing for efficient sequence manipulation and integration with other Bioconductor packages like `GenomicRanges` and `BSgenome`.

## Basic Usage

### Loading the Genome
To use the genome data, you must first load the package and assign the genome object to a variable for easier access.

```r
library(BSgenome.Creinhardtii.JGI.v5.6)
genome <- BSgenome.Creinhardtii.JGI.v5.6
```

### Exploring Genome Metadata
You can inspect the sequence names, lengths, and other metadata associated with the v5.6 assembly.

```r
# List all sequence names (chromosomes/scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Accessing Specific Sequences
Individual chromosomes or scaffolds can be retrieved as `DNAString` objects.

```r
# Access chromosome 1
chr1 <- genome[["chromosome_1"]]

# Get a subsequence (e.g., first 100 bases of chromosome 1)
sub_seq <- subseq(genome[["chromosome_1"]], start=1, end=100)
```

## Common Workflows

### Genome-Wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific motifs across the entire genome.

```r
library(Biostrings)

# Define a motif
motif <- "TTAGGG" # Example telomeric repeat

# Search across all chromosomes
matches <- vmatchPattern(motif, genome)

# Convert to GRanges for further analysis
matches_gr <- as(matches, "GRanges")
```

### Extracting Sequences from Genomic Ranges
If you have a set of genomic coordinates (e.g., from a BED file or gene annotations), use `getSeq` to extract the underlying DNA sequences.

```r
library(GenomicRanges)

# Define regions of interest
regions <- GRanges(seqnames = c("chromosome_1", "chromosome_2"),
                   ranges = IRanges(start = c(1000, 5000), end = c(1100, 5100)))

# Extract sequences
sequences <- getSeq(genome, regions)
```

## Tips
- **Memory Efficiency**: The genome is stored in a compressed format. Accessing specific chromosomes using `[[` is more memory-efficient than loading the entire genome into a single object if you only need specific regions.
- **Sequence Naming**: Ensure your `seqnames` match the package's naming convention (e.g., "chromosome_1" vs "chr1"). Use `seqnames(genome)` to verify.
- **Compatibility**: This package is designed to work seamlessly with `GenomicFeatures` for gene-centric analyses and `BSgenome` for general sequence analysis.

## Reference documentation
- [BSgenome.Creinhardtii.JGI.v5.6 Reference Manual](./references/reference_manual.md)