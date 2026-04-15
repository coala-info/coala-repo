---
name: bioconductor-harmandata
description: HarmanData provides curated microarray and methylation datasets for testing and demonstrating batch-effect correction methods. Use when user asks to load example gene expression data, access methylation reference statistics, or benchmark batch correction algorithms.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HarmanData.html
---

# bioconductor-harmandata

## Overview
`HarmanData` is a Bioconductor data experiment package that provides high-quality, curated datasets specifically designed for testing and demonstrating batch-effect correction methods. It contains three microarray gene expression datasets (IMR90, NPM, and OLF) and extensive methylation reference data (Infinium5, episcope) derived from 450K and EPIC arrays. This package is the primary data source for the `Harman` batch correction package.

## Loading Data
The package uses the standard R `data()` mechanism. Each dataset typically consists of a data matrix (probes as rows, samples as columns) and a corresponding info data frame containing experimental factors (Treatment and Batch).

```r
library(HarmanData)

# Load Gene Expression datasets
data(IMR90) # Loads imr90.data and imr90.info
data(NPM)   # Loads npm.data and npm.info
data(OLF)   # Loads olf.data and olf.info

# Load Methylation datasets
data(Infinium5) # Loads lvr.combat, lvr.harman, md.combat, md.harman
data(episcope)  # Loads a list containing pd, original, harman, combat, etc.
```

## Gene Expression Datasets
These datasets are formatted for immediate use with batch correction tools.

*   **IMR90**: 12 samples, 22,223 probesets. 4 experimental conditions (2 treatments x 2 time points) across 3 batches.
*   **NPM**: 24 samples, 35,512 probesets. 4 treatment groups across 3 batches.
*   **OLF**: 28 samples, 33,297 probesets. 7 treatment groups across 4 batches.

### Typical Workflow
```r
# Inspect the structure
table(olf.info$Treatment, olf.info$Batch)

# Use with the Harman package (if installed)
# library(Harman)
# harman_results <- harman(dat = olf.data, expt = olf.info$Treatment, batch = olf.info$Batch)
```

## Methylation Reference Data
The `Infinium5` data provides probe-wise summary statistics (Log Variance Ratio and Mean Differences) for ComBat and Harman across five large methylation datasets (EpiSCOPE, EPIC-Italy, BodyFatness, NOVI, URECA).

*   **lvr.harman / lvr.combat**: Log2 variance ratio statistics.
*   **md.harman / md.combat**: Mean differences.

### Using the Methylation Reference
You can check if specific CpG probes in your own study are susceptible to batch effects by comparing them to these reference matrices:

```r
# Check a specific CpG site across the 5 reference datasets
lvr.harman["cg01381374", ]
md.harman["cg01381374", ]
```

## The EpiSCOPE Example
The `episcope` object is a list used to demonstrate advanced methylation clustering functions in the `Harman` package.

```r
# Access components
head(episcope$original) # Uncorrected beta values
head(episcope$pd)       # Phenotypic descriptors
```

## Tips for Usage
*   **Missing Values**: In the `Infinium5` data, `NA` values indicate that a CpG probe was not present in that specific dataset (e.g., 450K vs EPIC differences).
*   **Data Structure**: Always ensure your experimental design (info) matches the columns of your data matrix before attempting batch correction.
*   **Normalization**: The gene expression data in this package has already been RMA-normalized and background-adjusted.

## Reference documentation
- [HarmanData](./references/HarmanData.md)