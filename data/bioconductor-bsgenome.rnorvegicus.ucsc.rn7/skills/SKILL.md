---
name: bioconductor-bsgenome.rnorvegicus.ucsc.rn7
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Rnorvegicus.UCSC.rn7.html
---

# bioconductor-bsgenome.rnorvegicus.ucsc.rn7

name: bioconductor-bsgenome.rnorvegicus.ucsc.rn7
description: Access and analyze the full genome sequences for Rattus norvegicus (Rat) using the UCSC rn7 assembly. Use this skill when performing genomic analysis in R that requires the rat reference genome, such as retrieving DNA sequences for specific coordinates, checking chromosome lengths, or conducting genome-wide motif searches.

# bioconductor-bsgenome.rnorvegicus.ucsc.rn7

## Overview

The `BSgenome.Rnorvegicus.UCSC.rn7` package is a Bioconductor data package providing the complete genome sequence for *Rattus norvegicus* as provided by UCSC (assembly rn7). The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the R environment.

## Getting Started

To use this genome in R, load the package and assign the genome object to a variable for easier access:

```r
library(BSgenome.Rnorvegicus.UCSC.rn7)
genome <- BSgenome.Rnorvegicus.UCSC.rn7
```

## Common Workflows

### Inspecting the Genome
Check available sequences (chromosomes) and their respective lengths:

```r
# List all sequence names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View metadata about the assembly
genome
```

### Accessing Sequence Data
Retrieve DNA sequences for specific chromosomes or genomic regions:

```r
# Access a specific chromosome (returns a DNAString object)
chr1_seq <- genome$chr1

# Extract a specific sub-sequence using coordinates
# Note: Coordinates are 1-based
getSeq(genome, "chr1", start=1000, end=2000)

# Extract multiple sequences using a GRanges object
library(GenomicRanges)
gr <- GRanges(seqnames=c("chr1", "chr2"), ranges=IRanges(start=c(100, 200), end=c(150, 250)))
getSeq(genome, gr)
```

### Genome-wide Motif Searching
Search for specific DNA patterns across the entire rat genome:

```r
library(Biostrings)
pattern <- "TATAAT"

# Search on a single chromosome
matchPattern(pattern, genome$chr1)

# Search across the entire genome
vmatchPattern(pattern, genome)
```

## Tips and Best Practices

- **Lazy Loading**: BSgenome objects use lazy loading. The sequence data is not loaded into memory until you specifically access a chromosome, which helps manage RAM usage.
- **Coordinate Systems**: Always remember that UCSC-based BSgenome packages use 1-based indexing in R, consistent with standard Bioconductor practices.
- **Compatibility**: This package is designed to work seamlessly with other Bioconductor tools like `GenomicRanges`, `GenomicFeatures`, and `BSgenome` software functions.
- **Masks**: Check if masks are available for repeat-masked sequences if your analysis requires avoiding repetitive regions.

## Reference documentation

- [BSgenome.Rnorvegicus.UCSC.rn7](./references/reference_manual.md)