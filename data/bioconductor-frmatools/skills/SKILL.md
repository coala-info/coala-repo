---
name: bioconductor-frmatools
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/frmaTools.html
---

# bioconductor-frmatools

name: bioconductor-frmatools
description: Advanced tools for the frma (Frozen Robust Multiarray Analysis) R package. Use this skill to create custom frozen vectors for microarray preprocessing or to convert AffyBatch objects between compatible platforms (e.g., converting hgu133atag to hgu133a).

# bioconductor-frmatools

## Overview

The `frmaTools` package provides advanced functionality for users of the `frma` (Frozen Robust Multiarray Analysis) algorithm. While `frma` typically relies on pre-computed vectors from public databases, `frmaTools` allows users to create their own custom frozen vectors from private or specialized datasets. Additionally, it provides utilities for platform conversion when one microarray chip's probe set is a subset of another.

## Workflow: Creating Custom Frozen Vectors

To use `frma` with a custom dataset or a platform not supported by existing Bioconductor annotation packages, you must generate a set of reference vectors (normalization, probe effects, and variances).

### 1. Prepare Data
Ensure all CEL files are in the working directory and represent a biologically diverse set of samples across multiple batches.

```r
library(frmaTools)
# List all CEL files in the directory
files <- list.files(pattern = "\\.CEL$", ignore.case = TRUE)
```

### 2. Define Batches
You must provide a `batch.id` vector. For the algorithm to work correctly, there should ideally be an equal number of arrays in each batch.

```r
# Example: 10 arrays, 2 batches of 5
batch.id <- rep(1:2, each = 5)
```

### 3. Generate Vectors
Use `makeVectorsAffyBatch` to compute the required statistics.

```r
vectors <- makeVectorsAffyBatch(files, batch.id)
```

The resulting list contains:
- `normVec`: Normalization reference vector.
- `probeVec`: Probe effect vector.
- `probeVarWithin`: Within-batch probe variance.
- `probeVarBetween`: Between-batch probe variance.
- `probesetSD`: Within-probeset standard deviation.
- `medianSE`: Median standard error of gene expression estimates.

## Workflow: Platform Conversion

This is used when probes on one platform (e.g., hgu133a) are a subset of probes on another (e.g., hgu133atag).

### 1. Load Data
Load the `AffyBatch` object representing the larger platform.

```r
library(frmaTools)
# Example using package data
library(frmaExampleData)
data("AffyBatch133atag")
```

### 2. Convert Platform
Specify the target platform name as the second argument.

```r
# Convert hgu133atag data to hgu133a
converted_object <- convertPlatform(AffyBatch133atag, "hgu133a")
```

## Tips and Best Practices
- **Diversity Matters**: When creating custom vectors, ensure the input samples are biologically diverse to capture a representative range of probe behavior.
- **Batch Balance**: The `makeVectorsAffyBatch` function performs best when batches are balanced in size.
- **Subset Requirement**: `convertPlatform` only works if the target platform is a strict subset of the source platform. It functions by discarding probes present in the source but missing in the target.

## Reference documentation
- [Tools for Advanced Use of the frma Package](./references/frmaTools.md)