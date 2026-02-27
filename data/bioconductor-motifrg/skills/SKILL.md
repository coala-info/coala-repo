---
name: bioconductor-motifrg
description: This tool discovers discriminative DNA motifs in high-throughput sequencing data by comparing foreground and background sequence sets. Use when user asks to identify over-represented motifs, perform discriminative motif discovery, or refine motifs using logistic regression and IUPAC degenerate letters.
homepage: https://bioconductor.org/packages/3.11/bioc/html/motifRG.html
---


# bioconductor-motifrg

name: bioconductor-motifrg
description: Discover and analyze discriminative motifs in high-throughput sequencing data (e.g., ChIP-seq). Use this skill when needing to identify over-represented DNA motifs by comparing a foreground sequence set (peaks) against a background set (control) using logistic regression and IUPAC refinement.

# bioconductor-motifrg

## Overview

The `motifRG` package provides a framework for discriminative motif discovery. Unlike tools that model genomic background distributions, `motifRG` identifies motifs that best distinguish a foreground dataset (e.g., ChIP-seq binding sites) from a background dataset (e.g., non-binding regions or genomic null models). It uses an exhaustive n-mer search followed by iterative refinement using IUPAC degenerate letters and logistic regression to measure statistical significance.

## Core Workflow

### 1. Motif Discovery from FASTA Files
The simplest entry point is using FASTA files for foreground and background sequences.

```r
library(motifRG)

# Find motifs comparing foreground to background
MD.motifs <- findMotifFasta(
  fg.file = "path/to/foreground.fa",
  bg.file = "path/to/background.fa",
  max.motif = 3,   # Number of motifs to find
  enriched = TRUE  # Search for enriched (vs depleted) motifs
)
```

### 2. Motif Discovery from Genomic Coordinates
If you have coordinates (e.g., from a BED file or GRanges object), use `getSequence` with a `BSgenome` object.

```r
library(BSgenome.Hsapiens.UCSC.hg19)

# Extract sequences
fg.seq <- getSequence(fg.ranges, genome = Hsapiens)
bg.seq <- getSequence(bg.ranges, genome = Hsapiens)

# Discover motifs
motifs <- findMotifFgBg(fg.seq, bg.seq, enriched = TRUE)
```

### 3. Refining Results and Handling Bias
ChIP-seq data often contains GC bias or varying peak widths that can lead to false positives.

*   **Narrowing Peaks:** Focus on the center of peaks to increase signal-to-noise.
*   **GC Correction:** Pass GC content as a covariate (`other.data`).
*   **Weighting:** Weight sequences by peak intensity.

```r
# Example: Refined search with GC and weights
# 1. Create category vector (1 for fg, 0 for bg)
category <- c(rep(1, length(fg.seq)), rep(0, length(bg.seq)))

# 2. Calculate GC bins
all.seq <- append(fg.seq, bg.seq)
gc <- as.integer(cut(letterFrequency(all.seq, "CG", as.prob=TRUE), 
                 c(-1, 0.4, 0.45, 0.5, 0.55, 0.6, 2)))

# 3. Run discovery with covariates
refined.motifs <- findMotif(
  all.seq, 
  category, 
  other.data = gc, 
  weights = c(fg.weights, rep(1, length(bg.seq))),
  max.motif = 5,
  enriched = TRUE
)
```

### 4. PWM Refinement and Extension
Motifs found by `findMotif` are often short seeds. Use EM-like algorithms to extend them into full Position Weight Matrices (PWM).

```r
# Refine a specific motif match from the results
seed_pattern <- motifs$motifs[[1]]@match$pattern
pwm.match <- refinePWMMotif(seed_pattern, fg.seq)

# Automatically extend the motif into flanking regions
pwm.extended <- refinePWMMotifExtend(seed_pattern, fg.seq)

# Visualize
library(seqLogo)
seqLogo(pwm.extended$model$prob)
plotMotif(pwm.extended$match$pattern)
```

## Visualization and Reporting

`motifRG` provides tools to summarize discovered motifs in tables or plots.

*   **Summary Table:** `motifLatexTable(motifs, prefix="my_analysis")` generates a summary of consensus sequences, scores, and fold-enrichment.
*   **Plotting:** `plotMotif(motifs$motifs[[1]]@match$pattern)` visualizes the alignment of matches.

## Tips for Success
*   **Control Selection:** The choice of background is critical. If possible, use a control dataset with a similar GC distribution and genomic context (e.g., promoters vs. intergenic) to the foreground.
*   **Peak Width:** If peaks are very wide (>500bp), sub-select the central 200bp to improve the specificity of the discovered motifs.
*   **IUPAC Codes:** The package uses IUPAC degenerate letters (e.g., R for A/G, Y for C/T) during the refinement step to capture biological variability.

## Reference documentation
- [motifRG](./references/motifRG.md)