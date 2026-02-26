---
name: bioconductor-bsgenome.ggallus.ucsc.galgal5
description: This package provides the full genome sequence for Gallus gallus (Chicken) based on the UCSC galGal5 assembly. Use when user asks to access chicken genomic sequences, retrieve specific chromosome data, extract subsequences, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ggallus.UCSC.galGal5.html
---


# bioconductor-bsgenome.ggallus.ucsc.galgal5

name: bioconductor-bsgenome.ggallus.ucsc.galgal5
description: Provides full genome sequences for Gallus gallus (Chicken) based on the UCSC galGal5 assembly (Dec. 2015). Use this skill when an AI agent needs to access, analyze, or manipulate chicken genomic sequences in R, including retrieving chromosome sequences, calculating sequence statistics, or performing genome-wide motif searching using Biostrings and BSgenome frameworks.

# bioconductor-bsgenome.ggallus.ucsc.galgal5

## Overview

The `BSgenome.Ggallus.UCSC.galGal5` package is a Bioconductor data package containing the complete genome sequence for *Gallus gallus* (Chicken). It is based on the UCSC galGal5 assembly and stores sequences as `Biostrings` objects. This package is essential for bioinformatics workflows involving the chicken genome, such as SNP annotation, primer design, or sequence alignment within the R environment.

## Loading and Basic Usage

To use this package, it must be loaded into the R session. The genome object is named identically to the package.

```r
library(BSgenome.Ggallus.UCSC.galGal5)

# Assign to a shorter variable for convenience
genome <- BSgenome.Ggallus.UCSC.galGal5

# View genome metadata
genome
```

## Common Workflows

### Sequence Inspection
You can check available chromosomes (sequences) and their lengths.

```r
# List all sequence names (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome 1)
chr1_seq <- genome$chr1
# Or using index notation
chr1_seq <- genome[["chr1"]]
```

### Extracting Subsequences
Use `getSeq` to extract specific genomic regions. This is more memory-efficient than loading entire chromosomes if only a small region is needed.

```r
# Extract a specific range from Chromosome 2
# Returns a DNAString or DNAStringSet
my_region <- getSeq(genome, "chr2", start=1000, end=2000)
```

### Genome-wide Motif Searching
This package integrates with `Biostrings` for pattern matching across the entire genome.

```r
library(Biostrings)

# Define a pattern
pattern <- DNAString("ATGCATGC")

# Search on a specific chromosome
matches <- matchPattern(pattern, genome$chr1)

# For genome-wide searching, use vmatchPattern
all_matches <- vmatchPattern(pattern, genome)
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "on-disk" caching. Accessing `genome$chr1` loads that specific chromosome into RAM. If memory is limited, use `getSeq()` with specific coordinates.
- **Coordinate System**: UCSC genomes use 1-based indexing in R/Bioconductor, consistent with standard R conventions.
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges`. You can pass the `genome` object to functions like `tileGenome` or use it to provide sequence information to `GRanges` objects.

## Reference documentation

- [BSgenome.Ggallus.UCSC.galGal5 Reference Manual](./references/reference_manual.md)