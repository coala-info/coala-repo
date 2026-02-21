---
name: bioconductor-gcapc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gcapc.html
---

# bioconductor-gcapc

name: bioconductor-gcapc
description: GC-content bias correction for ChIP-seq data. Use this skill to perform peak calling, refine existing peak sets, or correct read count tables by modeling GC effects using generalized linear mixture models.

## Overview

The `gcapc` package addresses the issue of sequence context biases (specifically GC bias) in ChIP-seq data. It uses generalized linear mixture models followed by EM algorithms to estimate GC effects and incorporates these into peak calling and significance ranking. It is particularly useful for improving the ranking of peaks and reducing systematic errors or batch effects in ChIP-seq analysis.

## Main Functions

- `read5endCoverage()`: Converts BAM files into basepair-resolution coverage objects for forward and reverse strands.
- `bindWidth()`: Estimates the protein binding width and peak detection window size from coverage data.
- `gcEffects()`: Estimates GC-content bias using mixture models (Poisson or Negative Binomial).
- `gcapcPeaks()`: Performs peak calling using estimated GC effects and permutation analysis.
- `refinePeaks()`: Re-calculates significance (enrichment scores and p-values) for peaks called by other tools (e.g., MACS2).
- `refineSites()`: Corrects GC-content bias for a read count table of predefined genomic regions.

## Typical Workflows

### Peak Calling from BAM

```r
library(gcapc)

# 1. Load coverage (5' ends only)
bam_path <- "path/to/your/file.bam"
cov <- read5endCoverage(bam_path)

# 2. Estimate binding width (can be skipped if width is known)
# range: search range for fragment size; step: resolution of search
bdw <- bindWidth(cov, range = c(50L, 300L), step = 10L)

# 3. Estimate GC effects
# model: 'poisson' is faster, 'nb' (Negative Binomial) is more accurate
# sampling: fraction of genome to use for estimation
gcb <- gcEffects(cov, bdw, sampling = c(0.05, 1), model = "poisson", plot = TRUE)

# 4. Call peaks
# permute: number of permutations for significance testing
peaks <- gcapcPeaks(cov, gcb, bdw, permute = 50L, plot = TRUE)
```

### Refining External Peaks

If you have peaks from another caller (as a `GRanges` object), you can adjust their significance:

```r
# peaks_external should be a GRanges object
refined_peaks <- refinePeaks(cov, gcb, bdw, peaks = peaks_external, permute = 50L)
# Results include 'newes' (new enrichment score) and 'newpv' (new p-value)
```

### Correcting a Count Table

For pre-defined regions (e.g., ENCODE sites) across multiple samples:

```r
# Requires a count table and corresponding GRanges
# See ?refineSites for specific parameter details
corrected_data <- refineSites(counts, regions, ...)
```

## Usage Tips

- **Memory Management**: For very deep sequencing, process data chromosome by chromosome to save memory. `read5endCoverage` allows filtering by chromosome.
- **Model Selection**: Use `model = "poisson"` for a fast approximation during initial runs. Use `model = "nb"` for final results if overdispersion is a concern.
- **Sampling**: For small genomes or single chromosomes, increase the `sampling` parameter (e.g., `0.25` or higher) to ensure the EM algorithm has enough data to converge.
- **GC Ranges**: If the protein has very few binding sites, the `gcrange` parameter in `gcEffects` should be carefully set to avoid outliers driving the regression.
- **Supervised Estimation**: If you have a set of potential peaks, pass them to the `supervise` argument in `gcEffects` to improve the separation of foreground and background signals during EM.

## Reference documentation

- [The gcapc user's guide](./references/gcapc.Rmd)
- [The gcapc user's guide (Markdown)](./references/gcapc.md)