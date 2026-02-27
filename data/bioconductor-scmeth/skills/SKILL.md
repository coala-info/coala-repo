---
name: bioconductor-scmeth
description: This tool performs quality control and preprocessing for single-cell DNA methylation data. Use when user asks to assess CpG coverage, analyze read mapping metrics, evaluate methylation bias, or generate comprehensive QC reports for bisulfite sequencing data.
homepage: https://bioconductor.org/packages/release/bioc/html/scmeth.html
---


# bioconductor-scmeth

name: bioconductor-scmeth
description: Quality control and preprocessing for single-cell methylation data using the scmeth R package. Use this skill to assess CpG coverage, read mapping metrics, methylation bias, and bisulfite conversion rates for BS-seq or RRBS data, particularly when working with bsseq objects or FireCloud pipeline outputs.

# bioconductor-scmeth

## Overview
The `scmeth` package provides a suite of tools for analyzing the quality of single-cell DNA methylation data. It is designed to work with `bsseq` objects and is particularly well-suited for data processed through the FireCloud methylation pipeline. The package helps researchers identify sequencing artifacts, assess CpG coverage across genomic features, and evaluate bisulfite conversion efficiency.

## Installation
Install the package using BiocManager:

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("scmeth")
library(scmeth)
```

## Data Input
The primary input for most functions is a `bsseq` object. For large datasets stored as HDF5 files (common in single-cell workflows), use the `HDF5Array` package to load the data:

```r
# Loading HDF5-backed SummarizedExperiment/bsseq object
directory <- "path/to/bismark_data"
bsObject <- HDF5Array::loadHDF5SummarizedExperiment(directory)
```

## Automated Quality Control Report
The most efficient way to perform QC is using the `report` function, which generates a comprehensive HTML report (`qcReport.html`) containing visualizations from most package functions.

```r
# Generate a full QC report
# organism: e.g., Hsapiens, Mmusculus
# genome: e.g., "hg38", "mm10"
scmeth::report(bsObject, outDir = '~/QC_Results', Hsapiens, "hg38")
```
**Parameters:**
- `subSample`: Optional. Number of CpGs to consider (default is all, but 1 million is often sufficient for QC).
- `offset`: Optional. Number of CpGs to skip from the start (to avoid telomeric regions).

## Individual QC Functions

### Coverage Analysis
Assess how well the genome was covered by the sequencing run.
- `coverage(bsObject)`: Returns the number of CpGs observed in each sample.
- `chromosomeCoverage(bsObject)`: Distribution of CpG coverage across individual chromosomes.
- `featureCoverage(bsObject, features, genome)`: Fraction of CpGs seen in specific genomic regions (e.g., 'cpg_islands', 'cpg_shores', 'promoters').
- `downsample(bsObject)`: Performs binomial sampling to determine if sequencing has reached saturation for CpG capture.

### Read and Alignment Metrics
- `readmetrics(bsObject)`: Visualizes total reads, mapped reads, and unmapped reads per sample.
- `repMask(bsObject, organism, genome)`: Provides CpG coverage specifically in non-repeat regions of the genome.

### Methylation Quality Metrics
- `mbiasplot(mbiasFiles)`: Analyzes methylation bias along the length of the reads. Fluctuations at the start or end of reads can indicate sequencing quality issues.
- `methylationDist(bsObject)`: Shows the distribution of methylation levels. In single-cell data, most CpGs should be near 0 or 1; a high frequency of intermediate values may suggest sequencing errors.
- `bsConversionPlot(bsObject)`: Calculates the bisulfite conversion rate. Rates below 95% typically indicate problems with sample preparation.
- `cpgDensity(bsObject, organism, windowLength = 1000)`: Diagnostic tool to see if the protocol (like RRBS) successfully targeted CpG-dense regions.

## Reference documentation
- [scmeth Vignette](./references/my-vignette.md)
- [scmeth Source Vignette](./references/my-vignette.Rmd)