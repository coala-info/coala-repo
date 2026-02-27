---
name: bioconductor-scone
description: bioconductor-scone provides a comprehensive framework for normalizing and evaluating single-cell RNA-seq data using multiple workflows. Use when user asks to compare normalization methods, filter poor-quality libraries, perform data imputation, or apply scaling and regression-based adjustments to scRNA-seq count data.
homepage: https://bioconductor.org/packages/release/bioc/html/scone.html
---


# bioconductor-scone

name: bioconductor-scone
description: Comprehensive framework for single-cell RNA-seq data normalization and evaluation. Use when you need to compare multiple normalization workflows, filter poor-quality libraries, perform data imputation, or apply scaling methods (TMM, DESeq, Upper Quartile, PsiNorm) and regression-based adjustments (RUVg, Quality PCs) to scRNA-seq count data.

## Overview

The `scone` package provides a data-driven framework for assessing the efficacy of various normalization workflows. Instead of relying on a single method, `scone` allows users to run many combinations of imputation, scaling, and regression-based adjustments in parallel. It then ranks these workflows using eight performance metrics (e.g., preservation of biological signal, removal of batch effects, and reduction of technical artifacts) to help select the optimal strategy for downstream analysis.

## Core Workflow

### 1. Data Preparation and Quality Control

Load your data into a `SingleCellExperiment` object and identify quality control (QC) metrics.

```r
library(scone)
library(scRNAseq)

# Example: Load data and extract counts
fluidigm <- ReprocessedFluidigmData(assays = "rsem_counts")
expr <- as.matrix(assay(fluidigm))

# Extract QC metrics (e.g., alignment rate, total reads)
qc <- colData(fluidigm)[, metadata(fluidigm)$which_qc]
ppq <- scale(qc[, apply(qc, 2, sd) > 0]) # Scale for PCA
```

### 2. Sample Filtering

Use `metric_sample_filter` to identify and remove low-quality libraries based on read counts, alignment rates, and gene detection breadth.

```r
# Identify common genes for breadth calculation
is_common <- rowSums(expr >= 10) >= (0.25 * ncol(expr))

mfilt <- metric_sample_filter(expr,
                              nreads = colData(fluidigm)$NREADS,
                              ralign = colData(fluidigm)$RALIGN,
                              gene_filter = is_common,
                              zcut = 3, 
                              plot = TRUE)

# Apply filter
is_good <- !apply(simplify2array(mfilt[!is.na(mfilt)]), 1, any)
expr_filtered <- expr[, is_good]
```

### 3. Defining the SconeExperiment

Initialize the `SconeExperiment` object with expression data, biological factors to preserve, and QC metrics to remove.

```r
# Define control genes (e.g., Housekeeping genes for negative controls)
negcon <- rownames(expr_filtered) %in% housekeeping_list

my_scone <- SconeExperiment(expr_filtered,
                            qc = ppq[is_good, ], 
                            bio = factor(colData(fluidigm)$Biological_Condition[is_good]),
                            negcon_ruv = negcon)
```

### 4. Running Normalization Workflows

Define scaling methods and run the evaluation. `scone` will test combinations of the provided modules.

```r
# Define scaling functions
scaling <- list(none = identity, 
                uq = UQ_FN, 
                tmm = TMM_FN, 
                psi = PSINORM_FN, 
                deseq = DESEQ_FN)

# Run scone evaluation
my_scone <- scone(my_scone,
                  scaling = scaling,
                  k_qc = 3, k_ruv = 3, # Factors for regression
                  run = TRUE,
                  return_norm = "in_memory",
                  zero = "postadjust")
```

### 5. Evaluating and Extracting Results

Rank methods by their mean score and extract the best-performing normalized matrix.

```r
# View top-ranked methods
head(get_score_ranks(my_scone))

# Extract the best normalized data
best_method <- rownames(get_params(my_scone))[1]
norm_data <- get_normalized(my_scone, method = best_method)

# Visualize trade-offs with a biplot
pc_obj <- prcomp(apply(t(get_scores(my_scone)), 1, rank))
biplot_color(pc_obj, y = -get_score_ranks(my_scone))
```

## Specialized Normalization: PsiNorm

`PsiNorm` is a scalable normalization based on the Pareto distribution, particularly effective for aligning high-expression gene distributions.

```r
# Direct usage on SingleCellExperiment
library(SingleCellExperiment)
sce <- PsiNorm(sce)
sce <- scuttle::logNormCounts(sce) # Uses PsiNorm size factors
```

## Tips for Success

- **Control Genes**: Providing high-quality positive (DE) and negative (housekeeping) control genes significantly improves the reliability of the evaluation metrics.
- **Imputation**: Imputation (e.g., via `estimate_ziber`) is computationally expensive. Consider running it only if drop-out effects are a primary concern.
- **Batch Effects**: If biological origin and batch are confounded, `scone` cannot directly "fix" the batch effect without risking biological signal loss; use the evaluation metrics to find the best compromise.
- **HDF5 Support**: `PsiNorm` and `scone` support `DelayedArray` and HDF5-backed matrices for large-scale datasets.

## Reference documentation

- [PsiNorm normalization](./references/PsiNorm.md)
- [PsiNorm normalization (RMarkdown source)](./references/PsiNorm.Rmd)
- [Introduction to SCONE](./references/sconeTutorial.md)
- [Introduction to SCONE (RMarkdown source)](./references/sconeTutorial.Rmd)