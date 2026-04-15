---
name: meta-neuro
description: meta-neuro is a neuroimaging workflow for medial tractography analysis that extracts and parcellates the core volume of white matter bundles to minimize microstructural heterogeneity. Use when user asks to generate medial surfaces, perform bundle parcellation, compute microstructural profiles, or extract shape metrics from diffusion MRI data.
homepage: https://github.com/bagari/meta
metadata:
  docker_image: "quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0"
---

# meta-neuro

## Overview

Medial Tractography Analysis (MeTA) is a specialized neuroimaging workflow designed to minimize microstructural heterogeneity in diffusion MRI (dMRI) metrics. Unlike standard tractometry which may include peripheral voxels, MeTA extracts and parcellates the core volume along the bundle length in voxel-space. This approach effectively preserves bundle shape while capturing regional variations within white matter (WM) bundles, making it ideal for population analyses and genetic correlation studies.

## Command Line Usage

The meta-neuro package provides several CLI entry points for a complete tractography analysis pipeline.

### 1. Medial Surface Generation
Before running the main MeTA workflow, you must generate a medial surface (skeleton) for the white matter bundle.

**Step A: Create a density map**
Convert streamlines into a binary image.
```bash
density_map --tractogram bundle.trk --reference fa_map.nii.gz --output bundle_mask.nii.gz
```

**Step B: Generate the 3D Medial Surface**
Use the CMREP (Continuous Medial Representation) method.
```bash
# Create a level set mesh
vtklevelset bundle_mask.nii.gz bundle.vtk 0.1

# Generate the skeleton
cmrep_vskel -c 3 -p 1.5 -g bundle.vtk bundle_skeleton.vtk
```

### 2. Main MeTA Workflow
Extract the core volume and parcellate it into segments.
```bash
meta --subject SUBJ_ID \
     --bundle CST \
     --medial_surface bundle_skeleton.vtk \
     --volume bundle.vtk \
     --sbundle bundle.trk \
     --mbundle model_template.trk \
     --transform subject_to_template.mat \
     --mask bundle_mask.nii.gz \
     --num_segments 15 \
     --output output_prefix
```

### 3. Microstructural Profiling
Compute metrics (FA, MD, RD, AD) along the bundle.

**Voxel-based Profile:**
```bash
volumetric_profile --subject SUBJ_ID --bundle CST --mask bundle_local_all.nii.gz --map FA.nii.gz --output ./results
```

**Streamline-based Profile:**
```bash
streamlines_profile --subject SUBJ_ID --bundle CST --tractogram bundle.trk --mask bundle_local_all.nii.gz --map FA.nii.gz --output ./results
```

### 4. Shape Metrics Extraction
Calculate geometric features of the bundle.
```bash
shape_metrics --subject SUBJ_ID --bundle CST --mask bundle_mask.nii.gz --tractogram bundle.trk --output metrics.csv
```

## Expert Tips and Best Practices

- **File Formats**: Version 2.0.1+ supports `trk`, `tck`, `trx`, and `tt.gz` formats. Ensure your tractograms are compatible with the reference image space.
- **Transformations**: If your registration matrix is from template-to-subject but the tool expects subject-to-template, check for the matrix inversion options in the `meta` command.
- **Segmentation Granularity**: The `--num_segments` parameter typically ranges from 15 to 100 depending on the length of the bundle and the desired spatial resolution.
- **Output Interpretation**: 
    - `*_segments_average.csv`: Contains the mean metric value for each segment along the tract.
    - `*_segments_voxelwise.h5`: Contains data for every voxel, useful for more complex statistical modeling.
- **Shape Features**: The `shape_metrics` tool extracts 9 key features: Streamline count, Average length, Span, Curl, Volume, Surface area, Diameter, Elongation, and Irregularity.



## Subcommands

| Command | Description |
|---------|-------------|
| cmrep_vskel | Skeletonize a boundary mesh |
| density_map | Convert streamlines of white matter bundle into a density map and binary mask. |
| meta | Medial Tractography Analysis (MeTA) for White Matter Bundle Parcellation |
| shape_metrics | Extract shape features from white matter bundle streamlines |
| streamlines_profile | Compute streamlines profile (average mean and point-wise) of a white matter bundle. |
| volumetric_profile | Compute volumetric profile (average mean and voxel-wise) of a white matter bundle. |
| vtklevelset | Generates a VTK mesh from a level set implicit surface defined by an input image. |

## Reference documentation
- [MeTA GitHub Repository](./references/github_com_bagari_meta_blob_main_README.md)
- [MeTA Changelog](./references/github_com_bagari_meta_blob_main_CHANGELOG.md)
- [MeTA Project Configuration](./references/github_com_bagari_meta_blob_main_pyproject.toml.md)