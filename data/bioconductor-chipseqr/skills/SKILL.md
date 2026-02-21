---
name: bioconductor-chipseqr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPseqR.html
---

# bioconductor-chipseqr

name: bioconductor-chipseqr
description: Analysis of nucleosome positioning and histone modification ChIP-seq data. Use this skill to identify binding sites from end-sequenced nucleosomes (MNase-seq) or other ChIP-seq experiments by calculating binding site scores and identifying significant peaks.

## Overview

ChIPseqR is designed for high-resolution analysis of nucleosome positioning. It uses a sliding window approach to score genomic positions based on the distribution of forward and reverse strand reads. While optimized for nucleosomes (approx. 147 bp binding sites), it can be adapted to other DNA-binding proteins by adjusting binding and support region parameters.

## Typical Workflow

### 1. Data Preparation
Load your mapped reads. While data frames are supported, using `ShortRead` to create `AlignedRead` objects is recommended for real data.

```r
library(ChIPseqR)

# Convert reads to strand-specific counts (pileup)
# reads: data.frame or AlignedRead object
# chrLen: length of the chromosome
counts <- strandPileup(reads, chrLen = 2e6, extend = 1, plot = FALSE)
```

### 2. Parameter Estimation
If binding and support lengths are unknown, estimate them from cross-correlation.
- **Binding Length (`bind`)**: The physical length of the protein-DNA interaction (e.g., 147 for nucleosomes).
- **Support Length (`support`)**: The distance from the binding site edge where reads are likely to be found.

```r
# Estimate parameters within specific ranges
bLen <- getBindLen(counts, bind = c(100, 200), support = c(5, 50))
```

### 3. Nucleosome/Binding Site Calling
The `simpleNucCall` function is the primary interface for predicting positions.

```r
# Call nucleosomes with known or estimated parameters
nucs <- simpleNucCall(counts, bind = 147, support = 15, plot = FALSE)

# Access predicted peaks
peak_list <- peaks(nucs)
```

### 4. Visualization and Diagnostics
Assess the fit of the null distribution and visualize specific genomic windows.

```r
# Diagnostic plots for null distribution fit
plot(nucs, type = "density")
plot(nucs, type = "qqplot")

# Visualize a specific window around a predicted peak
predicted_pos <- peaks(nucs)[[1]][1]
plot(counts, chr = "chr1", center = predicted_pos, score = nucs, width = 1000, type = "window")
```

## Key Functions

- `strandPileup`: Creates a `ReadCounts` object. Use `compress = FALSE` if memory allows and RLE is not efficient for your data.
- `simpleNucCall`: High-level wrapper for the entire calling pipeline.
- `callBindingSites`: The underlying engine for `simpleNucCall`; provides granular control over scoring and peak calling.
- `getBindLen`: Estimates binding and support region lengths via cross-correlation.
- `peaks`: Extracts the coordinates of identified binding sites.

## Advanced Configuration

- **Background Control**: Adjust `bgCutoff` (default 0.5 to 1) in `callBindingSites` to control how the model adapts to local coverage changes. Lower values are more restrictive.
- **Overlapping Peaks**: By default, `pickPeak` identifies the maximum of a peak. If peaks are wide, use `sub = TRUE` to identify sub-peaks.
- **Memory Management**: ChIPseqR uses run-length encoding (RLE). Use `decompress(counts)` to expand data if needed for specific manual analyses.

## Reference documentation

- [Introduction to ChIPseqR](./references/Introduction.md)