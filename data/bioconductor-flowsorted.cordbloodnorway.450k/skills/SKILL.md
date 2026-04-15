---
name: bioconductor-flowsorted.cordbloodnorway.450k
description: This package provides raw DNA methylation data from flow-sorted umbilical cord blood samples for use as a reference in cell type estimation. Use when user asks to access cord blood methylation reference data, estimate cell type proportions in newborn blood samples, or perform Houseman deconvolution on Illumina 450k data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FlowSorted.CordBloodNorway.450k.html
---

# bioconductor-flowsorted.cordbloodnorway.450k

## Overview

The `FlowSorted.CordBloodNorway.450k` package is a specialized data resource for Bioconductor. It contains raw DNA methylation data (RGChannelSet) from 77 umbilical cord blood samples across 11 individuals (6 girls, 5 boys). These samples were flow-sorted into pure cellular populations.

This package is a critical reference dataset for researchers performing Epigenome-Wide Association Studies (EWAS) on cord blood. While `FlowSorted.Blood.450k` exists for adult blood, it does not accurately estimate cell compositions in newborns; this package provides the appropriate cord-blood-specific reference for the Houseman deconvolution algorithm.

## Workflow: Cell Type Estimation

The primary use case for this package is to provide a reference for the `estimateCellCounts` function in the `minfi` package.

### 1. Load the Data
To access the RGset object directly:

```r
library(FlowSorted.CordBloodNorway.450k)
data(FlowSorted.CordBloodNorway.450k)

# View the object
FlowSorted.CordBloodNorway.450k
```

### 2. Estimate Cell Counts in User Data
To use this dataset as a reference for deconvoluting your own cord blood samples, specify it in the `compositeCellType` argument within `minfi`.

```r
library(minfi)

# Assuming 'myRGset' is your Illumina 450k data from cord blood
cell_counts <- estimateCellCounts(myRGset, 
                                  compositeCellType = "CordBloodNorway",
                                  processMethod = "preprocessQuantile")

# View estimated proportions
head(cell_counts)
```

## Key Considerations

- **Cell Types Included**: The reference includes CD4+ T-lymphocytes, CD8+ T-lymphocytes, CD19+ B cells, CD14+ monocytes, CD56+ NK cells, and granulocytes.
- **Platform**: This package is specifically designed for the Illumina HumanMethylation450 (450k) array.
- **Alternative**: If this dataset does not meet your needs, `FlowSorted.CordBlood.450k` is another alternative reference dataset for cord blood available in Bioconductor.
- **Integration**: The data is formatted as an `RGChannelSet`, allowing for seamless integration with `minfi` normalization and preprocessing pipelines.

## Reference documentation

- [FlowSorted.CordBloodNorway.450k Reference Manual](./references/reference_manual.md)