---
name: bioconductor-flowsorted.cordblood.450k
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FlowSorted.CordBlood.450k.html
---

# bioconductor-flowsorted.cordblood.450k

name: bioconductor-flowsorted.cordblood.450k
description: Data package for Illumina HumanMethylation450 (450k) cord blood cell type reference data. Use this skill when performing cell-type deconvolution or composition analysis on umbilical cord blood DNA methylation data, specifically when using the minfi::estimateCellCounts function or analyzing cell-specific methylation patterns in B cells, CD4T, CD8T, Gran, Mono, NK, and nRBC.

# bioconductor-flowsorted.cordblood.450k

## Overview

The `FlowSorted.CordBlood.450k` package provides a reference dataset of DNA methylation profiles (450k array) for sorted cell types from umbilical cord blood. It includes data for seven cell populations: B cells, CD4+ T cells, CD8+ T cells, granulocytes, monocytes, natural killer (NK) cells, and nucleated red blood cells (nRBCs). Its primary application is providing the reference basis for estimating cell type proportions in mixed cord blood samples using the `minfi` package.

## Key Workflows

### 1. Estimating Cell Counts in Cord Blood
The most common use case is passing this reference to `minfi::estimateCellCounts`. You do not usually call functions from this package directly for deconvolution; instead, you specify it as the `compositeCellType`.

```r
library(minfi)
library(FlowSorted.CordBlood.450k)

# Assuming 'rgSet' is your RGChannelSet of cord blood samples
cell_counts <- estimateCellCounts(rgSet, 
                                  compositeCellType = "CordBlood",
                                  processMethod = "preprocessQuantile")
```

### 2. Accessing Reference Data
You can load the raw `RGChannelSet` to inspect the reference methylation levels or use it for custom analysis.

```r
library(FlowSorted.CordBlood.450k)

# Load the RGChannelSet
data(FlowSorted.CordBlood.450k)
# The object is named FlowSorted.CordBlood.450k
```

### 3. Analyzing Cell-Specific Probes
The package provides pre-calculated tables for probes that differentiate cord blood cell types.

- **F-statistics**: To check if a specific CpG is associated with cell type.
- **Selected Probes**: The 700 probes (100 per cell type) used for differentiation.

```r
# Load F-statistics table
data(FlowSorted.CordBlood.450k.compTable)

# Load the 700 markers
data(FlowSorted.CordBlood.450k.ModelPars)
```

## Usage Tips
- **Nucleated Red Blood Cells (nRBCs)**: Unlike adult blood references (like `FlowSorted.Blood.450k`), this cord blood reference includes nRBCs, which are prevalent in cord blood and can significantly bias methylation results if not accounted for.
- **Compatibility**: This package is designed for 450k data. If working with EPIC (850k) data, ensure you are using the appropriate `minfi` mapping or the `FlowSorted.CordBlood.EPIC` package if available.
- **Memory**: Loading the full `RGChannelSet` can be memory-intensive. Only load it if you need to perform custom probe selection or validation.

## Reference documentation
- [FlowSorted.CordBlood.450k User's Guide](./references/FlowSorted.CordBlood.450k.md)