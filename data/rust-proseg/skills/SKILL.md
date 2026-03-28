---
name: rust-proseg
description: rust-proseg is a high-performance tool that uses probabilistic sampling to refine cell segmentation and transcript assignment in spatial transcriptomics. Use when user asks to perform cell segmentation, refine transcript assignments from spatial platforms like Xenium or MERSCOPE, or generate count matrices from spatial data.
homepage: https://github.com/dcjones/proseg
---

# rust-proseg

## Overview

rust-proseg is a high-performance tool designed to improve the accuracy of cell segmentation in spatial transcriptomics. Unlike traditional image-based methods that may struggle with overlapping cells or transcript diffusion, proseg uses a probabilistic sampling approach to model the spatial distribution of transcripts. It relies on an initial prior segmentation (often from nuclei staining) and refines the assignment of transcripts to specific cells. It is particularly effective at reducing spurious coexpression and is optimized for large-scale datasets, providing outputs compatible with the Python SpatialData ecosystem.

## Common CLI Patterns

### Platform Presets
The most efficient way to run proseg is using built-in presets that configure column names and parameters for specific platforms:

*   **Xenium**: `proseg --xenium transcripts.parquet`
*   **CosMx**: `proseg --cosmx transcripts.csv.gz`
*   **MERSCOPE**: `proseg --merscope detected_transcripts.csv.gz`
*   **Visium HD**: `proseg --visiumhd transcripts.parquet`

### Initializing with External Masks
If you have high-quality image-based segmentation (e.g., from Cellpose), you can use it to initialize the cell locations:
`proseg --xenium --cellpose-masks masks.tif transcripts.parquet`

To include a second auxiliary mask for fixed boundaries that proseg should not modify:
`proseg --xenium --cellpose-masks-fixed fixed_boundaries.tif transcripts.parquet`

### Controlling the Sampling Process
Proseg is a non-deterministic sampling method. You can tune the resolution and duration of the sampling:
*   **Iterations**: Use `--burnin-samples` and `--samples` to control the number of MCMC iterations.
*   **Resolution**: Use `--voxel-size` (in microns) to set the x/y grid size. Note that `--burnin-voxel-size` must be an integer multiple of the final voxel size.
*   **Z-axis**: Control vertical stacking with `--voxel-layers`.

### Output Management
By default, Proseg 3 outputs a SpatialData Zarr directory.
*   **Sparse Matrices**: To generate traditional count matrices, use `--output-mtx`.
*   **Polygons**: Generate non-overlapping consensus polygons with `--output-cell-polygons`.
*   **Baysor Compatibility**: Use the companion tool `proseg-to-baysor` to convert outputs for use in downstream pipelines expecting Baysor formats.

## Expert Tips and Best Practices

*   **Cell Compactness**: Use the `--cell-compactness` argument to influence cell shape. Smaller values lead to more compact, circular cells, which can prevent "bleeding" in low-density transcript regions.
*   **Handling Background**: If you have specific cells that should be excluded from the background model to improve signal-to-noise ratios, use the `--unmodeled-fixed-cells` flag.
*   **Memory Optimization**: Proseg 3 is significantly more memory-efficient than previous versions. If working with extremely large gene panels (e.g., Xenium Prime), ensure you are using at least v3.1.0, which includes optimized sparse matrix structures and parallelized loops.
*   **Low Transcript Warning**: Be aware that cells with very few observed transcripts will have unreliable boundaries. Proseg refines existing cells but does not "discover" new cells that were entirely missed by the prior segmentation.
*   **R Integration**: Since the default output is Zarr, R users should use Python to convert the AnnData component to `.h5ad` before reading it into R via `zellkonverter`.



## Subcommands

| Command | Description |
|---------|-------------|
| proseg | High-speed cell segmentation of transcript-resolution spatial transcriptomics data. |
| proseg-to-baysor | Convert proseg output to Baysor-compatible output. |

## Reference documentation

- [Proseg README](./references/github_com_dcjones_proseg_blob_main_README.md)
- [Proseg Changelog and Migration Guide](./references/github_com_dcjones_proseg_blob_main_CHANGES.md)