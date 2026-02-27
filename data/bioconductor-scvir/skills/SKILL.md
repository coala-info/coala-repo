---
name: bioconductor-scvir
description: This package provides an R interface to the scvi-tools Python library for performing variational inference on single-cell omics data within the Bioconductor ecosystem. Use when user asks to run totalVI models, perform joint analysis of RNA and protein data, or integrate scvi-tools outputs with SingleCellExperiment objects for downstream R analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/scviR.html
---


# bioconductor-scvir

name: bioconductor-scvir
description: Interface between Bioconductor and scvi-tools for single-cell omics analysis. Use when performing variational inference (VI) on single-cell data (RNA-seq, CITE-seq) in R, specifically for totalVI workflows, integrating AnnData/MuData with SingleCellExperiment, and comparing scvi-tools outputs with OSCA (Orchestrating Single-Cell Analysis) methods.

# bioconductor-scvir

## Overview
The `scviR` package provides an R interface to the `scvi-tools` Python library via `basilisk`. It facilitates the use of deep learning models like `totalVI` for joint analysis of RNA and protein (ADT) data within the Bioconductor ecosystem. It allows users to cache tutorial datasets, run variational autoencoders (VAE), and convert results into `SingleCellExperiment` objects for downstream R-based analysis.

## Core Workflows

### 1. Data Retrieval and Caching
The package provides several functions to retrieve pre-processed datasets and fitted models used in `scvi-tools` tutorials.
```r
library(scviR)

# Get CITE-seq 5k/10k PBMC data (AnnData)
adref <- getCiteseq5k10kPbmcs()

# Get a pre-fitted totalVI model
vae <- getCiteseqTutvae()

# Get denoised RNA and protein quantities
denoised <- getTotalVINormalized5k10k()
```

### 2. Running totalVI in R
For new analyses, `scviR` exposes the `scvi-tools` API. This typically involves using `MuData` for multimodal data.
```r
# Setup MuData for totalVI
mdata1 <- muonR()$read_10x_h5(path_to_h5)

# Preprocessing with scanpy via scviR
scr <- scanpyR()
scr$pp$highly_variable_genes(mdata1$mod["rna"], n_top_genes=4000L, flavor="seurat_v3")

# Initialize and train model
model <- scviR()$model$TOTALVI(mdata1)
model$train(max_epochs=50L)

# Inspect training history
plot(unlist(model$history$elbo_train), type="l")
```

### 3. Integration with SingleCellExperiment
To use Bioconductor tools (e.g., `scater`, `scran`) on `scvi-tools` outputs, wrap the results into a `SingleCellExperiment`.
```r
library(SingleCellExperiment)

# Extract latent space and denoised values from AnnData/MuData
latent <- fullvi$obsm$get("X_totalVI")
denoised_rna <- fullvi$layers$get("denoised_rna")

# Create SCE
sce <- SingleCellExperiment(list(logcounts = t(denoised_rna)))
reducedDims(sce) <- list(totalVI = latent)

# Add protein data as an alternative experiment
altExp(sce, "protein") <- SingleCellExperiment(list(logcounts = t(fullvi$obsm$get("denoised_protein"))))
```

## Tips and Best Practices
- **Memory Management**: Large datasets (e.g., 15k cells) may require significant RAM. Use `options(timeout=3600)` for large downloads.
- **Python Objects**: Objects returned by `scviR()` or `vae` are `python.builtin.object` instances. Access their attributes using the `$` operator (e.g., `vae$is_trained`).
- **Hardware Acceleration**: The package automatically detects GPU/MPS if available. You can specify the accelerator in the `$train()` method (e.g., `accelerator="gpu"` or `accelerator="cpu"`).
- **Basilisks**: `scviR` uses `basilisk` to manage a dedicated Python environment. This ensures version compatibility with `scvi-tools` (typically v1.3.0).

## Reference documentation
- [scvi-tools CITE-seq tutorial in R](./references/citeseq_tut.md)
- [Comparing totalVI and OSCA book CITE-seq analyses](./references/compch12.md)
- [CITE-seq setup for scviR, 2025](./references/new_citeseq.md)
- [scviR: an R package interfacing Bioconductor and scvi-tools](./references/scviR.md)