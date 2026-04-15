---
name: bioconductor-phastcons100way.ucsc.hg19
description: This tool provides UCSC phastCons conservation scores for the human genome assembly hg19 based on 100 vertebrate species alignments. Use when user asks to retrieve evolutionary conservation scores, evaluate genomic conservation at specific hg19 coordinates, or fetch phastCons values for genomic ranges.
homepage: https://bioconductor.org/packages/release/data/annotation/html/phastCons100way.UCSC.hg19.html
---

# bioconductor-phastcons100way.ucsc.hg19

name: bioconductor-phastcons100way.ucsc.hg19
description: Access and retrieve UCSC phastCons conservation scores for the human genome (hg19) based on 100 vertebrate species multiple alignments. Use this skill when you need to evaluate evolutionary conservation at specific genomic coordinates or ranges in the hg19/GRCh37 assembly.

# bioconductor-phastcons100way.ucsc.hg19

## Overview

The `phastCons100way.UCSC.hg19` package is a Bioconductor annotation resource providing phastCons conservation scores for the human genome (hg19). These scores represent the probability that a nucleotide belongs to a conserved element, calculated from genome-wide multiple alignments of 100 vertebrate species.

The data is stored as a `GScores` object (defined in the `GenomicScores` package), which allows for efficient overlapping and retrieval of conservation values for specific genomic ranges.

## Installation and Loading

To use this skill, the package and its engine must be loaded in R:

```R
library(GenomicScores)
library(phastCons100way.UCSC.hg19)

# The data object is automatically loaded with the package name
phast <- phastCons100way.UCSC.hg19
```

## Basic Workflow

### 1. Define Target Regions
Create a `GRanges` object containing the hg19 coordinates you wish to query.

```R
library(GenomicRanges)
rngs <- GRanges(seqnames = "chr7", 
                ranges = IRanges(start = 117232380, end = 117232384))
```

### 2. Retrieve Scores
Use the `gscores()` function to extract the conservation values.

```R
scores <- gscores(phast, rngs)
# View results
print(scores)
```

The resulting `GRanges` object will contain a metadata column (usually named `default`) representing the phastCons score (ranging from 0 to 1).

### 3. Working with Large Ranges
If querying large regions, `gscores()` returns the score for every base pair within the range. You can summarize these scores or handle them as `Rle` (Run-Length Encoding) objects for efficiency.

## Key Functions and Objects

- `phastCons100way.UCSC.hg19`: The primary `GScores` object containing the data.
- `gscores(obj, ranges, ...)`: The main method to fetch scores for specific genomic intervals.
- `citation(phastCons100way.UCSC.hg19)`: Provides the publication details for the phastCons method and data.

## Tips for Usage

- **Genome Build**: This package is strictly for **hg19/GRCh37**. If your data is in hg38, you must lift over your coordinates to hg19 before querying this specific package, or use the hg38 version of the package.
- **Memory Efficiency**: The scores are stored as `Rle` objects, making them memory-efficient. Accessing them via `gscores()` is the recommended high-level interface.
- **Dependencies**: Ensure `GenomicScores` is installed, as it provides the necessary methods to interact with the `GScores` class.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)