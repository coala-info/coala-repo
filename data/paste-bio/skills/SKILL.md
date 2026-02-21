---
name: paste-bio
description: PASTE (Probabilistic Alignment of Spatial Transcriptomics Experiments) is a computational method that leverages both gene expression similarity and spatial distances between spots to align and integrate spatial transcriptomics data.
homepage: https://github.com/raphael-group/paste
---

# paste-bio

## Overview
PASTE (Probabilistic Alignment of Spatial Transcriptomics Experiments) is a computational method that leverages both gene expression similarity and spatial distances between spots to align and integrate spatial transcriptomics data. It is designed to solve two primary problems: mapping spots between two different tissue sections (Pairwise Alignment) and merging multiple sections into a single representative consensus layer (Center Alignment). It is particularly effective when working with AnnData objects and integrates well with the scanpy/squidpy ecosystem.

## Core Workflows

### 1. Pairwise Alignment
Use this to find a mapping between spots of two different slices.
*   **Function**: `pst.pairwise_align(slice1, slice2)`
*   **Output**: A transport plan (matrix) where entry $(i, j)$ represents the probability that spot $i$ in slice 1 and spot $j$ in slice 2 are the same biological location.
*   **Visualization**: Use `pst.stack_slices_pairwise(slices, pis)` to transform coordinates based on the alignment for plotting.

### 2. Center Alignment
Use this to integrate multiple slices into one "center" slice that represents a biological consensus.
*   **Function**: `pst.center_align(initial_slice, slices, lmbda)`
*   **Parameters**: `lmbda` is a vector of weights for each slice (should sum to 1).
*   **Output**: A new AnnData object representing the center slice, with low-dimensional representations stored in `.uns['paste_W']` and `.uns['paste_H']`.

## Command Line Interface (CLI) Patterns
The tool can be executed directly via `paste-cmd-line.py`. You must provide pairs of files: the gene expression CSV followed by the spatial coordinates CSV for each slice.

**Pairwise Mode:**
```bash
python paste-cmd-line.py -m pairwise -f slice1.csv slice1_coor.csv slice2.csv slice2_coor.csv -a 0.1 -c kl
```

**Center Mode:**
```bash
python paste-cmd-line.py -m center -f slice1.csv slice1_coor.csv slice2.csv slice2_coor.csv slice3.csv slice3_coor.csv -p 15 -t 0.001
```

### Key CLI Flags:
*   `-a` (alpha): Trade-off between expression similarity and spatial distance (default 0.1).
*   `-c` (cost): Dissimilarity metric, either `kl` (Kullback-Leibler) or `euclidean`.
*   `-p` (n_components): Number of components for NMF in center alignment.
*   `-x`: Toggle to output new coordinates.

## Expert Tips and Best Practices

### Parameter Tuning
*   **Alpha ($\alpha$):** This is the most critical hyperparameter. A higher $\alpha$ (closer to 1) prioritizes gene expression similarity, while a lower $\alpha$ (closer to 0) prioritizes preserving spatial distances. If slices are from the same tissue but have high technical noise, decrease $\alpha$.
*   **Cost Metric:** Use `kl` for count-based data (standard for ST) and `euclidean` for normalized/log-transformed data.

### Performance Optimization
*   **GPU Acceleration:** For large datasets, enable the Pytorch backend.
    ```python
    import ot
    pi12 = pst.pairwise_align(slice1, slice2, backend=ot.backend.TorchBackend(), use_gpu=True)
    ```
*   **Data Preprocessing:** Always filter genes and cells before alignment to reduce the feature space and noise.
    ```python
    sc.pp.filter_genes(slice, min_counts=15)
    sc.pp.filter_cells(slice, min_counts=100)
    ```

### Data Handling
*   **Coordinate Mapping:** PASTE expects spatial coordinates to be stored in `adata.obsm['spatial']`.
*   **Common Genes:** When aligning different slices, PASTE automatically looks for common genes. Ensure your gene naming conventions are consistent across all AnnData objects.

## Reference documentation
- [PASTE GitHub Repository](./references/github_com_raphael-group_paste.md)
- [Bioconda paste-bio Overview](./references/anaconda_org_channels_bioconda_packages_paste-bio_overview.md)