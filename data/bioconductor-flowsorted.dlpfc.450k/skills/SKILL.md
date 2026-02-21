---
name: bioconductor-flowsorted.dlpfc.450k
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FlowSorted.DLPFC.450k.html
---

# bioconductor-flowsorted.dlpfc.450k

name: bioconductor-flowsorted.dlpfc.450k
description: Provides access to and instructions for the FlowSorted.DLPFC.450k Bioconductor data package. Use this skill when a user needs to perform cell-type deconvolution on human brain (DLPFC) DNA methylation data, or requires a reference RGChannelSet of flow-sorted neurons and non-neurons (NeuN+ and NeuN-) from the Illumina 450k platform.

## Overview

The `FlowSorted.DLPFC.450k` package provides a public Illumina HumanMethylation450 (450k) DNA methylation dataset consisting of 58 samples. These samples represent flow-sorted neurons (NeuN+) and non-neurons (NeuN-) from the dorsolateral prefrontal cortex (DLPFC) of 29 individuals. 

The primary value of this package is its use as a reference dataset for estimating cellular composition in bulk brain tissue samples using the `minfi` package. It is formatted as an `RGChannelSet`, making it compatible with standard Bioconductor methylation preprocessing and normalization workflows.

## Loading the Data

To use the dataset, load the library and the specific data object:

```r
library(FlowSorted.DLPFC.450k)

# Load the RGChannelSet object
data(FlowSorted.DLPFC.450k)

# Inspect the object
FlowSorted.DLPFC.450k
```

## Typical Workflow: Cell-Type Estimation

The most common use case is providing this data as a reference to `minfi::estimateCellCounts` to deconvolve bulk brain methylation data.

```r
library(minfi)
library(FlowSorted.DLPFC.450k)

# Assuming 'rgSet' is your own RGChannelSet of human DLPFC 450k data
# The estimateCellCounts function uses this package internally when 
# compositeCellType is set to "DLPFC"
cell_counts <- estimateCellCounts(rgSet, 
                                  compositeCellType = "DLPFC",
                                  referencePlatform = "IlluminaHumanMethylation450k",
                                  meanPlot = TRUE)

# View the estimated proportions of Neurons and Non-Neurons
head(cell_counts)
```

## Data Structure and Metadata

The object is an `RGChannelSet`. You can access the phenotypic data (sample information) to see the sorting status and individual IDs:

```r
pd <- pData(FlowSorted.DLPFC.450k)

# View cell types (NeuN_pos or NeuN_neg)
table(pd$CellType)

# View individual IDs (to see pairs)
table(pd$Sample_Name)
```

## Usage Tips

- **Platform Compatibility**: While generated on the 450k array, this reference is often used for EPIC (850k) array data by restricting the analysis to the probes present on both platforms (using `minfi`).
- **Normalization**: The data is provided as raw intensities (`RGChannelSet`). If using it for purposes other than `estimateCellCounts` (which handles its own normalization), you should apply `preprocessRaw`, `preprocessIllumina`, or `preprocessQuantile`.
- **Brain Region**: This specific dataset is optimized for the Dorsolateral Prefrontal Cortex. Using it for other brain regions may introduce bias if the cell-specific methylation signatures differ significantly.

## Reference documentation

- [FlowSorted.DLPFC.450k User's Guide](./references/FlowSorted.DLPFC.450k.md)