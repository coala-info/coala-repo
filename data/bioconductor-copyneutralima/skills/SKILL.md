---
name: bioconductor-copyneutralima
description: This package provides reference sets of copy-neutral healthy control samples for DNA methylation-based copy-number variation analysis using Illumina 450k or EPIC arrays. Use when user asks to retrieve baseline reference data for CNV profiling, obtain control samples for packages like conumee or ChAMP, or access standardized healthy methylation datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CopyNeutralIMA.html
---


# bioconductor-copyneutralima

name: bioconductor-copyneutralima
description: Provides reference samples for copy-number variation (CNV) analysis using Illumina Infinium 450k or EPIC DNA methylation arrays. Use this skill when performing genomic copy number profiling with packages like conumee or ChAMP and requiring a set of copy-neutral (healthy) samples as a baseline reference.

## Overview

CopyNeutralIMA is a Bioconductor data experiment package that provides a collection of healthy control samples for DNA methylation-based copy number analysis. It addresses the gap left by deprecated packages (like CopyNumber450kData) and provides the first standardized reference set for the EPIC (850k) array platform.

The package contains:
- 51 Illumina HumanMethylation450k samples.
- 13 Illumina HumanMethylationEPIC samples.
- Samples sourced from healthy individuals across multiple GEO studies (e.g., GSE49618, GSE86831).

## Core Workflow

The primary use case is retrieving an `RGChannelSet` of normal samples to use as a reference against tumor or test samples.

### 1. Retrieve Reference Data
Use the `getCopyNeutralRGSet` function, specifying the array type.

```r
library(CopyNeutralIMA)

# For 450k arrays
rgSet450k <- getCopyNeutralRGSet("450k")

# For EPIC arrays
rgSetEPIC <- getCopyNeutralRGSet("EPIC")
```

### 2. Integration with conumee
The most common workflow involves using these samples as the control set for the `conumee` package.

```r
library(minfi)
library(conumee)
library(CopyNeutralIMA)

# 1. Prepare your query data (e.g., from minfi)
# MsetEx is your preprocessed MethylSet of interest

# 2. Get and preprocess the reference data
array_type <- annotation(MsetEx)[['array']] # e.g., "IlluminaHumanMethylation450k"
ima_type <- ifelse(grepl("450k", array_type), "450k", "EPIC")

RGsetCtrl <- getCopyNeutralRGSet(ima_type)
MsetCtrl <- preprocessIllumina(RGsetCtrl) # Match the preprocessing of your samples

# 3. Perform CNV analysis
control.data <- CNV.load(MsetCtrl)
query.data <- CNV.load(MsetEx)

# Fit the model using the CopyNeutralIMA reference
# 'anno' is a CNV.anno object created via CNV.create_anno()
cnv_fit <- CNV.fit(query.data["Sample_Name"], control.data, anno)
```

## Key Functions and Parameters

- `getCopyNeutralRGSet(array_type)`:
    - `array_type`: A character string, either `"450k"` or `"EPIC"`.
    - Returns: An `RGChannelSet` object containing the raw intensity data for the selected reference samples.

## Tips for Success

- **Matching Preprocessing**: Always ensure that the reference samples from `CopyNeutralIMA` are preprocessed (e.g., `preprocessIllumina`, `preprocessFunctional`) using the exact same method and parameters as your test/query samples to avoid batch effects or normalization artifacts.
- **Array Compatibility**: Ensure the `array_type` passed to `getCopyNeutralRGSet` matches the platform used for your samples. The package will automatically handle the internal mapping to the correct GEO datasets.
- **Memory Management**: `RGChannelSet` objects can be large. If working with many samples, ensure your R environment has sufficient memory or use subsetting.

## Reference documentation

- [CopyNeutralIMA](./references/CopyNeutralIMA.md)