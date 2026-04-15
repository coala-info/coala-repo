---
name: bioconductor-reqon
description: ReQON recalibrates nucleotide quality scores for aligned NGS data in BAM format using logistic regression to improve the accuracy of Phred scores. Use when user asks to recalibrate quality scores in BAM files, generate diagnostic plots of quality score distributions, or calculate Frequency-Weighted Squared Error to assess sequencing quality.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ReQON.html
---

# bioconductor-reqon

name: bioconductor-reqon
description: Recalibrate nucleotide quality scores for aligned NGS data in BAM format using logistic regression. Use this skill when you need to improve the accuracy of Phred quality scores in BAM files, generate diagnostic plots of quality score distributions (Reported vs. Empirical), or calculate Frequency-Weighted Squared Error (FWSE) to assess sequencing quality.

## Overview

ReQON (Recalibrating Quality Of Nucleotides) is a Bioconductor package designed to recalibrate quality scores in BAM files so they more accurately reflect the true probability of sequencing errors. It uses a logistic regression model trained on a subset of the data (or the whole file) to replace original QUAL values with recalibrated Phred+33 scores.

## Core Workflow

The primary function is `ReQON()`. It requires a sorted and indexed BAM file.

### 1. Preparation
Ensure the BAM file is sorted and indexed. You can use `Rsamtools` if the file is not yet processed.

```r
library(ReQON)
library(Rsamtools)

# Sort and index if necessary
sorted_bam <- sortBam("input.bam", "input_sorted")
indexBam(sorted_bam)
```

### 2. Running Recalibration
The `ReQON` function performs the training and produces a new BAM file.

```r
diagnostics <- ReQON(
    in_bam = "input_sorted.bam",
    out_bam = "recalibrated.bam",
    region = "chr1:1-1000000", # Training region
    RefSeq = "reference.txt",   # Optional: 3-column text file (chrom, pos, base)
    nerr = 2,                  # Max errors allowed per position for training
    nraf = 0.05,               # Max non-reference allele frequency for training
    plotname = "output_plots.pdf"
)
```

### 3. Key Parameters
- `region`: The genomic region used for training the model (e.g., "chr1:1-20000000"). For large datasets, training on 10-25 million bases is recommended.
- `RefSeq`: A file used to identify errors. If omitted, errors are identified as nucleotides not matching the major allele (for coverage > 2).
- `SNP`: Optional file of known SNP locations to exclude from training to avoid confusing biological variants with sequencing errors.
- `max_train`: Maximum number of nucleotides to include in the training set.

## Diagnostic Outputs

The `ReQON` function returns a list containing data used for quality assessment:

- `ReadPosErrors`: Distribution of errors by position in the read.
- `QualFreqBefore` / `QualFreqAfter`: Frequency distribution of quality scores.
- `ErrRatesBefore` / `ErrRatesAfter`: Empirical error rates for each reported quality score.
- `FWSE`: Frequency-Weighted Squared Error (lower is better).

### Manual Plotting
You can recreate diagnostic plots using specific functions:

```r
# Error distribution by read position
ReadPosErrorPlot(diagnostics$ReadPosErrors, startpos = 0)

# Quality score frequency comparison
QualFreqPlot(diagnostics$QualFreqBefore, diagnostics$QualFreqAfter)

# Reported vs Empirical Quality (Before)
fwse_val <- FWSEplot(diagnostics$ErrRatesBefore, diagnostics$QualFreqBefore, col = "blue")
```

## Troubleshooting

- **BAM Index Errors**: Ensure the `.bai` file is in the same directory as the `.bam` file.
- **Sorting Warnings**: If the BAM header does not indicate it is sorted (common with SAMTools output), ReQON will issue a warning. Ensure the file is actually sorted by coordinate.
- **Paired-end Mates**: If mates have different reference names, use `samtools fixmate` before running ReQON.
- **Version Check**: Ensure you are using ReQON version 1.3.7 or later for full parameter support (`nerr`, `nraf`).

## Reference documentation

- [ReQON](./references/ReQON.md)