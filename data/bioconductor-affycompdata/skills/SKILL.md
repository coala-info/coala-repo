---
name: bioconductor-affycompdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/affycompData.html
---

# bioconductor-affycompdata

name: bioconductor-affycompdata
description: Access and use pre-calculated assessment data for Affymetrix expression measures. Use this skill when evaluating or comparing microarray normalization and summarization methods (like RMA, MAS 5.0, or dChip) using the benchmarks defined in the affycomp package.

## Overview

The `affycompData` package is a data-only experiment package for Bioconductor. It provides the necessary datasets to run the benchmarking and comparison tools found in the `affycomp` package. These datasets consist of pre-processed results from the Dilution and Spike-in (HGU95 and HGU133) datasets, which have been evaluated using various assessment functions.

## Loading Data

To use the datasets, you must load the library and use the `data()` function.

```r
library(affycompData)

# Load specific assessment results
data(rma.assessment)      # RMA results for Dilution and HGU95
data(mas5.assessment)     # MAS 5.0 results for Dilution and HGU95
data(lw.sd.assessment)    # dChip (Li-Wong) SD assessment
data(rma.sd.assessment)   # RMA SD assessment
```

## Available Datasets

The package contains several lists of assessment results categorized by the method used and the chip type:

### RMA (Robust Multi-array Average) Assessments
- `rma.assessment`: Results from `assessAll` on Dilution and HGU95.
- `rma.assessment.133`: Results from `assessSpikeIn` on HGU133.
- `rma.assessment2`: Results from `assessSpikeIn2` on HGU95.
- `rma.assessment2.133`: Results from `assessSpikeIn2` on HGU133.
- `rma.sd.assessment`: Results from `assessSD` on Dilution files.

### MAS 5.0 Assessments
- `mas5.assessment`: Results from `assessAll` on Dilution and HGU95.
- `mas5.assessment.133`: Results from `assessSpikeIn` on HGU133.
- `mas5.assessment2`: Results from `assessSpikeIn2` on HGU95.
- `mas5.assessment2.133`: Results from `assessSpikeIn2` on HGU133.

### dChip (Li-Wong) Assessments
- `lw.sd.assessment`: Results from `assessSD` on Dilution files processed with dChip (PM-only).

## Typical Workflow

These datasets are intended to be passed to plotting and comparison functions in the `affycomp` package to visualize how a new method performs against established standards.

```r
library(affycomp)
library(affycompData)

# Load RMA and MAS5 assessments for comparison
data(rma.assessment)
data(mas5.assessment)

# Example: Compare methods using a MA-plot or standard assessment plot
# (Requires affycomp functions)
affycomp.plot(rma.assessment)
```

## Reference documentation

- [affycompData Reference Manual](./references/reference_manual.md)