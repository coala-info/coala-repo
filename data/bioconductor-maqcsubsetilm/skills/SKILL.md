---
name: bioconductor-maqcsubsetilm
description: This package provides a subset of the Illumina MicroArray Quality Control dataset containing Human-6 BeadChip data across four reference RNA types. Use when user asks to load MAQC reference datasets, access LumiBatch objects for Illumina quality control, or compare experimental data against gold-standard RNA references.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/MAQCsubsetILM.html
---

# bioconductor-maqcsubsetilm

## Overview

The `MAQCsubsetILM` package provides a subset of the Illumina MicroArray Quality Control (MAQC) dataset. It contains data from Human-6 BeadChip 48K v1.0 arrays across four reference RNA types:
- **refA**: 100% Stratagene’s Universal Human Reference RNA.
- **refB**: 100% Ambion’s Human Brain Reference RNA.
- **refC**: 75% A and 25% B.
- **refD**: 25% A and 75% B.

Each dataset object contains three randomly chosen BeadChips (one from each of the three test sites) for that specific RNA reference. The data is stored as `LumiBatch` objects, compatible with the `lumi` package.

## Loading Reference Data

To use the datasets, load the library and use the `data()` function to bring the specific reference objects into the environment.

```r
library(MAQCsubsetILM)

# Load specific reference datasets
data(refA)
data(refB)
data(refC)
data(refD)

# Inspect the object
print(refA)
```

## Working with the Data

The objects are `LumiBatch` instances. You can interact with them using standard methods from the `Biobase` and `lumi` packages.

### Accessing Expression and Metadata
```r
# Get expression matrix
exp_matrix <- exprs(refA)

# View sample metadata (site, reference type, replicate)
pData(refA)

# View feature/probe information
fData(refA)
```

### Quality Control
Since these are `LumiBatch` objects, you can perform summary quality control checks:
```r
# Get a summary of the QC information
summary(refA, 'QC')

# Basic plotting (if lumi is loaded)
# plot(refA, what='cv')
```

## Typical Workflow: Comparison
A common use case is comparing your own Illumina data against these gold-standard references to evaluate reproducibility or platform performance.

1. Load your experimental data using `lumiR`.
2. Load the corresponding `MAQCsubsetILM` reference (e.g., `refA`).
3. Combine or compare the expression profiles to check for site-specific or batch-specific deviations.

## Reference documentation

- [MAQCsubsetILM](./references/MAQCsubsetILM.md)