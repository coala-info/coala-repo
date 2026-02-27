---
name: bioconductor-nadfinder
description: This tool analyzes Nucleolar-Associated Domains (NADs) from NAD-seq data by performing read counting, normalization, and peak calling. Use when user asks to count reads in sliding windows, normalize log2 ratios, smooth genomic signals, or call peaks for single or replicated NAD-seq samples.
homepage: https://bioconductor.org/packages/release/bioc/html/NADfinder.html
---


# bioconductor-nadfinder

name: bioconductor-nadfinder
description: Analysis of Nucleolar-Associated Domains (NADs) from NAD-seq data. Use this skill for bioinformatic workflows including read counting in sliding windows, log2 ratio normalization, background correction, smoothing, and peak calling for single or replicated samples.

# bioconductor-nadfinder

## Overview

The `NADfinder` package is designed for the analysis of NAD-seq data, which identifies genomic regions (Nucleolar-Associated Domains) that physically associate with the nucleolus. The workflow typically involves comparing a nucleolus-enriched DNA sample against a whole genomic DNA (input) background. The package supports sliding window analysis, normalization of ratios, local background correction, and statistical peak calling for both single pairs and replicated experiments.

## Core Workflow

### 1. Data Preparation and Counting
The process begins by counting reads in sliding windows across the genome using BAM files.

```r
library(NADfinder)
library(BSgenome.Mmusculus.UCSC.mm10)

# Define window and step size (NADs are typically broad, e.g., 50kb)
ws <- 50000
step <- 5000

# Count reads
se <- tileCount(reads = c("nucleolus.bam", "genome.bam"),
                genome = Mmusculus,
                windowSize = ws,
                step = step,
                mode = IntersectionNotStrict)
```

### 2. Normalization and Smoothing
Calculate log2 ratios between the nucleolus and genome samples, then smooth the signal to reduce noise.

```r
# Calculate log2 ratios
dat <- log2se(se, 
              nucleolusCols = "nucleolus.bam", 
              genomeCols = "genome.bam", 
              transformation = "log2CPMRatio")

# Smooth ratios by chromosome (corrects for 5' to 3' bias)
datList <- smoothRatiosByChromosome(dat, chr = paste0("chr", 1:19))
```

### 3. Peak Calling (Single Pair)
For a single pair of samples, use `trimPeaks` which utilizes a background percentage to determine significance.

```r
# Call and trim peaks
# backgroundPercentage 0.25 uses the lower 25% of ratios for background training
peaks <- lapply(datList, trimPeaks, 
                backgroundPercentage = 0.25, 
                cutoffAdjPvalue = 0.05, 
                countFilter = 1000)

# Convert to GRanges
peaks.gr <- unlist(GRangesList(peaks))
```

### 4. Peak Calling (Replicates)
When biological replicates are available, `NADfinder` uses `limma` for more robust statistical testing.

```r
# Calculate ratios for multiple columns
se <- log2se(se, 
             nucleolusCols = c("N_rep1.bam", "N_rep2.bam"),
             genomeCols = c("G_rep1.bam", "G_rep2.bam"))

seList <- smoothRatiosByChromosome(se)

# Use callPeaks for replicated data
peaks <- lapply(seList, callPeaks, cutoffAdjPvalue = 0.05)
peaks.gr <- unlist(GRangesList(peaks))
```

## Visualization and Export

### Quality Assessment
Use `cumulativePercentage` to check the distribution of reads. A uniform genomic background should appear as a near-straight line, while the nucleolus sample should show enrichment.

```r
cumulativePercentage(datList[["chr1"]])
```

### Plotting Results
Visualize peaks along an ideogram:

```r
ideo <- readRDS(system.file("extdata", "ideo.mm10.rds", package = "NADfinder"))
plotSig(ideo = ideo, grList = GRangesList(peaks.gr), mcolName = "AveSig",
        layout = list("chr18"), parameterList = list(types = "heatmap"))
```

### Exporting
```r
library(rtracklayer)
export(peaks.gr, "NAD_peaks.bed", "BED")
write.csv(as.data.frame(peaks.gr), "NAD_peaks.csv")
```

## Key Parameters
- `windowSize`: Usually set large (50kb+) because NADs are broad heterochromatic regions.
- `backgroundPercentage`: The fraction of lowest ratios used to model the null distribution.
- `countFilter`: Minimum read count required to consider a window for peak calling.

## Reference documentation
- [NADfinder Guide](./references/NADfinder.md)