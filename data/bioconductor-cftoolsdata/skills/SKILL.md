---
name: bioconductor-cftoolsdata
description: This package provides pre-trained deep learning models and methylation marker parameters for liquid biopsy and cell-free DNA analysis. Use when user asks to perform cell-free DNA deconvolution, detect cancer from methylation markers, or access fragment-based sorting models.
homepage: https://bioconductor.org/packages/release/data/experiment/html/cfToolsData.html
---


# bioconductor-cftoolsdata

name: bioconductor-cftoolsdata
description: Access pre-trained deep learning models and methylation marker parameters for liquid biopsy analysis. Use when working with the cfTools package to perform cell-free DNA (cfDNA) deconvolution, cancer detection, or fragment-based sorting.

## Overview

The `cfToolsData` package is an ExperimentHub-based data package that provides essential resources for the `cfTools` R package. It contains pre-trained Deep Neural Network (DNN) models and beta distribution shape parameters for methylation markers across various human tissues and cancer types. These resources are required for functions like `cfSort()`, `CancerDetector()`, and `cfDeconvolve()`.

## Installation and Loading

To use these data resources, ensure both `cfToolsData` and `ExperimentHub` are installed.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("cfToolsData")
library(cfToolsData)
```

## Accessing DNN Models for cfSort

The package provides two pre-trained DNN models used by the `cfSort` function in the `cfTools` package for fragment-based cell-free DNA deconvolution.

```r
# Load DNN models
model1_path <- DNN1()
model2_path <- DNN2()

# These functions return the local file path to the cached model
print(model1_path)
```

## Accessing Cancer Methylation Parameters

For the `CancerDetector` function, `cfToolsData` provides shape parameters of beta distributions characterizing methylation markers for specific cancer types (hg19 coordinates).

```r
# Available cancer types: COAD (Colon), LIHC (Liver), LUNG (Lung), STAD (Stomach)
coad_params <- COAD.tumorMarkerParams.hg19()
lihc_params <- LIHC.tumorMarkerParams.hg19()
lung_params <- LUNG.tumorMarkerParams.hg19()
stad_params <- STAD.tumorMarkerParams.hg19()

# Example: Combine into a named list for processing
tumor_params <- c(coad_params, lihc_params, lung_params, stad_params)
```

## Accessing Tissue-Specific Markers

For general cfDNA deconvolution using `cfDeconvolve`, the package provides parameters for 29 primary human tissue types and their corresponding annotations.

```r
# Get beta distribution parameters for 29 tissues
tissue_params <- tissue_markerParams.hg19()

# Get annotations for these markers
tissue_annot <- tissue_markerParams.annot()
```

## Usage Tips

- **Caching**: The first time you call these functions, the data is downloaded from ExperimentHub and cached locally. Subsequent calls will load the data from your local cache.
- **Integration**: These functions are designed to be passed as arguments to `cfTools` functions. Instead of manually loading the data, you often pass the result of these functions (the file paths) directly into the `cfTools` pipeline.
- **Genome Build**: Currently, the methylation parameters provided are specifically for the **hg19** genome assembly.

## Reference documentation

- [cfToolsData Vignette (Rmd)](./references/cfToolsData.Rmd)
- [cfToolsData Documentation (md)](./references/cfToolsData.md)