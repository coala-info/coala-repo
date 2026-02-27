---
name: bioconductor-tricycle
description: This tool infers and visualizes continuous cell cycle positions and stages from single-cell RNA-seq data using transfer learning. Use when user asks to project datasets into a cell cycle space, estimate cell cycle position, or visualize periodic gene expression.
homepage: https://bioconductor.org/packages/release/bioc/html/tricycle.html
---


# bioconductor-tricycle

name: bioconductor-tricycle
description: Infer and visualize cell cycle position and stages from single-cell RNA-seq data using transfer learning. Use this skill to project new datasets into a pre-learned cell cycle space, estimate continuous cell cycle position (0 to 2pi), and visualize results on embeddings or through periodic expression plots.

# bioconductor-tricycle

## Overview
The `tricycle` package provides a robust framework for inferring the cell cycle position of individual cells in single-cell RNA-seq (scRNA-seq) data. It utilizes a transfer learning approach where new data is projected into a pre-learned, biologically interpretable cell cycle space. This method is highly transferable across species (human/mouse), cell types, and technologies (10X, Fluidigm C1). The primary output is a continuous variable $\theta \in [0, 2\pi]$ representing the cell's position in the cycle.

## Core Workflow

### 1. Data Preparation
Input should ideally be a `SingleCellExperiment` object. Data must be library-size normalized (e.g., using `scater::logNormCounts`) before processing.

```r
library(tricycle)
library(scater)

# Assuming sce is your SingleCellExperiment object
# Ensure logcounts assay exists
sce <- logNormCounts(sce)
```

### 2. Projecting and Estimating Position
The `estimate_cycle_position` function is the primary entry point. It handles both the projection into the latent space and the calculation of the cyclic position.

```r
# This adds 'tricyclePosition' to colData and 'tricycleEmbedding' to reducedDims
sce <- estimate_cycle_position(sce, species = "mouse", gname.type = "ENSEMBL")
```

**Key Parameters:**
- `species`: "mouse" (default) or "human".
- `gname.type`: Type of gene IDs (e.g., "SYMBOL", "ENSEMBL").
- `ref.m`: Optional custom reference matrix. If NULL, the pre-learned NeuroRef is used.

### 3. Interpreting Cell Cycle Position ($\theta$)
The position $\theta$ ranges from $0$ to $2\pi$. Approximate stages:
- **0.5$\pi$**: Start of S stage
- **$\pi$**: Start of G2M stage
- **1.5$\pi$**: Middle of M stage
- **1.75$\pi$ - 0.25$\pi$**: G1/G0 stage

### 4. Visualizing Results
`tricycle` provides specialized functions for cyclic data visualization.

**Embedding Plots:**
Use a cyclic color scale to visualize $\theta$ on UMAP, t-SNE, or the tricycle embedding.
```r
library(ggplot2)
library(cowplot)

p <- plot_emb_circle_scale(sce, dimred = "UMAP", point.size = 1)
legend <- circle_scale_legend()
plot_grid(p, legend, ncol = 2, rel_widths = c(1, 0.4))
```

**Periodic Expression Plots:**
Verify the inference by plotting known markers (e.g., *Top2a*, *Smc2*) against the inferred position.
```r
# Fit a periodic loess line
top2a_idx <- which(rowData(sce)$Symbol == "Top2a")
fit <- fit_periodic_loess(sce$tricyclePosition, 
                          assay(sce, "logcounts")[top2a_idx, ], 
                          plot = TRUE, 
                          fig.title = "Top2a Expression")
fit$fig
```

**Density Plots:**
Compare cell cycle distributions across samples or conditions.
```r
plot_ccposition_den(sce$tricyclePosition, sce$sample_id, "Sample")
```

## Alternative: Discrete Stage Prediction
While continuous position is preferred, you can predict 5 discrete stages (G1.S, S, G2, G2.M, M.G1) using a modified Schwabe et al. method.

```r
sce <- estimate_Schwabe_stage(sce, species = "mouse", gname.type = "ENSEMBL")
# Adds 'CCStage' to colData
```

## Custom References
For specialized datasets, you can build a new reference using PCA on GO cell cycle genes.
```r
# Run PCA on GO:0007049 genes
gocc_sce <- run_pca_cc_genes(sce, species = "mouse")
# Extract rotation matrix for top 2 PCs
new_ref <- attr(reducedDim(gocc_sce, "PCA"), "rotation")[, 1:2]
# Use this reference for estimation
sce <- estimate_cycle_position(sce, ref.m = new_ref)
```

## Tips and Best Practices
- **Gene Mapping**: If gene IDs don't match the reference, ensure you provide the correct `AnnotationDb` (e.g., `org.Mm.eg.db`) to `project_cycle_space`.
- **Circular Correlation**: When comparing two cyclic variables, use `CircStats::circ.cor` instead of standard Pearson correlation.
- **Batch Effects**: If building a custom reference from multiple batches, perform batch correction (e.g., using Seurat or MNN) on the expression matrix before running PCA to define the reference.

## Reference documentation
- [tricycle: Transferable Representation and Inference of Cell Cycle](./references/tricycle.md)
- [tricycle Vignette Source](./references/tricycle.Rmd)