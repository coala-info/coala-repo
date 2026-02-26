---
name: squidpy
description: Squidpy is a Python-based framework for analyzing and visualizing spatial single-cell data by extending the anndata and scanpy ecosystem. Use when user asks to build spatial neighbor graphs, calculate spatial statistics like Moran's I, identify neighborhood enrichment, or extract features from tissue images.
homepage: https://github.com/scverse/squidpy
---


# squidpy

## Overview

Squidpy is a Python-based framework designed for the analysis and visualization of spatial single-cell data. It extends the `anndata` and `scanpy` ecosystem by providing specialized tools for the spatial domain. Use this skill to characterize the spatial organization of tissues, identify cellular niches, and integrate microscopy images with molecular profiles. It is particularly effective for workflows involving spatial neighbor graphs, co-occurrence metrics, and image-based feature extraction.

## Core Usage Patterns

Squidpy is organized into three primary modules: `gr` (graph), `im` (image), and `pl` (plotting).

### Spatial Graph Analysis (`sq.gr`)

The foundation of most spatial analyses is the spatial neighbor graph.

*   **Building Graphs**: Use `sq.gr.spatial_neighbors()` to define connectivity.
    *   For Visium (hexagonal grid): `sq.gr.spatial_neighbors(adata, coord_type="grid", n_neighs=6)`
    *   For single-cell resolution (Xenium/Merfish): `sq.gr.spatial_neighbors(adata, coord_type="generic")`
*   **Spatial Statistics**:
    *   **Global Autocorrelation**: Calculate Moran's I or Geary's C to find spatially variable genes: `sq.gr.spatial_autocorr(adata, mode="moran")`.
    *   **Neighborhood Enrichment**: Identify which cell types are found near each other: `sq.gr.nhood_enrichment(adata, cluster_key="cell_type")`.
    *   **Co-occurrence**: Calculate the probability of seeing cell type B at a specific distance from cell type A: `sq.gr.co_occurrence(adata, cluster_key="cell_type")`.

### Image Processing (`sq.im`)

Squidpy handles large tissue images via the `ImageContainer` object, which allows for memory-efficient tiling and processing.

*   **Loading Images**: `img = sq.im.ImageContainer("path/to/image.tif")`.
*   **Feature Extraction**: Extract features (e.g., summary statistics, texture, or deep learning features) from image crops corresponding to spatial observations: `sq.im.calculate_image_features(adata, img)`.
*   **Segmentation**: Use `sq.im.segment()` to define cell boundaries if nuclei stains are available.

### Visualization (`sq.pl`)

*   **Spatial Scatter**: Plot gene expression or clusters in spatial coordinates: `sq.pl.spatial_scatter(adata, color="gene_or_cluster")`.
*   **Interactive Exploration**: For large datasets or image-heavy workflows, use the napari integration: `sq.pl.interactive(adata, img)`.

## Expert Tips

*   **Coordinate Systems**: Always verify that your `adata.obsm['spatial']` coordinates match the orientation of your tissue image.
*   **Parallelization**: Many functions in `sq.gr` and `sq.im` support a `n_jobs` parameter. Use it to speed up computation on large datasets.
*   **Filtering**: Use `sq.pp.filter_cells()` (experimental in some versions) or standard scanpy filtering before building spatial graphs to remove low-quality observations that might distort neighborhood statistics.
*   **Niche Analysis**: Combine `sq.gr.spatial_neighbors` with clustering (like Leiden) on the resulting connectivity matrix to identify "spatial niches" or tissue domains.

## Reference documentation

- [Squidpy README](./references/github_com_scverse_squidpy.md)
- [Squidpy Issues (Functional details)](./references/github_com_scverse_squidpy_issues.md)
- [Squidpy Pull Requests (New features)](./references/github_com_scverse_squidpy_pulls.md)