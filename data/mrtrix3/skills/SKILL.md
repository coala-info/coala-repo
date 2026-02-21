---
name: mrtrix3
description: MRtrix3 is a specialized suite of tools designed for the analysis of diffusion-weighted magnetic resonance imaging (DWI) data.
homepage: https://www.mrtrix.org
---

# mrtrix3

## Overview

MRtrix3 is a specialized suite of tools designed for the analysis of diffusion-weighted magnetic resonance imaging (DWI) data. It is particularly effective for resolving complex white matter architecture, such as crossing fibers, through its implementation of Constrained Spherical Deconvolution (CSD). Use this skill to execute multi-step neuroimaging workflows, including preprocessing, tractography generation with Anatomically Constrained Tractography (ACT), and connectivity-based fixel enhancement (CFE) for group-level statistics.

## Core Command-Line Patterns

### Image Format Handling
MRtrix3 supports DICOM, NIfTI, and its native `.mif` format.
- **Prefer .mif**: Use the `.mif` format for intermediate steps as it stores essential metadata (like diffusion gradients and transform matrices) directly in the header.
- **Conversion**: Use `mrconvert` to move between formats.
- **Piping**: Many tools support piping via the `-` character to minimize disk I/O.
  ```bash
  mrconvert input.nii.gz - | dwi2mask - mask.mif
  ```

### Preprocessing and Response Function Estimation
- **Brain Masking**: Use `dwi2mask` to generate a brain mask from DWI data.
- **Response Function**: Use `dwi2response` with algorithms like `tournier` (single-shell) or `dhollander` (multi-shell multi-tissue) to estimate the diffusion signal of different tissue types.
  ```bash
  dwi2response dhollander dwi.mif wm.txt gm.txt csf.txt
  ```

### FOD Estimation (CSD)
- **Single-Shell**: Use `dwi2fod csd`.
- **Multi-Shell Multi-Tissue (MSMT-CSD)**: Use `dwi2fod msmt_csd` to resolve partial volume effects between white matter, gray matter, and CSF.
  ```bash
  dwi2fod msmt_csd dwi.mif wm.txt wm_fod.mif gm.txt gm.mif csf.txt csf.mif
  ```

### Tractography and Connectivity
- **Generation**: Use `tckgen` for probabilistic or deterministic tracking.
- **Anatomical Constraints**: Use the `-act` option with a 5-tissue-type (5TT) segmented image (generated via `5ttgen`) to ensure streamlines terminate in appropriate anatomical regions.
- **SIFT/SIFT2**: Use `tcksift` or `tcksift2` to filter or weight streamlines so that the streamline counts/weights are biologically meaningful and proportional to the underlying fiber density.

### Fixel-Based Analysis (FBA)
- **Fixel Connectivity**: Use `fixelconnectivity` to pre-compute the connectivity matrix required for statistical analysis.
- **Statistical Inference**: Use `fixelcfestats` for group-level comparisons. 
- **Memory Management**: When dealing with large cohorts (e.g., >1000 subjects), be aware that `fixelcfestats` can be RAM-intensive. Consider reducing the number of threads using `-nthreads` if memory limits are reached.

## Expert Tips

- **Visualization**: Use `mrview` for interactive inspection of images, FODs (using the ODF tool), and streamlines (using the Tractography tool).
- **Header Inspection**: Use `mrinfo` to check diffusion encoding, voxel sizes, and transform headers.
- **Performance**: Most MRtrix3 commands automatically use all available CPU cores. Use the `-nthreads` option to manually limit resource usage in shared computing environments.
- **Numerical Precision**: For statistical outputs, ensure you are using the appropriate data types (usually float32) to balance precision and storage.

## Reference documentation
- [mrtrix3 Overview](./references/anaconda_org_channels_bioconda_packages_mrtrix3_overview.md)
- [MRtrix3 Main Index](./references/www_mrtrix_org_index.md)
- [MRtrix3 Documentation Resources](./references/www_mrtrix_org_documentation.md)
- [Fixelcfestats Memory Management](./references/www_mrtrix_org_blog.md)