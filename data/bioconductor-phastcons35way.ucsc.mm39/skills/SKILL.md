---
name: bioconductor-phastcons35way.ucsc.mm39
description: This tool retrieves phastCons conservation scores for the mouse genome (mm39) based on 35-way vertebrate alignments. Use when user asks to query genomic conservation levels, identify evolutionary constrained elements in mouse, or retrieve conservation scores for specific genomic ranges.
homepage: https://bioconductor.org/packages/release/data/annotation/html/phastCons35way.UCSC.mm39.html
---

# bioconductor-phastcons35way.ucsc.mm39

name: bioconductor-phastcons35way.ucsc.mm39
description: Access and retrieve phastCons conservation scores for the mouse genome (mm39) calculated from 35-way vertebrate alignments. Use this skill when you need to query genomic conservation levels, identify evolutionary constrained elements in mouse, or retrieve phastCons scores for specific genomic ranges (GRanges) using the GenomicScores and AnnotationHub frameworks.

## Overview

The `phastCons35way.UCSC.mm39` package provides the metadata and infrastructure to access phastCons conservation scores for the `mm39` (mouse) genome assembly. These scores represent the probability that a nucleotide belongs to a conserved element, based on a multiple alignment of the mouse genome with 34 other vertebrate genomes. 

The package does not contain the data itself but acts as a bridge to retrieve it via `AnnotationHub`. It is designed to be used with the `GenomicScores` Bioconductor package API.

## Installation

To use this resource, ensure the core annotation and scoring packages are installed:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("phastCons35way.UCSC.mm39", "GenomicScores", "AnnotationHub"))
```

## Typical Workflow

### 1. Loading the Scoring Object
The primary way to interact with these scores is to retrieve them as a `GScores` object.

```r
library(GenomicScores)
library(phastCons35way.UCSC.mm39)

# Download/Load the phastCons scores from AnnotationHub
phast <- getGScores("phastCons35way.UCSC.mm39")

# Inspect the object
phast
```

### 2. Querying Scores for Genomic Ranges
Use the `gscores()` function to retrieve conservation values for specific coordinates. You must provide a `GRanges` object.

```r
library(GenomicRanges)

# Define regions of interest (e.g., specific positions on a chromosome)
# Note: Ensure seqnames match the UCSC style (e.g., "chr1")
query_ranges <- GRanges(seqnames = "chr1", 
                        IRanges(start = 1000000:1000005, width = 1))

# Retrieve scores
res <- gscores(phast, query_ranges)
print(res)
```

### 3. Working Offline
If you need to use these scores in an environment without internet access, you can convert the `AnnotationHub` resource into a local standalone annotation package.

```r
# Create a local package directory
makeGScoresPackage(phast, 
                   maintainer = "Your Name <your@email.com>", 
                   author = "Your Name", 
                   version = "1.0.0")

# This creates a folder named 'phastCons35way.UCSC.mm39' in your working directory.
# You must then install it via R CMD INSTALL or devtools::install()
```

## Tips and Best Practices

- **Memory Management**: `GScores` objects use a centralized cache. The first call to `getGScores()` will download a large data file; subsequent calls will use the local cache.
- **Coordinate Systems**: Always ensure your input `GRanges` use the `mm39` assembly coordinates. Using coordinates from `mm10` or other versions will result in incorrect data retrieval.
- **Score Interpretation**: phastCons scores range from 0 to 1. Higher values indicate a higher probability of conservation (evolutionary constraint).
- **Vectorization**: `gscores()` is vectorized. It is much more efficient to pass a single `GRanges` object containing many intervals than to call the function repeatedly in a loop.

## Reference documentation

- [phastCons35way.UCSC.mm39 AnnotationHub Resource Metadata](./references/phastCons35way.UCSC.mm39.md)