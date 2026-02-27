---
name: bioconductor-lungcanceracvssccgeo
description: This package provides lung cancer microarray data and metadata for distinguishing between Adenocarcinoma and Squamous Cell Carcinoma. Use when user asks to load lung cancer gene expression datasets, access Affymetrix CEL files for outcome prediction, or benchmark diagnostic signatures using the IMPROVER challenge data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/LungCancerACvsSCCGEO.html
---


# bioconductor-lungcanceracvssccgeo

name: bioconductor-lungcanceracvssccgeo
description: Access and use the LungCancerACvsSCCGEO Bioconductor experiment data package. Use this skill when a user needs to load lung cancer microarray datasets (Adenocarcinoma vs. Squamous Cell Carcinoma) for developing or testing outcome prediction models, specifically those related to the IMPROVER Diagnostic Signature Challenge.

# bioconductor-lungcanceracvssccgeo

## Overview
The `LungCancerACvsSCCGEO` package is a specialized data experiment package containing 30 Affymetrix CEL files and associated metadata. It was designed for use with the `maPredictDSC` package to develop and validate diagnostic signatures for distinguishing between Lung Adenocarcinoma (AC) and Squamous Cell Carcinoma (SCC). The data is sourced from multiple GEO datasets (GSE10245, GSE18842, GSE2109, and GSE43580).

## Loading the Data
The package uses a lazy-loading mechanism. To access the primary data objects, use the `data()` function.

```r
# Load the package
library(LungCancerACvsSCCGEO)

# Load the dataset objects
data(LC)
```

## Key Data Objects
Upon calling `data(LC)`, two main objects are loaded into the environment:

1.  **`anoLC`**: A data frame containing the annotation for the samples.
    *   Includes file names of the Affymetrix CEL files.
    *   Includes the phenotype/class labels (AC or SCC) for the training phase.
2.  **`gsLC`**: The "Gold Standard" data.
    *   Contains the true class membership for the test samples appearing in `anoLC`.

## Typical Workflow
This package is primarily used as a benchmark or training set for machine learning workflows in transcriptomics.

1.  **Data Inspection**:
    ```r
    # View the annotation structure
    head(anoLC)
    
    # Check the distribution of AC vs SCC
    table(anoLC$class)
    ```

2.  **Integration with maPredictDSC**:
    The package is intended to be used in conjunction with `maPredictDSC`. You would typically point your CEL file processing pipeline to the file paths indicated in `anoLC` to perform normalization (e.g., RMA) and subsequent prediction modeling.

3.  **Model Validation**:
    Use `gsLC` to evaluate the performance of a classifier trained on the training subset of these samples.

## Reference documentation
- [LungCancerACvsSCCGEO Reference Manual](./references/reference_manual.md)