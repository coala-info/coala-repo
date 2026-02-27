---
name: bioconductor-mircompdata
description: This package provides raw qPCR amplification curves and fluorescence data from a large-scale miRNA mixture and dilution study. Use when user asks to benchmark miRNA expression estimation methods, analyze PCR amplification curves, or access the miRcomp experiment data package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/miRcompData.html
---


# bioconductor-mircompdata

name: bioconductor-mircompdata
description: Access and use the miRcompData experiment data package from Bioconductor. This package provides raw qPCR amplification curves (fluorescence data) from a large miRNA mixture/dilution study. Use this skill when a user needs to benchmark miRNA expression estimation methods, analyze PCR amplification curves, or reproduce studies using the miRcomp framework.

# bioconductor-mircompdata

## Overview
`miRcompData` is a Bioconductor experiment data package containing raw amplification data from a large-scale microRNA mixture and dilution study. It is specifically designed to provide the underlying data required by the `miRcomp` package to evaluate and compare the performance of different methods for estimating expression levels from PCR amplification curves.

## Installation
To use this data package, install it via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("miRcompData")
```

## Loading and Inspecting Data
The package contains a single primary dataset. Load it into your R session using the `data()` function.

```r
library(miRcompData)

# Load the dataset
data(miRcompData)

# View the first few rows
head(miRcompData)

# Check the structure
str(miRcompData)
```

## Data Structure
The `miRcompData` object is a `data.frame` with the following columns:

*   **Barcode**: Unique identifier for each multi-well plate.
*   **Well**: Unique identifier for each well in a plate.
*   **SampleID**: Name given to each sample.
*   **FeatureSet**: Either "A" or "B", denoting the two feature groups.
*   **TargetName**: The name of the target miRNA.
*   **Cycle**: The specific PCR cycle number.
*   **Rn**: The raw fluorescence signal.
*   **dRn**: The background-subtracted fluorescence signal.
*   **NumCycle**: The total number of PCR cycles performed in the run.

## Typical Workflow
The data is typically used to visualize amplification curves or as input for expression estimation algorithms.

### Visualizing an Amplification Curve
To plot the amplification curve for a specific well:

```r
# Subset data for a single well
one_well <- subset(miRcompData, Barcode == miRcompData$Barcode[1] & Well == "A1")

# Plot Cycle vs Background-subtracted Fluorescence
plot(one_well$Cycle, one_well$dRn, type="b", 
     xlab="Cycle", ylab="dRn", 
     main=paste("Amplification Curve:", one_well$TargetName[1]))
```

### Integration with miRcomp
This data is intended to be processed by the `miRcomp` package. You can use the raw curves in `miRcompData` to test new methods for calculating Ct values or expression estimates and then compare them against the known titration/mixture designs provided in the `miRcomp` package.

## Reference documentation
- [miRcompData Reference Manual](./references/reference_manual.md)