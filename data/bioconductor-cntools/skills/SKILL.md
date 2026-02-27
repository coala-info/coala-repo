---
name: bioconductor-cntools
description: This tool converts segmented DNA copy number data into a matrix format for downstream genomic analysis. Use when user asks to convert CBS segments to a reduced segment matrix, align non-overlapping genomic segments across samples, or map copy number data to specific genes.
homepage: https://bioconductor.org/packages/release/bioc/html/CNTools.html
---


# bioconductor-cntools

name: bioconductor-cntools
description: Analysis of DNA copy number data using the CNTools package. Use this skill to convert segmented DNA copy number data (from CBS/DNAcopy) into a matrix format (Reduced Segment matrix) for downstream analysis like clustering, prediction, or differential testing.

## Overview

CNTools addresses the challenge of non-aligned genomic segments across different samples in copy number variation (CNV) studies. While algorithms like Circular Binary Segmentation (CBS) identify altered regions, the resulting segments often have different boundaries for each sample, making it impossible to form a standard data matrix. CNTools converts these segments into a "Reduced Segment" (RS) matrix where rows represent either overlapping chromosomal fragments or specific genes, and columns represent samples.

## Core Workflow

### 1. Data Preparation
CNTools requires segmented data, typically the `output` element from the `DNAcopy::segment` function. The input data frame must contain columns for sample ID, chromosome, start position, end position, number of markers, and segment mean.

```r
library(CNTools)
# Load example data provided by the package
data("sampleData")
# sampleData is a data frame of segments
```

### 2. Instantiate CNSeg Object
The first step is to wrap the segment data into a `CNSeg` object.

```r
# Create the CNSeg object
cnseg <- CNSeg(sampleData)
```

### 3. Generate Reduced Segment (RS) Matrix
Use the `getRS` function to convert segments into a matrix. There are two primary modes:

*   **By Region**: Aligns segments across samples and assigns means to overlapping fragments. The number of rows depends on the sample set.
*   **By Gene**: Assigns segment means to specific genes. This requires a `geneMap`.

```r
# Method 1: By Region
rdseg_region <- getRS(cnseg, by = "region", imput = FALSE, XY = FALSE, what = "mean")

# Method 2: By Gene (requires geneInfo)
data("geneInfo")
rdseg_gene <- getRS(cnseg, by = "gene", geneMap = geneInfo, what = "median")
```

**Parameters for `getRS`:**
- `by`: "region", "gene", or "pair".
- `imput`: Boolean; whether to impute missing values.
- `XY`: Boolean; whether to include sex chromosomes.
- `what`: Rule for multiple segment values in one region ("mean", "median", "max", or "min").
- `geneMap`: Required if `by="gene"`. A matrix with columns: `chrom`, `start`, `end`, `geneid`, `genename`.

### 4. Extracting and Filtering Data
Once the RS object is created, extract the matrix for standard R analysis or use built-in filters.

```r
# Extract the matrix
rs_matrix <- rs(rdseg_region)

# Filter for high variance using Median Absolute Deviation (MAD)
# Example: Keep top segments based on a MAD threshold
filtered_rs <- madFilter(rdseg_region, 0.8)

# Use genefilter for custom requirements (e.g., 5 samples with log2 ratio > 1)
library(genefilter)
f1 <- kOverA(5, 1)
ffun <- filterfun(f1)
filtered_custom <- genefilter(rdseg_region, ffun)
```

## Downstream Analysis
The resulting matrix or filtered object can be used directly in standard R clustering functions.

```r
# Hierarchical clustering example
d <- dist(t(rs(filtered_rs))) # Distance between samples
hc <- hclust(d, method = "complete")
plot(hc)
```

## Tips for Large Datasets
- Processing hundreds of samples "by region" can take 10-20 minutes.
- If using "by gene", ensure your `geneMap` matches the genome build used for the original alignment (e.g., the provided `geneInfo` is for build 36).
- Use `madFilter` to reduce the dimensionality of the matrix before performing computationally expensive clustering.

## Reference documentation
- [How to use CNTools](./references/HowTo.md)