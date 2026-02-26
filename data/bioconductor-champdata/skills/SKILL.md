---
name: bioconductor-champdata
description: This package provides essential datasets, probe annotations, and reference controls for the Chip Analysis Methylation Pipeline (ChAMP). Use when user asks to load methylation test datasets, access Illumina 450k or EPIC array annotations, perform CNA analysis with blood controls, or retrieve cell-type reference data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ChAMPdata.html
---


# bioconductor-champdata

name: bioconductor-champdata
description: Provides datasets needed for the ChAMP (Chip Analysis Methylation Pipeline) R package, including test datasets, blood controls for CNA analysis, and probe annotations for 450k and EPIC arrays. Use when needing example methylation data or specific annotation objects for ChAMP workflows.

# bioconductor-champdata

## Overview

ChAMPdata is a specialized data package that supports the Chip Analysis Methylation Pipeline (ChAMP). It provides the necessary infrastructure for methylation analysis, including probe annotations for Illumina 450k and EPIC arrays, reference blood controls for Copy Number Alteration (CNA) analysis, and pre-loaded datasets for testing pipeline functions.

## Loading Data

Most datasets in this package are used internally by ChAMP functions, but they can be loaded manually for inspection or custom analysis using the `data()` function.

```R
library(ChAMPdata)

# Load 450k probe annotations
data(probe.features)

# Load EPIC probe annotations
data(probe.features.epic)

# Load BMIQ normalization reference data
data(probeInfoALL.lv)
```

## Common Datasets and Workflows

### Testing the ChAMP Pipeline
The `testDataSet` and `EPICSimData` objects allow users to run the full ChAMP pipeline without providing their own IDAT files.

```R
# Load 450k test data
data(testDataSet)
# Access components: testDataSet$mset, testDataSet$rgSet, testDataSet$pd, testDataSet$beta

# Load EPIC simulation data
data(EPICSimData)
# Access components: EPICSimData$beta, EPICSimData$pd, EPICSimData$detP
```

### Copy Number Alteration (CNA) Analysis
The `bloodCtl` dataset provides the required reference controls for the `champ.CNA()` function when analyzing blood samples.

```R
data(bloodCtl)
# This object is typically passed to the control parameter in ChAMP CNA functions
```

### Cell Type Deconvolution
For cell-type correction (RefBaseEWAS), the package provides purified cell-type methylation means.

```R
# For 450k arrays
data(CellTypeMeans450K)

# For older 27k arrays
data(CellTypeMeans27K)
```

### SNP and Multi-hit Filtering
Datasets are provided to identify probes that may be unreliable due to SNPs or multi-hit sequences.

```R
# SNP information for 450k
data(hm450.manifest.hg19)

# SNP information for EPIC
data(EPIC.manifest.hg19)

# Probes known to have multi-hit issues
data(multi.hit)
```

## Data Structures

- **Manifests**: Data frames containing genomic coordinates (hg19), probe sequences, and masking flags (e.g., `EPIC.manifest.pop.hg19`).
- **GRanges**: S4 objects for genomic interval operations (e.g., `illumina450Gr`, `illuminaEPICGr`).
- **Pathway Lists**: Used for Gene Set Enrichment Analysis (GSEA) in `champ.GSEA()` (e.g., `PathwayList`).

## Reference documentation

- [ChAMPdata Reference Manual](./references/reference_manual.md)