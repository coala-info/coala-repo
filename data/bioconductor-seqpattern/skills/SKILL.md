---
name: bioconductor-seqpattern
description: This tool visualizes oligonucleotide distributions and motif occurrences across centered genomic regions using density maps and average occurrence profiles. Use when user asks to visualize sequence patterns, generate dinucleotide density maps, plot motif occurrence averages, or scan for transcription factor binding sites in genomic sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/seqPattern.html
---

# bioconductor-seqpattern

name: bioconductor-seqpattern
description: Visualizing oligonucleotide sequence patterns, consensus sequences, and motif occurrences (PWMs) across centered and ordered genomic regions (e.g., promoters, enhancers, ChIP-seq peaks). Use this skill to generate dinucleotide density maps, average occurrence profiles, and motif scanning heatmaps for Bioconductor-based sequence analysis.

## Overview

The `seqPattern` package is designed for the visualization of sequence motifs and oligonucleotide distributions relative to a fixed reference point (like a Transcription Start Site). It is particularly powerful for identifying positionally constrained patterns and correlating them with genomic features (e.g., promoter width or expression levels).

## Core Workflow

### 1. Data Preparation
Input sequences must be provided as a `DNAStringSet`. Typically, these are centered on a reference point and have equal lengths.

```R
library(seqPattern)
library(BSgenome.Drerio.UCSC.danRer7)

# Example: Extracting sequences around TSS
# regions: GRanges object centered on TSS
# upstream/downstream: distance from center
regions_flank <- promoters(regions, upstream = 400, downstream = 800)
seqs <- getSeq(Drerio, regions_flank)
```

### 2. Visualizing Oligonucleotide Density
Use `plotPatternDensityMap` to create heatmaps of di-, tri-, or any oligonucleotide/IUPAC consensus sequence.

```R
# Plotting dinucleotide density ordered by a feature (e.g., width)
plotPatternDensityMap(
  regionsSeq = seqs,
  patterns = c("AA", "CG", "GC"),
  seqOrder = order(metadata$feature_value),
  flankUp = 400, 
  flankDown = 800,
  color = "blue"
)
```
*   **Patterns**: Supports IUPAC codes (e.g., "WW" for A/T, "SS" for G/C).
*   **nBin**: Controls resolution. Default is per-nucleotide/per-sequence.
*   **bandWidth**: Standard deviation for the 2D Gaussian kernel used to smooth density.

### 3. Average Occurrence Profiles
To compare groups (e.g., sharp vs. broad promoters), use `plotPatternOccurrenceAverage`.

```R
plotPatternOccurrenceAverage(
  regionsSeq = seqs[index_group1],
  patterns = c("WW", "SS"),
  flankUp = 400,
  flankDown = 800,
  smoothingWindow = 3,
  color = "red"
)
```

### 4. Motif Analysis (PWMs)
The package handles Position Weight Matrices (PWMs) to find and visualize transcription factor binding sites.

```R
# Load example PWM or provide a matrix
data(TBPpwm)

# Density Map of motif hits above a threshold
plotMotifDensityMap(
  regionsSeq = seqs,
  motifPWM = TBPpwm,
  minScore = "90%",
  seqOrder = order(metadata$feature_value),
  flankUp = 200,
  flankDown = 200
)

# Heatmap of raw scanning scores
plotMotifScanScores(regionsSeq = seqs, motifPWM = TBPpwm)
```

### 5. Extracting Data Without Plotting
If you need the raw coordinates of matches for downstream analysis:

*   `motifScanHits()`: Returns a data.frame with sequence index, position, and score.
*   `getPatternOccurrenceList()`: Returns coordinates for oligonucleotide/consensus matches.
*   `motifScanScores()`: Returns a matrix of PWM scores for every position in every sequence.

## Tips for Success
*   **Parallelization**: For multiple patterns, use `useMulticore = TRUE` and `nrCores = X` to speed up density calculations.
*   **Color Palettes**: Choose from "blue", "greencyan", "purple", "pink", "red", "orange", "brown", "gray".
*   **Coordinate Systems**: Ensure `flankUp` and `flankDown` correctly reflect your `DNAStringSet` construction so the x-axis labels are accurate.
*   **Strand Specificity**: To visualize the antisense strand for a consensus sequence, use the reverse complement of the pattern (e.g., for TATA-box "TATAWAWR", also plot "YWTWTATA").

## Reference documentation
- [seqPattern: an R package for visualisation of oligonucleotide sequence patterns and motif occurrences](./references/seqPattern.md)