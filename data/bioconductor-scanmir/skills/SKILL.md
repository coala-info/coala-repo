---
name: bioconductor-scanmir
description: This tool scans sequences for miRNA binding sites using biochemical affinity models to predict dissociation constants and repression scores. Use when user asks to predict miRNA binding sites, calculate site-level dissociation constants, identify non-canonical interactions, or aggregate matches into transcript-level repression scores.
homepage: https://bioconductor.org/packages/release/bioc/html/scanMiR.html
---

# bioconductor-scanmir

name: bioconductor-scanmir
description: Tools for scanning sequences for miRNA binding sites using biochemical affinity models (KdModels). Use when you need to predict miRNA binding sites, calculate dissociation constants (Kd), identify non-canonical sites, or aggregate site-level predictions into transcript-level repression scores.

## Overview

The `scanMiR` package provides a framework for identifying miRNA binding sites based on the biochemical models developed by McGeary, Lin et al. (2019). Unlike simple seed-matching tools, it uses `KdModel` objects to predict the dissociation constant (affinity) of specific 12-mer sites, accounting for flanking dinucleotides and non-canonical interactions. It also supports calculating supplementary 3' pairing and aggregating multiple sites into a single predicted repression score for a transcript.

## Core Workflows

### 1. Working with KdModels
`KdModel` objects store miRNA sequences and their 12-mer affinity parameters.

```r
library(scanMiR)

# Load example model
data(SampleKdModel)
SampleKdModel

# Plot affinity for top seeds
plotKdModel(SampleKdModel, what="seeds")

# Predict affinity for specific 12-mers
# log_kd is log(Kd) * 1000 (lower = stronger affinity)
assignKdType(c("CTAGCATTAAGT", "ACGTACGTACGT"), SampleKdModel)

# Create a custom model from a table of 12-mer log_kd values
# mod <- getKdModel(kd=kd_table, mirseq="...", name="my-miRNA")
```

### 2. Finding Binding Sites
The `findSeedMatches` function is the primary tool for scanning sequences.

```r
# Inputs: DNAStringSet (targets) and KdModel/Seed/miRNA sequence
data("SampleTranscript")
data("SampleKdModel")

# Basic scan (returns GRanges)
matches <- findSeedMatches(SampleTranscript, SampleKdModel, verbose = FALSE)

# Scan options:
# onlyCanonical = TRUE: Ignore non-canonical sites
# shadow = 15: Ignore sites in the first 15nt of the UTR
# minDist = 7: Minimum distance between matches of the same miRNA
matches <- findSeedMatches(SampleTranscript, SampleKdModel, 
                           onlyCanonical = FALSE, 
                           shadow = 15)

# Visualize a specific alignment
viewTargetAlignment(matches[1], SampleKdModel, SampleTranscript)
```

### 3. Distinguishing ORF and UTR
If sequences are provided as a `DNAStringSet`, you can specify ORF lengths to categorize matches.

```r
library(Biostrings)
# Add ORF.length to metadata
mcols(seqs)$ORF.length <- c(500, 600, ...) 

# findSeedMatches will now include an 'ORF' column (TRUE/FALSE)
matches <- findSeedMatches(seqs, SampleKdModel)
```

### 4. Aggregating Repression Scores
Aggregate individual site affinities into a transcript-level repression value based on the biochemical occupancy model.

```r
# On-the-fly aggregation during scanning
agg <- findSeedMatches(SampleTranscript, SampleKdModel, ret = "aggregated")

# Aggregating existing GRanges matches
# Requires log_kd column in matches
agg_results <- aggregateMatches(matches)

# Results include 'repression' (log fold change) and site counts
head(agg_results)
```

## Tips and Performance

- **Large Scans**: For transcriptome-wide scans, use `BP = BiocParallel::MulticoreParam(n)` for multithreading.
- **Memory Management**: Use `n_seeds` to limit the number of miRNAs processed at once, or `useTmpFiles = TRUE` to save intermediate results to disk.
- **Species Data**: Pre-computed `KdModel` collections for human, mouse, and rat are available in the `scanMiRData` package.
- **Special Sites**: The `notes` column in matches flags potential TDMD (Target-Directed miRNA Degradation) sites or slicing sites for circular RNAs.

## Reference documentation

- [miRNA affinity models and the KdModel class](./references/Kdmodels.md)
- [Scanning sequences for miRNA binding sites and exploring matches with scanMiR](./references/scanning.md)