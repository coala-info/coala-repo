---
name: bioconductor-spikein
description: This tool provides probe-level data from Affymetrix HGU95 and HGU133 spike-in experiments for benchmarking microarray analysis methods. Use when user asks to load spike-in datasets, access probe-level intensities for controlled experiments, or test normalization and expression estimation algorithms against known gene concentrations.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SpikeIn.html
---

# bioconductor-spikein

name: bioconductor-spikein
description: Access and use the Affymetrix Spike-In experiment data (HGU95 and HGU133) for microarray analysis benchmarking. Use this skill when you need to load probe-level intensities (PM and MM) from controlled spike-in experiments to test normalization, expression estimation, or fold-change detection algorithms.

# bioconductor-spikein

## Overview

The `SpikeIn` package provides probe-level data from the classic Affymetrix HGU95 and HGU133 spike-in experiments. These datasets are fundamental for benchmarking microarray preprocessing methods because the concentrations of specific "spike-in" genes are known and systematically varied across different arrays. The data is stored as `AffyBatch` objects, which include both Perfect Match (PM) and Mismatch (MM) intensities, along with phenotypic data describing the concentrations.

## Loading the Data

The package contains two primary datasets. You must load the `affy` library to work with the resulting objects.

```r
library(SpikeIn)
library(affy)

# Load the HGU95 dataset
data(SpikeIn95)

# Load the HGU133 dataset
data(SpikeIn133)
```

## Working with SpikeIn Objects

The datasets are `AffyBatch` objects. You can interact with them using standard methods from the `affy` package.

### Inspecting Concentrations
The known concentrations for the spiked-in genes are stored in the phenotypic data (pData).

```r
# View the concentration matrix
concentrations <- pData(SpikeIn95)
head(concentrations)
```

### Accessing Probe Intensities
To extract the raw probe intensities for analysis:

```r
# Get Perfect Match intensities
pm_intensities <- pm(SpikeIn133)

# Get Mismatch intensities
mm_intensities <- mm(SpikeIn133)

# Get probe names
probes <- probeNames(SpikeIn133)
```

## Typical Workflow: Benchmarking

A common use case is comparing a new normalization or expression calculation method against the known concentrations provided in the metadata.

1. **Preprocess**: Apply a method like RMA or MAS5 to the `AffyBatch` object.
2. **Extract**: Get the estimated expression values for the spike-in probe sets.
3. **Compare**: Correlate the estimated values with the actual concentrations found in `pData(SpikeIn95)` or `pData(SpikeIn133)`.

```r
# Example: Simple RMA processing
library(affy)
eset <- rma(SpikeIn95)
expression_values <- exprs(eset)

# Compare expression_values for spike-in IDs against pData(SpikeIn95)
```

## Reference documentation

- [SpikeIn Reference Manual](./references/reference_manual.md)