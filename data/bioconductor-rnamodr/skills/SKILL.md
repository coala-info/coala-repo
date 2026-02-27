---
name: bioconductor-rnamodr
description: This tool detects post-transcriptional RNA modifications from high-throughput sequencing data by analyzing specific footprints in aligned reads. Use when user asks to detect RNA modifications like Inosine or RiboMethSeq, aggregate sequencing data from BAM files, or visualize modification scores across transcripts.
homepage: https://bioconductor.org/packages/release/bioc/html/RNAmodR.html
---


# bioconductor-rnamodr

name: bioconductor-rnamodr
description: Analysis of high-throughput sequencing data for post-transcriptional RNA modification footprints. Use this skill to detect RNA modifications (e.g., Inosine, RiboMethSeq) from BAM files, aggregate sequencing data, and visualize modification scores across transcripts.

# bioconductor-rnamodr

## Overview

The `RNAmodR` package provides a S4-class framework for detecting post-transcriptional RNA modifications from high-throughput sequencing data. It identifies modifications by analyzing specific "footprints" or patterns (like A-to-G conversions or RT-stops) in aligned reads. The workflow typically moves from raw data (`SequenceData`) to modification calling (`Modifier`) and multi-sample comparison (`ModifierSet`).

## Core Workflow

### 1. Data Preparation
Prepare a named character vector of BAM file paths. Names must be "treated" or "control".
```r
library(RNAmodR)
files <- c(treated = "path/to/rep1.bam", 
           treated = "path/to/rep2.bam", 
           control = "path/to/ctrl.bam")
annotation <- "annotation.gff3" # or TxDb object
sequences <- "genome.fasta"
```

### 2. Loading Sequence Data
Use specific subclasses to extract relevant features from BAM files.
- `End5SequenceData`: 5'-end positions.
- `PileupSequenceData`: Nucleotide counts (used for Inosine/A-to-G).
- `CoverageSequenceData`: Read coverage.
- `NormEnd5SequenceData`: Normalized 5'-ends.

```r
sd <- End5SequenceData(files, annotation = annotation, sequences = sequences)
```

### 3. Detecting Modifications (Modifier Class)
The `Modifier` class performs the statistical analysis to call modifications.
- `ModInosine`: Detects Inosine via A-to-G conversion.
- `ModRiboMethSeq`: (Requires `RNAmodR.RiboMethSeq`) Detects 2'-O-ribose methylation.
- `ModAlkAnilineSeq`: (Requires `RNAmodR.AlkAnilineSeq`) Detects m7G and m3C.

```r
# Create Modifier and find modifications
mi <- ModInosine(files, annotation = annotation, sequences = sequences)

# View/Adjust settings
settings(mi)
settings(mi) <- list(minScore = 0.5)
```

### 4. Working with Multiple Samples (ModifierSet)
To compare different conditions (e.g., WT vs Mutant), use `ModifierSet`.
```r
file_list <- list(WT = c(treated = "wt1.bam", treated = "wt2.bam"),
                  Mutant = c(treated = "mut1.bam", treated = "mut2.bam"))
msi <- ModSetInosine(file_list, annotation = annotation, sequences = sequences)
```

## Analysis and Visualization

### Extracting Results
Retrieve coordinates of detected modifications as `GRanges`.
```r
# Genomic coordinates
mod_gr <- modifications(mi)

# Transcript-relative coordinates
mod_tx <- modifications(mi, perTranscript = TRUE)
```

### Comparison and Performance
Compare scores across samples at specific coordinates.
```r
# Compare scores in a DataFrame
coord <- unique(unlist(modifications(msi)))
comparison <- compareByCoord(msi, coord)

# Plot ROC curve to evaluate performance
plotROC(msi, coord)
```

### Visualization
Generate coverage and score plots for specific transcripts.
```r
# Plot scores for a specific transcript
plotData(mi, name = "transcript_id", from = 1, to = 100)

# Plot with raw sequence data (pileup)
plotData(mi, name = "transcript_id", showSequenceData = TRUE)

# Heatmap comparison
plotCompareByCoord(msi, coord)
```

## Developer: Creating New Methods
To implement a new modification detection strategy, you must define:
1. A new `SequenceData` subclass (if existing ones like `End5` don't fit).
2. A new `Modifier` subclass.
3. Methods for `getData`, `aggregateData`, and `findMod`.

## Reference documentation
- [RNAmodR: analyzing high throughput sequencing data for post-transcriptional RNA modification footprints](./references/RNAmodR.md)
- [RNAmodR: creating classes for additional modification detection from high throughput sequencing](./references/RNAmodR.creation.md)