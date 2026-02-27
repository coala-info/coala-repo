---
name: bioconductor-mosaicsexample
description: This package provides example ChIP-seq datasets and genomic covariates for the MOSAiCS and MOSAiCS-HMM statistical frameworks. Use when user asks to load sample ChIP-seq data, test MOSAiCS workflows, or demonstrate transcription factor binding and histone modification analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/mosaicsExample.html
---


# bioconductor-mosaicsexample

name: bioconductor-mosaicsexample
description: Provides access to example ChIP-seq datasets for the MOSAiCS and MOSAiCS-HMM statistical frameworks. Use this skill when a user needs sample data to demonstrate transcription factor binding (STAT1) or histone modification (H3K4me3) analysis, or when testing workflows for the 'mosaics' R package.

## Overview

The `mosaicsExample` package is a data-only experiment data package for Bioconductor. It provides pre-processed bin-level data (BinData objects) from ChIP-seq experiments (STAT1 and H3K4me3 in MCF7 and HeLa S3 cell lines). These datasets include ChIP and control samples along with genomic covariates like mappability, GC content, and sequence ambiguity scores, specifically formatted for use with the `mosaics` analysis package.

## Loading and Using Example Data

The primary dataset provided is `exampleBinData`, which contains chromosome 21 data from a STAT1 ChIP-seq experiment (HG18).

### Basic Usage

To load the data for use in a `mosaics` workflow:

```R
# Load the example data package
library(mosaicsExample)
library(mosaics)

# Load the specific dataset
data(exampleBinData)

# Inspect the BinData object
exampleBinData
```

### Data Contents

The `exampleBinData` object is of class `BinData` and includes:
- **ChIP**: STAT1 binding data.
- **Control**: Input/Control sample data.
- **Mappability**: Mappability scores for the bins.
- **GC Content**: GC content scores.
- **Sequence Ambiguity**: Scores for genomic sequence ambiguity.

## Typical Workflow Integration

This package is intended to be used as the starting point for testing the `mosaics` pipeline:

1. **Model Fitting**: Use the loaded `exampleBinData` to fit a MOSAiCS model.
   ```R
   # Example: Fitting a two-sample model with covariates
   fit <- mosaicsFit(exampleBinData, analysisType="IO", bgEst="2S")
   ```

2. **Peak Calling**: Identify binding sites based on the fitted model.
   ```R
   peaks <- mosaicsPeak(fit, signalModel="2S", FDR=0.05)
   ```

## Tips

- **Genome Versions**: Note that `exampleBinData` uses HG18 coordinates. Other data in the package (STAT1/H3K4me3 in MCF7) uses HG19. Ensure your analysis parameters match the genome build of the example data.
- **Package Dependency**: While `mosaicsExample` contains the data, you must have the `mosaics` package loaded to manipulate or analyze the `BinData` objects.

## Reference documentation

- [mosaicsExample Reference Manual](./references/reference_manual.md)