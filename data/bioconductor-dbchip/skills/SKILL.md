---
name: bioconductor-dbchip
description: This tool performs differential binding analysis for ChIP-seq data to identify significant changes in transcription factor or histone modification occupancy across different conditions. Use when user asks to merge binding sites into consensus sites, count reads across replicates, or perform statistical testing for differential binding.
homepage: https://bioconductor.org/packages/3.6/bioc/html/DBChIP.html
---

# bioconductor-dbchip

name: bioconductor-dbchip
description: Differential binding analysis for ChIP-seq data using the DBChIP package. Use this skill to merge binding sites from multiple conditions into consensus sites, count reads across replicates, and perform statistical testing for differential binding of transcription factors or histone modifications.

## Overview

DBChIP is designed for ChIP-seq datasets where binding sites exhibit sharp peaks (e.g., transcription factors). It addresses the challenge of comparing binding across different conditions (treatments, cell lines, or time points) by creating consensus binding sites and using a generalized linear model (Negative Binomial distribution) to account for biological variation among replicates.

## Core Workflow

### 1. Data Preparation
DBChIP requires three main components:
- **Binding Site Predictions**: A list of data frames (one per condition) containing `chr` (chromosome) and `pos` (binding position).
- **ChIP Alignment Data**: Read data for each biological replicate.
- **Input/Control Data**: Background noise data (usually merged per condition).

```r
library(DBChIP)

# Define experimental conditions
conds <- factor(c("control", "control", "treat", "treat"), levels=c("control", "treat"))

# Load binding site predictions (example format)
# binding.site.list should be a list of data frames with 'chr' and 'pos'
bs.list <- read.binding.site.list(binding.site.list)
```

### 2. Creating Consensus Sites
Since peak callers may return slightly different coordinates for the same site across conditions, use `site.merge` to create a unified set of sites for testing.

```r
consensus.site <- site.merge(bs.list)
```
*Note: Default merging parameters are `in.distance = 100` (merge if closer) and `out.distance = 250` (separate if further).*

### 3. Loading Alignment Data
DBChIP supports multiple formats including MCS (Minimum ChIP-Seq), BAM (via `ShortRead`), and BED.

```r
# Example using MCS format (data.frame with chr, pos, strand)
dat <- load.data(chip.data.list = chip.data.list, 
                 conds = conds, 
                 consensus.site = consensus.site, 
                 input.data.list = input.data.list, 
                 data.type = "MCS")
```

### 4. Counting and Testing
Count the reads around consensus sites and perform the differential binding test.

```r
# Count reads
dat <- get.site.count(dat)

# Test for differential binding
dat <- test.diff.binding(dat)
```

### 5. Reporting and Visualization
Extract the results and visualize specific peaks.

```r
# Report top sites (default n=10)
rept <- report.peak(dat, n = 20, fdr = 0.05)

# Plot a specific peak (e.g., the first one in the report)
plotPeak(rept[1,], dat)
```

## Technical Tips
- **Replicates**: DBChIP expects biological replicates to estimate over-dispersion. Technical replicates should be merged prior to analysis.
- **Input Data**: Input/Control data is used to estimate background noise. It is typically organized per condition rather than per ChIP replicate.
- **Fold Change**: The first level of the `conds` factor is used as the baseline for fold change calculations.
- **Alignment Formats**: 
    - For **BAM**: Use `ShortRead::readAligned` to create an `AlignedRead` object.
    - For **BED**: Provide a list of file paths and set `data.type = "BED"`.

## Reference documentation
- [DBChIP: Detecting differential binding of transcription factors with ChIP-seq](./references/DBChIP.md)