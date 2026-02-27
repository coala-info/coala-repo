---
name: bioconductor-ruvnormalizedata
description: This package provides a curated gene expression dataset and negative control genes for benchmarking normalization methods like RUV-2 and RUV-4. Use when user asks to load the gender study benchmark dataset, access housekeeping genes for normalization, or evaluate the performance of RUV-based methods.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RUVnormalizeData.html
---


# bioconductor-ruvnormalizedata

## Overview

The `RUVnormalizeData` package provides a curated `ExpressionSet` containing gene expression data from a gender study. This dataset is a primary benchmark for normalization methods like RUV-2 and RUV-4 because it contains known sources of unwanted variation:
- **Technical factors:** Two microarray platforms (HGU-95A and HGU-95Av2) and three different laboratories.
- **Biological factors:** Three distinct brain regions (anterior cingulate cortex, dorsolateral prefrontal cortex, and cerebellar hemisphere).
- **Factor of interest:** Gender (Male vs. Female).

The package also includes a set of 799 housekeeping genes used as negative control probes.

## Loading the Data

To use the dataset, load the package and the `gender` object:

```r
library(RUVnormalizeData)
data(gender)
```

## Data Structure

The `gender` object is an `ExpressionSet`. You can explore its components using standard Biobase methods:

### Expression Matrix
Contains log-transformed RMA-processed intensities for 12,600 genes across 84 samples.
```r
exprs_data <- exprs(gender)
```

### Phenotype Data (Sample Metadata)
The `pData` contains information about gender, labs, and brain regions:
- `gender`: 'F' or 'M'.
- `UC Davis`, `UC Irvine`, `U. Michigan`: Binary indicators for the laboratory.
- `Anterior Cingulate`, `Cerebellum`, `Dorsolateral Prefrontal`: Binary indicators for brain region.

```r
sample_info <- pData(gender)
head(sample_info)
```

### Feature Data (Negative Controls)
The `fData` contains a logical vector identifying negative control probesets (housekeeping genes). These are essential for RUV-based normalization.

```r
# Identify negative control indices
is_control <- fData(gender)$control
control_indices <- which(is_control)
```

## Typical Workflow

This data is typically used as input for the `RUVnormalize` package to test normalization performance.

1. **Prepare Inputs:** Extract the expression matrix and the negative control indices.
2. **Define Variation:** Use the phenotype data to identify batch effects (e.g., Lab or Platform) to see if normalization successfully removes them while preserving the gender signal.
3. **Benchmark:** Compare the ranking of X and Y chromosome genes before and after RUV normalization to assess improvement in differential expression analysis.

## Reference documentation

- [RUVnormalizeData](./references/RUVnormalizeData.md)