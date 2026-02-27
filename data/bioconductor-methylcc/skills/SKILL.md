---
name: bioconductor-methylcc
description: This tool estimates the cell composition of whole blood samples from DNA methylation data across both microarray and sequencing platforms. Use when user asks to estimate cell type proportions, calculate blood cell composition from WGBS or RRBS data, or perform platform-agnostic cell count estimation.
homepage: https://bioconductor.org/packages/release/bioc/html/methylCC.html
---


# bioconductor-methylcc

## Overview

The `methylCC` package provides a statistical framework to estimate the cell composition of whole blood samples. Unlike traditional reference-based methods that are platform-specific, `methylCC` identifies informative genomic regions that maintain their methylation state across different technologies. This allows for accurate estimation in both microarray (e.g., 450k, EPIC) and sequencing (e.g., WGBS, RRBS) data.

## Core Workflow

### 1. Load Required Libraries
```r
library(methylCC)
library(minfi) # For microarray data
library(bsseq) # For sequencing data
```

### 2. Prepare Input Data
The package accepts two primary object types:
- **RGChannelSet**: For Illumina microarray data (processed via `minfi`).
- **BSseq**: For bisulfite sequencing data (processed via `bsseq`).

The input object should contain DNA methylation levels at CpGs (rows) for whole blood samples (columns).

### 3. Estimate Cell Composition
Use the `estimatecc()` function to perform the estimation. It is recommended to set a seed for reproducibility.

```r
set.seed(12345)
est <- estimatecc(object = your_data_object)
```

### 4. Extract and Interpret Results
The result is an `estimatecc` object. Use `cell_counts()` to retrieve the matrix of estimated proportions.

```r
# View summary of the estimation
print(est)

# Extract the cell counts matrix
counts <- cell_counts(est)
head(counts)
```

The output matrix contains proportions for:
- **Gran**: Granulocytes
- **CD4T**: CD4+ T-cells
- **CD8T**: CD8+ T-cells
- **Bcell**: B-cells
- **Mono**: Monocytes
- **NK**: Natural Killer cells

## Comparison with minfi
While `minfi::estimateCellCounts` is a standard for 450k arrays, `methylCC` is designed to be platform-agnostic. If working with 450k data, you can compare results:

```r
# minfi approach
est_minfi <- minfi::estimateCellCounts(rgset)

# methylCC approach
est_methylcc <- cell_counts(estimatecc(rgset))
```

## Tips for Success
- **Platform Independence**: Use `methylCC` specifically when you have sequencing data (WGBS/RRBS) or when you need a consistent estimation method across different microarray versions.
- **Memory**: For large `BSseq` objects, ensure sufficient RAM is available as the estimation process involves identifying specific genomic regions across the genome.
- **Seed**: Always use `set.seed()` before `estimatecc()` to ensure the latent variable estimation remains consistent across sessions.

## Reference documentation
- [The methylCC user's guide](./references/methylCC.md)
- [The methylCC user's guide (RMarkdown)](./references/methylCC.Rmd)