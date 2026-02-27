---
name: bioconductor-qdnaseq
description: QDNAseq performs copy number analysis from shallow whole-genome sequencing data by binning reads and correcting for GC content and mappability. Use when user asks to perform copy number aberration calling, process sWGS BAM files, or segment genomic data using circular binary segmentation.
homepage: https://bioconductor.org/packages/release/bioc/html/QDNAseq.html
---


# bioconductor-qdnaseq

## Overview
QDNAseq is an R package designed for copy number analysis from shallow whole-genome sequencing data. It implements a robust workflow that divides the genome into fixed-size bins, counts reads, and applies corrections for sequence mappability and GC content. The package integrates with `DNAcopy` for segmentation and `CGHcall` for calling aberrations, making it a complete pipeline for sWGS data.

## Core Workflow

### 1. Bin Annotations
Before processing BAM files, you must obtain bin annotations for the specific genome build and bin size (e.g., 15, 30, 50, or 100 kbp).
```r
library(QDNAseq)
# Requires separate installation of annotation packages like QDNAseq.hg19
bins <- getBinAnnotations(binSize=15, genome="hg19")
```

### 2. Processing BAM Files
Load sequencing data into the bin structure.
```r
# Read counts from BAM files
readCounts <- binReadCounts(bins, bamfiles=c("sample1.bam", "sample2.bam"))

# Apply default filters (removes bins with low mappability or in blacklisted regions)
readCountsFiltered <- applyFilters(readCounts, residual=TRUE, blacklist=TRUE)

# Estimate and apply GC/mappability correction
readCountsFiltered <- estimateCorrection(readCountsFiltered)
copyNumbers <- correctBins(readCountsFiltered)
```

### 3. Normalization and Smoothing
Prepare the data for segmentation by removing outliers and scaling.
```r
copyNumbersNormalized <- normalizeBins(copyNumbers)
copyNumbersSmooth <- smoothOutlierBins(copyNumbersNormalized)
```

### 4. Segmentation and Calling
Identify genomic segments and classify them as losses, normals, gains, or amplifications.
```r
# Segmentation using Circular Binary Segmentation (CBS)
copyNumbersSegmented <- segmentBins(copyNumbersSmooth)
copyNumbersSegmented <- normalizeSegmentedBins(copyNumbersSegmented)

# Call copy number aberrations
copyNumbersCalled <- callBins(copyNumbersSegmented)
```

## Visualization and Export
QDNAseq provides built-in plotting functions for every stage of the pipeline.
```r
# Plotting
plot(copyNumbersCalled)
isobarPlot(readCountsFiltered) # Check GC/mappability relationship
noisePlot(readCountsFiltered)  # Check sample quality

# Exporting results
exportBins(copyNumbersCalled, file="results.txt")
exportBins(copyNumbersCalled, format="igv", file="results.igv")
exportBins(copyNumbersCalled, format="vcf", file="results.vcf")
```

## Advanced Usage

### Parallel Processing
QDNAseq uses the `future` framework for parallelization.
```r
library(future)
plan("multisession", workers=4)
# Functions like segmentBins() and estimateCorrection() will now run in parallel
```

### Handling Sex Chromosomes
By default, sex chromosomes are ignored. To include them while maintaining proper LOESS correction:
1. Filter out sex chromosomes.
2. Run `estimateCorrection()`.
3. Re-apply filters with `chromosomes=NA` to restore X and Y.
4. Run `correctBins()`.

### Custom Bin Annotations
If using a non-standard genome or bin size, use `createBins()`, `calculateMappability()`, and `calculateBlacklist()` to generate a new annotation object.

## Reference documentation
- [Introduction to QDNAseq](./references/QDNAseq.md)