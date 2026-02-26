---
name: bioconductor-dcgsa
description: This tool performs distance-correlation based gene set analysis for longitudinal gene expression profiles. Use when user asks to analyze associations between gene sets and clinical outcomes in longitudinal studies, calculate longitudinal distance covariance, or perform gene set analysis on data with multiple measurements over time.
homepage: https://bioconductor.org/packages/release/bioc/html/dcGSA.html
---


# bioconductor-dcgsa

name: bioconductor-dcgsa
description: Distance-correlation based Gene Set Analysis (dcGSA) for longitudinal gene expression profiles. Use this skill when analyzing associations between gene sets and clinical outcomes in studies where subjects have multiple measurements over time (longitudinal data).

# bioconductor-dcgsa

## Overview

The `dcGSA` package provides a specialized statistical framework for Gene Set Analysis (GSA) tailored to longitudinal studies. Unlike standard GSA methods that assume independent samples, `dcGSA` utilizes distance correlation to capture the dependencies within longitudinal gene expression profiles and clinical outcomes. It assesses whether the multivariate longitudinal profile of a gene set is associated with the longitudinal profile of clinical phenotypes.

## Main Functions and Workflow

### 1. Data Preparation
The package requires data to be structured as a list containing three specific elements:
- `ID`: A character vector of subject identifiers.
- `pheno`: A data frame where each column is a clinical outcome/phenotype.
- `gene`: A data frame where each column is a gene expression value.

The number of rows in `pheno` and `gene` must match the length of `ID`, representing the total number of observations across all subjects and time points.

### 2. Loading Gene Sets
Use `readGMT` to import gene set definitions from standard .gmt files.
```r
library(dcGSA)
# Load a GMT file
fpath <- system.file("extdata", "sample.gmt.txt", package="dcGSA")
GS <- readGMT(file = fpath)
```

### 3. Performing the Analysis
The primary function is `dcGSA()`. It calculates the longitudinal distance covariance and provides significance testing via permutations or normal approximation.

```r
# Load example data
data(dcGSAtest)

# Run dcGSA
# nperm: number of permutations for P-value calculation
# c: minimum number of overlapping genes required to analyze a set
res <- dcGSA(data = dcGSAtest, 
             geneset = GS, 
             nperm = 100, 
             c = 5, 
             parallel = FALSE)

# View results
head(res)
```

### 4. Interpreting Results
The output is a data frame (or a list if `KeepPerm = TRUE`) containing:
- `TotalSize`: Original size of the gene set.
- `OverlapSize`: Number of genes from the set present in your data.
- `Stats`: The raw longitudinal distance covariance statistic.
- `NormScore`: Normalized score based on permutation mean and SD.
- `P.perm`: Permutation-based P-value (most robust).
- `P.approx`: P-value based on normal distribution approximation.
- `FDR.approx`: False Discovery Rate based on the approximate P-values.

## Advanced Usage: Parallel Computing
For large gene set databases (e.g., MSigDB), enable parallel processing to speed up permutations.
```r
library(BiocParallel)
res <- dcGSA(data = dcGSAtest, 
             geneset = GS, 
             nperm = 1000, 
             parallel = TRUE, 
             BPparam = MulticoreParam(workers = 4))
```

## Tips for Success
- **Subject IDs**: Ensure that the `ID` vector correctly groups repeated measures for the same individual. The distance correlation logic relies on these groupings to account for temporal dependencies.
- **Missing Data**: Ensure your gene expression and phenotype data frames do not contain missing values, or impute them prior to running `dcGSA`.
- **Permutations**: For publication-quality results, `nperm` should typically be set to at least 1000. Use `KeepPerm = TRUE` if you need to inspect the null distribution of the statistics.

## Reference documentation
- [dcGSA Reference Manual](./references/reference_manual.md)