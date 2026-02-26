---
name: bioconductor-alphamissense.v2023.hg38
description: This package provides access to AlphaMissense pathogenicity scores for human genome assembly hg38 within the Bioconductor ecosystem. Use when user asks to retrieve variant effect predictions, query pathogenicity scores for missense variants, or create local annotation packages for offline genomic scoring.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AlphaMissense.v2023.hg38.html
---


# bioconductor-alphamissense.v2023.hg38

## Overview

The `AlphaMissense.v2023.hg38` package provides metadata and access to AlphaMissense pathogenicity scores for the human genome assembly hg38. AlphaMissense is a deep learning model developed by Google DeepMind that predicts the effects of missense variants. This package integrates these scores into the Bioconductor ecosystem via `AnnotationHub` and the `GenomicScores` API, allowing for efficient, reproducible, and programmatic retrieval of variant effect predictions.

## Core Workflow

### 1. Loading the Resource
The recommended way to interact with AlphaMissense scores is through the `GenomicScores` package.

```r
library(GenomicScores)
library(AlphaMissense.v2023.hg38)

# Check available scores
availableGScores()

# Download/Load the hg38 AlphaMissense resource
# Note: accept.license=TRUE is required for non-interactive sessions
am23 <- getGScores("AlphaMissense.v2023.hg38", accept.license=TRUE)
```

### 2. Retrieving Pathogenicity Scores
Use the `gscores()` function to query specific variants. You must provide the `GScores` object, the genomic coordinates (as a `GRanges` object), and the reference/alternate alleles.

```r
library(GenomicRanges)

# Example: Retrieve score for a specific variant (e.g., GCK gene)
# Coordinates: chr7:44145576, Ref: C, Alt: T
res <- gscores(am23, 
               GRanges("chr7:44145576"), 
               ref="C", 
               alt="T")

# View results
# The 'default' column contains the AlphaMissense pathogenicity score (0 to 1)
# Scores > 0.564 are generally considered likely pathogenic
print(res)
```

### 3. Creating an Offline Annotation Package
If you need to work without an internet connection, you can convert the `AnnotationHub` resource into a local R package.

```r
makeGScoresPackage(am23, 
                   maintainer="Your Name <email@example.com>", 
                   author="Your Name", 
                   version="1.0.0",
                   destDir=".")
```
After running this, you must install the resulting directory using `R CMD INSTALL` or `devtools::install()`.

## Usage Tips
- **License**: AlphaMissense data is distributed under a CC BY-NC-SA 4.0 license. Always use `accept.license=TRUE` in scripts.
- **Caching**: The first call to `getGScores()` downloads a large file. Subsequent calls will use the local cache managed by `BiocFileCache`.
- **Score Interpretation**: AlphaMissense scores range from 0 to 1. According to the original publication, thresholds are typically:
  - Likely benign: < 0.34
  - Likely pathogenic: > 0.564
  - Uncertain: 0.34 - 0.564

## Reference documentation
- [Retrieval of AlphaMissense.v2023.hg38 pathogenicity scores through AnnotationHub resources](./references/AlphaMissense.v2023.hg38.md)