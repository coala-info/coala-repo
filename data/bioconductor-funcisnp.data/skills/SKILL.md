---
name: bioconductor-funcisnp.data
description: This package provides pre-packaged experiment data and genomic features required for functional annotation of genetic variants using the FunciSNP R package. Use when user asks to access SNP and regulatory datasets, identify candidate regulatory SNPs, or overlap GWAS hits with functional genomic features.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/FunciSNP.data.html
---


# bioconductor-funcisnp.data

name: bioconductor-funcisnp.data
description: Access and utilize the FunciSNP.data experiment data package. Use this skill when performing functional annotation of genetic variants, specifically when requiring the pre-packaged datasets (SNP, genomic features, and regulatory data) needed to run the FunciSNP R package for identifying candidate regulatory SNPs.

# bioconductor-funcisnp.data

## Overview

`FunciSNP.data` is a dedicated Bioconductor experiment data package designed to support the `FunciSNP` package. It provides the necessary data structures and example datasets required to integrate functional non-coding datasets with genetic association studies (GWAS). The primary goal of the associated workflow is to identify candidate regulatory SNPs by overlapping GWAS hits with functional genomic features like enhancers, promoters, and transcription factor binding sites.

## Loading and Using Data

To use this package, it must be loaded alongside the main `FunciSNP` analysis package.

```r
# Load the data package
library(FunciSNP.data)
library(FunciSNP)

# List available datasets within the package
data(package = "FunciSNP.data")
```

### Typical Workflow Integration

The data provided in this package is typically passed into the core `getFunciSNP` function. While `FunciSNP.data` contains the raw data, you will use it to:

1.  **Provide Reference SNPs**: Use the included SNP data to test the FunciSNP workflow.
2.  **Functional Features**: Access the pre-defined genomic features (e.g., CTCF binding sites, DNase I hypersensitive sites) used for overlap analysis.
3.  **Validation**: Use the data to run the examples provided in the main `FunciSNP` vignette to ensure your environment is configured correctly.

### Accessing Specific Objects

Commonly used data objects within this package include:
- `lincRNA`: Long intergenic non-coding RNA regions.
- `refseq`: Reference sequence gene annotations.
- `snp`: Example SNP data for association studies.
- `biofeatures`: Biological features used for intersection.

```r
# Example: Loading a specific dataset from the package
data(lincRNA)
head(lincRNA)
```

## Tips for Success

- **Dependency**: This package is a data-only container. It is rarely used in isolation and should almost always be used in conjunction with `library(FunciSNP)`.
- **Version Consistency**: Ensure your Bioconductor version matches the requirements for both `FunciSNP` and `FunciSNP.data` to avoid object schema mismatches.
- **Memory**: Since this is a data package, loading multiple large datasets (like `biofeatures`) can consume significant RAM. Only load the specific datasets required for your analysis.

## Reference documentation

- [Using the FunciSNP data package](./references/FunciSNP.data.md)