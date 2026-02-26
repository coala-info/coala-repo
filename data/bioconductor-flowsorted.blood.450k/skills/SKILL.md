---
name: bioconductor-flowsorted.blood.450k
description: This package provides a reference dataset of flow-sorted blood cell types for Illumina 450k methylation arrays. Use when user asks to estimate cellular composition in whole blood samples, access flow-sorted methylation data, or identify cell-specific DNA methylation markers.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FlowSorted.Blood.450k.html
---


# bioconductor-flowsorted.blood.450k

## Overview
The `FlowSorted.Blood.450k` package provides a public dataset of 60 samples from 6 healthy male individuals. Each individual's blood was flow-sorted into constituent cell types. The data is formatted as an `RGChannelSet`, making it compatible with the `minfi` ecosystem for normalization and cellular composition estimation.

## Loading the Data
To access the dataset, load the library and use the `data()` function.

```r
library(FlowSorted.Blood.450k)

# Load the RGChannelSet
data(FlowSorted.Blood.450k)

# View the object
FlowSorted.Blood.450k

# Access phenotype information (cell types and individual IDs)
pData(FlowSorted.Blood.450k)
```

## Typical Workflows

### 1. Cell Type Estimation (with minfi)
The most common use case is providing this dataset as a reference to the `estimateCellCounts` function in the `minfi` package to deconvolve whole blood samples.

```r
library(minfi)

# Assuming 'myRGSet' is your target whole blood 450k data
# This function uses FlowSorted.Blood.450k by default if compositeCellType is "Blood"
cell_counts <- estimateCellCounts(myRGSet, compositeCellType = "Blood", 
                                  processMethod = "preprocessQuantile")
```

### 2. Data Normalization
Since the data is an `RGChannelSet`, you can apply standard `minfi` preprocessing:

```r
# Example: Functional Normalization
Mset.norm <- preprocessFunnorm(FlowSorted.Blood.450k)

# Get Beta values
beta_values <- getBeta(Mset.norm)
```

### 3. Identifying Cell-Specific Markers
You can use this dataset to identify CpGs that are differentially methylated between specific blood cell types (e.g., Granulocytes vs. Lymphocytes).

```r
# Filter for specific cell types in the pData
pd <- pData(FlowSorted.Blood.450k)
keep <- pd$CellType %in% c("CD4T", "CD8T")
subSet <- FlowSorted.Blood.450k[, keep]
```

## Key Considerations
- **Platform:** This data is specific to the Illumina 450k array. While it can be used with EPIC (850k) data by subsetting to overlapping probes, newer reference packages like `FlowSorted.Blood.EPIC` are generally preferred for EPIC arrays.
- **Gender:** The reference samples are derived from 6 male individuals.
- **Cell Types Included:** Bcell, CD4T, CD8T, Gran, Mono, NK, and WholeBlood.

## Reference documentation
- [FlowSorted.Blood.450k User's Guide](./references/FlowSorted.Blood.450k.md)