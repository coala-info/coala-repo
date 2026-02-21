---
name: rust-proseg
description: `rust-proseg` is a high-performance tool designed to improve the accuracy of cell segmentation in spatial transcriptomics.
homepage: https://github.com/dcjones/proseg
---

# rust-proseg

## Overview
`rust-proseg` is a high-performance tool designed to improve the accuracy of cell segmentation in spatial transcriptomics. Unlike traditional image-only methods, it uses the spatial distribution of transcripts to probabilistically assign them to cells. It is particularly effective at reducing spurious coexpression and refining boundaries in dense tissue. The tool supports modern spatial formats and outputs results in the SpatialData Zarr format, making it compatible with the Python spatial analysis ecosystem.

## Installation
The tool can be installed via Conda or Cargo:
- **Conda**: `conda install bioconda::rust-proseg`
- **Cargo**: `cargo install proseg`

## Common CLI Patterns

### Using Platform Presets
Proseg includes presets that automatically configure column names and parameters for specific platforms.
- **Xenium**: `proseg --xenium transcripts.csv.gz`
- **CosMx**: `proseg --cosmx transcripts.csv.gz`
- **MERSCOPE**: `proseg --merfish transcripts.csv.gz`
- **Visium HD**: `proseg --visiumhd transcripts.csv.gz`

### Standard Output Configuration
By default, Proseg 3 outputs a SpatialData Zarr directory.
```bash
proseg --xenium --output-spatialdata output.zarr --nthreads 16 transcripts.csv.gz
```

### Manual Table Mapping
If using a custom CSV format, specify the coordinate and gene columns:
```bash
proseg --x-col x_location --y-col y_location --gene-col gene_name --cell-col initial_cell_id transcripts.csv
```

## Expert Tips and Best Practices

### Model Tuning
- **Cell Compactness**: Use `--cell-compactness <VALUE>` to control cell shape. Smaller values result in more circular/compact cells, while larger values allow for more irregular boundaries.
- **Voxel Resolution**: The sampling resolution is controlled by `--voxel-size` (in microns). For the burn-in phase, `--burnin-voxel-size` must be an integer multiple of the final voxel size.
- **3D Modeling**: For thick sections, use `--voxel-layers <N>` to model cells across multiple Z-axis layers.

### Performance Optimization
- **Threading**: Proseg uses all available cores by default. On shared systems, always limit this using `--nthreads <N>`.
- **Memory Management**: If the dataset is extremely large, you can exclude transcript positions from the final Zarr output to save space using `--exclude-spatialdata-transcripts`.

### Handling Non-Determinism
Proseg is a sampling-based method and is inherently non-deterministic. While results are generally stable, expect slight variations between runs. For critical reproducibility, ensure you document the version and parameters used.

### Downstream Integration
- **Python**: Load the output using `spatialdata.read_zarr("output.zarr")`.
- **R**: Convert the AnnData component of the Zarr to `.h5ad` in Python first, then use `zellkonverter` to read it into an R environment.
- **Baysor**: Use the `proseg-to-baysor` command to convert Proseg Zarr directories for use with Baysor workflows.

## Reference documentation
- [github_com_dcjones_proseg.md](./references/github_com_dcjones_proseg.md)
- [anaconda_org_channels_bioconda_packages_rust-proseg_overview.md](./references/anaconda_org_channels_bioconda_packages_rust-proseg_overview.md)