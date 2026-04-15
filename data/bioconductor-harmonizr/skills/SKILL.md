---
name: bioconductor-harmonizr
description: HarmonizR performs batch effect correction on biological datasets containing missing values using ComBat or limma algorithms. Use when user asks to harmonize datasets from different batches, correct batch effects in proteomics or genomics data with NAs, or apply batch adjustment to data without prior imputation.
homepage: https://bioconductor.org/packages/release/bioc/html/HarmonizR.html
---

# bioconductor-harmonizr

name: bioconductor-harmonizr
description: Batch effect correction for biological data (proteomics, genomics) with missing values using ComBat or limma. Use this skill when you need to harmonize datasets from different batches, especially when the data contains NAs or missing observations that standard algorithms cannot handle directly.

# bioconductor-harmonizr

## Overview

HarmonizR is an R package designed to perform batch effect reduction on biological datasets that contain missing values. While popular algorithms like `ComBat` and `limma` typically require complete matrices, HarmonizR uses a matrix dissection approach to apply these adjustments to data with gaps (common in proteomics). It supports both `data.frame` and `SummarizedExperiment` objects.

## Core Workflow

### 1. Data Preparation

HarmonizR requires two main inputs:
- **Expression Data**: A matrix or data frame where rows are features (e.g., proteins/genes) and columns are samples.
- **Description/Metadata**: A data frame mapping samples to their respective batches.

```r
library(HarmonizR)

# Example: data.frame input
# df: rows=features, cols=samples
# des: ID (sample names), batch (batch identifiers)
result <- harmonizR(data_as_input = df, 
                    description_as_input = des, 
                    algorithm = "ComBat", 
                    output_file = FALSE)
```

### 2. Using SummarizedExperiment

If using a `SummarizedExperiment`, the batch information should be present in the `colData`.

```r
# Assuming 'Batch' column exists in colData(se)
result_se <- harmonizR(data_as_input = se, 
                       algorithm = "ComBat")
```

## Function Parameters

The `harmonizR()` function is the primary interface. Key arguments include:

- `algorithm`: `"ComBat"` (default) or `"limma"`.
- `ComBat_mode`: Integers 1-4 to toggle `par.prior` and `mean.only` settings.
  - `1`: Parametric priors, adjust mean and variance (Default).
  - `2`: Parametric priors, adjust mean only.
  - `3`: Non-parametric, adjust mean and variance.
  - `4`: Non-parametric, adjust mean only.
- `plot`: Set to `"samplemeans"`, `"featuremeans"`, or `"CV"` to generate QC plots comparing pre- and post-adjustment data.
- `block`: Integer. Groups batches together during dissection to speed up processing.
- `cores`: Number of CPU cores for parallel processing (defaults to all available).
- `ur` (Unique Removal): Toggles removal of unique combinations to increase feature rescue (Default: `TRUE`).

## Implementation Tips

- **Log Transformation**: HarmonizR assumes data is log-transformed. If plotting is enabled, non-log-transformed data may cause errors or uninterpretable results.
- **Missing Values**: You do not need to impute missing values before using HarmonizR; the algorithm is specifically designed to handle them via matrix dissection.
- **Performance**: For large datasets with many batches, use the `block` parameter and ensure `cores` is set appropriately for your environment to reduce runtime.
- **Sorting**: Use the `sort` parameter (`"sparcity_sort"`, `"seriation_sort"`, or `"jaccard_sort"`) in conjunction with `block` to optimize how data is partitioned for adjustment.

## Reference documentation

- [HarmonizR Vignette](./references/HarmonizR_Vignette.md)