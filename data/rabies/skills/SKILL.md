---
name: rabies
description: RABIES is an image processing pipeline designed to transform raw rodent functional MRI data into analyzed connectivity maps. Use when user asks to preprocess rodent fMRI scans, apply confound correction, or perform functional connectivity analyses like seed-based correlation and group ICA.
homepage: https://github.com/CoBrALab/RABIES
metadata:
  docker_image: "quay.io/biocontainers/rabies:0.5.5--pyhdfd78af_0"
---

# rabies

## Overview
RABIES (Rodent Automated Bold Improvement of EPI Sequences) is a specialized image processing pipeline designed specifically for rodent functional MRI. Unlike human fMRI pipelines, RABIES is optimized to handle the unique challenges of rodent imaging, such as diverse scan field strengths, varying coil types, and small brain volumes. It transforms raw BIDS-compliant data into analyzed connectivity maps through three distinct stages: preprocessing, confound correction, and analysis.

## Command Line Usage

RABIES is typically executed via a command-line interface, often within a Docker or Apptainer container. The tool follows a modular structure corresponding to its three main stages.

### 1. Preprocessing
This stage handles head motion correction, susceptibility distortion correction, and registration to a common space.
- **Input**: A BIDS-compliant dataset.
- **Key Options**:
  - `--template_path`: Path to the anatomical template (e.g., DSURQE).
  - `--slc_resamp`: Enable slice timing correction.
  - `--despiking`: Apply voxel-wise despiking to remove outliers.

### 2. Confound Correction
This stage applies nuisance regression and temporal filtering to the preprocessed data.
- **Input**: The output directory from the preprocessing stage.
- **Key Options**:
  - `--confound_list`: Specify regressors (e.g., mot_6, wm, csf).
  - `--frame_censoring`: Apply scrubbing based on FD (Framewise Displacement) thresholds.
  - `--smoothing_filter`: Apply spatial smoothing (FWHM).
  - `--highpass` / `--lowpass`: Set frequency filter boundaries.

### 3. Analysis
This stage generates functional connectivity metrics.
- **Input**: The output directory from the confound correction stage.
- **Workflows**:
  - `seed_based`: For seed-to-voxel correlation maps.
  - `whole_brain_matrix`: To generate parcellation-based connectivity matrices.
  - `group_ica`: For data-driven network identification.

## Expert Tips and Best Practices

- **BIDS Compliance**: Ensure your rodent data is strictly BIDS-compliant before starting. Use a BIDS validator if the pipeline fails to find your subjects.
- **Visual QC**: RABIES automatically generates visual outputs for registration assessment. Always inspect the `QC_report` in the output folder to ensure the EPI-to-Template alignment is accurate before proceeding to analysis.
- **Data Diagnosis**: Use the `data_diagnosis` workflow to generate indices of data quality. This is critical for identifying high-motion subjects that may need to be excluded or more aggressively censored.
- **Parallelization**: Since RABIES is built on Nipype, use the `--n_procs` flag to utilize multiple CPU cores, significantly reducing processing time (which can otherwise take several hours to a day).
- **Methods Reporting**: Check the output folder for an automatically generated **boilerplate**. This text summarizes the exact parameters and versions used, which can be directly adapted for the "Methods" section of a publication.



## Subcommands

| Command | Description |
|---------|-------------|
| rabies analysis | Performs various neuroimaging analysis tasks, including confound correction, data diagnosis, dual regression, and neural prior recovery. |
| rabies confound_correction | Conduct confound correction and analysis in native space. |
| rabies_preprocess | Apply preprocessing with only EPI scans. Commonspace registration is executed directly using the corrected EPI 3D reference images. The commonspace registration simultaneously applies distortion correction. Nativespace is always the original EPI space. |

## Reference documentation
- [RABIES Main README](./references/github_com_CoBrALab_RABIES_blob_master_README.md)
- [RABIES Docker Configuration](./references/github_com_CoBrALab_RABIES_blob_master_Dockerfile.md)