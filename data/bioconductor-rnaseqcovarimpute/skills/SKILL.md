---
name: bioconductor-rnaseqcovarimpute
description: This tool performs linear model analysis for RNA-seq data using multiple imputation to handle missing covariate information. Use when user asks to perform differential expression analysis with missing metadata, impute missing values in RNA-seq covariates using PCA or gene binning, or run limma-voom on multiple imputed datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/RNAseqCovarImpute.html
---

# bioconductor-rnaseqcovarimpute

name: bioconductor-rnaseqcovarimpute
description: Perform linear model analysis for RNA-seq read counts with multiple imputation (MI) of missing covariates. Use this skill when analyzing RNA-seq data (DGEList objects) where covariate data (metadata) contains missing values (NAs) and you want to avoid the bias or power loss of complete-case analysis. Supports two workflows: a fast PCA-based method and a gene-binning method.

# bioconductor-rnaseqcovarimpute

## Overview

The `RNAseqCovarImpute` package integrates the `limma-voom` pipeline with multiple imputation (MI) via the `mice` package. It solves the "high-dimensional outcome" problem in MI by either reducing gene expression to Principal Components (PCs) or binning genes into small groups. This ensures that gene expression information is included in the imputation model for covariates, which is a requirement for unbiased estimates.

## Core Workflows

### 1. MI PCA Method (Recommended)
This is the most computationally efficient approach. It uses PCA to capture the variance of the expression data and includes the top PCs as predictors in the covariate imputation.

```r
library(RNAseqCovarImpute)
library(limma)
library(PCAtools)
library(mice)

# 1. Prepare PCA data from DGEList
pca_data <- limma::voom(example_DGE)$E
p <- PCAtools::pca(pca_data)

# 2. Select PCs (e.g., those explaining >80% variance)
num_pcs <- which(cumsum(p$variance) > 80)[1]
pcs <- p$rotated[, 1:num_pcs]

# 3. Append PCs to covariate data and run MI
data_with_pcs <- cbind(example_data, pcs)
imp <- mice::mice(data_with_pcs, m = 10) # m=30-100 recommended for production

# 4. Run limma-voom on imputed sets and pool
mi_pca_res <- limmavoom_imputed_data_pca(
  imp = imp,
  DGE = example_DGE,
  voom_formula = "~x + y + z + a + b"
)

# 5. Extract and adjust results
results_x <- mi_pca_res %>%
  dplyr::arrange(x_p) %>%
  dplyr::mutate(x_p_adj = p.adjust(x_p, method = "fdr"))
```

### 2. Gene Binning Method
Use this method if you prefer to impute covariates using local gene expression information. It bins genes into small groups and runs MI/limma separately for each bin.

```r
# 1. Define gene bins (default ratio is 1 gene per 10 samples)
intervals <- get_gene_bin_intervals(example_DGE, example_data)

# 2. Randomize gene order to avoid chromosomal/sequential bias
example_DGE <- example_DGE[sample(nrow(example_DGE)), ]

# 3. Impute covariates per gene bin
gene_bin_impute <- impute_by_gene_bin(
  example_data,
  intervals,
  example_DGE,
  m = 5
)

# 4. Run limma-voom on the list of imputed datasets
coef_se <- limmavoom_imputed_data_list(
  gene_intervals = intervals,
  DGE = example_DGE,
  imputed_data_list = gene_bin_impute,
  m = 5,
  voom_formula = "~x + y + z + a + b"
)

# 5. Pool results using Rubin's rules and apply Empirical Bayes
final_res <- combine_rubins(
  DGE = example_DGE,
  model_results = coef_se,
  predictor = "x"
)
```

## Key Functions

- `limmavoom_imputed_data_pca()`: The primary wrapper for the PCA workflow. It handles the parallel execution of `voom`, `lmFit`, and pooling.
- `impute_by_gene_bin()`: Performs MI separately for subsets of genes.
- `combine_rubins()`: Pools results from multiple imputations. Crucially, it applies `limma::squeezeVar` (Empirical Bayes) *before* pooling to ensure variance shrinkage is handled correctly in the MI context.
- `get_gene_bin_intervals()`: Calculates start/end indices for gene bins based on sample size.

## Tips for Success

- **Parallelization**: Both workflows support `BiocParallel`. Use the `BPPARAM` argument (e.g., `BPPARAM = MulticoreParam(4)`) to speed up the imputation and model fitting steps.
- **Number of Imputations (m)**: While examples use `m = 3` for speed, use at least `m = 20` to `m = 100` for publication-quality results to ensure stable standard error estimates.
- **Predictor Specification**: In `combine_rubins()`, the `predictor` argument must match the column name in the design matrix. For factors, this is usually `VariableNameLevelName` (e.g., `GroupB`).
- **Data Prep**: Ensure your `DGEList` and covariate `data.frame` have matching sample IDs and order before starting the pipeline.

## Reference documentation

- [Example Data for RNAseqCovarImpute](./references/Example_Data_for_RNAseqCovarImpute.md)
- [Impute Covariate Data in RNA-sequencing Studies](./references/Impute_Covariate_Data_in_RNA_sequencing_Studies.md)