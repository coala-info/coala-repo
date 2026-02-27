---
name: bioconductor-fitcons.ucsc.hg19
description: This package provides access to fitness consequence (fitCons) scores for the human genome assembly hg19. Use when user asks to retrieve conservation or fitness scores for specific genomic coordinates, query functional constraint probabilities, or analyze hg19 genomic ranges for potential fitness consequences.
homepage: https://bioconductor.org/packages/release/data/annotation/html/fitCons.UCSC.hg19.html
---


# bioconductor-fitcons.ucsc.hg19

name: bioconductor-fitcons.ucsc.hg19
description: Access and use UCSC fitCons (fitness consequence) scores for the human genome (hg19) via the fitCons.UCSC.hg19 Bioconductor package. Use this skill when you need to retrieve conservation/fitness scores for specific genomic coordinates or ranges in the hg19 assembly.

# bioconductor-fitcons.ucsc.hg19

## Overview

The `fitCons.UCSC.hg19` package is an annotation resource providing fitness consequence (fitCons) scores for the human genome (hg19). These scores represent the probability that a point mutation at a specific position will have a fitness consequence, integrated across various functional annotations. The data is stored as a `GScores` object, and access is managed through the `GenomicScores` infrastructure.

## Installation and Loading

To use this package, you must have `GenomicScores` and the annotation package installed:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("fitCons.UCSC.hg19")
BiocManager::install("GenomicScores")

library(fitCons.UCSC.hg19)
library(GenomicRanges)
```

## Basic Usage

The package exposes a single `GScores` object named `fitCons.UCSC.hg19`.

### Accessing the Score Object
```r
# Assign to a shorter variable for convenience
fitcons <- fitCons.UCSC.hg19

# Check metadata and citation
citation(fitcons)
```

### Querying Scores for Genomic Ranges
Use the `gscores()` function from the `GenomicScores` package to retrieve scores for specific `GRanges`.

```r
# Query a specific region on chromosome 7
query_range <- GRanges("chr7:117232380-117232384")
scores <- gscores(fitcons, query_range)

# View results
print(scores)
```

### Working with Results
The returned object is a `GRanges` object containing a `default` column (or specific score column) with the fitCons values.

```r
# Extract scores as a numeric vector
mcols(scores)$default
```

## Workflow Tips

1.  **Genome Assembly**: This package is strictly for **hg19**. If your data is in hg38, you must lift over your coordinates to hg19 before querying.
2.  **Memory Efficiency**: The scores are stored as `Rle` (Run-Length Encoding) objects, making them memory efficient. You can query large `GRanges` objects without significant overhead.
3.  **Score Interpretation**: fitCons scores range from 0 to 1. Higher scores indicate a higher probability that a mutation at that site has a fitness consequence (i.e., the site is more likely to be under functional constraint).
4.  **Available Populations**: Unlike some other GScores packages (like phastCons), fitCons typically provides a single integrated score per position for the hg19 assembly.

## Reference documentation

- [fitCons.UCSC.hg19 Reference Manual](./references/reference_manual.md)