---
name: bioconductor-strandcheckr
description: This tool performs quality control and filtering of strand-specific RNA-seq data to identify and remove double-stranded DNA contamination. Use when user asks to assess strand-specificity, quantify DNA contamination in BAM files, or filter out reads originating from genomic DNA.
homepage: https://bioconductor.org/packages/release/bioc/html/strandCheckR.html
---


# bioconductor-strandcheckr

name: bioconductor-strandcheckr
description: Quality control and filtering for strand-specific RNA-seq data to detect and remove double-stranded DNA contamination. Use this skill when you need to assess strand-specificity, quantify DNA contamination in RNA-seq BAM files, or filter out reads originating from genomic DNA.

# bioconductor-strandcheckr

## Overview

`strandCheckR` is a Bioconductor package designed to identify and filter DNA contamination in strand-specific RNA-seq data. It uses a sliding window approach across the genome to calculate the proportion of reads mapping to the positive and negative strands. In high-quality strand-specific RNA-seq, windows should show a strong bias toward one strand (near 0% or 100% positive proportion). Windows showing a ~50% distribution suggest double-stranded DNA contamination.

## Core Workflow

### 1. Quantify Strand Information
The primary function `getStrandFromBamFile` scans BAM files and returns a DataFrame with strand counts per window.

```r
library(strandCheckR)

# Define BAM files (must be sorted and indexed)
bam_files <- c("sample1.bam", "sample2.bam")

# Get strand info (default window = 1000bp, step = 100bp)
win_info <- getStrandFromBamFile(bam_files, sequences = "chr1")
```

### 2. Integrate Annotations
To distinguish between coding regions and intergenic regions, intersect the windows with a GRanges object (e.g., from a TxDb).

```r
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
annot <- transcripts(TxDb.Hsapiens.UCSC.hg38.knownGene)

# Ensure sequence names match (e.g., adding 'chr' if necessary)
win_info <- intersectWithFeature(
    windows = win_info, 
    annotation = annot, 
    overlapCol = "OverlapTranscript"
)
```

### 3. Visualizing Contamination
Use `plotHist` to view the distribution of positive strand proportions. A peak at 0.5 indicates DNA contamination.

```r
# Plot histogram of strand proportions
plotHist(win_info, groupBy = "File", normalizeBy = "File")

# Heatmap version for comparing many samples
plotHist(win_info, groupBy = "File", heatmap = TRUE)

# Plot read count vs positive proportion to determine filtering thresholds
plotWin(win_info, groupBy = "File")
```

### 4. Filtering DNA Contamination
The `filterDNA` function removes reads from windows that do not meet a specific strand-specificity threshold.

```r
# Filter a BAM file and save the result
# threshold = 0.7 means windows must have >70% or <30% of reads on one strand
filtered_win <- filterDNA(
    file = "sample.bam", 
    destination = "sample.filtered.bam",
    threshold = 0.7,
    getWin = TRUE
)
```

## Key Functions and Parameters

- `getStrandFromBamFile()`:
    - `window`: Length of sliding window (default 1000).
    - `step`: Step size (default 100).
    - `minMaxCoverage`: Filter windows with low coverage.
    - `pairedExp`: Set to `TRUE` for paired-end data.
- `plotHist()`:
    - `split`: Groups windows by coverage levels (default: <10, 10-100, 100-1000, >1000).
- `filterDNA()`:
    - `threshold`: The proportion threshold (0.5 to 1) to decide if a window is "single-stranded".
    - `keepRanges`: A GRanges object of regions to protect from filtering regardless of strand ratio.

## Reference documentation

- [An Introduction To strandCheckR](./references/strandCheckR.md)