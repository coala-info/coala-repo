---
name: bioconductor-bsgenome.osativa.msu.msu7
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Osativa.MSU.MSU7.html
---

# bioconductor-bsgenome.osativa.msu.msu7

name: bioconductor-bsgenome.osativa.msu.msu7
description: Provides the full genome sequence for Oryza sativa (Rice) based on the MSU7 Genome Release. Use this skill when you need to access, analyze, or manipulate the rice genome in R, including retrieving chromosome sequences, calculating sequence statistics, or performing genome-wide motif searching.

# bioconductor-bsgenome.osativa.msu.msu7

## Overview

The `BSgenome.Osativa.MSU.MSU7` package is a Bioconductor data package containing the complete genome sequence for *Oryza sativa* (Rice) as provided by the Michigan State University (MSU) Rice Genome Annotation Project, Release 7.0. The data is stored as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor tools like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Loading and Basic Usage

To use this package, you must first load it into your R session. The genome object is named identically to the package.

```r
library(BSgenome.Osativa.MSU.MSU7)

# Assign to a shorter variable for convenience
genome <- BSgenome.Osativa.MSU.MSU7

# Display genome metadata
genome
```

## Sequence Retrieval

You can access individual chromosomes or sequences using standard list or dollar-sign notation.

```r
# List all available sequences (chromosomes)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome 1)
chr1 <- genome$Chr1 
# or
chr1 <- genome[["Chr1"]]

# View the DNAString object for the chromosome
chr1
```

## Common Workflows

### Extracting Subsequences
Use `getSeq()` to extract specific genomic regions. This is more memory-efficient than loading entire chromosomes if you only need specific coordinates.

```r
library(GenomicRanges)

# Define a region of interest
roi <- GRanges("Chr1", IRanges(start=1000, end=2000))

# Extract the sequence
subseq <- getSeq(genome, roi)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire rice genome using `matchPattern` or `vmatchPattern`.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAA"

# Search on a single chromosome
matches_chr1 <- matchPattern(motif, genome$Chr1)

# Search across the entire genome
all_matches <- vmatchPattern(motif, genome)
```

### Calculating Nucleotide Frequency
Analyze the composition of the genome or specific chromosomes.

```r
# GC content of Chromosome 1
alphabetFrequency(genome$Chr1, as.prob=TRUE)

# Letter frequency for the whole genome
letterFrequency(genome, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Management**: `BSgenome` objects use "on-disk" caching. Accessing `genome$Chr1` loads that chromosome into memory. If working with many chromosomes, use `getSeq` with `GRanges` to keep memory usage low.
- **Coordinate System**: This package uses the MSU7 release. Ensure your annotation data (GFF/GTF) matches this specific version to avoid coordinate shifts.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) using `masks(genome$Chr1)`.

## Reference documentation
- [BSgenome.Osativa.MSU.MSU7 Reference Manual](./references/reference_manual.md)