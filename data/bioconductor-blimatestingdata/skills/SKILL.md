---
name: bioconductor-blimatestingdata
description: the package blima.
homepage: https://bioconductor.org/packages/release/data/experiment/html/blimaTestingData.html
---

# bioconductor-blimatestingdata

name: bioconductor-blimatestingdata
description: Access and use the blimaTestingData package, which provides example Illumina bead-level microarray data for the blima package. Use this skill when you need to demonstrate or test bead-level data processing, quantile normalization across multiple arrays, or differential expression workflows using the blima package.

# bioconductor-blimatestingdata

## Overview

The `blimaTestingData` package provides a specialized dataset derived from NCBI Gene Expression Omnibus (GSE56129). It contains 9 Illumina array spots representing three different treatment conditions of human mesenchymal cells. The primary purpose of this package is to provide a standardized `beadLevelData` object (from the `beadarray` package) to test and demonstrate the functionality of the `blima` package, which performs analysis on Illumina data without prior probe summarization.

## Loading the Data

The core object in this package is `blimatesting`. It is a list containing two `beadLevelData` objects.

```r
# Load the library
library(blimaTestingData)

# Load the example dataset
data(blimatesting)

# Inspect the object
# blimatesting is a list of beadLevelData objects
class(blimatesting)
length(blimatesting)
```

## Typical Workflows

### Using with the blima Package
The `blimatesting` object is designed to be passed directly into `blima` functions. Because it is structured as a list, it allows for testing workflows that involve multiple array kits or quantile normalization across different arrays.

```r
# Example: Using with blima (requires blima package)
# library(blima)
# normalized_data <- selectedChannelTransform(blimatesting, transformation=log2)
```

### Data Structure and Selection
The dataset contains 9 spots:
- Condition 1: 4 replicates
- Condition 2: 4 replicates
- Condition 3: 1 replicate

You can process specific arrays by providing a list of logical vectors to the `blima` processing functions to subset the `blimatesting` object.

## Data Preparation Patterns

While the package provides pre-processed data, the underlying workflow for creating such an object involves:
1. Reading raw Illumina scanner output (txt and tif files) using `beadarray::readIllumina`.
2. Attaching phenotypic metadata (experiment annotations).
3. Adding chip-specific annotation (e.g., HumanHT-12 v4).
4. Combining multiple `beadLevelData` objects into a single list for joint analysis.

## Tips for Usage
- **Object Type**: Remember that `blimatesting` is a `list`. If a function expects a single `beadLevelData` object, use `blimatesting[[1]]`.
- **Annotation**: For functional annotation of this specific data, the Bioconductor package `illuminaHumanv4.db` is typically used, though it may deviate slightly from the original manufacturer text files.
- **Memory**: Bead-level data can be memory-intensive. This testing dataset is kept small specifically for demonstration purposes.

## Reference documentation
- [blimaTestingData](./references/blimaTestingData.md)