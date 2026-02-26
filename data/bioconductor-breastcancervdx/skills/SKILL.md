---
name: bioconductor-breastcancervdx
description: This package provides access to the breastCancerVDX Bioconductor experiment data containing gene expression and clinical metadata from two major breast cancer studies. Use when user asks to load the vdx ExpressionSet, analyze breast cancer gene expression data, or access clinical metadata for survival analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/breastCancerVDX.html
---


# bioconductor-breastcancervdx

name: bioconductor-breastcancervdx
description: Access and utilize the breastCancerVDX Bioconductor experiment data package. Use this skill when you need to load, analyze, or subset the breast cancer gene expression datasets published by Wang et al. (2005) and Minn et al. (2007). This is specifically for working with the 'vdx' ExpressionSet object containing 344 samples and 22,283 features.

## Overview
The `breastCancerVDX` package provides a standardized `ExpressionSet` (eSet) containing gene expression, annotations, and clinical data from two significant breast cancer studies (Wang et al. and Minn et al.). The data was generated using the Affymetrix HGU133A platform and focuses on lymph-node-negative patients and lung metastasis gene-expression signatures (LMS).

## Loading the Data
To use the dataset, you must load the package and the specific data object:

```r
library(breastCancerVDX)
data(vdx)
```

## Working with the 'vdx' ExpressionSet
The `vdx` object is an `ExpressionSet`. Use standard `Biobase` methods to interact with it:

### 1. Accessing Expression Data
The expression matrix contains normalized values for 22,283 probes.
```r
# Get the expression matrix
exp_matrix <- exprs(vdx)

# View a subset
exp_matrix[1:5, 1:5]
```

### 2. Accessing Clinical Metadata (Phenotype Data)
The `pData` contains patient information, including ER status, metastasis-free survival, and other clinical variables.
```r
# View clinical columns
colnames(pData(vdx))

# Access specific clinical data
clinical_data <- pData(vdx)
head(clinical_data)
```

### 3. Accessing Feature Metadata
The `fData` contains probe annotations for the Affymetrix hgu133a platform.
```r
# View feature annotations
head(fData(vdx))

# Get probe names
featureNames(vdx)[1:20]
```

### 4. Experiment Metadata
To understand the study design and publication details:
```r
# Summary of the experiment
experimentData(vdx)

# Read the study abstract
abstract(vdx)

# Check the platform annotation
annotation(vdx)
```

## Typical Workflow: Survival Analysis
A common use case for this dataset is performing survival analysis based on gene expression or clinical markers (e.g., ER status).

```r
library(survcomp) # Often used with this dataset

# Example: Extracting time to distant metastasis and event status
time <- pData(vdx)$t.dmfs
event <- pData(vdx)$e.dmfs

# Example: Subset for ER positive patients
vdx_er_pos <- vdx[, pData(vdx)$er == 1]
```

## Tips
- **Platform**: The data uses the `hgu133a` chip. If you need to map probes to Gene Symbols, use the `fData(vdx)` or the `hgu133a.db` annotation package.
- **Sample Size**: The dataset contains 344 samples, which is a combination of the Wang (286) and Minn (58) cohorts.
- **Missing Values**: Always check for `NA` values in clinical columns before performing statistical modeling.

## Reference documentation
- [breastCancerVDX Reference Manual](./references/reference_manual.md)