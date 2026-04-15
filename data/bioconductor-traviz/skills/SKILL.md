---
name: bioconductor-traviz
description: bioconductor-traviz visualizes single-cell trajectories and gene expression trends along pseudotime. Use when user asks to plot lineage curves on reduced dimensionality embeddings, visualize smooth gene expression dynamics, or overlay trajectory paths onto cell scatter plots.
homepage: https://bioconductor.org/packages/release/bioc/html/traviz.html
---

# bioconductor-traviz

name: bioconductor-traviz
description: Visualization of single-cell trajectories and gene expression along pseudotime. Use this skill when you need to plot lineage curves on reduced dimensionality embeddings (UMAP, t-SNE) or visualize smooth gene expression trends across trajectories inferred by methods like Slingshot.

# bioconductor-traviz

## Overview
`traviz` is a Bioconductor package designed for the visualization of trajectories in single-cell data. It provides a streamlined interface for overlaying smooth trajectory curves onto cell embeddings and visualizing how gene expression changes along pseudotime. It is particularly compatible with `SingleCellExperiment` objects and trajectory inference outputs from packages like `Slingshot`.

## Typical Workflow

1.  **Data Preparation**: Start with a `SingleCellExperiment` (SCE) object that contains dimensionality reduction results (e.g., UMAP) and a trajectory object (e.g., a `SlingshotDataSet`).
2.  **Trajectory Visualization**: Use `plot_trajectory()` to overlay the paths onto the cell scatter plot.
3.  **Expression Profiling**: Use `plot_smooth_expression()` to visualize the dynamics of specific genes of interest along the inferred lineages.

## Main Functions

### plot_trajectory()
Visualizes the trajectory curves on a 2D embedding.
- **Usage**: `plot_trajectory(sce, trajectory, reducedDim = "UMAP", color_by = "cluster")`
- **Key Arguments**:
    - `sce`: The SingleCellExperiment object.
    - `trajectory`: The trajectory object (e.g., SlingshotDataSet).
    - `reducedDim`: The name of the dimensionality reduction to use.
    - `color_by`: Metadata column to color the cells.

### plot_smooth_expression()
Plots the smoothed expression trend of a gene along pseudotime.
- **Usage**: `plot_smooth_expression(sce, gene, trajectory, lineage = 1)`
- **Key Arguments**:
    - `gene`: The name or index of the gene to plot.
    - `lineage`: The specific lineage/path to visualize if multiple exist.
    - `n_points`: Number of points for the smoothing interpolation.

### get_trajectory_coords()
A utility function to extract the coordinates of the trajectory curves for custom `ggplot2` layers.

## Tips for Usage
- **Object Compatibility**: While designed for `SingleCellExperiment`, ensure that the trajectory object and the SCE object share the same cell identifiers and dimensionality reduction coordinates.
- **Customization**: Most `traviz` plotting functions return `ggplot` objects. You can extend them using standard `ggplot2` functions like `+ theme_bw()` or `+ scale_color_viridis_d()`.
- **Multiple Lineages**: If your trajectory has multiple branches, use the `lineages` or `lineage` arguments to avoid visual clutter and focus on specific biological transitions.

## Reference documentation
- [traviz Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/traviz.html)