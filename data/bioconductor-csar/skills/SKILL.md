---
name: bioconductor-csar
description: CSAR provides a statistical framework for identifying protein-DNA binding sites from ChIP-seq data by calculating enrichment scores and FDR-based thresholds. Use when user asks to calculate nucleotide-level hits, identify significant enrichment windows, call peaks, or map peaks to genomic features.
homepage: https://bioconductor.org/packages/release/bioc/html/CSAR.html
---

# bioconductor-csar

## Overview

CSAR (ChIP-Seq Analyzer in R) provides a robust statistical framework for identifying protein-DNA binding sites. It accounts for DNA fragment size by virtually extending reads and requires enrichment support from both strands to minimize PCR artifacts. The workflow involves calculating nucleotide-level "hits," scoring enrichment against a control, identifying significant windows, and mapping these regions to genomic features (genes).

## Core Workflow

### 1. Data Preparation and Hit Calculation
Convert mapped reads into nucleotide-level hit counts. CSAR expects a data frame with columns: `pos` (position), `strand` (+/-), and `chr` (chromosome).

```r
library(CSAR)
data("CSAR-dataset")

# Calculate hits for sample and control
# chrL is the length of the chromosome; file is the prefix for saved results
nhitsS <- mappedReads2Nhits(sampleSEP3_test, file="sample", chr="CHR1", chrL=10000)
nhitsC <- mappedReads2Nhits(controlSEP3_test, file="control", chr="CHR1", chrL=10000)
```

### 2. Enrichment Scoring
Calculate the read-enrichment score. This function normalizes the sample to the control and applies a Poisson test or ratio-based scoring.

```r
# 'times' scales the score for integer storage
test <- ChIPseqScore(control=nhitsC, sample=nhitsS, file="test_score", times=10000)
```

### 3. Peak Calling and Visualization
Identify significant windows and export data for genome browsers.

```r
# Identify candidate enriched regions (windows)
win <- sigWin(test)

# Export to WIG format for IGV/UCSC
score2wig(test, file="output.wig", times=10000)
```

### 4. Functional Annotation
Map identified peaks to gene annotations (GFF/GTF format).

```r
# Calculate distance to nearest genes
dist <- distance2Genes(win=win, gff=TAIR8_genes_test)

# Identify genes associated with peaks
genes <- genesWithPeaks(dist)
```

### 5. FDR Thresholding via Permutation
To determine a statistically sound cutoff, use permutations to estimate the null distribution of scores.

```r
# Run permutations (nn = permutation ID)
permutatedWinScores(nn=1, sample=sampleSEP3_test, control=controlSEP3_test, 
                    fileOutput="perm", chr="CHR1", chrL=10000)

# Load null distribution and calculate threshold for a specific FDR
nulldist <- getPermutatedWinScores(file="perm", nn=1:2)
threshold <- getThreshold(winscores=values(win)$score, permutatedScores=nulldist, FDR=0.05)
```

## Key Functions Reference

- `mappedReads2Nhits`: Converts read coordinates to per-nucleotide hit counts.
- `ChIPseqScore`: Main scoring function comparing sample and control.
- `sigWin`: Extracts contiguous regions (peaks) above a score threshold.
- `permutatedWinScores`: Generates null distribution data by swapping sample/control labels.
- `getThreshold`: Calculates the score cutoff required to achieve a target False Discovery Rate.
- `distance2Genes` / `genesWithPeaks`: Utilities for genomic context and gene-level summaries.

## Tips for Success

- **Memory Management**: CSAR saves intermediate results to disk (e.g., `.CSARNhits`, `.CSARScore`). Ensure you have write permissions in the working directory.
- **Fragment Size**: The algorithm virtually extends reads to 300bp by default (standard ChIP fragment size).
- **Strand Consistency**: CSAR is conservative; it calculates enrichment for both strands independently and takes the minimum, which effectively filters out many PCR-induced artifacts.
- **Permutations**: For publication-quality results, run a higher number of permutations (e.g., `nn=1:10` or more) to get a stable FDR estimate.

## Reference documentation

- [An Introduction to the CSAR Package](./references/CSAR.md)