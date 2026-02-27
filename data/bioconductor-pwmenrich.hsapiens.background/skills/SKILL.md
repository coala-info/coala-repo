---
name: bioconductor-pwmenrich.hsapiens.background
description: This package provides pre-compiled genomic background distributions and motif data for DNA motif enrichment analysis in human sequences using the PWMEnrich package. Use when user asks to perform motif enrichment analysis on human DNA sequences, load hg19 background models, or calculate the significance of motif matches using MotifDb motifs.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PWMEnrich.Hsapiens.background.html
---


# bioconductor-pwmenrich.hsapiens.background

name: bioconductor-pwmenrich.hsapiens.background
description: Provides pre-compiled genomic background objects for the PWMEnrich package specifically for Homo sapiens (human). Use this skill when performing DNA motif enrichment analysis in human sequences (hg19) using MotifDb motifs. It includes lognormal and Z-score background distributions fitted to human promoter sequences.

# bioconductor-pwmenrich.hsapiens.background

## Overview

The `PWMEnrich.Hsapiens.background` package is a data-only experiment package for Bioconductor. It provides the necessary background distributions (null models) required by the `PWMEnrich` package to calculate the significance of motif enrichment in human DNA sequences. These backgrounds are pre-compiled using 2kb promoter regions from the hg19 genome build and motifs from `MotifDb`.

## Loading Background Data

To use these backgrounds, you must load the package and then use the `data()` function to load the specific background object into your R session.

```R
library(PWMEnrich)
library(PWMEnrich.Hsapiens.background)

# List available objects
# data(package = "PWMEnrich.Hsapiens.background")

# Load the lognormal background (recommended for most uses)
data(PWMLogn.hg19.MotifDb.Hsap)

# Load the raw PWMs or PFMs
data(MotifDb.Hsap)
data(MotifDb.Hsap.PFM)
```

## Typical Workflow

The primary use case is passing a pre-compiled background object to the `motifEnrichment()` function from the `PWMEnrich` package.

### 1. Motif Enrichment Analysis
Perform enrichment on a `DNAString` or `DNAStringSet` using the pre-compiled lognormal background.

```R
library(Biostrings)

# Example sequence
seq <- DNAString("TGCATCAAGTGTGTAGTGCAAGTGAGTGATGAGTAGAAGTTGAGTGAGGTAGATGC")

# Run enrichment using the loaded background object
res <- motifEnrichment(seq, PWMLogn.hg19.MotifDb.Hsap)

# View top enriched motifs
report <- groupReport(res)
print(report[1:10])
```

### 2. Choosing a Background Type
The package provides different statistical models for background:

*   **Lognormal (`PWMLogn.hg19.MotifDb.Hsap`)**: Threshold-free; fits a lognormal distribution to 500bp chunks of promoters. Generally recommended.
*   **Z-score with Fixed Cutoff (`PWMCutoff4...`, `PWMCutoff5...`)**: Counts hits based on a fixed PWM score cutoff (base e).
*   **Z-score with P-value Cutoff (`PWMPvalueCutoff1e2...`, etc.)**: Counts hits where the motif match P-value is better than 0.01, 0.001, or 0.0001.

## Available Data Objects

*   `MotifDb.Hsap.PFM`: Position Frequency Matrices for human motifs.
*   `MotifDb.Hsap`: Position Weight Matrices (PWMs) generated using human promoter nucleotide frequencies.
*   `hg19.upstream2000`: 2kb upstream sequences for human genes (hg19).
*   `PWMLogn.hg19.MotifDb.Hsap`: Lognormal background.
*   `PWMCutoff4.hg19.MotifDb.Hsap`: Z-score background (cutoff 4).
*   `PWMCutoff5.hg19.MotifDb.Hsap`: Z-score background (cutoff 5).
*   `PWMPvalueCutoff1e2.hg19.MotifDb.Hsap`: P-value cutoff 0.01.
*   `PWMPvalueCutoff1e3.hg19.MotifDb.Hsap`: P-value cutoff 0.001.
*   `PWMPvalueCutoff1e4.hg19.MotifDb.Hsap`: P-value cutoff 0.0001.

## Tips
*   **Genome Build**: These backgrounds are specifically compiled for **hg19**. If you are working with hg38, you should ideally compile a custom background using `PWMEnrich::makeBackground()`, though hg19 backgrounds are often used as a proxy if promoter composition is similar.
*   **Memory**: These objects can be large. Only load the specific background model you intend to use.

## Reference documentation
- [PWMEnrich.Hsapiens.background Reference Manual](./references/reference_manual.md)