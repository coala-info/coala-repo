---
name: r-saige
description: SAIGE is an R package for performing scalable large-scale genetic association studies using generalized mixed models to account for sample relatedness and case-control imbalance. Use when user asks to fit null models for genetic data, perform single-variant association tests, or conduct gene-based association tests using SAIGE-GENE.
homepage: https://cran.r-project.org/web/packages/saige/index.html
---


# r-saige

## Overview
SAIGE is an R package designed for Scalable and Accurate Implementation of Generalized mixed models. It is specifically optimized for large-scale genetic association studies (N > 400,000), accounting for sample relatedness through a Genetic Relationship Matrix (GRM) and handling case-control imbalance in binary traits using Saddlepoint Approximation (SPA).

## Installation
SAIGE requires several dependencies including `Rcpp`, `RcppArmadillo`, `data.table`, `SPAtest`, and `SKAT`.

```R
# Install dependencies from CRAN
install.packages(c("R.utils", "Rcpp", "RcppParallel", "RcppArmadillo", "data.table", "RcppEigen", "Matrix", "SPAtest", "SKAT", "optparse"))

# Install MetaSKAT from GitHub
devtools::install_github("leeshawn/MetaSKAT")

# Install SAIGE from GitHub
devtools::install_github("weizhouUMICH/SAIGE")
```

## Core Workflow

### 1. Fit the Null Model (Step 1)
Before testing variants, fit a null model using phenotypes, covariates, and a subset of genetic markers (PLINK format) to estimate the GRM and variance components.

```R
library(SAIGE)

# For Binary Traits
fitNULLGLMM(
  plinkFile = "path/to/genotypes_for_GRM",
  phenoFile = "pheno.txt",
  phenoCol = "y_binary",
  covarColList = c("x1", "x2"),
  sampleIDColinphenoFile = "IID",
  traitType = "binary",
  outputPrefix = "./output/res_binary",
  nThreads = 4,
  LOCO = TRUE
)

# For Quantitative Traits
fitNULLGLMM(
  plinkFile = "path/to/genotypes_for_GRM",
  phenoFile = "pheno.txt",
  phenoCol = "y_quant",
  traitType = "quantitative",
  invNormalize = TRUE,
  outputPrefix = "./output/res_quant"
)
```

### 2. Single-Variant Association Tests (Step 2)
Use the fitted model to test variants in VCF, BGEN, or SAV formats.

```R
SPAGMMATtest(
  vcfFile = "input.vcf.gz",
  vcfFileIndex = "input.vcf.gz.tbi",
  vcfField = "GT",
  chrom = "1",
  minMAF = 0.0001,
  minMAC = 3,
  GMMATmodelFile = "./output/res_binary.rda",
  varianceRatioFile = "./output/res_binary.varianceRatio.txt",
  SAIGEOutputFile = "./output/assoc_results.txt"
)
```

### 3. Gene-Based Tests (SAIGE-GENE)
Requires a sparse GRM (Step 0) and a group file defining gene sets.

```R
# Step 0: Create Sparse GRM
createSparseGRM(
  plinkFile = "path/to/genotypes",
  outputPrefix = "./output/sparseGRM",
  numRandomMarkerforSparseKin = 2000,
  relatednessCutoff = 0.125
)

# Step 2: Gene-based test
SPAGMMATtest(
  vcfFile = "input.vcf.gz",
  groupFile = "genes.group",
  sparseSigmaFile = "sparseGRM.sparseSigma.mtx",
  IsSingleVarinGroupTest = TRUE,
  # ... other parameters same as single-variant
)
```

## Key Parameters & Tips
- **LOCO (Leave-One-Chromosome-Out):** Recommended for Step 1 to increase power by avoiding proximal contamination.
- **Trait Types:** Use `traitType = "binary"` for case-control data and `"quantitative"` for continuous traits.
- **SPA Threshold:** SAIGE uses SPA for binary traits to handle imbalance. Results for variants with MAC < 3 may be unstable; use `minMAC = 3` as a filter.
- **Missing Data:** Use `IsDropMissingDosages = TRUE` to exclude samples with missing genotypes, otherwise they are mean-imputed.
- **Conditional Analysis:** Pass marker IDs to the `condition` argument in `SPAGMMATtest` to perform conditional association.

## Reference documentation
- [Genetic association tests using SAIGE](./references/Genetic-association-tests-using-SAIGE.md)
- [SAIGE README](./references/README.md)
- [SAIGE Wiki](./references/wiki.md)
- [SAIGE Home Page](./references/home_page.md)
- [GitHub Articles](./references/articles.md)