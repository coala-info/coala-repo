---
name: bioconductor-epigrahmm
description: epigraHMM performs consensus and differential peak calling in epigenomic sequencing data using Hidden Markov Models. Use when user asks to call peaks, identify differential enrichment across conditions, normalize epigenomic count data, or analyze ChIP-seq and ATAC-seq experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/epigraHMM.html
---

# bioconductor-epigrahmm

name: bioconductor-epigrahmm
description: Expert guidance for using the epigraHMM R package for consensus and differential peak calling in epigenomic sequencing data (ChIP-seq, ATAC-seq, DNase-seq). Use this skill when performing end-to-end epigenomic analysis including data pre-processing from BAM files, non-linear normalization, HMM-based peak detection, and visualization of genomic enrichment patterns across multiple conditions.

## Overview

epigraHMM is a Bioconductor package designed for the analysis of high-throughput epigenomic assays. It utilizes Hidden Markov Models (HMM) to segment the genome into background and enrichment regions. It is particularly effective for both narrow and broad peak profiles. The package supports two primary workflows:
1.  **Consensus Peak Calling**: Detecting consistent enrichment across replicates of a single condition.
2.  **Differential Peak Calling**: Identifying changes in enrichment across multiple conditions or genomic segmentation across different marks.

## Core Workflow

### 1. Data Input and Object Creation

epigraHMM uses the `epigraHMMDataSet` object (a subclass of `RangedSummarizedExperiment`).

**From BAM files:**
```r
library(epigraHMM)
bamFiles <- c("sample1.bam", "sample2.bam")
colData <- data.frame(condition = c('A','A'), replicate = c(1,2))

object <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                  colData = colData,
                                  genome = 'hg38', # or GRanges of chrom sizes
                                  windowSize = 1000,
                                  gapTrack = TRUE,
                                  blackList = TRUE)
```

**From Count Matrices:**
```r
# countData can be a matrix or a named list (e.g., list(counts=mat, controls=ctrl_mat))
object <- epigraHMMDataSetFromMatrix(countData = countData,
                                     colData = colData,
                                     rowRanges = rowRanges)
```

### 2. Normalization

Non-linear normalization is critical for epigenomic data. Use `normalizeCounts` to create model offsets based on loess smoothing.

```r
object <- normalizeCounts(object = object, control = controlEM())
```
*Note: If you have custom offsets (e.g., GC-content), use `addOffsets()` before running `normalizeCounts()`.*

### 3. Peak Calling Execution

The analysis requires an initialization step followed by the main HMM fitting.

```r
# 1. Initialize parameters
object <- initializer(object = object, control = controlEM())

# 2. Run HMM (type = 'consensus' or 'differential')
object <- epigraHMM(object = object,
                    type = 'differential',
                    dist = 'zinb', # 'zinb' recommended for consensus; 'nb' also available
                    control = controlEM())
```

### 4. Extracting Results

Use `callPeaks` to define genomic regions of enrichment.

```r
# Viterbi-based peaks (most likely state)
peaks <- callPeaks(object = object)

# FDR-controlled peaks (window-level control)
peaks_fdr <- callPeaks(object = object, method = 0.05)
```

For differential analyses, use `callPatterns` to see which specific conditions are enriched in a differential region:
```r
# Get most likely enrichment pattern (e.g., "ConditionA", "ConditionB", or "ConditionA-ConditionB")
patterns <- callPatterns(object = object, peaks = peaks, type = 'max')
```

## Visualization

epigraHMM provides built-in functions to visualize tracks and posterior probabilities.

```r
# Plot read counts, peaks, and posterior probabilities
plotCounts(object = object,
           ranges = GRanges('chr1', IRanges(start, end)),
           peaks = peaks,
           annotation = annotation_granges)

# Plot heatmap of combinatorial enrichment patterns for a specific peak
plotPatterns(object = object,
             ranges = peaks[1],
             peaks = peaks)
```

## Advanced Tuning

- **Control Experiments**: To include Input/Control BAMs, pass a named list to `bamFiles` with a `controls` element. epigraHMM will automatically include them as covariates.
- **Pruning Patterns**: In complex differential designs with many conditions, use `controlEM(pruningThreshold = 0.05)` to remove rare combinatorial patterns and simplify results.
- **Distribution Choice**: Use `dist = 'zinb'` (Zero-Inflated Negative Binomial) for consensus peak calling to better model background noise.

## Reference documentation

- [Consensus and differential peak calling with epigraHMM](./references/epigraHMM.md)