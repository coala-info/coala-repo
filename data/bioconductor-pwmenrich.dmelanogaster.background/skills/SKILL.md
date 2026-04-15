---
name: bioconductor-pwmenrich.dmelanogaster.background
description: This package provides pre-compiled genomic background models and motifs for Drosophila melanogaster to support motif enrichment analysis with PWMEnrich. Use when user asks to perform motif enrichment analysis in Drosophila, load pre-calculated background distributions for dm3, or identify over-represented transcription factor binding sites.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PWMEnrich.Dmelanogaster.background.html
---

# bioconductor-pwmenrich.dmelanogaster.background

name: bioconductor-pwmenrich.dmelanogaster.background
description: Provides pre-compiled genomic background objects and MotifDb motifs for Drosophila melanogaster (dm3) to be used with the PWMEnrich package. Use this skill when performing motif enrichment analysis in D. melanogaster to avoid the computationally expensive step of generating background distributions from scratch.

# bioconductor-pwmenrich.dmelanogaster.background

## Overview

The `PWMEnrich.Dmelanogaster.background` package is a data-only experiment package for Bioconductor. It contains pre-compiled background models (lognormal and distribution-free) specifically for *Drosophila melanogaster* (UCSC dm3). These backgrounds are built using 2kb promoter sequences from 10,031 unique genes.

This package is designed to be used in conjunction with the `PWMEnrich` package to identify over-represented transcription factor binding sites (motifs) in DNA sequences.

## Loading Data and Backgrounds

The package provides several types of background objects. You must load them using the `data()` function before passing them to `PWMEnrich` functions.

```r
library(PWMEnrich)
library(PWMEnrich.Dmelanogaster.background)

# 1. Load MotifDb PWMs for Drosophila
data(MotifDb.Dmel) 

# 2. Load Lognormal background (Recommended for threshold-free enrichment)
data(PWMLogn.dm3.MotifDb.Dmel)

# 3. Load Z-score backgrounds with specific score cutoffs (base e)
data(PWMCutoff4.dm3.MotifDb.Dmel)
data(PWMCutoff5.dm3.MotifDb.Dmel)

# 4. Load P-value cutoff backgrounds
data(PWMPvalueCutoff1e2.dm3.MotifDb.Dmel) # P < 0.01
data(PWMPvalueCutoff1e3.dm3.MotifDb.Dmel) # P < 0.001
```

## Typical Workflow

The primary use case is to pass a pre-compiled background object to the `motifEnrichment()` function.

### Single Sequence Enrichment

```r
library(Biostrings)

# Define your sequence of interest
my_seq <- DNAString("TGCATCAAGTGTGTAGTGCGATGAATGC")

# Perform enrichment using the pre-compiled lognormal background
res <- motifEnrichment(my_seq, PWMLogn.dm3.MotifDb.Dmel)

# View top ranked motifs
report <- motifRankingForGroup(res)
head(report)
```

### Accessing Raw Motifs

If you need the raw Position Frequency Matrices (PFMs) from MotifDb:

```r
data(MotifDb.Dmel.PFM)
# This returns a list of 740 PFMs
```

## Key Objects

- `MotifDb.Dmel`: A list of PWMs generated using D. melanogaster background frequencies.
- `PWMLogn.dm3.MotifDb.Dmel`: Threshold-free lognormal background fitted to 1kb fragments of 2kb promoters.
- `dm3.upstream2000`: 2kb upstream sequences for Drosophila genes (dm3).

## Tips for Usage

- **Genome Version**: These backgrounds are specifically for the **dm3** (BDGP Release 5) assembly. If you are working with dm6, these backgrounds may not be perfectly accurate, though they are often used as a proxy for general Drosophila promoter composition.
- **Memory Management**: These background objects can be large. Only load the specific background (Lognormal vs. Cutoff) that you intend to use for your analysis.
- **Function Compatibility**: Use these objects as the `background` argument in `PWMEnrich` functions like `motifEnrichment()` and `motifScores()`.

## Reference documentation

- [PWMEnrich.Dmelanogaster.background Reference Manual](./references/reference_manual.md)