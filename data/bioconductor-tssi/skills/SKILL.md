---
name: bioconductor-tssi
description: The TSSi package provides a statistical framework for identifying transcription start sites from high-throughput sequencing data by using a regularization approach to reduce background noise. Use when user asks to identify transcription start sites from CAP-capture data, normalize read counts using shrinkage, or segmentize genomic count data.
homepage: https://bioconductor.org/packages/3.5/bioc/html/TSSi.html
---

# bioconductor-tssi

## Overview

The `TSSi` package provides a statistical framework for identifying Transcription Start Sites (TSS) from CAP-capture data (e.g., Solexa/Illumina). It addresses the challenge of distinguishing real TSS from background noise and alternative start sites by using a regularization (shrinkage) approach to reduce false positives and an iterative convolution algorithm to define TSS locations.

## Typical Workflow

### 1. Data Preparation and Segmentation
Data should be in a data frame containing genomic coordinates (chromosome, start, strand) and read counts. The `segmentizeCounts` function divides the data into independent units (segments) for analysis.

```R
library(TSSi)
data(physcoCounts)

# Create a TssData object
# counts: number of reads
# start: genomic position of 5' end
# chr, region, strand: grouping variables
x <- segmentizeCounts(counts=physcoCounts$counts, 
                      start=physcoCounts$start, 
                      chr=physcoCounts$chromosome, 
                      region=physcoCounts$region, 
                      strand=physcoCounts$strand)
```

### 2. Normalization (Shrinkage)
Normalization reduces noise by shrinking counts towards zero, especially for isolated reads.

```R
# Simple approximation based on frequency
yRatio <- normalizeCounts(x)

# Explicit fit for each segment (more robust, supports parallel processing)
yFit <- normalizeCounts(x, fit=TRUE)
```

### 3. Identifying TSS
The `identifyStartSites` function uses an iterative algorithm. It identifies the largest count as a TSS and assigns neighboring counts to it, then updates the expected background noise using exponential kernels.

```R
z <- identifyStartSites(yFit)

# Access identified TSS
tss_data <- tss(z)
head(tss(z, 1)) # Get TSS for the first segment
```

### 4. Visualization
The package includes a specialized `plot` method to visualize reads, normalized fits, and identified TSS.

```R
# Plot a specific segment (e.g., segment 3)
plot(z, 3)

# Customized plot
plot(z, 4, 
     ratio=FALSE, 
     threshold=FALSE, 
     expect=TRUE, 
     expectArgs=list(type="l"),
     plotArgs=list(xlab="Genomic position", main="TSS Analysis"))
```

## Data Extraction and Export

The package provides methods to extract data into standard R formats or `IRanges` objects for downstream analysis.

*   `segments(z)`: Summary of all segments (counts, number of TSS).
*   `reads(z)`: Detailed read information including fit and expectation values.
*   `tss(z)`: Identified TSS positions and associated read strengths.

To interface with other Bioconductor packages (like `rtracklayer`):
```R
readsRd <- readsAsRangedData(z)
segmentsRd <- segmentsAsRangedData(z)
tssRd <- tssAsRangedData(z)
```

## Key Parameters for `identifyStartSites`
*   `tau`: A vector of length 2 specifying the decay rates of the convolution kernels in 3' and 5' directions. Default is `c(20, 20)`.
*   `threshold`: The minimum difference between transcription level and expected background to identify a TSS.

## Reference documentation

- [TSSi](./references/TSSi.md)