---
name: bioconductor-nanotubes
description: This package provides CAGE experiment data from mouse lung biopsies exposed to carbon nanotubes, including sample metadata and BigWig files. Use when user asks to access CAGE transcription start site data, analyze gene expression responses to nanotubes, or demonstrate CAGEfightR workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/nanotubes.html
---

# bioconductor-nanotubes

## Overview

The `nanotubes` package is a Bioconductor experiment data package providing CAGE (Cap Analysis of Gene Expression) data from mouse lung biopsies. The study investigates gene transcription start sites (TSS) and enhancers responding to pulmonary carbon nanotube exposure. It contains a study design data frame and paths to BigWig files (plus and minus strands) for 11 samples (5 Control, 6 Nano-treated).

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("nanotubes")
```

## Loading Study Design

The core of the package is the `nanotubes` dataset, which contains the sample metadata and filenames.

```r
library(nanotubes)
data("nanotubes")

# View the study design (Class, Name, BigWigPlus, BigWigMinus)
head(nanotubes)
```

## Accessing BigWig Files

The raw CAGE Transcription Start Site (CTSS) data is stored as BigWig files within the package's `extdata` directory. Use `system.file` to resolve the full paths.

```r
library(rtracklayer)

# Get path for the first sample's plus strand
bw_path <- system.file("extdata", nanotubes$BigWigPlus[1], 
                       package = "nanotubes", 
                       mustWork = TRUE)

# Import as GRanges
ctss_data <- import(bw_path)
```

## Workflow: Integration with CAGEfightR

The primary use case for this package is demonstrating CAGE analysis workflows using `CAGEfightR`.

```r
library(CAGEfightR)
library(nanotubes)
data("nanotubes")

# 1. Collect all file paths
bw_plus <- system.file("extdata", nanotubes$BigWigPlus, 
                       package = "nanotubes", mustWork = TRUE)
bw_minus <- system.file("extdata", nanotubes$BigWigMinus, 
                        package = "nanotubes", mustWork = TRUE)

# 2. Create named BigWigFileLists
bw_plus <- BigWigFileList(bw_plus)
bw_minus <- BigWigFileList(bw_minus)
names(bw_plus) <- names(bw_minus) <- nanotubes$Name

# 3. Quantify CTSSs using the study design
# This creates a RangedSummarizedExperiment object
CTSSs <- quantifyCTSSs(plusStrand = bw_plus, 
                       minusStrand = bw_minus, 
                       design = nanotubes)
```

## Data Details
- **Organism**: Mouse (Mus musculus)
- **Genome Build**: mm9
- **Samples**: 11 total (C547-C560 are Control; N13-N18 are Nano-exposed)
- **Data Type**: CTSS (CAGE Transcription Start Sites) counts mapping to genomic locations.

## Reference documentation
- [Cap Analysis of Gene Expression (CAGE) data from mouse nanotube experiment](./references/nanotubes.md)
- [nanotubes Source Rmd](./references/nanotubes.Rmd)