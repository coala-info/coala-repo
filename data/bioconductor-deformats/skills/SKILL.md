---
name: bioconductor-deformats
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DEFormats.html
---

# bioconductor-deformats

## Overview

The `DEFormats` package provides a unified interface for converting data structures between the two most popular Bioconductor packages for differential expression: `DESeq2` and `edgeR`. It eliminates the need for manual extraction of count matrices and metadata when switching between analysis methods, ensuring that sample information and genomic annotations are preserved during the transition.

## Core Functions

The package uses a standard coercion pattern: `as.<TargetClass>(object)`.

- `as.DESeqDataSet(dge)`: Converts an edgeR `DGEList` to a `DESeqDataSet`.
- `as.DGEList(dds)`: Converts a `DESeqDataSet` to an edgeR `DGEList`.
- `DGEList(se)`: An overloaded constructor that allows creating an edgeR object directly from a `SummarizedExperiment` or `RangedSummarizedExperiment`.
- `simulateRnaSeqData()`: A utility to generate mock RNA-seq data for testing workflows.

## Typical Workflows

### 1. Converting edgeR to DESeq2
When you have an existing `DGEList` and want to use `DESeq2` features (like `vst` or `results` shrinkage):

```r
library(DEFormats)
library(DESeq2)

# Assuming 'dge' is your DGEList
dds <- as.DESeqDataSet(dge)

# Note: You may need to set or update the design formula
design(dds) <- ~ condition
```

### 2. Converting DESeq2 to edgeR
When you have a `DESeqDataSet` and want to use `edgeR` features (like `exactTest` or `glmQLFit`):

```r
library(DEFormats)
library(edgeR)

# Assuming 'dds' is your DESeqDataSet
dge <- as.DGEList(dds)

# The 'group' in DGEList is automatically populated from the 
# first factor in the DESeqDataSet design formula.
```

### 3. SummarizedExperiment to edgeR
`edgeR` does not natively support `SummarizedExperiment` as an input to the `DGEList` constructor; `DEFormats` adds this capability:

```r
library(DEFormats)
library(edgeR)

# Ensure colData has a 'group' column for edgeR defaults
names(colData(se))[1] <- "group" 

dge <- DGEList(se)
```

## Tips and Best Practices

- **Metadata Preservation**: When converting from `DESeqDataSet` to `DGEList`, if the input is a `RangedSummarizedExperiment`, the genomic coordinates (rowRanges) are preserved in the `$genes` slot of the `DGEList`.
- **Identity Checks**: While `as.DGEList(as.DESeqDataSet(dge))` will return an object identical to the original, `identical(dds1, dds2)` for `DESeqDataSet` objects often returns `FALSE` due to internal environment/reference class handling, even if the data is the same.
- **Indirect Conversions**: To convert a `DGEList` to a `RangedSummarizedExperiment`, go through `DESeqDataSet` first:
  ```r
  rse <- as(as.DESeqDataSet(dge), "RangedSummarizedExperiment")
  ```
- **Column Naming**: `edgeR` looks for a column named `group` in sample metadata. If your `SummarizedExperiment` uses `condition`, rename the column or pass the `group` argument explicitly to the `DGEList()` constructor.

## Reference documentation

- [Differential gene expression data formats converter](./references/DEFormats.Rmd)
- [Differential gene expression data formats converter](./references/DEFormats.md)