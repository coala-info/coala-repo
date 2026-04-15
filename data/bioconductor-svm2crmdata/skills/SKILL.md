---
name: bioconductor-svm2crmdata
description: This package provides experimental ChIP-seq data and pre-processed matrices for training Support Vector Machines to identify Cis-Regulatory Modules. Use when user asks to access example chromatin signature data, load training sets for enhancer prediction, or perform tutorial analyses with the SVM2CRM package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SVM2CRMdata.html
---

# bioconductor-svm2crmdata

name: bioconductor-svm2crmdata
description: Access and use the SVM2CRMdata experiment data package, which provides ChIP-seq methylation and acetylation maps from CD4+ T-cells, p300 binding sites, and pre-processed matrices for training Support Vector Machines (SVM) to identify Cis-Regulatory Modules (CRM). Use this skill when needing example data for the SVM2CRM package or when performing tutorial analyses for enhancer prediction.

## Overview

The `SVM2CRMdata` package is a data-only experiment package designed to support the `SVM2CRM` software package. It contains high-resolution chromatin signature data (20 methylation and 17 acetylation maps) from human CD4+ T-cells. The primary purpose of this package is to provide the necessary inputs—positive training sets (p300 binding sites), negative training sets (random genomic regions), and genome-wide signal matrices—to demonstrate the SVM-based enhancer prediction workflow.

## Data Objects and Usage

The package contains three primary types of data objects stored as `.rda` files. These are typically loaded using `data()` or by locating the files within the package directory.

### 1. Genome-wide Signal Matrix
The object `CD4_matrixInputSVMbin100window1000` contains smoothed histone modification signals for Chromosome 1.
- **Bin Size**: 100 bp.
- **Window Size**: 1000 bp (used for smoothing).
- **Structure**: Rows represent genomic coordinates; columns represent specific histone modification signals.

```r
library(SVM2CRMdata)
# Load the pre-processed genome-wide matrix
data("CD4_matrixInputSVMbin100window1000")

# Explore the dimensions (rows = genomic windows, cols = signals)
dim(CD4_matrixInputSVMbin100window1000)
```

### 2. Training Sets (Positive and Negative)
These objects are required to train the SVM model in the `SVM2CRM` package.
- `train_positive`: Signals at known p300 binding sites (putative enhancers).
- `train_negative`: Signals at random genomic regions distant from Transcription Start Sites (TSS).

```r
# Load training datasets
data("train_positive")
data("train_negative")

# View the first few rows of the positive training set
head(train_positive)
```

## Typical Workflow with SVM2CRM

`SVM2CRMdata` provides the "gold standard" and "background" data needed for the following workflow in the main `SVM2CRM` package:

1.  **Model Training**: Use `train_positive` and `train_negative` to train an SVM classifier that recognizes the chromatin signature of an enhancer.
2.  **Prediction**: Apply the trained model to the genome-wide signals found in `CD4_matrixInputSVMbin100window1000`.
3.  **Validation**: Compare predictions against known regulatory elements.

## Data Source and Pre-processing
The data originates from Wang et al. (2008) and was processed using the following `SVM2CRM` functions:
- `cisREfindbed`: Used to create the genome-wide signal matrix from external BED files.
- `getSignal`: Used to extract signals at specific coordinates for the training sets.

## Reference documentation

- [The SVM2CRM data User's Guide](./references/SVM2CRMdata.md)