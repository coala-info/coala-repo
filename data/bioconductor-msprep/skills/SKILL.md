---
name: bioconductor-msprep
description: This tool performs pre-analytic processing of mass spectrometry-based metabolomics data. Use when user asks to summarize technical replicates, filter metabolites, impute missing values, or normalize metabolomics data.
homepage: https://bioconductor.org/packages/release/bioc/html/MSPrep.html
---


# bioconductor-msprep

name: bioconductor-msprep
description: Comprehensive pre-analytic processing for mass spectrometry-based metabolomics data. Use when Claude needs to perform summarization of technical replicates, metabolite filtering, missing value imputation, and normalization/batch correction using the MSPrep R package.

# bioconductor-msprep

## Overview

`MSPrep` is a Bioconductor package designed for the pre-analytic processing of mass spectrometry (MS) metabolomics data. It provides a standardized pipeline to handle technical replicates, filter low-quality metabolites, impute missing values, and normalize data to remove batch effects or unwanted variation.

## Data Preparation

MSPrep supports two primary input formats: `SummarizedExperiment` objects and standard `Data Frames`.

### Data Frame Requirements
If using a Data Frame, you must define how the package identifies compounds and samples:
- **compVars**: A character vector of columns identifying unique compounds (e.g., `c("mz", "rt")` or `c("Compound.Name")`).
- **sampleVars**: A character vector identifying sample variables embedded in column names (e.g., `c("batch", "replicate", "subject_id")`).
- **separator**: The character separating variables in column names (e.g., `_`).
- **colExtraText**: Any constant prefix in column names to be ignored (e.g., `Neutral_Pos_`).

### SummarizedExperiment
When using `SummarizedExperiment`, the package automatically uses `assay` for abundances, `rowData` for compound info, and `colData` for sample info.

## Core Workflow

### 1. Summarizing Technical Replicates
Use `msSummarize()` to collapse technical replicates into a single value per sample. It uses the Coefficient of Variation (CV) to decide between mean and median summarization.

```r
summarizedDF <- msSummarize(data,
                            cvMax = 0.50,
                            minPropPresent = 1/3,
                            compVars = c("mz", "rt"),
                            sampleVars = c("batch", "replicate", "subject_id"),
                            separator = "_",
                            missingValue = 1)
```

### 2. Filtering Metabolites
Use `msFilter()` to remove compounds that are not present in a minimum proportion of samples (default is the 80% rule).

```r
filteredDF <- msFilter(summarizedDF,
                       filterPercent = 0.8,
                       compVars = c("mz", "rt"),
                       sampleVars = c("batch", "subject_id"),
                       separator = "_")
```

### 3. Imputation
Use `msImpute()` to handle missing values. Supported methods:
- `half-min`: Half the minimum observed value for that compound.
- `bpca`: Bayesian PCA (requires `nPcs`).
- `knn`: k-Nearest Neighbors (requires `kKnn`).

```r
imputedDF <- msImpute(filteredDF,
                      imputeMethod = "knn",
                      compVars = c("mz", "rt"),
                      sampleVars = c("batch", "subject_id"),
                      separator = "_")
```

### 4. Normalization and Batch Correction
Use `msNormalize()` to transform and normalize data.
- **Methods**: `median`, `quantile`, `ComBat`, `CRMN`, `RUV`, `SVA`.
- **Transformations**: `log10` (default), `log2`, `ln`, or `none`.

```r
normalizedDF <- msNormalize(imputedDF,
                            normalizeMethod = "quantile + ComBat",
                            transform = "log10",
                            batch = "batch",
                            compVars = c("mz", "rt"),
                            sampleVars = c("batch", "subject_id"),
                            separator = "_")
```

## All-in-One Pipeline

The `msPrepare()` function executes the entire pipeline (Summarize -> Filter -> Impute -> Normalize) in a single call.

```r
preparedData <- msPrepare(raw_data,
                          minPropPresent = 1/3,
                          filterPercent = 0.8,
                          imputeMethod = "bpca",
                          normalizeMethod = "median",
                          transform = "log10",
                          compVars = c("mz", "rt"),
                          sampleVars = c("batch", "replicate", "subject_id"),
                          separator = "_")
```

## Tips for Success
- **Missing Values**: Ensure you specify the `missingValue` argument (e.g., `1` or `0`) if your raw data uses a specific placeholder for missingness.
- **Batch Correction**: If using `ComBat`, ensure a "batch" variable is present in your `sampleVars` or `colData`.
- **Return Type**: Use `returnToSE = TRUE` if you want the output to be a `SummarizedExperiment` object regardless of the input type.

## Reference documentation
- [Using MSPrep](./references/using_MSPrep.Rmd)
- [Using MSPrep](./references/using_MSPrep.md)