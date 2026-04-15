---
name: bioconductor-phastcons100way.ucsc.hg38
description: This package provides UCSC phastCons conservation scores for the human genome (hg38) based on a multiple alignment of 100 vertebrate species. Use when user asks to retrieve evolutionary conservation scores for genomic coordinates, annotate human variants with phastCons metrics, or identify highly conserved regions in the hg38 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/phastCons100way.UCSC.hg38.html
---

# bioconductor-phastcons100way.ucsc.hg38

name: bioconductor-phastcons100way.ucsc.hg38
description: Access and retrieve UCSC phastCons conservation scores for the human genome (hg38) based on 100 vertebrate species. Use this skill when you need to annotate genomic coordinates with evolutionary conservation metrics, identify highly conserved regions, or evaluate the functional significance of specific human variants using the phastCons algorithm.

# bioconductor-phastcons100way.ucsc.hg38

## Overview
The `phastCons100way.UCSC.hg38` package is a Bioconductor annotation resource providing phastCons conservation scores for the human genome assembly hg38. These scores represent the probability that a nucleotide belongs to a conserved element, derived from a multiple alignment of 100 vertebrate species. The data is stored as a `GScores` object, which allows for efficient memory usage and fast retrieval of scores for specific genomic ranges.

## Installation and Loading
To use this package, you must have both the data package and the `GenomicScores` infrastructure package installed.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("phastCons100way.UCSC.hg38")
BiocManager::install("GenomicScores")

library(phastCons100way.UCSC.hg38)
library(GenomicRanges)
```

## Basic Usage

### Accessing the Score Object
The package exposes an object with the same name as the package.

```r
phast <- phastCons100way.UCSC.hg38
phast
```

### Retrieving Scores for Genomic Ranges
Use the `gscores()` function from the `GenomicScores` package to query specific coordinates.

```r
# Define regions of interest
rng <- GRanges("chr7:117592326-117592330")

# Retrieve scores
scores <- gscores(phast, rng)
print(scores)
```

### Working with Results
The output is a `GRanges` object where the conservation scores are stored in the metadata columns (typically named `default`).

```r
# Access the scores directly
mcols(scores)$default

# To get scores for every single position in a range
scores_per_base <- gscores(phast, rng, summaryFun = "none")
```

## Common Workflows

### Annotating a VCF or List of Variants
If you have a set of variants, convert them to a `GRanges` object to annotate them with conservation scores.

```r
# Example: Annotating specific SNPs
snps <- GRanges(seqnames = c("chr1", "chr1"), 
                ranges = IRanges(start = c(10000, 20000), width = 1))
annotated_snps <- gscores(phast, snps)
```

### Visualizing Conservation
You can extract scores across a larger genomic window to plot conservation profiles.

```r
roi <- GRanges("chr1:1000000-1000100")
score_profile <- gscores(phast, roi, summaryFun = "none")
plot(start(score_profile), mcols(score_profile)$default, type = "l", 
     xlab = "Position", ylab = "phastCons Score")
```

## Tips
- **Genome Build**: Ensure your input coordinates are in **hg38**. Using hg19 coordinates will result in incorrect or missing data.
- **Memory Efficiency**: The scores are stored as `Rle` (Run-Length Encoding) objects, making them very memory efficient for large-scale genomic analysis.
- **Score Interpretation**: phastCons scores range from 0 to 1. Higher values indicate a higher probability of being part of a conserved element.

## Reference documentation
- [phastCons100way.UCSC.hg38 Reference Manual](./references/reference_manual.md)