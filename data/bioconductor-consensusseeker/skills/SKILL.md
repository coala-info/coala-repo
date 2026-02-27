---
name: bioconductor-consensusseeker
description: The consensusSeekeR package identifies consensus genomic regions across multiple experiments by using specific feature positions like peak summits or nucleosome centers. Use when user asks to find consensus genomic regions, identify common peaks across multiple datasets, or aggregate genomic features from different experiments using an iterative median-based approach.
homepage: https://bioconductor.org/packages/release/bioc/html/consensusSeekeR.html
---


# bioconductor-consensusseeker

## Overview

The `consensusSeekeR` package provides a method for identifying consensus genomic regions across multiple experiments. Unlike standard methods that rely solely on overlapping genomic ranges, `consensusSeekeR` uses the specific feature positions (e.g., peak summits or nucleosome centers) to define consensus areas. It employs an iterative process to calculate a median position from gathered features, ensuring that consensus regions are robust even when individual experiments have slightly shifted or missing features.

## Core Workflow

### 1. Data Preparation

The package requires two main `GRanges` objects:
- **Positions**: The specific point locations (e.g., peak summits).
- **Ranges**: The enriched regions surrounding those positions.

**Requirements:**
- Both objects must have a metadata column named `name` to link a position to its corresponding range.
- Row names (`names(gr)`) must be set to the experiment/source name. All entries from the same experiment must share the same row name.

```r
library(consensusSeekeR)
library(GenomicRanges)

# Example: Preparing a GRanges object
# 1. Assign unique names to each feature in metadata
my_peaks$name <- paste0("Exp1_peak_", 1:length(my_peaks))
# 2. Assign the experiment name to the row names
names(my_peaks) <- rep("Experiment_1", length(my_peaks))
```

### 2. Reading NarrowPeak Files

You can use the helper function `readNarrowPeakFile` to automatically extract both regions and peak positions from ENCODE-style files.

```r
result <- readNarrowPeakFile("path/to/file.narrowPeak", extractRegions = TRUE, extractPeaks = TRUE)
# Access via:
# result$narrowPeak (the ranges)
# result$peak (the positions)
```

### 3. Finding Consensus Regions

The primary function is `findConsensusPeakRegions`.

```r
results <- findConsensusPeakRegions(
    narrowPeaks = c(ranges_exp1, ranges_exp2),
    peaks = c(peaks_exp1, peaks_exp2),
    chrInfo = chrList,             # Seqinfo object
    extendingSize = 100,           # Half-width of the initial window
    minNbrExp = 2,                 # Min experiments required for a consensus
    expandToFitPeakRegion = TRUE,  # Expand consensus to cover all included ranges
    shrinkToFitPeakRegion = TRUE,  # Shrink consensus to fit included ranges
    nbrThreads = 1                 # Parallel processing support
)

# Access the results
consensus_gr <- results$consensusRanges
```

## Key Parameters

- `extendingSize`: Defines the initial window size (2 * `extendingSize`). Small values may miss regions; large values may merge distinct regions.
- `minNbrExp`: The stringency filter. Setting this to the total number of experiments finds "universal" features; lower values allow for experiment-specific noise.
- `expandToFitPeakRegion`: If `TRUE`, ensures the final consensus range encompasses the full width of all contributing features' ranges.
- `shrinkToFitPeakRegion`: If `TRUE`, clips the consensus range to the boundaries of the contributing features' ranges if the calculated window is larger.

## Parallelization

For genome-wide analysis, use the `nbrThreads` parameter. The package parallelizes the computation by chromosome. Ensure your `chrInfo` (Seqinfo object) contains all chromosomes you wish to process.

```r
# Example Seqinfo setup
chrList <- Seqinfo(seqnames = c("chr1", "chr2"), seqlengths = c(249250621, 243199373), genome = "hg19")
```

## Reference documentation

- [Detection of consensus regions inside a group of experiments](./references/consensusSeekeR.md)
- [Detection of consensus regions inside a group of experiments (RMarkdown)](./references/consensusSeekeR.Rmd)