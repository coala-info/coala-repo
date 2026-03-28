---
name: minc-tools
description: minc-tools provides a suite of command-line utilities for the analysis, manipulation, and spatial normalization of N-dimensional medical imaging data. Use when user asks to convert imaging formats, resample volumes, perform voxel-wise arithmetic, correct intensity non-uniformity, or register images to stereotaxic space.
homepage: https://github.com/BIC-MNI/minc
---


# minc-tools

## Overview

The MINC (Medical Imaging NetCDF) ecosystem is a comprehensive suite of tools designed for the analysis of N-dimensional medical imaging data, such as MRI, PET, and CT scans. This skill enables the efficient use of the MINC command-line interface (CLI) to perform complex neuroimaging tasks. It covers the transition from raw data to processed volumes, including spatial normalization to standard atlases (like ICBM152), non-linear fitting, and voxel-based math operations.

## Core Command-Line Utilities

### Volume Manipulation and Conversion
*   **rawtominc / minctoraw**: Convert between raw binary data and MINC format.
*   **mincresample**: Resample a volume along specific dimensions or into a new coordinate space using a transformation file (.xfm).
*   **mincreshape**: Change the dimension ordering or extract slices from a volume.
*   **mincconcat**: Concatenate multiple MINC files into a higher-dimensional volume (e.g., combining 3D volumes into a 4D time series).
*   **mincmath**: Perform voxel-wise arithmetic (addition, subtraction, multiplication) across multiple volumes.

### Spatial Normalization and Registration
*   **mritotal**: Automatically register an MRI volume to the standard Talairach/MNI stereotaxic space.
*   **minctracc**: The core engine for estimating linear and non-linear transformations between two volumes.
*   **volrot**: Rotate a volume about its center.
    *   *Example*: `volrot -x_rotation 90 input.mnc output.mnc`
*   **nlpfit**: Perform hierarchical non-linear fitting using progressively finer grids (e.g., 16mm, 8mm, 4mm steps).

### Image Enhancement and Analysis
*   **N3 (nu_correct)**: Corrects for intensity non-uniformity (bias field) in MRI data. This is typically the essential first step in any pipeline.
*   **classify**: Perform tissue segmentation to separate a volume into white matter, gray matter, and CSF.
*   **minclookup**: Apply color lookup tables (LUTs) to volumes for visualization.

## Expert Tips and Best Practices

### Coordinate Systems
Always distinguish between **Voxel Coordinates** (indices in the data array) and **World Coordinates** (real-world millimeter space). MINC tools use the header information to map voxels to world space automatically. When resampling, ensure your transformation file (.xfm) correctly maps the source world space to the target world space.

### MINC1 vs. MINC2
*   **MINC1**: Based on NetCDF; limited by file size (2GB-4GB).
*   **MINC2**: Based on HDF5; supports multi-gigabyte datasets and internal compression.
*   Most modern tools are backward compatible, but libraries like `RMINC` or `pyminc` may require MINC2 format. Use `mincconvert` to upgrade files if you encounter "large file" errors.

### Non-Linear Fitting (nlpfit)
When using `nlpfit`, you can customize the fitting hierarchy by providing a configuration file. This prevents the algorithm from falling into local minima by blurring the volumes with progressively smaller FWHM (Full Width at Half Maximum) kernels at each step.

### Voxel Ranges
When using `minclookup` for visualization, ensure your input file has a symmetric range (e.g., -x to x) if using double-ended lookup tables to ensure the zero-point aligns with the center of your color map.



## Subcommands

| Command | Description |
|---------|-------------|
| minc_modify_header | Modify the header of a MINC file. (Note: The provided help text contained container execution errors; arguments are based on standard tool documentation). |
| mincmath | Perform simple arithmetic operations on MINC files (e.g., addition, subtraction, multiplication, division). |

## Reference documentation
- [MINC Introduction](./references/en_wikibooks_org_wiki_MINC_Introduction.md)
- [MINC Scripts (volrot, nlpfit)](./references/en_wikibooks_org_wiki_MINC_Scripts.md)
- [MINC History and Tool Justification](./references/en_wikibooks_org_wiki_MINC_History.md)
- [MINC Atlases](./references/en_wikibooks_org_wiki_MINC_Atlases.md)