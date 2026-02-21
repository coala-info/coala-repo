---
name: bioconductor-ccl4
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CCl4.html
---

# bioconductor-ccl4

name: bioconductor-ccl4
description: Guidance for using the CCl4 Bioconductor experiment data package. Use when needing to access raw Genepix (.gpr) data files, convert microarray data into RGList objects using limma, or construct NChannelSet objects for downstream analysis.

# bioconductor-ccl4

## Overview

The `CCl4` package is a Bioconductor experiment data package containing rat liver microarray data from carbon tetrachloride (CCl4) exposure experiments. Its primary purpose is to provide raw data files and demonstrate the workflow for transitioning from Genepix output files (.gpr) to standard Bioconductor data structures like `RGList` (from the `limma` package) and `NChannelSet` (from the `Biobase` package).

## Loading the Package and Locating Data

To use the package, load it along with its dependencies:

```r
library("Biobase")
library("limma")
library("CCl4")
```

The raw data files are stored in the `extdata` directory of the package. Locate them using:

```r
datapath <- system.file("extdata", package="CCl4")
```

## Typical Workflow

### 1. Create an RGList
The first step involves reading the sample metadata and the raw intensity files.

```r
# Read sample metadata
p <- read.AnnotatedDataFrame("samplesInfo.txt", path = datapath)

# Read Genepix files into an RGList
CCl4_RGList <- read.maimages(
  files = sampleNames(p),
  path = datapath,
  source = "genepix",
  columns = list(
    R = "F635 Median", 
    Rb = "B635 Median",
    G = "F532 Median", 
    Gb = "B532 Median"
  )
)
```

### 2. Build an NChannelSet
Once the `RGList` is created, you can convert it into an `NChannelSet` for use with `Biobase` workflows.

```r
# Prepare feature data from the RGList genes
featureData <- new("AnnotatedDataFrame", data = CCl4_RGList$genes)

# Create assay data with four channels
assayData <- with(CCl4_RGList, assayDataNew(R=R, G=G, Rb=Rb, Gb=Gb))

# Define channel metadata
varMetadata(p)$channel <- factor(c("G", "R", "G", "R"), 
                                 levels = c(ls(assayData), "_ALL_"))

# Construct the NChannelSet
CCl4_NSet <- new("NChannelSet",
                 assayData = assayData,
                 featureData = featureData,
                 phenoData = p)
```

## Key Functions and Objects

- `read.maimages()`: From the `limma` package; used to parse `.gpr` files.
- `RGList`: A list-based object containing Red and Green intensities (foreground and background).
- `NChannelSet`: A container for multi-channel assay data, extending the `eSet` class.
- `system.file()`: Essential for retrieving the path to the included `.gpr` and `.txt` files in the package installation directory.

## Reference documentation

- [CCl4](./references/CCl4.md)