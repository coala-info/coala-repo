---
name: bioconductor-scannotatr.models
description: This package provides pre-trained classification models for automated cell type annotation of human single-cell RNA-sequencing data. Use when user asks to load pre-trained classifiers, inspect marker genes for specific cell types, or prepare models for classifying cells in Seurat or SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/data/annotation/html/scAnnotatR.models.html
---


# bioconductor-scannotatr.models

name: bioconductor-scannotatr.models
description: Provides pre-trained cell type classification models for human immune and non-immune cells. Use this skill when you need to load, inspect, or apply standardized classification models for single-cell RNA-sequencing data (Seurat or SingleCellExperiment objects) using the scAnnotatR framework.

# bioconductor-scannotatr.models

## Overview

The `scAnnotatR.models` package is a data-only Bioconductor package that serves as a repository for pre-trained S4 `scAnnotatR` classification models. These models are primarily used to automate cell type annotation in human scRNA-seq datasets. The package includes classifiers for a wide range of cells, including B cells, T cells, NK cells, Monocytes, Endothelial cells, and various organ-specific cells (e.g., pancreatic alpha/beta cells).

## Loading Models

Models are stored in `AnnotationHub`. While `scAnnotatR` usually loads them automatically, you can access them manually for inspection or custom workflows.

### Manual Loading via AnnotationHub
```r
library(AnnotationHub)
eh <- AnnotationHub()
# Query for the specific package
query_res <- query(eh, "scAnnotatR.models")
# Retrieve the models (typically AH95906)
models <- query_res[["AH95906"]]
```

### Loading via scAnnotatR
The preferred way to access these models within an active analysis session is using the `scAnnotatR` helper function:
```r
library(scAnnotatR)
default_models <- load_models("default")
```

## Inspecting Available Models

The models are returned as a named list. You can check which cell types are available and inspect the underlying marker genes for any specific classifier.

```r
# List all available cell types
names(default_models)

# Inspect a specific model (e.g., B cells)
b_cell_model <- default_models[["B cells"]]
print(b_cell_model)
```

When printing a model object, you will see:
- The number of marker genes used.
- The specific gene symbols (e.g., CD19, MS4A1 for B cells).
- The probability threshold (default is usually 0.5).
- Whether it has a parent model (hierarchical classification).

## Typical Workflow

1. **Prepare Data**: Ensure your data is in a `Seurat` or `SingleCellExperiment` object.
2. **Load Models**: Use `load_models("default")`.
3. **Classify**: Use the `classify_cells` function from the `scAnnotatR` package (which utilizes these models).

```r
library(scAnnotatR)
# Load models from this package
models <- load_models("default")

# Apply a specific model to a Seurat object
# seurat_obj <- classify_cells(seurat_obj, model = models[["T cells"]])
```

## Available Cell Types
The package includes models for:
- **Immune**: B cells, Plasma cells, NK (CD16/CD56), T cells (CD4, CD8, Treg, NKT), ILC, Monocytes (CD14/CD16), DC, pDC, Mast cells.
- **Structural/Other**: Endothelial cells (LEC, VEC), Platelets, RBC, Melanocytes, Schwann cells, Pericytes, Keratinocytes, Fibroblasts.
- **Pancreatic**: alpha, beta, delta, gamma, acinar, ductal.

## Reference documentation

- [Introduction to scAnnotatR.models](./references/introduction.md)