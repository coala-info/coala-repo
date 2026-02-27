---
name: bioconductor-wrench
description: "Wrench normalizes sparse count data from metagenomic surveys by estimating compositional and normalization factors. Use when user asks to normalize 16S metagenomic data, account for compositional bias in sparse counts, or calculate normalization factors for differential abundance analysis."
homepage: https://bioconductor.org/packages/release/bioc/html/Wrench.html
---


# bioconductor-wrench

## Overview
Wrench is a normalization technique specifically designed for sparse count data, such as 16S metagenomic surveys. It addresses the issue where relative abundance changes in a few features can lead to false positives in unperturbed features. Wrench estimates compositional and normalization factors by leveraging experimental group information to reconstruct absolute abundance relationships.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Wrench")
library(Wrench)
```

## Basic Workflow
The primary function is `wrench()`. It requires a count matrix and a condition vector.

```r
# counts: matrix of features (rows) x samples (cols)
# condition: vector of group labels for each sample
W <- wrench(counts, condition = group)

# Extract factors
compositionalFactors <- W$ccf
normalizationFactors <- W$nf
```

## Integration with DA Pipelines
Wrench factors are designed to be plugged directly into common differential abundance (DA) tools.

### metagenomeSeq
```r
library(metagenomeSeq)
# Assuming mouseData is an MRexperiment object
normFactors(mouseData) <- W$nf
```

### DESeq2
```r
library(DESeq2)
dds <- DESeqDataSetFromMatrix(countData = counts, 
                              colData = DataFrame(group), 
                              design = ~ group)
sizeFactors(dds) <- W$nf
```

### edgeR
Note: edgeR requires the **compositional factors** (`ccf`) rather than the final normalization factors.
```r
library(edgeR)
dge <- DGEList(counts = counts, 
               group = group, 
               norm.factors = W$ccf)
```

## Advanced Usage

### Handling Continuous Covariates
Wrench currently requires categorical group labels. For continuous data, discretize the variable into levels:
```r
time_groups <- cut(numeric_time, breaks = 5)
W <- wrench(counts, condition = time_groups)
```

### The Detrend Option
In cases of extreme sparsity and low depth, a linear trend may appear between compositional factors and sample depth. Use `detrend = TRUE` to correct this:
```r
W <- wrench(counts, condition = group, detrend = TRUE)
```

## Tips
- **Input Format**: Ensure the count matrix is not already normalized (use raw counts).
- **Group Labels**: Providing accurate group labels is critical as Wrench uses them to estimate the ratio of proportions.
- **Interpretation**: `ccf` (compositional change factors) represent the change in the ratio of absolute to relative abundance. `nf` (normalization factors) are the final values used to scale the data (typically `ccf` multiplied by library size).

## Reference documentation
- [Wrench Vignette (Rmd)](./references/vignette.Rmd)
- [Wrench Vignette (Markdown)](./references/vignette.md)