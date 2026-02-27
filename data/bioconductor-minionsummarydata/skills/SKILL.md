---
name: bioconductor-minionsummarydata
description: This package provides example Nanopore sequencing summary data from Salmonella Typhi for use with the IONiseR analysis tool. Use when user asks to access sample Fast5Summary objects, explore MinION run metrics, or practice visualizing Nanopore quality control statistics.
homepage: https://bioconductor.org/packages/release/data/experiment/html/minionSummaryData.html
---


# bioconductor-minionsummarydata

## Overview

The `minionSummaryData` package is a Bioconductor experiment data package. It contains three `Fast5Summary` objects representing replicates of *Salmonella Typhi* sequencing data originally published by Ashton et al. (2015). These objects are designed for use with the `IONiseR` package, providing a standardized way to explore Nanopore run metrics, basecalling statistics, and quality scores without needing the original multi-gigabyte FAST5 files.

## Loading the Data

The package contains three primary datasets: `s.typhi.rep1`, `s.typhi.rep2`, and `s.typhi.rep3`.

```r
# Install the package if necessary
# BiocManager::install("minionSummaryData")

# Load the package
library(minionSummaryData)

# Load the specific datasets into the workspace
data(s.typhi.rep1)
data(s.typhi.rep2)
data(s.typhi.rep3)

# Inspect the object
s.typhi.rep1
```

## Typical Workflow with IONiseR

Since these objects are `Fast5Summary` class (defined in `IONiseR`), you can immediately apply `IONiseR` functions to analyze the run performance.

### 1. Summarizing Read Statistics
```r
library(IONiseR)

# View summary of read types (template, complement, 2D)
readTypeSummary(s.typhi.rep1)

# Check Pass/Fail counts (based on 2D read quality > 9)
table(readInfo(s.typhi.rep1)$pass)
```

### 2. Visualizing Run Metrics
You can plot various aspects of the MinION flowcell performance using the data provided in this package:

```r
# Plot layout of the flowcell
plotFlowcell(s.typhi.rep1)

# Plot accumulation of data over time
plotReadAccumulation(s.typhi.rep1)

# Plot active channels over time
plotActiveChannels(s.typhi.rep1)
```

### 3. Quality Control
Analyze the distribution of quality scores or read lengths:

```r
# Plot histogram of read lengths
plotReadLengths(s.typhi.rep1)

# Plot 2D read quality scores
plotEventRate(s.typhi.rep1)
```

## Data Structure Notes

- **Source**: The data comes from early MinION R7 chemistry.
- **Processing**: The objects were created by reading raw FAST5 files using `IONiseR::readFast5Summary()`.
- **Pass/Fail Criteria**: A "PASS" status was manually added to these objects. A read is marked as `pass = TRUE` if it has a 2D read with a mean base quality score greater than 9.
- **Metadata**: Use `readInfo(s.typhi.rep1)` to access a data frame containing metadata for every read, including channel ID, start time, and duration.

## Reference documentation

- [Creating example MinION summary dataset](./references/creating-Styphi-Dataset.md)