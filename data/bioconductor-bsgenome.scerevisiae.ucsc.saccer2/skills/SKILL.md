---
name: bioconductor-bsgenome.scerevisiae.ucsc.saccer2
description: This package provides the full genome sequence for Saccharomyces cerevisiae based on the UCSC sacCer2 assembly for use in Bioconductor. Use when user asks to retrieve yeast chromosome sequences, calculate sequence statistics, perform genome-wide motif searching, or extract sequences from genomic coordinates.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Scerevisiae.UCSC.sacCer2.html
---

# bioconductor-bsgenome.scerevisiae.ucsc.saccer2

name: bioconductor-bsgenome.scerevisiae.ucsc.saccer2
description: Provides the full genome sequence for Saccharomyces cerevisiae (Yeast) based on the UCSC sacCer2 assembly (June 2008). Use this skill when you need to perform genomic analysis in R involving yeast sequences, such as retrieving chromosome sequences, calculating sequence statistics, or performing genome-wide motif searching using Biostrings.

# bioconductor-bsgenome.scerevisiae.ucsc.saccer2

## Overview

The `BSgenome.Scerevisiae.UCSC.sacCer2` package is a data-driven Bioconductor annotation package. It contains the complete genome sequence for *Saccharomyces cerevisiae* as provided by UCSC (assembly sacCer2). The sequences are stored as `DNAString` or `DNAStringSet` objects, allowing for efficient sequence manipulation and analysis within the Bioconductor ecosystem.

## Basic Usage

### Loading the Genome

To use the genome in an R session, load the library and assign the provider object to a variable for easier access.

```r
library(BSgenome.Scerevisiae.UCSC.sacCer2)

# Assign to a shorter variable name
genome <- BSgenome.Scerevisiae.UCSC.sacCer2
```

### Exploring Genome Metadata

You can inspect the sequence names and their respective lengths.

```r
# List all chromosome/sequence names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Check the organism and provider version
organism(genome)
provider(genome)
release_date(genome)
```

### Accessing Specific Sequences

Sequences can be accessed using the `$` operator or double brackets `[[ ]]`.

```r
# Access Chromosome I
chr1 <- genome$chrI

# Access using string index
chrM <- genome[["chrM"]]

# View a portion of the sequence
subseq(chr1, start=1, end=100)
```

## Common Workflows

### Sequence Statistics

Calculate the GC content or nucleotide frequency for a specific chromosome.

```r
library(Biostrings)

# Calculate nucleotide frequency for Chromosome IV
alphabetFrequency(genome$chrIV, baseOnly=TRUE)

# Calculate GC content
letterFrequency(genome$chrIV, letters="GC", as.prob=TRUE)
```

### Genome-Wide Motif Searching

To find a specific DNA pattern across the entire genome, use the `vmatchPattern` function.

```r
# Define a motif
motif <- "TATAWAW"

# Search across all chromosomes
matches <- vmatchPattern(motif, genome)

# Summarize match counts per chromosome
elementNROWS(matches)

# Extract coordinates of matches on a specific chromosome
as.data.frame(matches$chrI)
```

### Extracting Sequences from Coordinates

If you have a set of genomic coordinates (e.g., from a BED file or GRanges object), use `getSeq`.

```r
library(GenomicRanges)

# Define regions of interest
gr <- GRanges(seqnames = c("chrI", "chrII"),
              ranges = IRanges(start = c(100, 500), end = c(150, 550)))

# Extract sequences
sequences <- getSeq(genome, gr)
```

## Tips and Best Practices

- **Memory Efficiency**: The sequences are loaded into memory on demand. If working with many large genomes, clear your workspace or use `getSeq` for specific regions to manage memory.
- **Naming Consistency**: Ensure your chromosome naming convention matches UCSC (e.g., "chrI", "chrII", "chrM") rather than Ensembl/NCBI (e.g., "1", "2", "MT").
- **Compatibility**: This package is designed to work seamlessly with `Biostrings`, `GenomicRanges`, and `BSgenome` infrastructure functions.

## Reference documentation

- [BSgenome.Scerevisiae.UCSC.sacCer2 Reference Manual](./references/reference_manual.md)