---
name: bioconductor-alphamissense.v2023.hg19
description: This package provides access to AlphaMissense pathogenicity scores for missense variants in the hg19 human genome assembly. Use when user asks to retrieve pathogenicity predictions for genomic variants, query AlphaMissense scores using GenomicScores, or create a local annotation package for offline variant scoring.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AlphaMissense.v2023.hg19.html
---


# bioconductor-alphamissense.v2023.hg19

## Overview

The `AlphaMissense.v2023.hg19` package provides metadata and access to AlphaMissense pathogenicity scores for the human genome assembly hg19. AlphaMissense is a deep learning model developed by Google DeepMind that predicts the effects of missense variants. This package acts as a bridge to Bioconductor's `AnnotationHub`, allowing users to retrieve scores efficiently using the `GenomicScores` API.

## Core Workflow

### 1. Loading the Resource
To use these scores, you must use the `GenomicScores` package to fetch the data from `AnnotationHub`. Note that you must explicitly accept the CC BY-NC-SA 4.0 license.

```r
library(GenomicScores)

# Download/Load the AlphaMissense hg19 resource
am23 <- getGScores("AlphaMissense.v2023.hg19", accept.license=TRUE)
```

### 2. Retrieving Pathogenicity Scores
Use the `gscores()` function to query specific genomic coordinates. You should provide the reference (`ref`) and alternative (`alt`) alleles to get the specific missense prediction.

```r
library(GenomicRanges)

# Define the variant position (example: GCK gene variant)
variant <- GRanges("chr7:44185175")

# Retrieve the score
# 'default' column contains the pathogenicity score (0 to 1)
res <- gscores(am23, variant, ref="C", alt="T")
```

### 3. Interpreting Results
*   **Score Range:** Scores range from 0 to 1.
*   **Pathogenicity:** Higher scores indicate a higher probability of the variant being pathogenic.
*   **Metadata:** Use `citation(am23)` to get the correct publication details for the AlphaMissense model.

### 4. Creating an Offline Package
If you need to work without an internet connection, you can convert the `AnnotationHub` resource into a local R annotation package.

```r
makeGScoresPackage(am23, 
                   maintainer="Your Name <your@email.com>", 
                   author="Your Name", 
                   version="1.0.0")
```
This creates a package directory that can be installed via `R CMD INSTALL`.

## Tips and Best Practices
*   **Genome Build:** Ensure your input coordinates are in **hg19/GRCh37**. If your data is in hg38, use the `AlphaMissense.v2023.hg38` package instead.
*   **Caching:** The first call to `getGScores()` downloads a large file. Subsequent calls will use the local cache managed by `BiocFileCache`.
*   **Batch Queries:** For better performance, pass a `GRanges` object containing multiple variants to a single `gscores()` call rather than looping.

## Reference documentation
- [AlphaMissense.v2023.hg19 AnnotationHub Resource Metadata](./references/AlphaMissense.v2023.hg19.md)