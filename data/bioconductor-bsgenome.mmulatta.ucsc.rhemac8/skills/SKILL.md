---
name: bioconductor-bsgenome.mmulatta.ucsc.rhemac8
description: This package provides the full genome sequence for Macaca mulatta from the UCSC rheMac8 build for use in R. Use when user asks to access Rhesus monkey reference sequences, extract specific genomic sub-sequences, or perform motif searching and coordinate-based lookups.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmulatta.UCSC.rheMac8.html
---


# bioconductor-bsgenome.mmulatta.ucsc.rhemac8

name: bioconductor-bsgenome.mmulatta.ucsc.rhemac8
description: Access and analyze the full genome sequences for Macaca mulatta (Rhesus monkey) from UCSC build rheMac8 (Nov. 2015). Use this skill when performing genomic analysis in R that requires the Rhesus macaque reference sequence, including sequence extraction, motif searching, or coordinate-based lookups.

# bioconductor-bsgenome.mmulatta.ucsc.rhemac8

## Overview

The `BSgenome.Mmulatta.UCSC.rheMac8` package is a data provider package within the Bioconductor ecosystem. It contains the complete genome sequence for *Macaca mulatta* as provided by UCSC (build rheMac8). The sequences are stored as `Biostrings` objects, allowing for efficient manipulation and analysis of large genomic data.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Mmulatta.UCSC.rheMac8")
library(BSgenome.Mmulatta.UCSC.rheMac8)
```

## Basic Usage

### Accessing the Genome Object
The main object is named after the package. You can assign it to a shorter variable for convenience:

```r
genome <- BSgenome.Mmulatta.UCSC.rheMac8
genome
```

### Exploring Sequence Metadata
Check available chromosomes and their lengths:

```r
# List all sequence names (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View metadata about the organism and provider
organism(genome)
provider(genome)
release_date(genome)
```

### Extracting Sequences
You can retrieve specific chromosome sequences using standard list or dollar-sign notation:

```r
# Access chromosome 1
chr1 <- genome$chr1

# Access via string (useful for programmatic loops)
chr_name <- "chr2"
chr2 <- genome[[chr_name]]

# Get a specific sub-sequence (e.g., first 100 nucleotides of chr1)
sub_seq <- getSeq(genome, "chr1", start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching
Use the `matchPattern` function from the `Biostrings` package to find specific DNA motifs across a chromosome:

```r
library(Biostrings)
# Search for a specific sequence on chromosome 1
pattern <- "GATAAG"
matches <- matchPattern(pattern, genome$chr1)
```

### Working with Genomic Ranges
This package integrates seamlessly with `GenomicRanges` for extracting sequences based on coordinates:

```r
library(GenomicRanges)
gr <- GRanges(seqnames = c("chr1", "chr2"), 
              ranges = IRanges(start = c(100, 200), end = c(150, 250)))
getSeq(genome, gr)
```

## Tips
- **Memory Management**: BSgenome objects use "lazy loading." The sequence for a chromosome is only loaded into memory when you specifically access it (e.g., via `genome$chr1`).
- **Masks**: Check if the genome contains built-in masks (e.g., for assembly gaps or repeat regions) by inspecting `masknames(genome)`.
- **Consistency**: Ensure your input coordinates match the UCSC naming convention (e.g., "chr1" instead of "1").

## Reference documentation

- [BSgenome.Mmulatta.UCSC.rheMac8 Reference Manual](./references/reference_manual.md)