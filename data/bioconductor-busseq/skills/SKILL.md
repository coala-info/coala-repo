---
name: bioconductor-busseq
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BUSseq.html
---

# bioconductor-busseq

## Overview

The `BUSseq` package implements a Bayesian hierarchical model designed to simultaneously correct batch effects, cluster cell types, and impute dropout events in single-cell RNA-sequencing (scRNA-seq) data. Unlike methods that require known subtypes, BUSseq treats cell types as latent variables, making it ideal for discovery-based workflows. It accounts for count-based distributions (Negative Binomial), overdispersion, and cell-specific sequencing depth.

## Core Workflow

### 1. Data Preparation
BUSseq accepts either a `SingleCellExperiment` object or a named `list` of count matrices.

```r
library(BUSseq)
library(SingleCellExperiment)

# Option A: SingleCellExperiment (Recommended)
# counts: matrix of raw read counts
# colData: must contain a factor indicating batch membership
sce <- SingleCellExperiment(assays = list(counts = count_matrix),
                           colData = DataFrame(Batch_ind = factor(batch_vector)))

# Option B: List of matrices
# Each element is a batch (genes in rows, cells in columns)
list_input <- list(Batch1 = matrix1, Batch2 = matrix2)
```

### 2. Model Fitting
The `BUSseq_MCMC` function performs the posterior sampling. You must specify the expected number of cell types (`n.celltypes`).

```r
# Fit the model
# n.celltypes: Number of clusters to identify
# n.iterations: Total MCMC iterations (default burn-in is half)
bus_results <- BUSseq_MCMC(ObservedData = sce, 
                           n.celltypes = 4, 
                           n.iterations = 500, 
                           seed = 1234, 
                           n.cores = 2)
```

### 3. Extracting Results
After fitting, use specific accessor functions to retrieve inferred parameters and biological signals.

*   **Cell Types:** `celltypes(bus_results)` returns the posterior mode of cell-type indicators for each cell.
*   **Batch Effects:** `location_batch_effects(bus_results)` returns the $\nu_{bg}$ parameters (first batch is the reference).
*   **Overdispersion:** `overdispersions(bus_results)` returns batch-specific gene overdispersion.
*   **Cell Effects:** `cell_effect_values(bus_results)` returns cell-specific size factors $\delta_{bi}$.
*   **Mean Expression:** `celltype_mean_expression(bus_results)` returns the batch-corrected, cell-type-specific expression levels.

### 4. Batch Correction and Imputation
To obtain a corrected count matrix for downstream visualization or analysis (e.g., Seurat/Scanpy), use `corrected_read_counts`.

```r
# Impute dropouts and remove batch effects
bus_results <- corrected_read_counts(bus_results)

# Access the corrected data
corrected_counts <- assay(bus_results, "corrected_data")
imputed_counts <- assay(bus_results, "imputed_data")
```

### 5. Identifying Intrinsic Genes
Intrinsic genes are those that drive the differences between cell types and are not influenced by batch effects.

```r
intrinsic_genes <- intrinsic_genes_BUSseq(bus_results)
# Returns a DataFrame indicating 'Yes' or 'No' for each gene
```

## Visualization
The package provides a built-in heatmap function to compare data states.

```r
# data_type can be "Raw", "Imputed", or "Corrected"
heatmap_data_BUSseq(bus_results, 
                    data_type = "Corrected", 
                    gene_set = 1:100, 
                    project_name = "MyStudy", 
                    image_dir = "./plots")
```

## Tips and Best Practices
*   **Selecting K:** If the number of cell types (`n.celltypes`) is unknown, run `BUSseq_MCMC` across a range of values and select the one that minimizes the Bayesian Information Criterion (BIC).
*   **Reference Batch:** BUSseq automatically treats the first batch as the reference. Ensure your most "reliable" or largest batch is indexed first if necessary.
*   **Convergence:** For publication-quality results, increase `n.iterations` (e.g., 2000+) to ensure MCMC convergence.
*   **Memory:** For very large datasets, ensure `n.cores` is set appropriately to leverage parallel processing during the MCMC sampling.

## Reference documentation
- [BUSseq User's Guide](./references/BUSseq_user_guide.md)