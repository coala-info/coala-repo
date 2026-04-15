---
name: bioconductor-methylaiddata
description: This package provides pre-summarized quality control metrics from large-scale Illumina human methylation array datasets to serve as a reference background. Use when user asks to load 450k or EPIC array reference data, compare methylation samples against a population background, or identify outliers in methylation studies using MethylAid.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MethylAidData.html
---

# bioconductor-methylaiddata

## Overview

MethylAidData is an experiment data package that provides pre-summarized quality control metrics for two large-scale Illumina human methylation array datasets. It contains data for 2,800 samples from the BIOS consortium (450k array) and 2,620 samples from the University of Southampton and University of Essex (EPIC/850k array). 

These datasets are intended to be used with the `MethylAid` package to provide a robust background for identifying outliers in new methylation studies.

## Loading Reference Data

The package provides two primary `summarizedData` objects. These are loaded using the standard R `data()` function.

```r
library(MethylAidData)

# Load the 450k array reference data (N=2800)
data(exampleDataLarge) 

# Load the EPIC/850k array reference data (N=2620)
data(exampleDataEPIC)
```

## Typical Workflow

The primary use case is passing these objects to the `visualize` function in the `MethylAid` package to compare your own data against a large-scale population reference.

### Using as Background in MethylAid

When running the interactive `MethylAid` application, you can provide the `MethylAidData` objects as the `background` argument.

```r
library(MethylAid)
library(MethylAidData)

# Load your own summarized data (previously created via MethylAid::summarize)
# myData <- summarize(targets) 

# Load the EPIC reference
data(exampleDataEPIC)

# Launch the interactive app with the reference background
visualize(myData, background = exampleDataEPIC)
```

### Merging Summarized Data

You can combine the reference data with your own summarized objects or merge multiple reference sets to create a custom large-scale reference.

```r
# Combine two summarizedData objects
combinedData <- c(exampleDataLarge, myData)
```

## Data Characteristics

- **450k Data (`exampleDataLarge`)**: Based on the BIOS consortium study. Useful for legacy 450k array QC.
- **EPIC Data (`exampleDataEPIC`)**: Based on combined studies from Southampton and Essex. Essential for modern 850k array QC.
- **Contents**: Each object contains median Methylated and Unmethylated intensities, quality control probe intensities, and calculated QC metrics (sample-dependent, sample-independent, and detection p-values).

## Reference documentation

- [MethylAidData](./references/MethylAidData.md)