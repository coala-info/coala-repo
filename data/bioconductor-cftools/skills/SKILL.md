---
name: bioconductor-cftools
description: bioconductor-cftools analyzes cell-free DNA methylation data for cancer detection and tissue deconvolution. Use when user asks to estimate tumor burden, infer tissue-of-origin composition from plasma samples, or perform supervised sorting of human tissues.
homepage: https://bioconductor.org/packages/release/bioc/html/cfTools.html
---

# bioconductor-cftools

name: bioconductor-cftools
description: Analysis of cell-free DNA (cfDNA) methylation data for cancer detection and tissue deconvolution. Use when analyzing fragment-level methylation states to estimate tumor burden or infer tissue-of-origin composition from plasma samples.

# bioconductor-cftools

## Overview

The `cfTools` package provides a suite of tools for analyzing cell-free DNA (cfDNA) methylation sequencing data. It employs a read-based deconvolution algorithm to separate tumor-derived or tissue-specific fragments from background normal fragments. Its primary applications include:
1. **Cancer Detection**: Estimating tumor burden ($\theta$) by separating fragments into tumor and normal classes.
2. **Tissue Deconvolution**: Inferring the fractional contribution of various tissue types to a plasma sample.
3. **Supervised Sorting**: Using deep learning models (`cfSort`) to estimate fractions for 29 major human tissues.

## Installation

Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("cfTools")
```

## Data Preparation Workflow

The package requires fragment-level methylation states (binary sequences where 0 is unmethylated and 1 is methylated).

### 1. Generate Fragment-Level Information
Merge paired-end sequencing reads from a sorted BED file:

```r
# PEReads is a path to a sorted BED file
fragInfo <- MergePEReads(PEReads)
```

### 2. Extract Methylation States
Merge methylation calls from Bismark `CpG_OT` and `CpG_OB` files:

```r
# CpG_OT and CpG_OB are paths to Bismark extractor outputs
methInfo <- MergeCpGs(CpG_OT, CpG_OB)
```

### 3. Combine Fragment and Methylation Data
Create the final fragment-level methylation object:

```r
fragMeth <- GenerateFragMeth(fragInfo, methInfo)
```

### 4. Define Marker Parameters
Calculate shape parameters for beta distributions using reference methylation levels:

```r
# methLevel: matrix of beta values (samples x markers)
# sampleTypes: vector of types (e.g., "tumor", "normal")
# markerNames: vector of marker IDs
markerParam <- GenerateMarkerParam(methLevel, sampleTypes, markerNames)
```

## Core Analysis Functions

### Cancer Detection
Use `CancerDetector()` to estimate tumor burden. It requires fragment-level methylation states mapped to cancer markers and the corresponding marker parameters.

```r
# lambda: tuning parameter for tumor burden sensitivity
results <- CancerDetector(fragMethFile, markerParamFile, lambda = 0.5, id = "sample_01")
# Returns: cfDNA_tumor_burden, normal_cfDNA_fraction
```

### Tissue Deconvolution (Unsupervised/Semi-supervised)
Use `cfDeconvolve()` for multi-class tissue estimation:

```r
tissueFraction <- cfDeconvolve(
  fragMethFile = fragMethFile,
  markerParamFile = markerParamFile,
  numTissues = 7,
  emAlgorithmType = "em.global.unknown",
  likelihoodRatioThreshold = 2,
  id = "sample_01"
)
```

### Supervised Tissue Deconvolution (cfSort)
Use `cfSort()` for a deep-learning based estimation of 29 human tissues. This requires fragments mapped to specific cfSort markers.

```r
# fragMethInfo must contain markerName and methState columns
fractions <- cfSort(fragMethInfo, id = "sample_01")
```

## Visualization

Generate a pie chart of the estimated fractions:

```r
PlotFractionPie(
  results, 
  title = "cfDNA Composition", 
  class_colors = c("normal_cfDNA_fraction" = "blue", "cfDNA_tumor_burden" = "red")
)
```

## Tips for Success

- **Marker Intersection**: To improve performance, filter your `fragMeth` data to only include fragments overlapping your genomic marker regions using `GenomicRanges::subsetByOverlaps` before running deconvolution.
- **Parameter Cleaning**: Ensure `markerParam` does not contain `NA:NA` or `0:0` values, as these will cause errors in the EM algorithm.
- **cfSort Markers**: When using `cfSort`, ensure your `markerName` column corresponds to the `region_index` from the cfSort marker reference (hg19).

## Reference documentation

- [Analyzing cell-free DNA methylation data with cfTools](./references/cfTools-vignette.md)
- [cfTools-vignette.Rmd](./references/cfTools-vignette.Rmd)