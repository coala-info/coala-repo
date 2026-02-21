---
name: bioconductor-alpinedata
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/alpineData.html
---

# bioconductor-alpinedata

## Overview
The `alpineData` package provides a subset of aligned RNA-seq reads from four GEUVADIS samples. These data are primarily used as an experiment data package for the `alpine` package to demonstrate bias modeling and abundance estimation. The data is stored as `GAlignmentPairs` objects and is retrieved via `ExperimentHub`.

## Loading the Package
To begin, load the package and its dependencies:
```R
library(alpineData)
library(GenomicAlignments)
```

## Accessing Data
There are two primary ways to access the sample data.

### 1. Direct Function Calls
The package provides convenience functions named after the sample IDs:
- `ERR188297()`
- `ERR188088()`
- `ERR188204()`
- `ERR188317()`

Example:
```R
gap <- ERR188297()
```

### 2. ExperimentHub Interface
You can also search for and retrieve the data using the `ExperimentHub` interface:
```R
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "alpineData")
# Retrieve by EH ID
gap <- eh[["EH166"]] 
```

## Typical Workflow

### Inspecting Alignments
Once the `GAlignmentPairs` object is loaded, you can perform standard genomic analysis:
```R
# Check distribution across chromosomes
table(seqnames(gap))

# Filter for a specific chromosome
gap1 <- gap[seqnames(gap) == "1"]

# Access start positions of the first read in the pair
starts <- start(first(gap1))

# Visualize read distribution
hist(starts, col="grey", main="Read Starts on Chromosome 1")
```

### Data Characteristics
- **Format**: `GAlignmentPairs`
- **Strand Mode**: 1 (standard for these samples)
- **Content**: Subset of reads from the GEUVADIS project, specifically selected for demonstrating fragment sequence bias.

## Tips
- The data is cached locally via `ExperimentHub`. The first call will download the data, while subsequent calls will load it from the local cache.
- Use `seqinfo(gap)` to see the chromosome information associated with the alignments.
- These objects are compatible with all functions in the `GenomicAlignments` and `GenomicRanges` packages.

## Reference documentation
- [Exploring the GAlignmentPairs in alpineData](./references/alpineData.md)