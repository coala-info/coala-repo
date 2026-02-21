---
name: bioconductor-bsgenome.amellifera.ncbi.amelhav3.1
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Amellifera.NCBI.AmelHAv3.1.html
---

# bioconductor-bsgenome.amellifera.ncbi.amelhav3.1

name: bioconductor-bsgenome.amellifera.ncbi.amelhav3.1
description: Provides full genome sequences for Apis mellifera (Honey bee) based on the NCBI Amel_HAv3.1 assembly (GCF_003254395.2). Use this skill when you need to perform genomic analysis, sequence extraction, or motif searching specifically for the honey bee genome in R using Bioconductor.

# bioconductor-bsgenome.amellifera.ncbi.amelhav3.1

## Overview

This package is a data provider for the `BSgenome` infrastructure. It contains the complete genome sequence for *Apis mellifera* (Honey bee) as provided by NCBI. The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the R environment.

## Installation and Loading

To use this genome in R:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Amellifera.NCBI.AmelHAv3.1")

# Load the library
library(BSgenome.Amellifera.NCBI.AmelHAv3.1)
```

## Basic Usage

### Accessing Genome Metadata

```R
# Assign to a shorter variable name for convenience
genome <- BSgenome.Amellifera.NCBI.AmelHAv3.1

# View general information
genome

# List sequence names (chromosomes/scaffolds)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)
```

### Extracting Sequences

You can extract specific sequences using standard `BSgenome` indexing or the `getSeq` function.

```R
# Access a specific chromosome/group by name
genome[["Group1"]]

# Extract a specific sub-sequence (e.g., first 100 bp of Group1)
getSeq(genome, "Group1", start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching

Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the honey bee genome.

```R
library(Biostrings)

# Define a motif
motif <- "TATA"

# Search on a specific chromosome
matchPattern(motif, genome[["Group1"]])

# Search across the entire genome
vmatchPattern(motif, genome)
```

### Calculating Nucleotide Frequency

```R
# Calculate frequency for a specific chromosome
alphabetFrequency(genome[["Group1"]])

# Calculate GC content for a specific region
letterFrequency(getSeq(genome, "Group1", start=1, end=1000), "GC")
```

## Tips

- **Memory Management**: `BSgenome` objects use "on-disk" caching or efficient memory mapping. However, loading many large chromosomes into memory simultaneously as `DNAString` objects can be intensive.
- **Coordinate Systems**: Ensure your genomic coordinates match the `Amel_HAv3.1` assembly (GCF_003254395.2).
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges`, `GenomicFeatures`, and `Biostrings`.

## Reference documentation

- [BSgenome.Amellifera.NCBI.AmelHAv3.1 Reference Manual](./references/reference_manual.md)