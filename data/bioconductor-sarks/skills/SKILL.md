---
name: bioconductor-sarks
description: bioconductor-sarks identifies sequence motifs and multi-motif domains that correlate with numeric scores using suffix array kernel smoothing. Use when user asks to find k-mers associated with continuous variables like gene expression, perform de novo motif discovery without binary classification, or identify clusters of motifs in DNA sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/sarks.html
---


# bioconductor-sarks

name: bioconductor-sarks
description: De novo discovery of correlative sequence motifs and multi-motif domains (MMDs) using Suffix Array Kernel Smoothing (SArKS). Use this skill when you need to identify sequence patterns (k-mers) in DNA or other alphabets that correlate with numeric scores (e.g., gene expression levels, binding affinities).

# bioconductor-sarks

## Overview

The `sarks` package implements the Suffix Array Kernel Smoothing algorithm to identify sequence motifs whose presence is significantly associated with numeric scores assigned to those sequences. Unlike traditional motif discovery which often relies on binary classification (e.g., "target" vs "background"), `sarks` uses the full range of numeric scores. It employs suffix arrays for efficient string processing and kernel smoothing to detect regions in the suffix space where high-scoring sequences cluster.

## Core Workflow

### 1. Initialization and Java Setup
`sarks` relies on `rJava`. You must initialize the Java Virtual Machine with sufficient heap space before loading the library.

```R
options(java.parameters = '-Xmx8G') # Adjust memory as needed
library(rJava)
.jinit()
library(sarks)
```

### 2. Input Data Requirements
- **Sequences**: A named character vector or a FASTA file path.
- **Scores**: A named numeric vector where names match the sequence names.

```R
# Example using package data
data(simulatedSeqs)
data(simulatedScores)
```

### 3. Running the SArKS Analysis
The analysis follows a specific sequence: object creation, filter definition, permutation testing for thresholds, and peak calling.

```R
# 1. Create Sarks object
# halfWindow: smoothing window size (try n/20, n/10, n/5 where n is sequence count)
# spatialLength: for spatial smoothing (MMDs); set to 0 to disable
sarks <- Sarks(simulatedSeqs, simulatedScores, halfWindow=4, spatialLength=0)

# 2. Define filters
# minGini: 1.1 is a recommended starting point to filter repetitive sequence bias
filters <- sarksFilters(halfWindow=4, spatialLength=0, minGini=1.1)

# 3. Generate permutation distribution (Null model)
permDist <- permutationDistribution(sarks, reps=250, filters, seed=123)

# 4. Calculate thresholds
# nSigma: stringency (e.g., 2.0 for discovery, 5.0 for high stringency)
thresholds <- permutationThresholds(filters, permDist, nSigma=2.0)

# 5. Identify k-mer peaks
peaks <- kmerPeaks(sarks, filters, thresholds)
```

### 4. Refining Results
Raw peaks often contain redundant or overlapping k-mers. Use these functions to simplify output:

```R
# Remove redundant sub-peaks
nonRedundant <- mergedKmerSubPeaks(sarks, filters, thresholds)

# Extend k-mers to their full length in the source sequences
extended <- extendKmers(sarks, nonRedundant)
```

### 5. Spatial Smoothing (MMDs)
To detect Multi-Motif Domains (clusters of motifs), set `spatialLength` > 0. This requires higher `nSigma` values.

```R
sarksSpatial <- Sarks(simulatedSeqs, simulatedScores, halfWindow=4, spatialLength=3)
filtersSpatial <- sarksFilters(halfWindow=4, spatialLength=3, minGini=1.1)
# ... follow permutation steps ...
peaksSpatial <- kmerPeaks(sarksSpatial, filtersSpatial, thresholdsSpatial)
```

## Key Functions and Parameters

- `Sarks()`: Main constructor. Use `nThreads` for multithreading permutational analysis.
- `sarksFilters()`: Defines the parameter space to test. You can pass vectors to `halfWindow` or `spatialLength` to test multiple combinations simultaneously.
- `kmerCounts()`: Utility to count occurrences of identified k-mers across the input sequences.
- `clusterKmers()`: Groups similar k-mers into broader motifs. Use `directional=FALSE` for DNA if reverse complements should be treated as the same motif.
- `estimateFalsePositiveRate()`: Validates the significance of the results using an independent set of permutations.

## Tips for Success
- **Memory**: SArKS is memory-intensive due to suffix array construction. Always set `-Xmx` in `java.parameters` before loading the package.
- **Gini Filter**: If you get too many false positives from a single sequence dominating a window, increase `minGini` (values > 1 are more stringent).
- **Multiple Testing**: The `estimateFalsePositiveRate` function accounts for testing multiple parameter combinations defined in the `filters` object (Family-Wise Error Rate).

## Reference documentation
- [Suffix Array Kernel Smoothing for de novo discovery of correlative sequence motifs and multi-motif domains: the sarks package](./references/sarks-vignette.md)