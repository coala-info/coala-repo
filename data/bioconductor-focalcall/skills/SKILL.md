---
name: bioconductor-focalcall
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/focalCall.html
---

# bioconductor-focalcall

name: bioconductor-focalcall
description: Specialized analysis of focal copy number aberrations (CNAs) in cancer specimens using the focalCall R package. Use this skill to distinguish somatic focal aberrations from germ-line copy number variations (CNVs), differentiate between homozygous/hemizygous deletions and gains/amplifications, and generate frequency plots or IGV-compatible files from array CGH or sequencing data.

# bioconductor-focalcall

## Overview

The `focalCall` package is designed to identify and annotate focal copy number aberrations (CNAs) while filtering out germ-line copy number variations (CNVs). It builds upon segmentation and calling algorithms (like `CGHcall`) to provide a streamlined workflow for high-resolution genomic data. It is particularly useful for identifying recurrent focal events and distinguishing them from broader chromosomal alterations.

## Core Workflow

### 1. Data Preparation
The package expects objects of class `CGHcall`. You typically need a tumor dataset and either a matched normal reference or an external CNV track to filter out non-somatic variations.

```r
library(focalCall)
# Load example data or your own CGHcall object
data(BierkensCNA) 
# CGHset: The tumor data
# CNVset: The CNV reference track
```

### 2. Detecting Focal Aberrations
The primary function is `focalCall()`. It identifies aberrations smaller than a user-defined size and calculates peak regions for recurrent focal CNAs.

```r
# focalSize: Size cutoff in Mb to define 'focal' (e.g., 3 Mb)
# minFreq: Minimum number of samples required to define a recurrent region
calls_focals <- focalCall(CGHset, CNVset, focalSize = 3, minFreq = 2)
```

### 3. Visualizing Results
`focalCall` provides specific plotting functions to visualize the frequency of all aberrations versus specifically focal ones.

```r
# Plot frequency of all aberrations
FreqPlot(calls_focals, header="Frequency Plot: All Aberrations")

# Plot frequency of focal aberrations only
FreqPlotfocal(calls_focals, header="Frequency Plot: Focal Only")
```

### 4. Exporting for External Viewers
To visualize the calls in the Integrative Genomics Viewer (IGV), use the `igvFiles` function. This generates `.SEG` and `.IGV` files in the working directory.

```r
igvFiles(calls_focals)
```

## Key Functions and Parameters

- `focalCall(CGHset, CNVset, focalSize, minFreq, ...)`: The main analysis engine.
    - `CGHset`: A `cghCall` object containing tumor data.
    - `CNVset`: A `cghCall` object containing CNV data (or matched normals).
    - `focalSize`: The maximum size (in Mb) for an aberration to be considered focal.
    - `minFreq`: The minimum frequency (count) for a focal aberration to be reported in the peak regions.
- `FreqPlotfocal()`: Specialized frequency plot that highlights only the focal events identified by the algorithm.
- `igvFiles()`: Utility to export data into formats compatible with IGV for manual inspection of genomic loci.

## Reference documentation

- [focalCall](./references/focalCall.md)