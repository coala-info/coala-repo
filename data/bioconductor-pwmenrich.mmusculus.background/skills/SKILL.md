---
name: bioconductor-pwmenrich.mmusculus.background
description: This package provides pre-compiled genomic background models and motifs for mouse (mm9) to support transcription factor motif enrichment analysis. Use when user asks to perform motif enrichment analysis in mouse sequences, load mm9 promoter backgrounds, or use MotifDb-derived position weight matrices for statistical significance testing.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PWMEnrich.Mmusculus.background.html
---

# bioconductor-pwmenrich.mmusculus.background

name: bioconductor-pwmenrich.mmusculus.background
description: Provides pre-compiled genomic background objects and motifs for M. musculus (mouse) to be used with the PWMEnrich package. Use this skill when performing transcription factor motif enrichment analysis in mouse sequences, specifically when requiring mm9 promoter backgrounds, MotifDb-derived PWMs, or lognormal/Z-score background distributions for statistical significance testing.

## Overview

The `PWMEnrich.Mmusculus.background` package is a data-support package for `PWMEnrich`. It contains pre-compiled background models based on 2kb upstream promoter sequences of the mouse (mm9) genome. These objects allow for rapid motif enrichment analysis without the need to computationally generate backgrounds from scratch.

Key components include:
- **MotifDb.Mmus**: PWMs for mouse motifs from MotifDb.
- **Background Objects**: Pre-calculated distributions (Lognormal, Z-score, P-value cutoffs) used to determine the significance of motif hits.
- **mm9.upstream2000**: 2kb upstream sequences for mouse genes.

## Loading Data and Backgrounds

To use these backgrounds, you must load the package and then use the `data()` function to load the specific background object required for your analysis.

```r
library(PWMEnrich)
library(PWMEnrich.Mmusculus.background)

# Load the lognormal background for MotifDb mouse motifs
data(PWMLogn.mm9.MotifDb.Mmus)

# Load the position frequency matrices
data(MotifDb.Mmus.PFM)
```

## Typical Workflow

The primary use case is passing a background object to the `motifEnrichment()` function from the `PWMEnrich` package.

### 1. Motif Enrichment Analysis
Perform enrichment on a DNA sequence (or `DNAStringSet`) using the pre-compiled lognormal background.

```r
library(Biostrings)

# Example sequence
seq = DNAString("TGCATCAAGTGTGTAGTGCAAGTGAGTGATGAATGC")

# Run enrichment
res = motifEnrichment(seq, PWMLogn.mm9.MotifDb.Mmus)

# View top results
report = groupReport(res)
print(report[1:10])
```

### 2. Choosing the Right Background
- **PWMLogn.mm9.MotifDb.Mmus**: Recommended for threshold-free affinity-based enrichment. It fits a lognormal distribution to 500bp chunks of promoters.
- **PWMCutoff4.mm9.MotifDb.Mmus / PWMCutoff5.mm9.MotifDb.Mmus**: Used for Z-score calculations based on the number of hits with a specific log-odds cutoff (4 or 5).
- **PWMPvalueCutoff1e2.mm9.MotifDb.Mmus**: Used for Z-score calculations based on P-value thresholds (0.01, 0.001, etc.).

## Tips and Best Practices

- **Genome Version**: Note that these backgrounds are specifically compiled for **mm9**. If working with mm10 or other assemblies, these backgrounds may serve as a proxy, but for maximum precision, you should generate a custom background using `makeBackground()` from the `PWMEnrich` package.
- **Memory Management**: These objects can be large. Only load the specific background object (`data(...)`) that matches your chosen statistical method.
- **Integration**: Use `registerPWMConfiguration()` from the `PWMEnrich` package if you want to set these mouse backgrounds as the default for subsequent calls.

## Reference documentation

- [PWMEnrich.Mmusculus.background package overview](./references/reference_manual.md)