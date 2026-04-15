---
name: bioconductor-rrbsdata
description: The RRBSdata package provides a high-quality reduced representation bisulfite sequencing dataset containing simulated differentially methylated regions for benchmarking methylation analysis algorithms. Use when user asks to load example RRBS data, access ground-truth differentially methylated regions, or test differential methylation detection tools.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RRBSdata.html
---

# bioconductor-rrbsdata

## Overview

The `RRBSdata` package is an experiment data package providing a high-quality RRBS dataset derived from 12 human control samples. It features 10,000 simulated DMRs incorporated into real biological backgrounds to preserve technical and biological variation (e.g., CpG site correlation). The data is divided into "cancer" and "control" groups, making it ideal for testing algorithms designed to detect differential methylation.

## Data Objects

The package provides three primary datasets that can be loaded using the `data()` function.

### 1. The `rrbs` Object
This is a `BSraw` object (defined in the `BiSeq` package) containing the raw sequencing counts.
- **Assays**: `totalReads` (coverage) and `methReads` (methylated counts).
- **ColData**: Contains the `group` factor (cancer vs. control).

```r
library(BiSeq)
library(RRBSdata)
data(rrbs)

# Inspect the data
rrbs
colData(rrbs)
```

### 2. The `islands` Object
A `GRanges` object containing the CpG islands that were considered for DMR simulation.
- Use this to identify the genomic regions where DMRs might be located.

```r
data(islands)
head(islands)
```

### 3. The `diffMethCpGs` Object
A `GRanges` object containing the ground-truth differentially methylated CpG sites.
- This is the "answer key" for benchmarking. It contains the exact locations where methylation levels were manually altered.

```r
data(diffMethCpGs)
head(diffMethCpGs)
```

## Typical Workflow: Benchmarking a DMR Caller

1. **Load Data**: Load the `rrbs` object.
2. **Preprocessing**: Use `BiSeq` or other methylation tools to smooth or filter the data.
3. **Run Detection**: Apply a DMR detection algorithm (e.g., `betaRegression` from `BiSeq`).
4. **Validation**: Compare the detected regions against the `diffMethCpGs` object to calculate sensitivity, specificity, or FDR.

```r
# Example: Checking coverage of a specific island
library(GenomicRanges)
subsetByOverlaps(rrbs, islands[1])
```

## Usage Tips
- **BiSeq Dependency**: Since the `rrbs` object is a `BSraw` class, you must have the `BiSeq` package loaded to manipulate the object effectively.
- **Simulation Details**: DMRs were simulated with differences of 10%, 20%, 30%, or 40% methylation, spanning varying percentages of the CpG sites within an island.
- **Sample Size**: The dataset contains 10 samples (as shown in the metadata) divided into two groups, providing sufficient power for testing most regional methylation tools.

## Reference documentation
- [RRBSdata: An RRBS data set with simulated DMRs](./references/RRBSdata.md)