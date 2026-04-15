---
name: bioconductor-variantexperiment
description: This tool manages large-scale genomic variant data by providing a memory-efficient RangedSummarizedExperiment container with a GDS backend. Use when user asks to convert VCF or GDS files into VariantExperiment objects, perform on-disk data manipulation, subset high-throughput variant data, or synchronize genomic datasets for downstream analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/VariantExperiment.html
---

# bioconductor-variantexperiment

name: bioconductor-variantexperiment
description: Use this skill when working with the Bioconductor package VariantExperiment to manage large-scale genomic variant data (VCF/GDS) using RangedSummarizedExperiment containers with a GDS backend. This skill is ideal for memory-efficient on-disk data manipulation, subsetting, and conversion of high-throughput variant data.

# bioconductor-variantexperiment

## Overview

The `VariantExperiment` package provides a light-weight container for high-throughput variant data (DNA-seq, genotyping, etc.) by extending the `RangedSummarizedExperiment` class. It utilizes a GDS (Genomic Data Structure) backend via `GDSArray` and `DelayedDataFrame` to enable on-disk data storage and processing. This allows users to work with massive datasets that exceed available RAM by performing lazy operations and only loading data into memory when explicitly requested.

## Core Workflows

### 1. Data Import and Conversion

Convert VCF or GDS files into `VariantExperiment` objects.

```r
library(VariantExperiment)

# From VCF
vcf_path <- SeqArray::seqExampleFileName("vcf")
ve_vcf <- makeVariantExperimentFromVCF(vcf_path, out.dir = tempfile())

# From GDS
gds_path <- SeqArray::seqExampleFileName("gds")
ve_gds <- makeVariantExperimentFromGDS(gds_path)

# Check available nodes before conversion
showAvailable(gds_path)
```

### 2. Accessing Data

`VariantExperiment` objects behave like `SummarizedExperiment` objects but store data on-disk.

```r
# Access assays (returns GDSArray/DelayedArray)
assay(ve_gds, 1)

# Access variant annotations (returns DelayedDataFrame)
rowData(ve_gds)
rowRanges(ve_gds)

# Access sample annotations
colData(ve_gds)

# Get the underlying GDS file path
gdsfile(ve_gds)
```

### 3. Subsetting and Filtering

Subsetting is "lazy" and does not immediately read the data into memory.

```r
# 2D Subsetting (variants by samples)
ve_sub <- ve_gds[1:100, 1:10]

# Subsetting by metadata (use as.logical for DelayedDataFrame columns)
ve_filtered <- ve_gds[, as.logical(ve_gds$family == "1328")]

# Range-based subsetting
library(GenomicRanges)
roi <- GRanges("22:1-48958933")
ve_range <- subsetByOverlaps(ve_gds, roi)
```

### 4. Synchronization and Saving

After subsetting or modifying the object, you must synchronize the on-disk representation before performing certain downstream statistical analyses.

```r
# Save/Synchronize to a new directory
save_dir <- tempfile()
ve_final <- saveVariantExperiment(ve_range, dir = save_dir, replace = TRUE)

# Load a previously saved VariantExperiment
ve_loaded <- loadVariantExperiment(dir = save_dir)
```

## Tips for Efficient Usage

- **Lazy Evaluation**: Remember that `rowData` and `colData` are often `DelayedDataFrame` objects. When using them for logical indexing, wrap the column access in `as.logical()` to trigger the necessary data realization.
- **Memory Management**: Use `rowDataOnDisk = TRUE` and `colDataOnDisk = TRUE` (default) in `makeVariantExperimentFromGDS` to keep annotations on disk for very large cohorts.
- **Partial Loading**: Use the `start` and `count` arguments in `makeVariantExperimentFromVCF` to load specific chunks of a VCF if you do not need the entire file.
- **Permutation**: Note that `VariantExperiment` automatically permutes assay dimensions so that the first two dimensions are always [Variants, Samples], ensuring consistency with the `SummarizedExperiment` metaphor.

## Reference documentation

- [VariantExperiment: A RangedSummarizedExperiment Container for Large-Scale Variant Data with GDS Backend](./references/VariantExperiment-class.md)
- [VariantExperiment-class RMarkdown Source](./references/VariantExperiment-class.Rmd)