---
name: bioconductor-flowsorted.blood.epic
description: This package provides a reference dataset and tools for estimating cell-type composition in Illumina HumanMethylationEPIC blood samples. Use when user asks to estimate cell proportions in EPIC DNA methylation data, perform deconvolution using IDOL optimized probes, or access reference datasets for adult blood cell populations.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FlowSorted.Blood.EPIC.html
---

# bioconductor-flowsorted.blood.epic

## Overview

The `FlowSorted.Blood.EPIC` package provides a high-quality reference dataset of immunomagnetic sorted adult blood cell populations (CD4T, CD8T, Bcell, NK, Mono, Neu) specifically designed for the Illumina HumanMethylationEPIC (EPIC) platform. While the older 450k reference is often used, this package is the gold standard for EPIC data to ensure precise cell-type composition estimates in Epigenome-Wide Association Studies (EWAS).

The package introduces `estimateCellCounts2`, a flexible version of the standard `minfi` deconvolution function that supports IDOL (Identifying Optimal Libraries) optimized CpG probes.

## Core Workflows

### 1. Loading the Reference Data
The reference library is stored as an `RGChannelSet` and is retrieved via `ExperimentHub`.

```r
library(FlowSorted.Blood.EPIC)
# Retrieve the RGChannelSet object
FlowSorted.Blood.EPIC <- libraryDataGet('FlowSorted.Blood.EPIC')
```

### 2. Standard Deconvolution (EPIC Blood)
Use `estimateCellCounts2` to estimate cell proportions in your target samples. It is highly recommended to use the `IDOL` probe selection and `preprocessNoob` for normalization.

```r
library(minfi)

# target_RGset is your IlluminaHumanMethylationEPIC RGChannelSet
results <- estimateCellCounts2(target_RGset, 
                               compositeCellType = "Blood",
                               processMethod = "preprocessNoob",
                               probeSelect = "IDOL",
                               cellTypes = c("CD8T", "CD4T", "NK", "Bcell", "Mono", "Neu"))

# Access proportions
proportions <- results$prop
```

### 3. Using IDOL Optimized CpGs
The package includes pre-defined vectors of CpG IDs optimized for different arrays. These are used automatically when `probeSelect = "IDOL"` is set in `estimateCellCounts2`, but can be accessed manually:

*   `IDOLOptimizedCpGs`: For EPIC arrays (450 CpGs).
*   `IDOLOptimizedCpGs450klegacy`: For 450k arrays using the EPIC reference.

```r
data("IDOLOptimizedCpGs")
head(IDOLOptimizedCpGs) # Vector of probe IDs (e.g., "cg08769189")
```

### 4. Advanced Deconvolution (Custom Methods)
If you prefer using methods like RPC (Robust Partial Correlations) or CBS (CIBERSORT) via the `EpiDISH` package, you can use the package's internal comparison table:

```r
# Requires normalized beta values for the IDOL probes
# IDOLOptimizedCpGs.compTable is provided by the package
library(EpiDISH)
out <- epidish(beta_values[IDOLOptimizedCpGs, ], 
               IDOLOptimizedCpGs.compTable, 
               method = "RPC")
proportions <- out$estF
```

## Specialized Deconvolution Tasks

### Umbilical Cord Blood
The package supports cord blood deconvolution when used in conjunction with `FlowSorted.CordBloodCombined.450k`.
*   **compositeCellType**: "CordBloodCombined"
*   **cellTypes**: `c("CD8T", "CD4T", "NK", "Bcell", "Mono", "Gran", "nRBC")`

### Blood Extended (12 Cell Types)
For finer resolution (e.g., Memory vs Naive T-cells, Tregs, Basophils, Eosinophils), use the `BloodExtended` reference.
*   **compositeCellType**: "BloodExtended"
*   **CustomCpGs**: `IDOLOptimizedCpGsBloodExtended`

## Usage Tips
*   **Memory Requirements**: Normalization and deconvolution of large EPIC datasets are memory-intensive. Ensure your R environment has sufficient RAM.
*   **Normalization**: Always use the same normalization method for your target data as the reference. `preprocessNoob` is the recommended default.
*   **Object Types**: `estimateCellCounts2` accepts `RGChannelSet` objects. If you have `MethylSet` objects (e.g., from GEO), only Quantile normalization is supported.

## Reference documentation
- [FlowSorted.Blood.EPIC](./references/FlowSorted.Blood.EPIC.md)