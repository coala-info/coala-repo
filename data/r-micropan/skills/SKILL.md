---
name: r-micropan
description: A collection of functions for computations and visualizations of microbial pan-genomes.</p>
homepage: https://cran.r-project.org/web/packages/micropan/index.html
---

# r-micropan

name: r-micropan
description: Expert guidance for microbial pan-genome analysis using the micropan R package. Use this skill when performing comparative genomics, calculating pangenome sizes, clustering gene families (ortholog groups), and conducting diversity analyses (Heaps' law, rarefaction) on microbial genomes.

## Overview
The `micropan` package provides a comprehensive set of tools for the study of microbial pan-genomes. It focuses on the analysis of gene families across multiple genomes, offering functions for distance calculation, clustering, and statistical modeling of pan-genome expansion (open vs. closed pan-genomes).

## Installation
To install the package from CRAN:
```r
install.packages("micropan")
library(micropan)
```

## Core Workflow

### 1. Sequence Pre-processing
Before pan-genome analysis, sequences must be prepared.
- Use `panPrep()` to standardize FASTA files (naming, headers) before BLAST or HMMER searches.
- This ensures locus tags are consistent across the dataset.

### 2. Identifying Orthologs (Clustering)
`micropan` supports two main approaches for grouping genes:

**A. Sequence Alignment (BLAST-based):**
- Use `blastpAllAll()` to run all-against-all protein BLAST (requires external BLAST+).
- Use `bDist()` to calculate alignment distances from BLAST results.
- Use `bClust()` to cluster sequences into gene families based on distances.

**B. Domain HMM Search (HMMER-based):**
- Use `hmmerScan()` to scan sequences against profile HMM databases like Pfam (requires external HMMER).
- Use `dClust()` to cluster sequences based on shared protein domains.

### 3. The Pan-matrix
The central data structure is the **Pan-matrix**, where rows are genomes and columns are gene families.
- Use `makePanMatrix()` to convert clustering results into a frequency matrix.

### 4. Pan-genome Statistics and Visualization
Once the pan-matrix is created, analyze the distribution of gene families:
- **Rarefaction:** Use `rarefaction()` to estimate how many new gene families are found as more genomes are sequenced.
- **Heaps' Law:** Use `heaps()` to estimate the "openness" of the pan-genome. An alpha parameter < 1 indicates an open pan-genome.
- **Fluidity:** Use `fluidity()` to calculate the genomic variation between randomly pulled pairs of genomes.
- **Binomial Mixture Models:** Use `binomMixMs()` to estimate the number of core, accessory, and rare genes.

## Tips for Version 2.0+
- **Data Structures:** `micropan` 2.0+ uses standard `tidyverse` structures (tibbles). Use `dplyr` and `stringr` for manual filtering of BLAST results or pan-matrices.
- **External Software:** Functions like `blastpAllAll()` and `hmmerScan()` are wrappers. Ensure `blast+` and `hmmer` are in your system PATH.
- **Visualization:** The package no longer includes internal plotting functions. Use `ggplot2` or `ggdendro` for custom visualizations of rarefaction curves or dendrograms.

## Reference documentation
- [The micropan package vignette](./references/vignette.md)