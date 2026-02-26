---
name: bioconductor-bsgenome.tgondii.toxodb.7.0
description: This tool provides the full genome sequence for Toxoplasma gondii ME49 (ToxoDB-7.0) as a BSgenome object for Bioconductor analysis. Use when user asks to access the Toxoplasma gondii genome, extract specific DNA sequences, search for motifs, or perform coordinate-based genomic lookups.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Tgondii.ToxoDB.7.0.html
---


# bioconductor-bsgenome.tgondii.toxodb.7.0

name: bioconductor-bsgenome.tgondii.toxodb.7.0
description: Provides the full genome sequence for Toxoplasma gondii ME49 (ToxoDB-7.0) as a BSgenome object. Use this skill when you need to perform genomic analysis on T. gondii, including sequence extraction, motif searching, or coordinate-based lookups using Bioconductor tools.

# bioconductor-bsgenome.tgondii.toxodb.7.0

## Overview

This skill facilitates the use of the `BSgenome.Tgondii.ToxoDB.7.0` R package. This package is a data container for the Toxoplasma gondii ME49 genome, specifically Release 7.0 from ToxoDB. It allows users to interact with the parasite's genome using the standard Bioconductor `BSgenome` interface, enabling efficient sequence retrieval and integration with other genomic packages like `Biostrings` and `GenomicRanges`.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and then loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Tgondii.ToxoDB.7.0")
library(BSgenome.Tgondii.ToxoDB.7.0)
```

## Basic Usage

### Accessing the Genome Object
The genome object is named the same as the package. You can assign it to a shorter variable for convenience.

```r
genome <- BSgenome.Tgondii.ToxoDB.7.0
genome
```

### Exploring Genome Metadata
Check the available chromosomes (sequences) and their lengths:

```r
# List all sequence names (chromosomes/scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Retrieving Sequences
You can access specific chromosomes using the `$` operator or double brackets `[[ ]]`.

```r
# Access chromosome Ia
chrIa <- genome$Ia 

# Alternative access
chrIa <- genome[["Ia"]]

# View the DNAString object
chrIa
```

## Common Workflows

### Sequence Extraction
Extract specific sub-sequences using `getSeq`. This is the preferred method for working with coordinates.

```r
library(BSgenome)

# Extract a specific region (e.g., first 100bp of chromosome Ib)
sub_seq <- getSeq(genome, "Ib", start=1, end=100)

# Extract multiple regions using a GRanges object
library(GenomicRanges)
gr <- GRanges(seqnames = c("Ia", "Ib"), 
              ranges = IRanges(start = c(100, 200), end = c(150, 250)))
multi_seqs <- getSeq(genome, gr)
```

### Genome-wide Motif Searching
Use the `matchPattern` function from the `Biostrings` package to find specific DNA motifs across the genome.

```r
library(Biostrings)

# Define a motif
motif <- "GAATTC" # EcoRI site

# Search on a specific chromosome
matches <- matchPattern(motif, genome$Ia)

# To search the entire genome, iterate through chromosomes
all_matches <- lapply(seqnames(genome), function(chr) {
    matchPattern(motif, genome[[chr]])
})
```

## Tips
- **Memory Efficiency**: `BSgenome` objects use "on-disk" loading. Sequences are only loaded into memory when specifically accessed, making it efficient for large-scale analyses.
- **Coordinate Systems**: Ensure your coordinates match the ToxoDB 7.0 release. If using data from newer ToxoDB releases, coordinates may have shifted.
- **Masks**: Check if the genome contains masks (e.g., for repeat regions) using `masks(genome$Ia)`.

## Reference documentation
- [BSgenome.Tgondii.ToxoDB.7.0 Reference Manual](./references/reference_manual.md)