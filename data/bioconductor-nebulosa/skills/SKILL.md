---
name: bioconductor-nebulosa
description: Nebulosa uses weighted kernel density estimation to visualize gene expression and address sparsity in single-cell data. Use when user asks to visualize gene expression density, recover signal from dropout genes, or identify cell populations using joint density of multiple markers.
homepage: https://bioconductor.org/packages/release/bioc/html/Nebulosa.html
---


# bioconductor-nebulosa

## Overview

Nebulosa is an R package designed to address the sparsity (dropout) common in single-cell data. It uses weighted kernel density estimation to "convolve" gene expression across similar cells, providing a smoother and often more accurate representation of where a gene is expressed compared to standard scatter plots. It is particularly effective for visualizing genes with high dropout rates and for identifying cell populations based on the joint density of multiple markers.

## Core Workflow

### 1. Installation and Loading
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Nebulosa")

library(Nebulosa)
library(Seurat) # or library(scater) for SingleCellExperiment
```

### 2. Basic Density Plotting
The primary function is `plot_density`. It works seamlessly with both `Seurat` and `SingleCellExperiment` objects.

```r
# For a single gene
plot_density(object, "CD4")

# For multiple genes (returns a grid of plots)
plot_density(object, c("CD4", "CD3D"))
```

### 3. Multi-feature Joint Density
To visualize where multiple genes are co-expressed, use the `joint = TRUE` parameter. This calculates the joint density by multiplying the individual densities.

```r
# Visualize individual densities and the joint density
plot_density(object, c("CD8A", "CCR7"), joint = TRUE)

# To get only the joint density plot (the last one in the list)
p_list <- plot_density(object, c("CD8A", "CCR7"), joint = TRUE, combine = FALSE)
p_list[[length(p_list)]]
```

### 4. Customizing Output
Nebulosa returns `ggplot` objects, which can be modified using `ggplot2` or `patchwork`.

```r
library(patchwork)
p <- plot_density(object, c("CD4", "CCR7"), joint = TRUE)
p + plot_layout(ncol = 1)
```

## Usage Tips

- **When to use**: Nebulosa is most beneficial for genes with high dropout (e.g., transcription factors or specific surface markers like CD4 in T cells). For very highly expressed genes, standard `FeaturePlot` or `plotUMAP` may be sufficient.
- **Object Compatibility**:
    - **Seurat**: Ensure the object has a default assay (RNA or SCT) and a dimensional reduction (UMAP or TSNE) already computed.
    - **SingleCellExperiment**: Ensure the object has `logcounts` and a reduced dimension slot (e.g., "UMAP").
- **Method Comparison**: It is often helpful to compare `plot_density(obj, "Gene")` with `FeaturePlot(obj, "Gene")` to see how much signal recovery is occurring.
- **Joint Density**: Use `joint = TRUE` to identify specific sub-populations, such as Naive T cells (CD4+CCR7+) or specific myeloid subsets, where individual markers might be too sparse to show clear overlap in standard plots.

## Reference documentation

- [Visualization of gene expression with Nebulosa](./references/introduction.md)
- [Visualization of gene expression with Nebulosa (in Seurat)](./references/nebulosa_seurat.md)