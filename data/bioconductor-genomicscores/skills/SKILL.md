---
name: bioconductor-genomicscores
description: The GenomicScores package provides a unified interface for efficiently storing, discovering, and retrieving genomewide position-specific scores such as conservation, pathogenicity, and allele frequencies. Use when user asks to load genomic score datasets, retrieve scores for specific genomic ranges or alleles, or summarize scores over regions.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicScores.html
---

# bioconductor-genomicscores

## Overview

The `GenomicScores` package provides a unified interface for storing and accessing genomewide position-specific scores in Bioconductor. It uses lossy compression (quantization) and Run-Length Encoding (Rle) to efficiently handle massive datasets like conservation scores (phastCons, phyloP), pathogenicity metrics (CADD, AlphaMissense), and Minor Allele Frequencies (MAF). Data is accessed via `GScores` objects, which can be loaded from standalone annotation packages or retrieved from `AnnotationHub`.

## Core Workflows

### 1. Discovering and Loading Scores

Use `availableGScores()` to see what data is available and how to obtain it (via BiocManager or AnnotationHub).

```r
library(GenomicScores)

# List all available score sets
avgs <- availableGScores()

# Load from an installed annotation package
library(phastCons100way.UCSC.hg38)
phast <- phastCons100way.UCSC.hg38

# Retrieve from AnnotationHub (cached locally)
# Example: phyloP scores or AlphaMissense
phylop <- getGScores("phyloP100way.UCSC.hg38")
am23 <- getGScores("AlphaMissense.v2023.hg38", accept.license=TRUE)
```

### 2. Retrieving Scores for Genomic Ranges

The primary functions for data retrieval are `gscores()` (returns a GRanges object with scores) and `score()` (returns a numeric vector).

```r
library(GenomicRanges)
query <- GRanges("chr22:50528591-50528596")

# Get scores as metadata in GRanges
res <- gscores(phast, query)

# Get scores as a simple numeric vector
vals <- score(phast, query)
```

### 3. Handling Multiple Alleles (Pathogenicity Scores)

For scores that depend on the specific nucleotide substitution (like CADD or AlphaMissense), provide the `ref` and `alt` alleles.

```r
# query_gr should have REF and ALT columns
query_gr$score <- score(am23, query_gr, ref=query_gr$REF, alt=query_gr$ALT)
```

### 4. Working with MAF Data

Minor Allele Frequency data is stored in `MafDb` or `MafH5` packages. These often contain multiple populations.

```r
library(MafH5.gnomAD.v4.0.GRCh38)
maf_obj <- MafH5.gnomAD.v4.0.GRCh38

# Check available populations
populations(maf_obj)

# Retrieve MAF for a specific population
mafs <- score(maf_obj, query_gr, pop="AF_allpopmax")
```

### 5. Summarizing Scores over Regions

If a query range is wider than 1bp, `gscores()` summarizes the values. The default is the arithmetic mean.

```r
# Use different summary functions
max_scores <- gscores(phast, query, summaryFun=max)
min_scores <- gscores(phast, query, summaryFun=min)
```

## Tips and Best Practices

*   **Memory Efficiency**: `GScores` objects load data per chromosome. If working with many variants, sort your `GRanges` by chromosome to minimize disk I/O.
*   **Default Populations**: Many score sets have a "default" population. Use `defaultPopulation(obj)` to check which one is active.
*   **Quantization**: Scores are often quantized to save space. If you need higher precision, check `populations(obj)` for versions with more decimal places (e.g., "DP2").
*   **Metadata**: Use `organism(obj)`, `provider(obj)`, and `citation(obj)` to retrieve provenance information for the scores.
*   **Offline Use**: If you download a resource via `AnnotationHub` and need to use it on a cluster without internet, use `makeGScoresPackage()` to wrap the `GScores` object into a standard R package for local installation.

## Reference documentation

- [An introduction to the GenomicScores package](./references/GenomicScores.md)