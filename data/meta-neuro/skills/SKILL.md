---
name: meta-neuro
description: Medial Tractography Analysis (MeTA) is a specialized neuroimaging workflow designed to minimize microstructural heterogeneity in diffusion MRI metrics.
homepage: https://github.com/bagari/meta
---

# meta-neuro

## Overview

Medial Tractography Analysis (MeTA) is a specialized neuroimaging workflow designed to minimize microstructural heterogeneity in diffusion MRI metrics. Unlike standard tractography analysis which may include peripheral "noise" or partial volume effects, MeTA extracts and parcellates the core volume of a white matter bundle. This approach effectively preserves the bundle's shape while capturing regional variations in metrics like Fractional Anisotropy (FA) or Mean Diffusivity (MD) both within and along the bundle length.

## Installation and Environment

MeTA is primarily distributed via Bioconda. Ensure your environment uses Python >= 3.9 and < 3.14.

```bash
conda config --add channels bioconda
conda create -n meta python=3.13
conda activate meta
conda install bioconda::meta-neuro=2.0.1
```

Alternatively, use the Singularity/Apptainer image for containerized execution:
`apptainer run docker://quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0 meta --help`

## Core Workflow Commands

### 1. Medial Surface Generation
Before running the main MeTA analysis, you must generate a 3D medial surface (skeleton) of the bundle.

**Step A: Create a binary density map**
Converts streamlines (trk/tck) into a voxel-space binary image.
```bash
density_map --tractogram bundle.trk --reference dti_FA.nii.gz --output bundle_mask.nii.gz
```

**Step B: Generate VTK Level Set**
```bash
vtklevelset bundle_mask.nii.gz bundle.vtk 0.1
```

**Step C: Extract Medial Skeleton**
Uses the Continuous Medial Representation (CMREP) method.
```bash
cmrep_vskel -c 3 -p 1.5 -g bundle.vtk bundle_skeleton.vtk
```

### 2. Main MeTA Analysis
The `meta` command performs the core volume extraction and parcellation.

```bash
meta --subject SUBJ_ID \
     --bundle CST \
     --medial_surface bundle_skeleton.vtk \
     --volume bundle.vtk \
     --sbundle bundle.trk \
     --mbundle bundle_model.trk \
     --transform subject_to_template_affine.mat \
     --mask bundle_mask.nii.gz \
     --num_segments 15 \
     --output ./output_dir
```

### 3. Microstructural Profiling
After parcellation, extract metrics along the bundle length.

**Voxel-based Profile:**
Computes averages based on the parcellated masks and a metric map (e.g., FA).
```bash
volumetric_profile --subject SUBJ_ID --bundle CST --mask bundle_local_all.nii.gz --map FA.nii.gz --output ./output_dir
```

**Streamline-based Profile:**
Computes metrics mapped directly onto the streamlines.
```bash
streamlines_profile --subject SUBJ_ID --bundle CST --tractogram bundle.trk --mask bundle_local_all.nii.gz --map FA.nii.gz --output ./output_dir
```

### 4. Shape Feature Extraction
Extract geometric features including length, span, curl, volume, surface area, and elongation.
```bash
shape_metrics --subject SUBJ_ID --bundle CST --mask bundle_mask.nii.gz --tractogram bundle.trk --output bundle_metrics.csv
```

## Expert Tips and Best Practices

- **Segment Selection**: The `--num_segments` parameter in the `meta` command determines the granularity of the analysis along the bundle length. For most major bundles (like the CST), 15-20 segments provide a good balance between spatial resolution and signal-to-noise ratio.
- **Input Formats**: MeTA supports `.trk`, `.tck`, and `.tt.gz` tractography formats. Ensure your reference image (`--reference`) matches the orientation and dimensions of your dMRI metric maps.
- **Output Files**: 
    - `*_segments_average.csv`: Contains the mean metric value for each segment along the bundle.
    - `*_segments_voxelwise.h5`: Contains high-dimensional data for every voxel within the bundle core, useful for advanced statistical mapping.
- **Medial Surface Tuning**: If the skeletonization (`cmrep_vskel`) fails or produces artifacts, check the threshold used in `vtklevelset` (default 0.1). A cleaner binary mask from `density_map` usually resolves skeletonization issues.

## Reference documentation
- [MeTA GitHub Repository](./references/github_com_bagari_meta.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_meta-neuro_overview.md)