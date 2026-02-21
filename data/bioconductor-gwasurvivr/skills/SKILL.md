---
name: bioconductor-gwasurvivr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gwasurvivr.html
---

# bioconductor-gwasurvivr

name: bioconductor-gwasurvivr
description: Perform survival analysis on large-scale genetic data (imputed or directly typed) using Cox Proportional Hazard (Cox PH) models. Use when analyzing time-to-event data with genotypes from Michigan/Sanger servers, IMPUTE2, or PLINK formats.

# bioconductor-gwasurvivr

## Overview
`gwasurvivr` is an R package designed for genome-wide survival analysis. It fits Cox Proportional Hazard models to each SNP, accounting for covariates and optional interaction terms. It is optimized for memory efficiency by processing data in chunks, making it suitable for large imputed datasets.

## Core Functions
The package provides specific functions based on the input genotype format:

*   `michiganCoxSurv()`: For Michigan Imputation Server VCF files (`.vcf.gz`).
*   `sangerCoxSurv()`: For Sanger Imputation Server VCF files (`.vcf.gz`).
*   `impute2CoxSurv()`: For IMPUTE2 output (`.impute` and `.sample` files).
*   `plinkCoxSurv()`: For PLINK binary files (`.bed`, `.bim`, `.fam`).
*   `gdsCoxSurv()`: For data already converted to Genomic Data Structure (GDS) format.

## Typical Workflow

### 1. Prepare Covariate Data
The `covariate.file` must be a data frame where:
*   Sample IDs match the genotype file.
*   Categorical variables are converted to **numeric dummy variables** (0/1).
*   Ordinal variables are converted to numeric values.
*   Time and event (status) columns are clearly defined.

```r
# Example preparation
pheno <- read.table("phenotypes.txt", header=TRUE)
pheno$SexFemale <- ifelse(pheno$sex == "female", 1, 0)
```

### 2. Execute Survival Analysis
All main functions share a similar interface.

```r
library(gwasurvivr)

michiganCoxSurv(
  vcf.file = "data.vcf.gz",
  covariate.file = pheno,
  id.column = "ID_2",
  time.to.event = "time",
  event = "event",
  covariates = c("age", "SexFemale", "PC1"),
  out.file = "results_output",
  r2.filter = 0.3,
  maf.filter = 0.01,
  chunk.size = 10000
)
```

### 3. Interaction Terms
To test for a SNP-covariate interaction, use the `inter.term` argument. When used, the output P-value and Hazard Ratio (HR) refer to the interaction term.

```r
sangerCoxSurv(..., inter.term = "DrugTx", ...)
```

## Key Parameters and Tips

*   **Filtering**: Use `maf.filter` and `info.filter` (or `r2.filter`) to skip low-quality variants and speed up computation.
*   **Chunk Size**: `chunk.size` defaults to 10,000. Increase for more speed if RAM allows, but 10,000–100,000 is generally recommended.
*   **Parallelization**: `gwasurvivr` uses the `parallel` package.
    *   Linux/Mac: `options("gwasurvivr.cores"=4)`
    *   All Platforms: Pass a cluster object via `clusterObj = makeCluster(cores)`.
*   **VCF Indexing**: VCF files must have an associated index (`.tbi` or `.csi`) in the same directory.
*   **Output**: Results are saved directly to disk as a `.coxph` file to conserve memory. Use `print.covs = "all"` if you need coefficients for all covariates, though this increases file size.

## Reference documentation
- [gwasurvivr Introduction](./references/gwasurvivr_Introduction.md)
- [gwasurvivr Vignette](./references/gwasurvivr_Introduction.Rmd)