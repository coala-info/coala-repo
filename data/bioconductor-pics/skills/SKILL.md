---
name: bioconductor-pics
description: bioconductor-pics identifies transcription factor binding sites from ChIP-Seq data using a Bayesian hierarchical t-mixture model. Use when user asks to identify binding sites, deconvolute overlapping peaks, estimate fragment lengths, or calculate false discovery rates for ChIP-Seq experiments.
homepage: https://bioconductor.org/packages/3.5/bioc/html/PICS.html
---


# bioconductor-pics

name: bioconductor-pics
description: Probabilistic Inference for ChIP-Seq (PICS). Use this skill to identify transcription factor binding sites from ChIP-Seq data using a Bayesian hierarchical t-mixture model. It is particularly effective for discriminating closely adjacent binding events, estimating fragment lengths, and adjusting for genome mappability.

# bioconductor-pics

## Overview

The `PICS` package provides a probabilistic framework for analyzing ChIP-Seq data. Unlike simple peak-callers, PICS models the local concentrations of directional reads (forward and reverse) using a t-mixture model. This allows for higher spatial resolution, the ability to deconvolute overlapping binding events, and the estimation of uncertainties in binding site locations.

## Typical Workflow

### 1. Data Preparation
Convert aligned reads (IP and Control) into `GRanges` objects. PICS requires sorted reads.

```r
library(PICS)
library(GenomicRanges)

# Load IP and Control data (e.g., from BED files)
dataIP <- as(read.table("IP_reads.bed", header=TRUE), "GRanges")
dataCont <- as(read.table("Control_reads.bed", header=TRUE), "GRanges")

# Load Mappability profile (optional but recommended)
# Mappability profiles are disjoint intervals of non-mappable regions
map <- as(read.table("mapProfile.bed", header=TRUE), "GRanges")
```

### 2. Genome Segmentation
Segment the genome into candidate regions containing a minimum number of reads.

```r
# minReads: minimum number of forward and reverse reads to define a region
# A control-to-IP candidate region ratio of ~25% is a good heuristic
seg <- segmentPICS(dataIP, dataC=dataCont, map=map, minReads=1)
```

### 3. Parameter Estimation (Peak Calling)
Run the PICS model on the segmented regions. Use `parallel` to speed up computation.

```r
library(parallel)
# dataType="TF" for Transcription Factors; "H" for Histone modifications (experimental)
pics <- PICS(seg, nCores=2, dataType="TF")
```

### 4. FDR Estimation
To estimate the False Discovery Rate, repeat the segmentation and PICS steps with swapped IP and Control samples.

```r
# Swap samples
segC <- segmentPICS(dataCont, dataC=dataIP, map=map, minReads=1)
picsC <- PICS(segC)

# Calculate FDR with filters to remove noisy estimates
# delta: fragment length, se: standard error, sigmaSq: variance
myFilter <- list(delta=c(50, 300), se=c(0, 50), sigmaSqF=c(0, 22500), sigmaSqR=c(0, 22500))
fdr <- picsFDR(pics, picsC, filter=myFilter)
```

### 5. Visualizing and Exporting Results
Visualize the FDR vs. Score relationship to determine a threshold, then export to standard formats.

```r
# Plot FDR vs Score
plot(pics, picsC, filter=myFilter, type="l")

# Create RangedData output for BED or WIG
rdBed <- makeRangedDataOutput(pics, type="bed", filter=c(myFilter, list(score=c(1, Inf))))

# Export using rtracklayer
library(rtracklayer)
export(rdBed, "enriched_regions.bed")
```

## Key Parameters and Tips

- **minReads**: Lowering this increases sensitivity but significantly increases computation time and potential false positives.
- **Mappability**: Using a mappability profile is highly recommended to compensate for missing reads in repetitive genomic regions.
- **Filtering**: The `filter` argument in `picsFDR` and `makeRangedDataOutput` is crucial. Typical filters include:
    - `delta`: Expected fragment length range.
    - `sigmaSqF`/`sigmaSqR`: Variance of the forward/reverse read distributions (prevents overly broad peaks).
    - `se`: Standard error of the binding site position.

## Reference documentation

- [PICS: Probabilistic Inference for ChIP-Seq](./references/PICS.md)