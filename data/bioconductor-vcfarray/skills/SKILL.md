---
name: bioconductor-vcfarray
description: This tool represents VCF files as memory-efficient DelayedArray objects for large-scale genomic data analysis in R. Use when user asks to represent VCF files as arrays, extract genotype or info fields without loading full datasets into memory, or access remote VCF data for Bioconductor workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/VCFArray.html
---

# bioconductor-vcfarray

name: bioconductor-vcfarray
description: Use this skill to represent VCF (Variant Call Format) files as DelayedArray objects in R. This is ideal for working with large local or remote VCF files without loading the entire dataset into memory. Use it for extracting fixed fields (REF, ALT), info fields (AF, AA), or genotype fields (GT, DP) into a memory-efficient, array-like structure compatible with Bioconductor's SummarizedExperiment infrastructure.

# bioconductor-vcfarray

## Overview

The `VCFArray` package provides a `DelayedArray` backend for VCF files. It allows users to treat VCF data entries as R arrays or matrices without loading the full data into RAM. This is particularly useful for large-scale genomic studies where VCF files are stored on-disk or on remote servers (e.g., FTP/HTTP).

Key features:
- **Memory Efficiency**: Data is only loaded when accessed (lazy evaluation).
- **Interoperability**: Inherits from `DelayedArray`, making it compatible with standard R matrix operations and Bioconductor containers like `SummarizedExperiment`.
- **Remote Access**: Supports remote VCF files via URL (requires an index file).

## Core Workflow

### 1. Inspecting VCF Fields
Before constructing an array, use `vcfFields()` to see available data entries in the `fixed`, `info`, and `geno` categories.

```r
library(VCFArray)
library(VariantAnnotation)

fl <- "path/to/your.vcf.gz"
fields <- vcfFields(fl)
print(fields)
# Access specific categories: fields$fixed, fields$info, fields$geno
```

### 2. Constructing a VCFArray
Use the `VCFArray()` constructor. You must specify the `file` and the `name` of the field to extract.

```r
# Extract Genotypes (GT) - usually returns a 2D VCFMatrix (variants x samples)
va_gt <- VCFArray(file = fl, name = "GT")

# Extract an Info field (e.g., AF) - usually returns a 1D VCFArray (variants)
va_af <- VCFArray(file = fl, name = "AF")

# If the same name exists in multiple categories, use pfix
va_fixed_ref <- VCFArray(file = fl, name = "REF", pfix = "fixed")
```

### 3. Working with Remote Files
For remote files, the `vindex` argument (path to the .tbi index) is mandatory.

```r
url <- "https://example.com/data.vcf.gz"
url_tbi <- "https://example.com/data.vcf.gz.tbi"
va_remote <- VCFArray(file = url, vindex = url_tbi, name = "GT")
```

### 4. Array Operations
`VCFArray` objects behave like standard R arrays.

```r
# Dimensions and Dimnames
dim(va_gt)
dimnames(va_gt)

# Subsetting (returns a DelayedArray/Matrix)
sub_va <- va_gt[1:100, 1:5]

# Numeric calculations (if data is numeric)
ds <- VCFArray(fl, name = "DS")
log_ds <- log(ds + 1)

# Realize data into memory (only if small enough)
dense_matrix <- as.matrix(sub_va)
```

## Tips and Best Practices

- **Subsetting 1D Arrays**: When subsetting 1-dimensional `VCFArray` objects (from `fixed` or `info` fields), always use `drop = FALSE` to ensure the returned value remains a `VCFArray` object.
- **Index Files**: Ensure your VCF files are bgzipped and tabix-indexed. If the index is not in the same directory or has a non-standard name, provide it via the `vindex` argument.
- **VcfStack Support**: The constructor also accepts `RangedVcfStack` objects from the `GenomicFiles` package for managing multiple VCF files simultaneously.
- **Seed Access**: Use `seed(va)` to inspect the underlying `VCFArraySeed`, which contains metadata about the file path and specific data entry being accessed.

## Reference documentation

- [VCFArray: DelayedArray objects with on-disk/remote VCF backend](./references/VCFArray.Rmd)
- [VCFArray: DelayedArray objects with on-disk/remote VCF backend (Markdown)](./references/VCFArray.md)