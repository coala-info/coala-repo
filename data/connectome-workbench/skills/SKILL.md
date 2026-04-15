---
name: connectome-workbench
description: Connectome Workbench is a neuroimaging analysis suite for processing and visualizing surface-based and volumetric brain data. Use when user asks to perform surface smoothing, resample mesh densities, map volume data to surfaces, or manipulate CIFTI and GIFTI files.
homepage: https://www.humanconnectome.org/software/connectome-workbench
metadata:
  docker_image: "quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0"
---

# connectome-workbench

## Overview
The Connectome Workbench is a specialized suite for neuroimaging analysis that bridges the gap between volumetric (3D) and surface-based (2D) brain data. This skill provides guidance on using the `wb_command` interface to perform algorithmic tasks such as surface smoothing, resampling, and data conversion. It is particularly useful for researchers working with HCP-style data who need to manipulate "grayordinates"—a coordinate system combining cortical surface vertices and subcortical volume voxels.

## Command Line Best Practices
The primary interface for automated processing is `wb_command`. Follow these patterns for efficient usage:

### Core Command Structure
Most commands follow a verbose but descriptive syntax:
`wb_command -<category>-<action> <input> <parameters> <output>`

### Common CLI Patterns
- **Information Gathering**: Use `-file-information` to inspect CIFTI (.d*.nii), GIFTI (.surf.gii, .func.gii), or NIFTI files to verify dimensions and mapping types before processing.
- **Surface Resampling**: When moving data between different mesh densities (e.g., from 164k to 32k vertices), use `-surface-resample`.
- **Metric Smoothing**: Use `-metric-smoothing` for surface-based spatial smoothing, which avoids the "bleeding" across sulci common in volumetric smoothing.
- **Volume to Surface Mapping**: Use `-volume-to-surface-mapping` with a defined surface (midthickness) to project anatomical or functional volume data onto the cortical ribbon.

### Expert Tips
- **Memory Management**: CIFTI files (especially dense connectomes) can be extremely large. Ensure your environment has sufficient RAM when running correlation or covariance commands.
- **Workbench View (wb_view)**: While `wb_command` handles processing, use `wb_view` to generate "scene" files (.scene). These files can then be used with `wb_command -show-scene` to automate high-resolution image rendering for publications.
- **HCP Compatibility**: Always ensure your surface files (GIFTI) and data files (CIFTI) match in vertex count. The standard HCP "fsaverage_LR" mesh is the default for most workbench operations.



## Subcommands

| Command | Description |
|---------|-------------|
| wb_command | Connectome Workbench command-line interface |
| wb_view | Display usage text, set graphics region size, logging level, disable splash screens, load scenes, change window style, load spec files, set window size and position. |

## Reference documentation
- [Connectome Workbench Overview](./references/www_humanconnectome_org_software_connectome-workbench.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_connectome-workbench_overview.md)