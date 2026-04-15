---
name: bioconductor-wavetilingdata
description: This package provides experimental datasets and pre-computed wavelet-based functional model results for Arabidopsis thaliana tiling array studies. Use when user asks to load example tiling array data, access leaf development transcriptome datasets, or retrieve pre-processed WfmFit and WfmInf objects for testing waveTiling workflows.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/waveTilingData.html
---

# bioconductor-wavetilingdata

name: bioconductor-wavetilingdata
description: Access and use the waveTilingData experiment data package. Use this skill when you need to load example datasets, tiling array objects, or pre-computed wavelet-based functional model (WFM) results for Arabidopsis thaliana leaf development studies. This is essential for demonstrating or testing the waveTiling package workflows.

# bioconductor-wavetilingdata

## Overview
The `waveTilingData` package provides experimental and annotation data files specifically designed for use with the `waveTiling` package. It contains transcriptome analysis data from a study on *Arabidopsis thaliana* leaf development, covering six time points (day 8 to day 13) with three biological replicates each. The data includes raw `TilingFeatureSet` objects, normalized data, and processed objects representing model fits and inference results.

## Loading the Data
To use the datasets, first load the library and then use the `data()` function to bring specific objects into the R environment.

```r
library(waveTilingData)

# List available data files in the package
data(package = "waveTilingData")
```

## Available Datasets and Objects
The package contains several key objects representing different stages of a tiling array analysis pipeline:

### Raw and Normalized Data
- `leafdev`: A `TilingFeatureSet` object containing raw data for 18 samples (6 time points x 3 replicates).
- `leafdevBQ`: A `TilingFeatureSet` object containing background-corrected and quantile-normalized expression data.

### Pre-processed and Model Objects
- `leafdevMapAndFilterTAIR9`: A `mapFilterProbe` object. Use this to see how probes were remapped to the TAIR9 genome and filtered for redundancy.
- `leafdevFit`: A `WfmFit` object. This contains the results of fitting the wavelet-based functional model to the forward strand of chromosome 1.
- `leafdevInfCompare`: A `WfmInf` object. This contains transcriptome analysis and pairwise comparisons between time points for the forward strand of chromosome 1.

## Typical Workflow Example
This package is primarily used to provide inputs for `waveTiling` functions without needing to run computationally expensive preprocessing.

```r
library(waveTilingData)
library(waveTiling)

# Load pre-computed fit and inference objects
data(leafdevFit)
data(leafdevInfCompare)

# Inspect the fit object
show(leafdevFit)

# Access inference results for specific genomic regions
# (Requires waveTiling package methods)
```

## Accessing Raw Files
If you need to access the underlying data files directly (e.g., to check directory structure):

```r
dataDir <- system.file("data", package="waveTilingData")
list.files(dataDir)
```

## Reference documentation
- [waveTilingData Reference Manual](./references/reference_manual.md)