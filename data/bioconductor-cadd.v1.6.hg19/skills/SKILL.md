---
name: bioconductor-cadd.v1.6.hg19
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/cadd.v1.6.hg19.html
---

# bioconductor-cadd.v1.6.hg19

name: bioconductor-cadd.v1.6.hg19
description: Access and retrieve CADD (Combined Annotation Dependent Depletion) pathogenicity scores for human genetic variants (hg19/GRCh37) using the GenomicScores and AnnotationHub framework. Use this skill when you need to annotate genomic coordinates with CADD v1.6 scores to estimate the relative pathogenicity of variants.

## Overview

The `cadd.v1.6.hg19` package provides the metadata and infrastructure to access CADD v1.6 pathogenicity scores for the human genome assembly hg19. Instead of storing the massive CADD dataset locally, it utilizes the `AnnotationHub` and `GenomicScores` frameworks to download and cache scores on demand. CADD scores are widely used to prioritize functional, non-coding, and coding variants by integrating multiple annotations into a single metric.

## Core Workflow

### 1. Load the Resource
To use these scores, you must first retrieve the `GScores` object using the `GenomicScores` package.

```r
library(GenomicScores)
library(cadd.v1.6.hg19)

# Check available scores (optional)
# availableGScores()

# Download/Load the CADD hg19 resource
cadd <- getGScores("cadd.v1.6.hg19")
```

### 2. Retrieve Pathogenicity Scores
Use the `gscores()` function to query specific genomic positions. You should provide the reference and alternate alleles for accurate CADD scoring.

```r
library(GenomicRanges)

# Define the variant position (hg19 coordinates)
# Example: NM_000162.5(GCK):c.1174C>T (p.Arg392Cys)
variant <- GRanges("chr7:44185175")

# Query the score
res <- gscores(cadd, variant, ref="C", alt="T")
# The score is found in the 'default' metadata column
score <- mcols(res)$default
```

### 3. Batch Annotation
You can pass a `GRanges` object containing multiple ranges to `gscores()` for efficient batch processing.

```r
# Example batch query
variants <- GRanges(c("chr7:44185175", "chr7:44185180"))
batch_scores <- gscores(cadd, variants)
```

## Offline Usage
If you need to work without an internet connection after the initial download, you can package the cached resource into a local R annotation package.

```r
makeGScoresPackage(cadd, 
                   maintainer="Your Name <email@example.com>", 
                   author="Your Name", 
                   version="1.0.0")
# This creates a package directory that can be installed via R CMD INSTALL
```

## Tips and Interpretation
- **Score Meaning**: Higher CADD scores indicate a higher probability that a variant is deleterious. A score of 10 indicates the variant is among the top 10% of most deleterious substitutions; a score of 20 indicates the top 1%, and 30 indicates the top 0.1%.
- **Genome Build**: Ensure your input coordinates are strictly **hg19**. For hg38, use the `cadd.v1.6.hg38` package instead.
- **Allele Specificity**: CADD scores are allele-specific. Always provide `ref` and `alt` arguments in `gscores()` when available to ensure you are retrieving the correct score for the specific substitution.

## Reference documentation

- [cadd.v1.6.hg19 AnnotationHub Resource Metadata](./references/cadd.v1.6.hg19.md)