---
name: bioconductor-illuminahumanmethylation27kmanifest
description: This package provides the manifest object containing the array design and probe metadata for the Illumina HumanMethylation27 microarray. Use when user asks to process 27k DNA methylation data, map probes to the 27k platform, or load manifest structures for use with minfi and methylumi.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylation27kmanifest.html
---


# bioconductor-illuminahumanmethylation27kmanifest

name: bioconductor-illuminahumanmethylation27kmanifest
description: Annotation data for the Illumina HumanMethylation27 (27k) microarray. Use this skill when processing DNA methylation data from the 27k platform, specifically for mapping probes, identifying manifest structures, or as a dependency for the minfi and methylumi R packages.

# bioconductor-illuminahumanmethylation27kmanifest

## Overview
The `IlluminaHumanMethylation27kmanifest` package provides the manifest object for Illumina's Human Methylation 27k microarray. This object contains the array design and is essential for preprocessing and analyzing 27k methylation data. It is primarily used in conjunction with the `minfi` package to handle raw data (IDAT files) or to provide metadata about the 27k platform.

## Installation and Loading
To use this manifest in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("IlluminaHumanMethylation27kmanifest")

# Load the package
library(IlluminaHumanMethylation27kmanifest)
```

## Typical Workflows

### Loading the Manifest Object
The primary data object is an `IlluminaMethylationManifest` class object.

```r
# Load the manifest data
data(IlluminaHumanMethylation27kmanifest)

# Inspect the object
IlluminaHumanMethylation27kmanifest
```

### Integration with minfi
In most cases, you do not call this package directly. Instead, `minfi` uses it automatically when it detects 27k array data.

```r
library(minfi)

# When reading IDAT files, minfi identifies the array type
# and loads this manifest automatically
# RGset <- read.metharray.exp(base = "path/to/idat/files")

# To manually set or check the manifest associated with an RGChannelSet
# annotation(RGset)
```

### Accessing Manifest Details
You can use functions from the `minfi` package to extract information from the manifest object.

```r
# Get probe information (Type I, Type II, etc.)
getProbeInfo(IlluminaHumanMethylation27kmanifest)

# Get control probes
getControlAddress(IlluminaHumanMethylation27kmanifest)
```

## Tips
- **Platform Specificity**: This package is strictly for the 27k array. For the 450k or EPIC arrays, use `IlluminaHumanMethylation450kmanifest` or `IlluminaHumanMethylationEPICmanifest` respectively.
- **Class Structure**: The object is of class `IlluminaMethylationManifest`. Documentation for the methods used to interact with this object can be found in the `minfi` package.
- **Data Source**: This manifest is based on the Illumina file `HumanMethylation27_270596_v.1.2.bpm`.

## Reference documentation
- [IlluminaHumanMethylation27kmanifest Reference Manual](./references/reference_manual.md)