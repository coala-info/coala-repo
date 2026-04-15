---
name: radiantkit
description: radiantkit is a Python-based toolkit for the quantitative analysis of YFISH images to study the radial organization of chromatin within the cell nucleus. Use when user asks to convert microscopy formats, perform nuclear segmentation, or calculate spatial metrics from imaging data.
homepage: https://github.com/bicrolab/radiantkit
metadata:
  docker_image: "quay.io/biocontainers/radiantkit:0.1.0--pyhdfd78af_1"
---

# radiantkit

## Overview
`radiantkit` is a specialized Python-based toolkit designed for the quantitative analysis of YFISH images to reveal the radial organization of chromatin within the cell nucleus. It provides a pipeline for converting raw microscopy formats, performing nuclear segmentation, and calculating spatial metrics. This skill helps navigate the transition from raw imaging data to structured biological insights by providing the correct command-line patterns and configuration logic for different imaging modalities.

## Core Workflow and CLI Patterns

### 1. Data Preparation
The pipeline prefers channel-separated `.tif` or `.tiff` files. If starting with Nikon `.nd2` files, the first step is conversion.
- **Input Organization**: Store all raw images in a single directory.
- **Deconvolution**: For widefield microscopy data, images must be deconvolved (e.g., using `deconwolf`) before processing with `radiantkit` to ensure segmentation accuracy.

### 2. Segmentation Strategy
Choosing between 2D and 3D segmentation is critical for data integrity:
- **2D Segmentation**: Recommended for nuclei that are not uniformly shaped or are significantly flattened.
- **3D Segmentation**: Preferred for round, uniformly shaped nuclei where volumetric spatial distribution is the primary metric.

### 3. SLURM Integration
For high-throughput processing, `radiantkit` is typically deployed via SLURM. A standard execution involves:
- Cloning the repository to access the environment definition.
- Creating the environment: `conda env create -f radiant-kit-env.yml`.
- Customizing the `radiantK_SLURM_jobscript.sh` with specific imaging parameters (pixel size, channel names, etc.) before submission via `sbatch`.

## Expert Tips
- **Channel Separation**: Ensure your `.tif` files are properly labeled by channel, as the pipeline relies on specific channel identifiers to distinguish between nuclear markers (DAPI) and FISH signals.
- **Hardware Compatibility**: While the package is `noarch`, image processing is memory-intensive; ensure SLURM allocations provide sufficient RAM for 3D volumetric reconstructions.
- **Version Control**: This version is a fork maintained by BiCroLab to ensure compatibility with modern Python versions; always check the `CHANGELOG` if migrating from the original `ggirelli/radiantkit` repository.

## Reference documentation
- [BiCroLab radiantkit Repository](./references/github_com_BiCroLab_radiantkit.md)
- [Radiantkit Overview and Installation](./references/anaconda_org_channels_bioconda_packages_radiantkit_overview.md)