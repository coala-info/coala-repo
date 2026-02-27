---
name: bioconductor-shinymethyldata
description: This package provides example TCGA Head and Neck Cancer DNA methylation summary datasets for use with the shinyMethyl package. Use when user asks to load example methylation data, demonstrate shinyMethyl functionality, or compare raw and normalized methylation summaries.
homepage: https://bioconductor.org/packages/release/data/experiment/html/shinyMethylData.html
---


# bioconductor-shinymethyldata

name: bioconductor-shinymethyldata
description: Access and use the TCGA Head and Neck Cancer DNA methylation example datasets (450k arrays) provided for the shinyMethyl package. Use this skill when a user needs to load example methylation data, demonstrate shinyMethyl functionality, or perform quality control and normalization visualization on TCGA-derived methylation summaries.

# bioconductor-shinymethyldata

## Overview
The `shinyMethylData` package provides pre-computed summary objects for 369 TCGA Head and Neck Cancer DNA methylation samples (450k arrays). These objects are specifically formatted for use with the `shinyMethyl` package. The dataset includes 310 tumor samples, 50 matched normals, and 9 technical replicates. It serves as the primary example data for demonstrating interactive visualization of DNA methylation quality control and normalization.

## Loading the Data
The package contains two main data objects: `summary.tcga.raw` and `summary.tcga.norm`.

```r
# Load the package
library(shinyMethylData)

# Load the raw summary data
data(summary.tcga.raw)

# Load the normalized summary data
data(summary.tcga.norm)
```

## Typical Workflow
The primary use case for this package is to provide input for the `runShinyMethyl` function from the `shinyMethyl` package.

### 1. Interactive Visualization
To launch the interactive shinyMethyl interface using the raw TCGA data:

```r
library(shinyMethyl)
library(shinyMethylData)

data(summary.tcga.raw)
runShinyMethyl(summary.tcga.raw)
```

### 2. Comparing Raw and Normalized Data
You can use these datasets to compare the effects of normalization within the shinyMethyl interface:

```r
data(summary.tcga.raw)
data(summary.tcga.norm)

# Launch with both objects to compare
runShinyMethyl(summary.tcga.raw, summary.tcga.norm)
```

## Data Objects
- **summary.tcga.raw**: A list object containing extracted summaries (quantiles, principal components, etc.) from the raw 450k IDAT files.
- **summary.tcga.norm**: A list object containing summaries after functional normalization (funnorm) has been applied.

## Usage Tips
- These objects are "summarized" data. They do not contain the full 450,000+ probe intensities for every sample, but rather the distribution summaries required for fast interactive plotting.
- To create similar objects from your own `RGChannelSet` or `MethylSet`, use the `shinySummarize` function from the `shinyMethyl` package.

## Reference documentation
- [shinyMethylData Reference Manual](./references/reference_manual.md)