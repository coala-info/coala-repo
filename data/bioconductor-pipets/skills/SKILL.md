---
name: bioconductor-pipets
description: This tool identifies bacterial transcription termination peaks from 3'-seq or Term-seq data using a sliding-window Poisson distribution test. Use when user asks to identify transcription termination signals, process aligned bacterial sequencing reads, or find statistically significant termination sites across a genome.
homepage: https://bioconductor.org/packages/release/bioc/html/PIPETS.html
---


# bioconductor-pipets

name: bioconductor-pipets
description: Analyze 3'-seq or Term-seq data to identify bacterial transcription termination peaks using a Poisson Distribution Test. Use this skill when you need to process aligned bacterial sequencing reads (Bed files or GRanges) to find statistically significant termination sites across the entire genome.

# bioconductor-pipets

## Overview

PIPETS (Poisson Identification of PEaks from Term-Seq data) is a Bioconductor package designed to identify transcription termination signals in bacteria. Unlike gene-centric tools, PIPETS analyzes the entire genome using a sliding-window Poisson distribution test to differentiate true termination peaks from background noise. It is particularly effective for identifying premature termination, attenuation, and operon-internal signals.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("PIPETS")
library(PIPETS)
```

## Core Workflow

The primary interface is the `PIPETS_FullRun` function, which handles data splitting, significance testing, and peak condensing.

### 1. Using Bed File Input
Provide a path to a Bed file. The file must contain at least: `chrom`, `chromStart`, `chromStop`, `score`, and `strand`.

```R
PIPETS_FullRun(
  inputData = "path/to/data.bed",
  readScoreMinimum = 30,
  OutputFileID = "Experiment_Prefix",
  OutputFileDir = tempdir(),
  inputDataFormat = "bedFile"
)
```

### 2. Using GRanges Input
If data is already in R, use a `GRanges` object. This returns a list where the first element is the Plus-strand results and the second is the Minus-strand results.

```R
# Example conversion from data frame to GRanges
gr <- GRanges(
  seqnames = df$V1,
  ranges = IRanges(start = df$V2, end = df$V3),
  score = df$V5,
  strand = df$V6
)

results <- PIPETS_FullRun(
  inputData = gr,
  readScoreMinimum = 30,
  OutputFileID = "GRanges_Run",
  OutputFileDir = tempdir(),
  inputDataFormat = "GRanges"
)
```

## Parameter Tuning

Adjust these parameters to refine sensitivity or handle strand-specific noise:

- **Significance**: `user_pValue` (default 0.0005) sets the threshold for the Poisson test and Benjamini-Hochberg correction.
- **Global Cutoff**: `threshAdjust` (default 0.75) and `highOutlierTrim` (default 0.01) define the background noise floor.
- **Strand-Specific Analysis**: If one strand has significantly higher depth, set `threshAdjust = NA` and `highOutlierTrim = NA`, then specify `threshAdjust_TopStrand`, `threshAdjust_CompStrand`, etc.
- **Windowing**: `slidingWindowSize` (default 25, resulting in a 51bp window) and `slidingWindowMovementDistance` (default 25).
- **Peak Condensing**: `adjacentPeakDistance` (default 2bp) merges nearby significant positions; `peakCondensingDistance` (default 20bp) merges proximal peaks.

## Interpreting Results

PIPETS generates four files (when using Bed input) or returns a list (when using GRanges):
1. **Strand-split Bed files**: Raw counts separated by strand.
2. **Termination Peaks**: A table/GRanges object containing:
   - The coordinate with the highest termination coverage.
   - The peak coverage value.
   - The full genomic range (start/end) of the identified peak.

## Reference documentation

- [Analyzing 3’-seq/Term-seq Data with PIPETS](./references/PIPETS.md)