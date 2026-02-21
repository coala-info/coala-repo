---
name: bioconductor-chipseq
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/chipseq.html
---

# bioconductor-chipseq

name: bioconductor-chipseq
description: Analysis of ChIP-Seq data using the chipseq package. Use this skill to process aligned short reads, estimate fragment lengths, calculate genomic coverage, identify peaks (islands), and perform differential peak analysis between samples.

# bioconductor-chipseq

## Overview

The `chipseq` package provides a specialized framework for the analysis of ChIP-Seq data, leveraging Bioconductor's `IRanges` and `GenomicRanges` infrastructure. It is designed to handle the transition from aligned short reads to biological insights by extending reads to represent full fragments, calculating coverage across the genome, and identifying significant peaks (islands of enrichment) while controlling for false discovery rates (FDR).

## Core Workflow

### 1. Data Loading and Filtering
Data is typically imported from alignment files (e.g., BAM or MAQ) using `ShortRead::readAligned`. The `chipseqFilter` function helps remove duplicates and restrict mappings to canonical chromosomes.

```r
library(chipseq)
# Example using internal dataset
data(cstest) 
# cstest is a GRangesList containing 'ctcf' and 'gfp' samples
```

### 2. Estimating Fragment Length and Extending Reads
Since sequenced reads represent only the ends of fragments, they must be extended to their estimated full length to accurately represent binding sites.

```r
# Estimate mean fragment length using correlation method
fraglen <- estimate.mean.fraglen(cstest$ctcf, method="correlation")

# Extend reads (e.g., to 200bp) based on strand orientation
ctcf.ext <- resize(cstest$ctcf, width = 200)
```

### 3. Coverage and Island Analysis
Coverage represents the number of fragments covering each base. "Islands" are contiguous regions of non-zero coverage.

```r
# Calculate coverage (returns an RleList)
cov.ctcf <- coverage(ctcf.ext)

# Find islands (regions with coverage >= 1)
islands <- slice(cov.ctcf, lower = 1)

# Summarize island statistics
viewSums(islands) # Total reads in island
viewMaxs(islands) # Maximum depth in island
```

### 4. Peak Calling
Peaks are identified by finding regions where coverage exceeds a statistical threshold, often modeled using a Poisson distribution.

```r
# Determine a cutoff for a specific False Discovery Rate (FDR)
cutoff <- peakCutoff(cov.ctcf, fdr = 0.0001)

# Identify peaks using the calculated cutoff
peaks.ctcf <- slice(cov.ctcf, lower = cutoff)

# Generate a summary GRanges object of peaks
peaks.summary <- peakSummary(peaks.ctcf)
```

### 5. Differential Peak Analysis
To compare two samples (e.g., Treatment vs. Control), use `diffPeakSummary` to calculate enrichment statistics across combined peak sets.

```r
# Calculate coverage for control
cov.gfp <- coverage(resize(cstest$gfp, 200))

# Compare samples
diff.peaks <- diffPeakSummary(slice(cov.gfp, lower = 8), peaks.ctcf)
```

## Visualization

The package provides specialized plotting functions to inspect peak quality and strand-specific distribution.

- `islandDepthPlot(cov)`: Visualizes the distribution of island depths against a null Poisson model.
- `coverageplot(pos_cov, neg_cov)`: Plots strand-specific coverage for a specific peak to verify the expected "shift" between forward and reverse strand reads.

## Genomic Context

Integrate peaks with gene annotations using `GenomicFeatures`:

```r
# Check if peaks overlap with promoters
# promoters is a GRanges object of promoter regions
peakSummary$inPromoter <- peakSummary %over% promoters
```

## Reference documentation

- [Workflow](./references/Workflow.md)