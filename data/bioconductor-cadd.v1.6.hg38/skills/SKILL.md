---
name: bioconductor-cadd.v1.6.hg38
description: This tool retrieves CADD v1.6 pathogenicity scores for human genetic variants on the hg38 genome build. Use when user asks to annotate variants with pathogenicity scores, retrieve CADD scores for hg38, or prioritize functional variants using GenomicScores.
homepage: https://bioconductor.org/packages/release/data/annotation/html/cadd.v1.6.hg38.html
---


# bioconductor-cadd.v1.6.hg38

name: bioconductor-cadd.v1.6.hg38
description: Access and retrieve CADD (Combined Annotation Dependent Depletion) v1.6 pathogenicity scores for the human genome build hg38. Use this skill when you need to annotate human genetic variants with CADD scores to estimate their relative pathogenicity using Bioconductor's GenomicScores and AnnotationHub infrastructure.

# bioconductor-cadd.v1.6.hg38

## Overview

The `cadd.v1.6.hg38` package provides the metadata and infrastructure to access CADD v1.6 pathogenicity scores for the human genome (hg38). Instead of containing the raw data itself, it acts as a bridge to Bioconductor's `AnnotationHub`, allowing users to download, cache, and query scores efficiently using the `GenomicScores` API.

CADD scores are used to prioritize functional, deleterious, and disease-causing variants across a wide range of functional categories.

## Core Workflow

### 1. Load and Download Scores
To use these scores, you must first retrieve the `GScores` object. This requires an internet connection for the initial download, after which the data is cached locally.

```r
library(GenomicScores)
library(cadd.v1.6.hg38)

# Check available scores (optional)
# availableGScores()

# Download and load the CADD v1.6 hg38 resource
cadd <- getGScores("cadd.v1.6.hg38")
```

### 2. Querying Pathogenicity Scores
Use the `gscores()` function to retrieve scores for specific genomic coordinates. You should provide a `GRanges` object and, for CADD, specify the reference and alternative alleles to get the specific variant score.

```r
library(GenomicRanges)

# Define the variant (Example: chr7:44145576 C > T)
variant <- GRanges("chr7:44145576")

# Retrieve the score
# 'default' column in the output contains the CADD score
score_res <- gscores(cadd, variant, ref="C", alt="T")
```

### 3. Offline Usage (Package Creation)
If you need to work in an environment without internet access, you can convert the `AnnotationHub` resource into a standalone local annotation package.

```r
makeGScoresPackage(cadd, 
                   maintainer="Your Name <email@example.com>", 
                   author="Your Name", 
                   version="1.0.0")

# This creates a package directory which you then install via:
# R CMD INSTALL cadd.v1.6.hg38
```

## Tips and Best Practices
- **Caching**: The first call to `getGScores()` downloads a large dataset. Ensure you have sufficient disk space in your Bioconductor cache directory.
- **Allele Specificity**: CADD scores are allele-specific. Always provide `ref` and `alt` arguments in `gscores()` to ensure you are retrieving the score for the correct substitution.
- **Genome Build**: This package is strictly for **hg38**. For hg19/GRCh37, use the `cadd.v1.6.hg19` package instead.
- **Batch Queries**: For high-throughput annotation, pass a `GRanges` object containing multiple ranges to `gscores()` rather than calling the function in a loop.

## Reference documentation
- [Retrieval of cadd.v1.6.hg38 pathogenicity scores through AnnotationHub resources](./references/cadd.v1.6.hg38.md)