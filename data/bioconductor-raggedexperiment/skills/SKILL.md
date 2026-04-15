---
name: bioconductor-raggedexperiment
description: This tool manages and transforms ragged genomic data, such as copy number variants and mutations, into rectangular matrices for analysis. Use when user asks to manage genomic range data with varying sample lengths, convert ASCAT output into Bioconductor objects, or transform ragged data into sparse, compact, or disjoint matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/RaggedExperiment.html
---

# bioconductor-raggedexperiment

name: bioconductor-raggedexperiment
description: Comprehensive management and transformation of ragged genomic data (copy number, mutations) into rectangular matrices. Use when working with genomic range data where samples have varying numbers of ranges, or when converting ASCAT output and other genomic data frames into Bioconductor-standard objects for downstream analysis.

# bioconductor-raggedexperiment

## Overview

The `RaggedExperiment` package provides a flexible container for genomic location data where different samples have different numbers of ranges (e.g., copy number variants, somatic mutations). It bridges the gap between `GRangesList` objects and rectangular `SummarizedExperiment` objects by providing "assay" functions that transform ragged data into matrices based on various overlap and reduction rules.

## Installation and Loading

To use this package, ensure it is installed via `BiocManager`:

library(BiocManager)
BiocManager::install("RaggedExperiment")
library(RaggedExperiment)
library(GenomicRanges)

## Constructing a RaggedExperiment

You can create a `RaggedExperiment` from individual `GRanges` objects, a `GRangesList`, or a standard `data.frame`.

### From GRanges Objects
sample1 <- GRanges(c(A = "chr1:1-10:-", B = "chr1:8-14:+"), score = 3:4)
sample2 <- GRanges(c(C = "chr1:1-10:-", D = "chr2:11-18:+"), score = 1:2)
colDat <- DataFrame(id = 1:2, row.names = c("sample1", "sample2"))

re <- RaggedExperiment(sample1 = sample1, sample2 = sample2, colData = colDat)

### From a Data Frame (e.g., ASCAT output)
# Useful for converting flat files with sample, chr, start, end columns
grl <- makeGRangesListFromDataFrame(
    df, 
    split.field = "sample", 
    keep.extra.columns = TRUE,
    seqnames.field = "chr", 
    start.field = "startpos", 
    end.field = "endpos"
)
re <- RaggedExperiment(grl)

## Accessors and Subsetting

`RaggedExperiment` objects behave like matrices where rows are genomic ranges and columns are samples.

- **Accessors**: Use `rowRanges(re)`, `colData(re)`, and `assays(re)`.
- **Subsetting**: Use matrix-style indexing `re[i, j]`.
- **Genomic Subsetting**: Use `subsetByOverlaps(re, query_granges)`.

## Transforming to Rectangular Matrices

The core power of `RaggedExperiment` lies in its four assay functions which "rectangularize" the data.

### 1. sparseAssay
Returns a matrix where the rows are the union of all ranges across all samples.
sparseAssay(re, assayName = "score")

### 2. compactAssay
Similar to `sparseAssay`, but rows with identical genomic ranges across samples are binned together.
compactAssay(re, sparse = TRUE)

### 3. disjoinAssay
Uses `disjoin()` to create a set of non-overlapping ranges across all samples. You must provide a `simplifyDisjoin` function to handle cases where multiple ranges in a sample overlap a disjoint range.
disjoinAssay(re, simplifyDisjoin = mean)

### 4. qreduceAssay
Summarizes data against a specific set of query ranges (e.g., genes or bins).
query <- GRanges(c("chr1:1-14", "chr2:11-18"))
# Example: weighted mean based on overlap width
weightedmean <- function(scores, ranges, qranges) {
    isects <- pintersect(ranges, qranges)
    sum(scores * width(isects)) / sum(width(isects))
}
qreduceAssay(re, query, simplifyReduce = weightedmean)

## Coercion to SummarizedExperiment

To use downstream Bioconductor tools that require `SummarizedExperiment`, use the parallel coercion functions:

- `sparseSummarizedExperiment(re)`
- `compactSummarizedExperiment(re)`
- `disjoinSummarizedExperiment(re, simplifyDisjoin = ...)`
- `qreduceSummarizedExperiment(re, query = ..., simplifyReduce = ...)`

## Reference documentation

- [ASCAT to RaggedExperiment](./references/ASCAT_to_RaggedExperiment.md)
- [RaggedExperiment](./references/RaggedExperiment.md)