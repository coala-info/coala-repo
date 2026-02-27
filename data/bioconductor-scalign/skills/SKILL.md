---
name: bioconductor-scalign
description: scAlign is a deep learning framework for aligning and integrating heterogeneous single-cell RNA-seq datasets across different platforms, batches, or conditions. Use when user asks to integrate single-cell datasets, learn a joint low-dimensional embedding space, or transfer cell type labels from a reference to a query dataset.
homepage: https://bioconductor.org/packages/3.9/bioc/html/scAlign.html
---


# bioconductor-scalign

name: bioconductor-scalign
description: A tool for aligning single-cell RNA-seq datasets across different platforms, batches, or conditions using a deep learning-based approach. Use this skill when you need to perform unsupervised or supervised alignment of single-cell data, learn a joint low-dimensional embedding space, or transfer labels (cell types/states) from a reference dataset to a query dataset.

# bioconductor-scalign

## Overview

scAlign is a deep learning framework designed to integrate heterogeneous single-cell RNA-seq datasets. It maps cells from different conditions (e.g., different technologies like CEL-seq and SORT-seq, or different time points) into a common, low-dimensional alignment space. This allows for downstream analysis such as clustering and differential expression on the combined data, regardless of the original batch or platform.

## Installation

The package requires `BiocManager` for installation and a working `tensorflow` environment.

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scAlign")

# Ensure TensorFlow is configured (requires Python 3.6-3.8)
library(tensorflow)
# install_tensorflow() # Run if tensorflow is not already installed
```

## Typical Workflow

### 1. Data Preparation
scAlign works with `SingleCellExperiment` objects. Data should be normalized and scaled before creating the scAlign object.

```r
library(scAlign)
library(SingleCellExperiment)

# Create SCE objects for each batch
sce_batch1 <- SingleCellExperiment(assays = list(scale.data = matrix_batch1))
sce_batch2 <- SingleCellExperiment(assays = list(scale.data = matrix_batch2))

# Build the scAlign object
scAlignObj = scAlignCreateObject(
    sce.objects = list("Batch1" = sce_batch1, "Batch2" = sce_batch2),
    labels = list(labels_batch1, labels_batch2),
    data.use = "scale.data",
    pca.reduce = FALSE,
    cca.reduce = TRUE,
    ccs.compute = 5,
    project.name = "scAlign_Integration"
)
```

### 2. Running Alignment
The `scAlign` function performs the actual integration. You can choose to run the encoder (to get embeddings) or the decoder (to project data between conditions).

```r
scAlignObj = scAlign(
    scAlignObj,
    options = scAlignOptions(
        steps = 1000,
        log.every = 100,
        norm = TRUE,
        early.stop = TRUE
    ),
    encoder.data = "scale.data", # or "CCA" if cca.reduce was TRUE
    supervised = 'none',         # 'none' for unsupervised alignment
    run.encoder = TRUE,
    run.decoder = FALSE,
    device = "CPU"               # Use "GPU" if available
)
```

### 3. Visualization and Analysis
Use the built-in plotting functions to visualize the alignment in reduced dimensions (t-SNE).

```r
# Plot the aligned data
plot_tsne = PlotTSNE(
    scAlignObj,
    "ALIGNED-GENE",
    title = "scAlign Aligned Space",
    perplexity = 30
)
print(plot_tsne)
```

## Key Functions and Parameters

- `scAlignCreateObject()`: Initializes the alignment object. Use `cca.reduce = TRUE` to use Canonical Correlation Analysis as a preprocessing step for high-dimensional data.
- `scAlignOptions()`: Sets hyperparameters. `steps` defines training iterations; `early.stop` helps prevent overfitting.
- `scAlign()`: The main execution function. 
    - `encoder.data`: Specifies which assay or reduction to use as input.
    - `supervised`: Set to 'none' for unsupervised, or provide labels for supervised alignment to improve cell type separation.
- `PlotTSNE()`: A wrapper for t-SNE visualization specifically for scAlign objects.

## Tips for Success

- **Python Environment**: Since scAlign relies on TensorFlow, ensure your R session can find a valid Python installation with `tensorflow` installed. Use `reticulate::use_python()` if necessary.
- **Data Representation**: While scAlign can run on raw gene counts, it is often more efficient to run it on dimensionality-reduced data like CCA or PCA scores (set in `scAlignCreateObject`).
- **Device Selection**: For large datasets, setting `device = "GPU"` in the `scAlign` function significantly speeds up the training process.

## Reference documentation

- [scAlign](./references/scAlign.md)