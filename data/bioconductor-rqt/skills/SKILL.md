---
name: bioconductor-rqt
description: This tool performs gene-level GWAS meta-analysis by aggregating variant signals and accounting for linkage disequilibrium through dimensionality reduction. Use when user asks to calculate gene-level effect sizes, perform gene-based association testing, or combine p-values across multiple GWAS datasets using PCA or PLS methods.
homepage: https://bioconductor.org/packages/release/bioc/html/rqt.html
---


# bioconductor-rqt

name: bioconductor-rqt
description: Gene-level GWAS meta-analysis using the rqt package. Use this skill to calculate gene-level effect sizes and p-values from single or multiple GWAS datasets, accounting for linkage disequilibrium (LD) through dimensionality reduction (PCA/PLS).

# bioconductor-rqt

## Overview

The `rqt` package provides methods for gene-level meta-analysis of GWAS data. Instead of focusing on single variants, it aggregates signals across a gene to calculate a total gene-level effect size and significance. The workflow typically involves:
1. Reducing predictor dimensionality (addressing correlation/LD).
2. Fitting a regression model on reduced data.
3. Pooling coefficients into a gene-level statistic.
4. Combining p-values across multiple studies using Fisher's method.

## Core Workflow

### 1. Data Preparation
The package requires phenotypes (vector), genotypes (SummarizedExperiment), and optional covariates (matrix).

```r
library(rqt)
library(SummarizedExperiment)

# Prepare Genotype as a SummarizedExperiment object
# geno_matrix: N individuals by M variants
geno.obj <- SummarizedExperiment(assays = list(counts = geno_matrix))

# Initialize the rqt object
obj <- rqt(phenotype = pheno_vector, 
           genotype = geno.obj, 
           covariates = covar_matrix)
```

### 2. Single Dataset Analysis
Use `geneTest` to perform the analysis. Specify the outcome type: "D" for dichotomous (binary) or "C" for continuous.

```r
# PCA-based reduction (default)
res <- geneTest(obj, method = "pca", out.type = "C")

# PLS-based reduction (for continuous outcomes)
res <- geneTest(obj, method = "pls", out.type = "C")

print(res)
```

### 3. Meta-Analysis
To combine results from multiple studies, create a list of `rqt` objects and use `geneTestMeta`.

```r
# Assuming obj1, obj2, and obj3 are initialized rqt objects
res.meta <- geneTestMeta(list(obj1, obj2, obj3))

# Access results
res.meta$final.pvalue  # Combined p-value
res.meta$pvalueList    # Individual study p-values
```

## Parameters and Methods

- **Methods**: 
  - `"pca"`: Principal Component Analysis. Suitable for both continuous and dichotomous outcomes.
  - `"pls"`: Partial Least Squares. Recommended for continuous outcomes to maximize explained variance relative to the phenotype.
- **Outcome Types (`out.type`)**:
  - `"C"`: Continuous (Linear regression).
  - `"D"`: Dichotomous (Logistic regression).

## Interpreting Results
The output of `geneTest` is a list containing:
- `Qstatistic`: Statistics for different aggregation approaches.
- `pValue`: Corresponding p-values (pVal1, pVal2, pVal3).
- `beta`: The estimated effect size.
- `model`: Information on the underlying model used (e.g., PCA or PLS).

## Tips
- Ensure variant names (colnames) are assigned to the genotype matrix before creating the `SummarizedExperiment` object.
- When using covariates, ensure the row order matches the phenotype and genotype data.
- For meta-analysis, the package automatically applies Fisher's combined probability method to the gene-level p-values derived from each study.

## Reference documentation
- [Using RQT, an R package for gene-level meta-analysis](./references/rqt-vignette.md)
- [Tutorial for rqt package](./references/rqt-vignette.Rmd)