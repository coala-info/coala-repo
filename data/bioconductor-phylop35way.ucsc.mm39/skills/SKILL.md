---
name: bioconductor-phylop35way.ucsc.mm39
description: This package provides access to phyloP conservation scores for the mouse genome (mm39) derived from 35-way vertebrate alignments. Use when user asks to retrieve nucleotide-level conservation scores, query evolutionary acceleration for specific genomic coordinates, or analyze genomic conservation in Mus musculus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/phyloP35way.UCSC.mm39.html
---


# bioconductor-phylop35way.ucsc.mm39

name: bioconductor-phylop35way.ucsc.mm39
description: Provides metadata and access to phyloP conservation scores for the mouse genome (mm39) calculated from 35-way vertebrate alignments. Use this skill when a user needs to retrieve, query, or analyze genomic conservation scores for Mus musculus (mm39) using Bioconductor.

# bioconductor-phylop35way.ucsc.mm39

## Overview
The `phyloP35way.UCSC.mm39` package is an annotation resource package that provides metadata for phyloP conservation scores. These scores represent nucleotide-level evolutionary conservation or acceleration, derived from multiple genome alignments of the mouse genome (mm39) with 34 other vertebrate genomes. Instead of containing the data directly, this package facilitates the retrieval of scores through the `AnnotationHub` and `GenomicScores` frameworks.

## Installation
To use this resource, ensure the following Bioconductor packages are installed:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("phyloP35way.UCSC.mm39", "GenomicScores", "AnnotationHub"))
```

## Workflow: Retrieving and Querying Scores

### 1. Load the Resource
The recommended way to access the scores is via the `GenomicScores` API.

```r
library(GenomicScores)

# Check available scores (optional)
# availableGScores()

# Download/Load the phyloP scores for mm39
phylop <- getGScores("phyloP35way.UCSC.mm39")
```

### 2. Query Specific Genomic Positions
Use the `gscores()` function with a `GRanges` object to retrieve scores for specific coordinates.

```r
library(GenomicRanges)

# Define regions of interest (example: chr1)
query_ranges <- GRanges(seqnames = "chr1", 
                        IRanges(start = 1000000:1000005, width = 1))

# Retrieve scores
scores <- gscores(phylop, query_ranges)
print(scores)
```

### 3. Create an Offline Annotation Package
If you need to work without an internet connection, you can convert the `AnnotationHub` resource into a standalone local R package.

```r
makeGScoresPackage(phylop, 
                   maintainer = "Your Name <your@email.com>", 
                   author = "Your Name", 
                   version = "1.0.0",
                   destDir = ".")
```
After running this, you must build and install the resulting directory using `R CMD INSTALL`.

## Tips
- **Caching**: The first call to `getGScores()` downloads the data to a local cache. Subsequent calls will be significantly faster.
- **Memory**: When querying large regions, consider that `gscores()` returns a `GRanges` object with a score column; for very high-throughput needs, check the `GenomicScores` documentation for optimized accessors.
- **Genome Version**: This package is strictly for the **mm39** (GRCm39) assembly. Do not use it with mm10 coordinates.

## Reference documentation
- [phyloP35way.UCSC.mm39 AnnotationHub Resource Metadata](./references/phyloP35way.UCSC.mm39.md)