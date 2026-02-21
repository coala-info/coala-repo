---
name: bioconductor-hibed
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HiBED.html
---

# bioconductor-hibed

name: bioconductor-hibed
description: Perform brain cell type deconvolution on human DNA methylation microarray data (450K and EPIC). Use this skill to estimate proportions of 7 major brain cell types—GABAergic neurons, glutamatergic neurons, astrocytes, microglial cells, oligodendrocytes, endothelial cells, and stromal cells—from bulk brain methylation beta values.

# bioconductor-hibed

## Overview
HiBED (Hierarchical Brain cell Deconvolution) is an R package designed to estimate cell type proportions in bulk brain tissue samples using DNA methylation data. It utilizes reference libraries derived from Illumina HumanMethylation450K and HumanMethylationEPIC microarrays. The package implements a modified version of the constrained projection/quadratic programming (CP/QP) algorithm to resolve seven major brain cell types.

## Installation
To install the package from Bioconductor:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("HiBED")
```

## Core Workflow

### 1. Load the Package and Reference Data
The package includes pre-built reference libraries necessary for the deconvolution process.
```r
library(HiBED)
data("HiBED_Libraries")
```

### 2. Prepare Input Data
The input must be a matrix of DNA methylation Beta values where:
- Rows represent CpG probe IDs (e.g., cg00000029).
- Columns represent individual samples.
- Values are between 0 and 1.

Typically, these are generated using the `minfi` package from IDAT files.

### 3. Run Deconvolution
The primary function is `HiBED_deconvolution`. It requires the beta value matrix and a parameter `h` which specifies the hierarchical level or specific library configuration.

```r
# Example using a beta value matrix 'Examples_Betas'
# h=2 is the standard setting for the 7-cell type deconvolution
HiBED_result <- HiBED_deconvolution(Examples_Betas, h = 2)

# View the estimated proportions
head(HiBED_result)
```

## Key Functions and Parameters

### HiBED_deconvolution(betas, h = 2)
- **betas**: A matrix or data frame of beta values.
- **h**: An integer specifying the deconvolution model. The package uses a hierarchical approach to separate neurons from non-neurons and then further sub-divide those categories.
- **Returns**: A data frame where rows are samples and columns are the 7 estimated cell type proportions:
    - `GABA`: GABAergic neurons
    - `GLU`: Glutamatergic neurons
    - `Astrocyte`: Astrocytes
    - `Microglial`: Microglial cells
    - `Oligodendrocyte`: Oligodendrocytes
    - `Endothelial`: Endothelial cells
    - `Stromal`: Stromal cells

## Usage Tips
- **Probe Matching**: The function automatically handles the intersection of probes between your dataset and the reference libraries. However, ensure your data is properly normalized (e.g., using `preprocessQuantile` or `preprocessNoob` in `minfi`) before deconvolution.
- **Array Compatibility**: HiBED is compatible with both 450K and EPIC (850K) array data.
- **Missing Values**: Ensure your beta matrix does not contain excessive `NA` values in the required reference probe positions, as this can lead to `NaN` results in the output.

## Reference documentation
- [HiBED Vignette (Rmd)](./references/HiBED.Rmd)
- [HiBED Vignette (Markdown)](./references/HiBED.md)