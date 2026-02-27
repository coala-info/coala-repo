---
name: bioconductor-xcore
description: Bioconductor-xcore models transcription factor activities by performing ridge regression on gene expression data and molecular signatures. Use when user asks to estimate transcription factor activities, model gene expression as a linear combination of molecular signatures, or perform promoter-level expression analysis using ridge regression.
homepage: https://bioconductor.org/packages/release/bioc/html/xcore.html
---


# bioconductor-xcore

name: bioconductor-xcore
description: Transcription factor (TF) activity modeling using ridge regression. Use when analyzing gene expression data (e.g., CAGE or promoter-level RNA-seq) to predict TF activities based on molecular signatures (ChIP-seq peaks) and promoter annotations.

# bioconductor-xcore

## Overview

`xcore` is an R package designed to model changes in gene expression as a linear combination of molecular signatures (typically transcription factor binding sites) to estimate transcription factor activities. It utilizes ridge regression to handle the high dimensionality and multicollinearity of molecular signatures. The package integrates with `MultiAssayExperiment` for data management and `xcoredata` for pre-processed signatures from ReMap and ChIP-Atlas.

## Core Workflow

### 1. Data Preparation
The starting point is a count matrix (e.g., FANTOM5 promoters) and a design matrix. Use `prepareCountsForRegression` to filter lowly expressed promoters, normalize (CPM), and log2 transform the data.

```r
library(xcore)

# counts: matrix with promoters as rows and samples as columns
# design: matrix describing experimental groups
# base_lvl: the reference group (e.g., "control" or "00hr")
mae <- prepareCountsForRegression(counts = count_matrix,
                                  design = design_matrix,
                                  base_lvl = "control")
```

### 2. Managing Molecular Signatures
Molecular signatures are binary matrices indicating TF binding at specific promoters. You can fetch pre-computed signatures via `ExperimentHub` or create custom ones.

**Loading from xcoredata:**
```r
library(ExperimentHub)
eh <- ExperimentHub()
remap_promoters_f5 <- eh[["EH7301"]] # ReMap2020 signatures for FANTOM5
mae <- addSignatures(mae, remap = remap_promoters_f5)
```

**Creating Custom Signatures:**
Use `getInteractionMatrix` to intersect promoter ranges with TF binding sites (GRanges).
```r
# a: promoters GRanges, b: TFBS GRanges
# ext: extension around promoter center
molecular_signature <- getInteractionMatrix(a = promoters_gr, b = tfbs_gr, ext = 500)
```

### 3. Filtering Signatures
To improve model stability, filter out signatures that overlap too few or too many promoters.
```r
mae <- filterSignatures(mae, min = 0.05, max = 0.95)
```

### 4. Modeling Gene Expression
The `modelGeneExpression` function performs the ridge regression. It is computationally intensive and benefits from parallelization.

```r
library(doParallel)
library(BiocParallel)

# Register parallel backend
registerDoParallel(cores = 2)
register(DoparParam(), default = TRUE)

res <- modelGeneExpression(
  mae = mae,
  xnames = "remap", # Name of the signature experiment in MAE
  nfolds = 10       # Folds for cross-validation
)
```

### 5. Interpreting Results
The output is a list containing:
- `results`: A data frame with replicate-averaged activities and an overall `z_score` for ranking.
- `coef_avg`: Matrix of average signatures activities per group.
- `zscore_avg`: Matrix of average Z-scores per group.

```r
# View top TFs by Z-score
head(res$results$remap)

# Visualize activities
top_sigs <- head(res$results$remap, 10)
pheatmap::pheatmap(top_sigs[, c("group1", "group2")])
```

## Tips and Best Practices
- **Memory Management**: Large signature matrices (like the full ReMap set) can require significant RAM (8GB+). Subset signatures if resources are limited.
- **Input Requirements**: For `getInteractionMatrix`, both the promoter and TF GRanges must have a `name` column.
- **Basal Level**: Ensure the `base_lvl` in `prepareCountsForRegression` correctly identifies your reference samples, as activities are modeled relative to this baseline.
- **Parallelization**: Always register a parallel backend (e.g., `doParallel`) before running `modelGeneExpression` to avoid long execution times.

## Reference documentation
- [xcore vignette](./references/xcore_vignette.md)