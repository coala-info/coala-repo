---
name: bioconductor-bsgenome.cjacchus.ucsc.caljac3
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Cjacchus.UCSC.calJac3.html
---

# bioconductor-bsgenome.cjacchus.ucsc.caljac3

name: bioconductor-bsgenome.cjacchus.ucsc.caljac3
description: Access and analyze the full genome sequences for Callithrix jacchus (Common marmoset) based on the UCSC calJac3 assembly (March 2009). Use this skill when performing genomic analysis in R that requires the marmoset reference genome, including sequence extraction, motif searching, or coordinate-based lookups.

# bioconductor-bsgenome.cjacchus.ucsc.caljac3

## Overview

The `BSgenome.Cjacchus.UCSC.calJac3` package is a data-centric Bioconductor package providing the complete genome sequence for the Common marmoset (*Callithrix jacchus*). It stores the UCSC calJac3 assembly as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor infrastructure like `GenomicRanges` and `Biostrings`.

## Basic Usage

### Loading the Genome
To use the package, you must first load it into your R session. The genome object is named identically to the package.

```r
library(BSgenome.Cjacchus.UCSC.calJac3)

# Assign to a shorter variable for convenience
genome <- BSgenome.Cjacchus.UCSC.calJac3
genome
```

### Exploring Genome Metadata
You can check available chromosomes, their lengths, and the organism information.

```r
# List all sequences (chromosomes/scaffolds)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access specific chromosome metadata
genome@provider
genome@release_date
```

### Extracting Sequences
Sequences can be accessed using standard list or dollar-sign notation, returning `DNAString` objects.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string (useful for programmatic loops)
chr_name <- "chr2"
chr2_seq <- genome[[chr_name]]

# Get a specific sub-sequence (e.g., first 100 bases of chr1)
getSeq(genome, "chr1", start=1, end=100)
```

## Common Workflows

### Genomic Ranges Integration
The most common way to extract multiple sequences is using a `GRanges` object.

```r
library(GenomicRanges)

# Define regions of interest
query_regions <- GRanges(
  seqnames = c("chr1", "chrX"),
  ranges = IRanges(start = c(1000, 5000), end = c(1100, 5100))
)

# Extract all sequences at once
region_seqs <- getSeq(genome, query_regions)
```

### Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific motifs across the marmoset genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAWAW"

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across the entire genome (returns a GRangesList or similar)
# Note: This can be memory intensive
all_matches <- vmatchPattern(motif, genome)
```

## Tips and Best Practices
- **Memory Management**: `BSgenome` objects use "lazy loading." The sequence for a chromosome is only loaded into memory when you specifically access it.
- **Coordinate System**: UCSC assemblies use 1-based indexing in R/Bioconductor, consistent with standard R conventions.
- **Masks**: Check if the assembly contains masked sequences (N's for repeats) by inspecting `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Cjacchus.UCSC.calJac3 Reference Manual](./references/reference_manual.md)